return {
	Play121471001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 121471001
		arg_1_1.duration_ = 10.2

		local var_1_0 = {
			ja = 10.2,
			ko = 7.366,
			zh = 7.366
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
				arg_1_0:Play121471002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST41 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST41")
				var_4_0.name = "ST41"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST41 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST41

				arg_1_1.bgs_.ST41.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST41" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			local var_4_8 = "1076ui_story"

			if arg_1_1.actors_["1076ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1076ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_1_1.stage_.transform)

				var_4_9.name = var_4_8
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_8] = var_4_9

				local var_4_10 = var_4_9:GetComponentInChildren(typeof(CharacterEffect))

				var_4_10.enabled = true

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_9, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_10.transform, false)

				arg_1_1.var_[var_4_8 .. "Animator"] = var_4_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_8 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_8 .. "LipSync"] = var_4_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_12 = arg_1_1.actors_["1076ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1076ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_1_1.time_ - 1.8) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_13 and arg_1_1.time_ < 1.8 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1076ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1076ui_story == nil then
				arg_1_1.var_.characterEffect1076ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1076ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1076ui_story then
				arg_1_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_4_17 = "1072ui_story"

			if arg_1_1.actors_["1072ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1072ui_story"))) then
				local var_4_18 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_1_1.stage_.transform)

				var_4_18.name = var_4_17
				var_4_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_17] = var_4_18

				local var_4_19 = var_4_18:GetComponentInChildren(typeof(CharacterEffect))

				var_4_19.enabled = true

				local var_4_20 = GameObjectTools.GetOrAddComponent(var_4_18, typeof(DynamicBoneHelper))

				if var_4_20 then
					var_4_20:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_19.transform, false)

				arg_1_1.var_[var_4_17 .. "Animator"] = var_4_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_17 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_17 .. "LipSync"] = var_4_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_21 = arg_1_1.actors_["1072ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1072ui_story = var_4_21.localPosition
			end

			local var_4_22 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_22 then
				var_4_21.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_1_1.time_ - 1.8) / var_4_22)
				var_4_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_21.position).x, (manager.ui.mainCamera.transform.position - var_4_21.position).y, (manager.ui.mainCamera.transform.position - var_4_21.position).z)
				var_4_21.localEulerAngles.z = 0
				var_4_21.localEulerAngles.x = 0
				var_4_21.localEulerAngles = var_4_21.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_22 and arg_1_1.time_ < 1.8 + var_4_22 + arg_4_0 then
				var_4_21.localPosition = Vector3.New(0.7, -0.71, -6)
				var_4_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_21.position).x, (manager.ui.mainCamera.transform.position - var_4_21.position).y, (manager.ui.mainCamera.transform.position - var_4_21.position).z)
				var_4_21.localEulerAngles.z = 0
				var_4_21.localEulerAngles.x = 0
				var_4_21.localEulerAngles = var_4_21.localEulerAngles
			end

			local var_4_23 = arg_1_1.actors_["1072ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_23) and arg_1_1.var_.characterEffect1072ui_story == nil then
				arg_1_1.var_.characterEffect1072ui_story = var_4_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_24 = 0.0166666666666667

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_24 and not isNil(var_4_23) then
				if arg_1_1.var_.characterEffect1072ui_story and not isNil(var_4_23) then
					arg_1_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_1_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_1_1.time_ - 1.8) / var_4_24)
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_24 and arg_1_1.time_ < 1.8 + var_4_24 + arg_4_0 and not isNil(var_4_23) and arg_1_1.var_.characterEffect1072ui_story then
				arg_1_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_1_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
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

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan.awb")

				local var_4_30 = manager.audio:GetAudioName("bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan")

				if "" ~= "" then
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

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				if arg_1_1.var_.characterEffect1072ui_story == nil then
					arg_1_1.var_.characterEffect1072ui_story = arg_1_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_4_31 = arg_1_1.var_.characterEffect1072ui_story

				arg_1_1.var_.characterEffect1072ui_story.imageEffect:turnOff()

				var_4_31.interferenceEffect.enabled = true
				var_4_31.interferenceEffect.noise = 0.001
				var_4_31.interferenceEffect.simTimeScale = 1
				var_4_31.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 1.81666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.81666666666667 + arg_4_0 then
				if arg_1_1.var_.characterEffect1072ui_story == nil then
					arg_1_1.var_.characterEffect1072ui_story = arg_1_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_1_1.var_.characterEffect1072ui_story.imageEffect:turnOn(false)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_33 = 2
			local var_4_34 = 0.625

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_35 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_35:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_36 = arg_1_1:GetWordFromCfg(121471001)
				local var_4_37 = arg_1_1:FormatText(var_4_36.content)

				arg_1_1.text_.text = var_4_37

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 25 <= 0 and var_4_34 or var_4_34 * (utf8.len(var_4_37) / 25)

				if (25 <= 0 and var_4_34 or var_4_34 * (utf8.len(var_4_37) / 25)) > 0 and var_4_34 < var_4_39 then
					arg_1_1.talkMaxDuration = var_4_39
					var_4_33 = var_4_33 + 0.3

					if var_4_39 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_39 + var_4_33
					end
				end

				arg_1_1.text_.text = var_4_37
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471001", "story_v_out_121471.awb") ~= 0 then
					local var_4_40 = manager.audio:GetVoiceLength("story_v_out_121471", "121471001", "story_v_out_121471.awb") / 1000

					if var_4_40 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_40 + var_4_33
					end

					if var_4_36.prefab_name ~= "" and arg_1_1.actors_[var_4_36.prefab_name] ~= nil then
						local var_4_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_36.prefab_name].transform, "story_v_out_121471", "121471001", "story_v_out_121471.awb")

						arg_1_1:RecordAudio("121471001", var_4_41)
						arg_1_1:RecordAudio("121471001", var_4_41)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_121471", "121471001", "story_v_out_121471.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_121471", "121471001", "story_v_out_121471.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_33 + 0.3
			local var_4_43 = math.max(var_4_34, arg_1_1.talkMaxDuration)

			if var_4_33 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_42) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play121471002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 121471002
		arg_9_1.duration_ = 13.73

		local var_9_0 = {
			ja = 13.733,
			ko = 9.266,
			zh = 9.266
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
				arg_9_0:Play121471003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1076ui_story"]) and arg_9_1.var_.characterEffect1076ui_story == nil then
				arg_9_1.var_.characterEffect1076ui_story = arg_9_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1076ui_story"]) then
				if arg_9_1.var_.characterEffect1076ui_story and not isNil(arg_9_1.actors_["1076ui_story"]) then
					arg_9_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1076ui_story"]) and arg_9_1.var_.characterEffect1076ui_story then
				arg_9_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_12_1 = arg_9_1.actors_["1072ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1072ui_story == nil then
				arg_9_1.var_.characterEffect1072ui_story = var_12_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 and not isNil(var_12_1) then
				if arg_9_1.var_.characterEffect1072ui_story and not isNil(var_12_1) then
					arg_9_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1072ui_story then
				arg_9_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_12_4 = 0
			local var_12_5 = 1.1

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_6 = arg_9_1:GetWordFromCfg(121471002)
				local var_12_7 = arg_9_1:FormatText(var_12_6.content)

				arg_9_1.text_.text = var_12_7

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_9 = 44 <= 0 and var_12_5 or var_12_5 * (utf8.len(var_12_7) / 44)

				if (44 <= 0 and var_12_5 or var_12_5 * (utf8.len(var_12_7) / 44)) > 0 and var_12_5 < var_12_9 then
					arg_9_1.talkMaxDuration = var_12_9

					if var_12_9 + var_12_4 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_9 + var_12_4
					end
				end

				arg_9_1.text_.text = var_12_7
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471002", "story_v_out_121471.awb") ~= 0 then
					local var_12_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471002", "story_v_out_121471.awb") / 1000

					if var_12_10 + var_12_4 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_10 + var_12_4
					end

					if var_12_6.prefab_name ~= "" and arg_9_1.actors_[var_12_6.prefab_name] ~= nil then
						local var_12_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_6.prefab_name].transform, "story_v_out_121471", "121471002", "story_v_out_121471.awb")

						arg_9_1:RecordAudio("121471002", var_12_11)
						arg_9_1:RecordAudio("121471002", var_12_11)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_121471", "121471002", "story_v_out_121471.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_121471", "121471002", "story_v_out_121471.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_12 = math.max(var_12_5, arg_9_1.talkMaxDuration)

			if var_12_4 <= arg_9_1.time_ and arg_9_1.time_ < var_12_4 + var_12_12 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_4) / var_12_12

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_4 + var_12_12 and arg_9_1.time_ < var_12_4 + var_12_12 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play121471003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 121471003
		arg_13_1.duration_ = 10.7

		local var_13_0 = {
			ja = 8.366,
			ko = 10.7,
			zh = 10.7
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
				arg_13_0:Play121471004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.3

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(121471003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 52 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 52)

				if (52 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 52)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471003", "story_v_out_121471.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471003", "story_v_out_121471.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_121471", "121471003", "story_v_out_121471.awb")

						arg_13_1:RecordAudio("121471003", var_16_6)
						arg_13_1:RecordAudio("121471003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_121471", "121471003", "story_v_out_121471.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_121471", "121471003", "story_v_out_121471.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play121471004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 121471004
		arg_17_1.duration_ = 11.57

		local var_17_0 = {
			ja = 11.566,
			ko = 7,
			zh = 7
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
				arg_17_0:Play121471005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.625

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:GetWordFromCfg(121471004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 25 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 25)

				if (25 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 25)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471004", "story_v_out_121471.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471004", "story_v_out_121471.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_121471", "121471004", "story_v_out_121471.awb")

						arg_17_1:RecordAudio("121471004", var_20_6)
						arg_17_1:RecordAudio("121471004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_121471", "121471004", "story_v_out_121471.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_121471", "121471004", "story_v_out_121471.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play121471005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 121471005
		arg_21_1.duration_ = 9.1

		local var_21_0 = {
			ja = 9.1,
			ko = 5.866,
			zh = 5.866
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
				arg_21_0:Play121471006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1072ui_story"]) and arg_21_1.var_.characterEffect1072ui_story == nil then
				arg_21_1.var_.characterEffect1072ui_story = arg_21_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1072ui_story"]) then
				if arg_21_1.var_.characterEffect1072ui_story and not isNil(arg_21_1.actors_["1072ui_story"]) then
					arg_21_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1072ui_story"]) and arg_21_1.var_.characterEffect1072ui_story then
				arg_21_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_24_1 = arg_21_1.actors_["1076ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1076ui_story == nil then
				arg_21_1.var_.characterEffect1076ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1076ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1076ui_story then
				arg_21_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_24_4 = 0
			local var_24_5 = 0.55

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(121471005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 22 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 22)

				if (22 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 22)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471005", "story_v_out_121471.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471005", "story_v_out_121471.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_121471", "121471005", "story_v_out_121471.awb")

						arg_21_1:RecordAudio("121471005", var_24_11)
						arg_21_1:RecordAudio("121471005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_121471", "121471005", "story_v_out_121471.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_121471", "121471005", "story_v_out_121471.awb")
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
	Play121471006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 121471006
		arg_25_1.duration_ = 5.83

		local var_25_0 = {
			ja = 5.833,
			ko = 4.1,
			zh = 4.1
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
				arg_25_0:Play121471007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1072ui_story"]) and arg_25_1.var_.characterEffect1072ui_story == nil then
				arg_25_1.var_.characterEffect1072ui_story = arg_25_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1072ui_story"]) then
				if arg_25_1.var_.characterEffect1072ui_story and not isNil(arg_25_1.actors_["1072ui_story"]) then
					arg_25_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1072ui_story"]) and arg_25_1.var_.characterEffect1072ui_story then
				arg_25_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_28_2 = arg_25_1.actors_["1076ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect1076ui_story == nil then
				arg_25_1.var_.characterEffect1076ui_story = var_28_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_3 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.characterEffect1076ui_story and not isNil(var_28_2) then
					arg_25_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_3)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect1076ui_story then
				arg_25_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_28_4 = 0
			local var_28_5 = 0.375

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(121471006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 15 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 15)

				if (15 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 15)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471006", "story_v_out_121471.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471006", "story_v_out_121471.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_121471", "121471006", "story_v_out_121471.awb")

						arg_25_1:RecordAudio("121471006", var_28_11)
						arg_25_1:RecordAudio("121471006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_121471", "121471006", "story_v_out_121471.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_121471", "121471006", "story_v_out_121471.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play121471007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 121471007
		arg_29_1.duration_ = 9.67

		local var_29_0 = {
			ja = 9.666,
			ko = 6.133,
			zh = 6.133
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
				arg_29_0:Play121471008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.725

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(121471007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 29 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 29)

				if (29 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 29)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471007", "story_v_out_121471.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471007", "story_v_out_121471.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_121471", "121471007", "story_v_out_121471.awb")

						arg_29_1:RecordAudio("121471007", var_32_6)
						arg_29_1:RecordAudio("121471007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_121471", "121471007", "story_v_out_121471.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_121471", "121471007", "story_v_out_121471.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play121471008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 121471008
		arg_33_1.duration_ = 15.5

		local var_33_0 = {
			ja = 15.5,
			ko = 8.5,
			zh = 8.5
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
				arg_33_0:Play121471009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1072ui_story"]) and arg_33_1.var_.characterEffect1072ui_story == nil then
				arg_33_1.var_.characterEffect1072ui_story = arg_33_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1072ui_story"]) then
				if arg_33_1.var_.characterEffect1072ui_story and not isNil(arg_33_1.actors_["1072ui_story"]) then
					arg_33_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1072ui_story"]) and arg_33_1.var_.characterEffect1072ui_story then
				arg_33_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_36_1 = arg_33_1.actors_["1076ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1076ui_story == nil then
				arg_33_1.var_.characterEffect1076ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1076ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1076ui_story then
				arg_33_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_36_4 = 0
			local var_36_5 = 0.875

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(121471008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 35 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 35)

				if (35 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 35)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471008", "story_v_out_121471.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471008", "story_v_out_121471.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_out_121471", "121471008", "story_v_out_121471.awb")

						arg_33_1:RecordAudio("121471008", var_36_11)
						arg_33_1:RecordAudio("121471008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_121471", "121471008", "story_v_out_121471.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_121471", "121471008", "story_v_out_121471.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_12 and arg_33_1.time_ < var_36_4 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play121471009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 121471009
		arg_37_1.duration_ = 10.93

		local var_37_0 = {
			ja = 10.933,
			ko = 8.933,
			zh = 8.933
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
				arg_37_0:Play121471010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1072ui_story"]) and arg_37_1.var_.characterEffect1072ui_story == nil then
				arg_37_1.var_.characterEffect1072ui_story = arg_37_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1072ui_story"]) then
				if arg_37_1.var_.characterEffect1072ui_story and not isNil(arg_37_1.actors_["1072ui_story"]) then
					arg_37_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1072ui_story"]) and arg_37_1.var_.characterEffect1072ui_story then
				arg_37_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_40_2 = arg_37_1.actors_["1076ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.characterEffect1076ui_story == nil then
				arg_37_1.var_.characterEffect1076ui_story = var_40_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_3 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.characterEffect1076ui_story and not isNil(var_40_2) then
					arg_37_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_3)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.characterEffect1076ui_story then
				arg_37_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_40_4 = 0
			local var_40_5 = 1

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(121471009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 40 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 40)

				if (40 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 40)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471009", "story_v_out_121471.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471009", "story_v_out_121471.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_121471", "121471009", "story_v_out_121471.awb")

						arg_37_1:RecordAudio("121471009", var_40_11)
						arg_37_1:RecordAudio("121471009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_121471", "121471009", "story_v_out_121471.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_121471", "121471009", "story_v_out_121471.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_12 and arg_37_1.time_ < var_40_4 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play121471010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 121471010
		arg_41_1.duration_ = 3.57

		local var_41_0 = {
			ja = 3.566,
			ko = 2.333,
			zh = 2.333
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
				arg_41_0:Play121471011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.25

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:GetWordFromCfg(121471010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 10 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 10)

				if (10 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 10)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471010", "story_v_out_121471.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471010", "story_v_out_121471.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_121471", "121471010", "story_v_out_121471.awb")

						arg_41_1:RecordAudio("121471010", var_44_6)
						arg_41_1:RecordAudio("121471010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_121471", "121471010", "story_v_out_121471.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_121471", "121471010", "story_v_out_121471.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play121471011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 121471011
		arg_45_1.duration_ = 6

		local var_45_0 = {
			ja = 6,
			ko = 4.166,
			zh = 4.166
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
				arg_45_0:Play121471012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1072ui_story"]) and arg_45_1.var_.characterEffect1072ui_story == nil then
				arg_45_1.var_.characterEffect1072ui_story = arg_45_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1072ui_story"]) then
				if arg_45_1.var_.characterEffect1072ui_story and not isNil(arg_45_1.actors_["1072ui_story"]) then
					arg_45_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1072ui_story"]) and arg_45_1.var_.characterEffect1072ui_story then
				arg_45_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_48_1 = arg_45_1.actors_["1076ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1076ui_story == nil then
				arg_45_1.var_.characterEffect1076ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1076ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1076ui_story then
				arg_45_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_48_4 = 0
			local var_48_5 = 0.425

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(121471011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 17 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 17)

				if (17 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 17)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471011", "story_v_out_121471.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471011", "story_v_out_121471.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_out_121471", "121471011", "story_v_out_121471.awb")

						arg_45_1:RecordAudio("121471011", var_48_11)
						arg_45_1:RecordAudio("121471011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_121471", "121471011", "story_v_out_121471.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_121471", "121471011", "story_v_out_121471.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_12 and arg_45_1.time_ < var_48_4 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play121471012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 121471012
		arg_49_1.duration_ = 11.53

		local var_49_0 = {
			ja = 11.533,
			ko = 8.1,
			zh = 8.1
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
				arg_49_0:Play121471013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1072ui_story"]) and arg_49_1.var_.characterEffect1072ui_story == nil then
				arg_49_1.var_.characterEffect1072ui_story = arg_49_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1072ui_story"]) then
				if arg_49_1.var_.characterEffect1072ui_story and not isNil(arg_49_1.actors_["1072ui_story"]) then
					arg_49_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1072ui_story"]) and arg_49_1.var_.characterEffect1072ui_story then
				arg_49_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_52_2 = arg_49_1.actors_["1076ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1076ui_story == nil then
				arg_49_1.var_.characterEffect1076ui_story = var_52_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_3 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.characterEffect1076ui_story and not isNil(var_52_2) then
					arg_49_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_3)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1076ui_story then
				arg_49_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			local var_52_4 = 0
			local var_52_5 = 0.95

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(121471012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 38 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 38)

				if (38 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 38)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471012", "story_v_out_121471.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471012", "story_v_out_121471.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_121471", "121471012", "story_v_out_121471.awb")

						arg_49_1:RecordAudio("121471012", var_52_11)
						arg_49_1:RecordAudio("121471012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_121471", "121471012", "story_v_out_121471.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_121471", "121471012", "story_v_out_121471.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play121471013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 121471013
		arg_53_1.duration_ = 15.03

		local var_53_0 = {
			ja = 15.033,
			ko = 9.733,
			zh = 9.733
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
				arg_53_0:Play121471014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.225

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(121471013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 49 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 49)

				if (49 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 49)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471013", "story_v_out_121471.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471013", "story_v_out_121471.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_121471", "121471013", "story_v_out_121471.awb")

						arg_53_1:RecordAudio("121471013", var_56_6)
						arg_53_1:RecordAudio("121471013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_121471", "121471013", "story_v_out_121471.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_121471", "121471013", "story_v_out_121471.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play121471014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 121471014
		arg_57_1.duration_ = 3.93

		local var_57_0 = {
			ja = 3.933,
			ko = 1.733,
			zh = 1.733
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
				arg_57_0:Play121471015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1072ui_story"]) and arg_57_1.var_.characterEffect1072ui_story == nil then
				arg_57_1.var_.characterEffect1072ui_story = arg_57_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1072ui_story"]) then
				if arg_57_1.var_.characterEffect1072ui_story and not isNil(arg_57_1.actors_["1072ui_story"]) then
					arg_57_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1072ui_story"]) and arg_57_1.var_.characterEffect1072ui_story then
				arg_57_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_60_1 = arg_57_1.actors_["1076ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1076ui_story == nil then
				arg_57_1.var_.characterEffect1076ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1076ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1076ui_story then
				arg_57_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_60_4 = 0
			local var_60_5 = 0.125

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(121471014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 5 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 5)

				if (5 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 5)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471014", "story_v_out_121471.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471014", "story_v_out_121471.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_121471", "121471014", "story_v_out_121471.awb")

						arg_57_1:RecordAudio("121471014", var_60_11)
						arg_57_1:RecordAudio("121471014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_121471", "121471014", "story_v_out_121471.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_121471", "121471014", "story_v_out_121471.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play121471015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 121471015
		arg_61_1.duration_ = 12.17

		local var_61_0 = {
			ja = 12.166,
			ko = 7.6,
			zh = 7.6
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
				arg_61_0:Play121471016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1072ui_story"]) and arg_61_1.var_.characterEffect1072ui_story == nil then
				arg_61_1.var_.characterEffect1072ui_story = arg_61_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1072ui_story"]) then
				if arg_61_1.var_.characterEffect1072ui_story and not isNil(arg_61_1.actors_["1072ui_story"]) then
					arg_61_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1072ui_story"]) and arg_61_1.var_.characterEffect1072ui_story then
				arg_61_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_64_2 = arg_61_1.actors_["1076ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1076ui_story == nil then
				arg_61_1.var_.characterEffect1076ui_story = var_64_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_3 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.characterEffect1076ui_story and not isNil(var_64_2) then
					arg_61_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_3)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1076ui_story then
				arg_61_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_2")
			end

			local var_64_4 = 0
			local var_64_5 = 0.9

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(121471015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 36 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 36)

				if (36 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 36)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471015", "story_v_out_121471.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471015", "story_v_out_121471.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_121471", "121471015", "story_v_out_121471.awb")

						arg_61_1:RecordAudio("121471015", var_64_11)
						arg_61_1:RecordAudio("121471015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_121471", "121471015", "story_v_out_121471.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_121471", "121471015", "story_v_out_121471.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play121471016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 121471016
		arg_65_1.duration_ = 9.9

		local var_65_0 = {
			ja = 9.6,
			ko = 9.9,
			zh = 9.9
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
				arg_65_0:Play121471017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 1

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:GetWordFromCfg(121471016)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 40 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 40)

				if (40 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 40)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471016", "story_v_out_121471.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471016", "story_v_out_121471.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_121471", "121471016", "story_v_out_121471.awb")

						arg_65_1:RecordAudio("121471016", var_68_6)
						arg_65_1:RecordAudio("121471016", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_121471", "121471016", "story_v_out_121471.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_121471", "121471016", "story_v_out_121471.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play121471017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 121471017
		arg_69_1.duration_ = 9.3

		local var_69_0 = {
			ja = 8.1,
			ko = 9.3,
			zh = 9.3
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
				arg_69_0:Play121471018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.975

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(121471017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 39 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 39)

				if (39 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 39)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471017", "story_v_out_121471.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471017", "story_v_out_121471.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_121471", "121471017", "story_v_out_121471.awb")

						arg_69_1:RecordAudio("121471017", var_72_6)
						arg_69_1:RecordAudio("121471017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_121471", "121471017", "story_v_out_121471.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_121471", "121471017", "story_v_out_121471.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play121471018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 121471018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play121471019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1076ui_story = arg_73_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1076ui_story"].transform.position).z)
				arg_73_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1076ui_story"].transform.localEulerAngles = arg_73_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1076ui_story"].transform.position).z)
				arg_73_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1076ui_story"].transform.localEulerAngles = arg_73_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["1076ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1076ui_story == nil then
				arg_73_1.var_.characterEffect1076ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect1076ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_2)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1076ui_story then
				arg_73_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_76_3 = arg_73_1.actors_["1072ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1072ui_story = var_76_3.localPosition
			end

			local var_76_4 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				var_76_3.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_4)
				var_76_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_3.position).x, (manager.ui.mainCamera.transform.position - var_76_3.position).y, (manager.ui.mainCamera.transform.position - var_76_3.position).z)
				var_76_3.localEulerAngles.z = 0
				var_76_3.localEulerAngles.x = 0
				var_76_3.localEulerAngles = var_76_3.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				var_76_3.localPosition = Vector3.New(0, 100, 0)
				var_76_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_3.position).x, (manager.ui.mainCamera.transform.position - var_76_3.position).y, (manager.ui.mainCamera.transform.position - var_76_3.position).z)
				var_76_3.localEulerAngles.z = 0
				var_76_3.localEulerAngles.x = 0
				var_76_3.localEulerAngles = var_76_3.localEulerAngles
			end

			local var_76_5 = arg_73_1.actors_["1072ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.characterEffect1072ui_story == nil then
				arg_73_1.var_.characterEffect1072ui_story = var_76_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_6 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_6 and not isNil(var_76_5) then
				if arg_73_1.var_.characterEffect1072ui_story and not isNil(var_76_5) then
					arg_73_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_6)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_6 and arg_73_1.time_ < 0 + var_76_6 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.characterEffect1072ui_story then
				arg_73_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_76_7 = 0
			local var_76_8 = 1

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_7 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_9 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(121471018).content)

				arg_73_1.text_.text = var_76_9

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 40 <= 0 and var_76_8 or var_76_8 * (utf8.len(var_76_9) / 40)

				if (40 <= 0 and var_76_8 or var_76_8 * (utf8.len(var_76_9) / 40)) > 0 and var_76_8 < var_76_11 then
					arg_73_1.talkMaxDuration = var_76_11

					if var_76_11 + var_76_7 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_7
					end
				end

				arg_73_1.text_.text = var_76_9
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_8, arg_73_1.talkMaxDuration)

			if var_76_7 <= arg_73_1.time_ and arg_73_1.time_ < var_76_7 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_7) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_7 + var_76_12 and arg_73_1.time_ < var_76_7 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play121471019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 121471019
		arg_77_1.duration_ = 2.57

		local var_77_0 = {
			ja = 2.566,
			ko = 2.166,
			zh = 2.166
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
				arg_77_0:Play121471020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1076ui_story = arg_77_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1076ui_story"].transform.position).z)
				arg_77_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1076ui_story"].transform.localEulerAngles = arg_77_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_77_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1076ui_story"].transform.position).z)
				arg_77_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1076ui_story"].transform.localEulerAngles = arg_77_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1076ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1076ui_story == nil then
				arg_77_1.var_.characterEffect1076ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1076ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1076ui_story then
				arg_77_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_4 = "1075ui_story"

			if arg_77_1.actors_["1075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_story"))) then
				local var_80_5 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_77_1.stage_.transform)

				var_80_5.name = var_80_4
				var_80_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_[var_80_4] = var_80_5

				local var_80_6 = var_80_5:GetComponentInChildren(typeof(CharacterEffect))

				var_80_6.enabled = true

				local var_80_7 = GameObjectTools.GetOrAddComponent(var_80_5, typeof(DynamicBoneHelper))

				if var_80_7 then
					var_80_7:EnableDynamicBone(false)
				end

				arg_77_1:ShowWeapon(var_80_6.transform, false)

				arg_77_1.var_[var_80_4 .. "Animator"] = var_80_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_77_1.var_[var_80_4 .. "Animator"].applyRootMotion = true
				arg_77_1.var_[var_80_4 .. "LipSync"] = var_80_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_80_8 = arg_77_1.actors_["1075ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1075ui_story = var_80_8.localPosition
			end

			local var_80_9 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_9 then
				var_80_8.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_77_1.time_ - 0) / var_80_9)
				var_80_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_8.position).x, (manager.ui.mainCamera.transform.position - var_80_8.position).y, (manager.ui.mainCamera.transform.position - var_80_8.position).z)
				var_80_8.localEulerAngles.z = 0
				var_80_8.localEulerAngles.x = 0
				var_80_8.localEulerAngles = var_80_8.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_9 and arg_77_1.time_ < 0 + var_80_9 + arg_80_0 then
				var_80_8.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_80_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_8.position).x, (manager.ui.mainCamera.transform.position - var_80_8.position).y, (manager.ui.mainCamera.transform.position - var_80_8.position).z)
				var_80_8.localEulerAngles.z = 0
				var_80_8.localEulerAngles.x = 0
				var_80_8.localEulerAngles = var_80_8.localEulerAngles
			end

			local var_80_10 = arg_77_1.actors_["1075ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_10) and arg_77_1.var_.characterEffect1075ui_story == nil then
				arg_77_1.var_.characterEffect1075ui_story = var_80_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_11 = 0.0166666666666667

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_11 and not isNil(var_80_10) then
				if arg_77_1.var_.characterEffect1075ui_story and not isNil(var_80_10) then
					arg_77_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_11)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_11 and arg_77_1.time_ < 0 + var_80_11 + arg_80_0 and not isNil(var_80_10) and arg_77_1.var_.characterEffect1075ui_story then
				arg_77_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_80_12 = 0
			local var_80_13 = 0.2

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_12 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_14 = arg_77_1:GetWordFromCfg(121471019)
				local var_80_15 = arg_77_1:FormatText(var_80_14.content)

				arg_77_1.text_.text = var_80_15

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_17 = 8 <= 0 and var_80_13 or var_80_13 * (utf8.len(var_80_15) / 8)

				if (8 <= 0 and var_80_13 or var_80_13 * (utf8.len(var_80_15) / 8)) > 0 and var_80_13 < var_80_17 then
					arg_77_1.talkMaxDuration = var_80_17

					if var_80_17 + var_80_12 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_17 + var_80_12
					end
				end

				arg_77_1.text_.text = var_80_15
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471019", "story_v_out_121471.awb") ~= 0 then
					local var_80_18 = manager.audio:GetVoiceLength("story_v_out_121471", "121471019", "story_v_out_121471.awb") / 1000

					if var_80_18 + var_80_12 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_18 + var_80_12
					end

					if var_80_14.prefab_name ~= "" and arg_77_1.actors_[var_80_14.prefab_name] ~= nil then
						local var_80_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_14.prefab_name].transform, "story_v_out_121471", "121471019", "story_v_out_121471.awb")

						arg_77_1:RecordAudio("121471019", var_80_19)
						arg_77_1:RecordAudio("121471019", var_80_19)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_121471", "121471019", "story_v_out_121471.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_121471", "121471019", "story_v_out_121471.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_20 = math.max(var_80_13, arg_77_1.talkMaxDuration)

			if var_80_12 <= arg_77_1.time_ and arg_77_1.time_ < var_80_12 + var_80_20 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_12) / var_80_20

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_12 + var_80_20 and arg_77_1.time_ < var_80_12 + var_80_20 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play121471020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 121471020
		arg_81_1.duration_ = 9.7

		local var_81_0 = {
			ja = 9.7,
			ko = 7.533,
			zh = 7.533
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
				arg_81_0:Play121471021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1076ui_story"]) and arg_81_1.var_.characterEffect1076ui_story == nil then
				arg_81_1.var_.characterEffect1076ui_story = arg_81_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1076ui_story"]) then
				if arg_81_1.var_.characterEffect1076ui_story and not isNil(arg_81_1.actors_["1076ui_story"]) then
					arg_81_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1076ui_story"]) and arg_81_1.var_.characterEffect1076ui_story then
				arg_81_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_84_1 = arg_81_1.actors_["1075ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1075ui_story == nil then
				arg_81_1.var_.characterEffect1075ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1075ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1075ui_story then
				arg_81_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_84_4 = 0
			local var_84_5 = 0.85

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(121471020)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 34 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 34)

				if (34 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 34)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471020", "story_v_out_121471.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471020", "story_v_out_121471.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_121471", "121471020", "story_v_out_121471.awb")

						arg_81_1:RecordAudio("121471020", var_84_11)
						arg_81_1:RecordAudio("121471020", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_121471", "121471020", "story_v_out_121471.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_121471", "121471020", "story_v_out_121471.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_12 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_12 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_12

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_12 and arg_81_1.time_ < var_84_4 + var_84_12 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play121471021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 121471021
		arg_85_1.duration_ = 6.33

		local var_85_0 = {
			ja = 6.333,
			ko = 3.1,
			zh = 3.1
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play121471022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.375

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:GetWordFromCfg(121471021)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 15 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 15)

				if (15 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 15)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471021", "story_v_out_121471.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471021", "story_v_out_121471.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_121471", "121471021", "story_v_out_121471.awb")

						arg_85_1:RecordAudio("121471021", var_88_6)
						arg_85_1:RecordAudio("121471021", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_121471", "121471021", "story_v_out_121471.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_121471", "121471021", "story_v_out_121471.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play121471022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 121471022
		arg_89_1.duration_ = 3.53

		local var_89_0 = {
			ja = 3.533,
			ko = 2.6,
			zh = 2.6
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
				arg_89_0:Play121471023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1075ui_story"]) and arg_89_1.var_.characterEffect1075ui_story == nil then
				arg_89_1.var_.characterEffect1075ui_story = arg_89_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1075ui_story"]) then
				if arg_89_1.var_.characterEffect1075ui_story and not isNil(arg_89_1.actors_["1075ui_story"]) then
					arg_89_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1075ui_story"]) and arg_89_1.var_.characterEffect1075ui_story then
				arg_89_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_92_1 = arg_89_1.actors_["1076ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1076ui_story == nil then
				arg_89_1.var_.characterEffect1076ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1076ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1076ui_story then
				arg_89_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_92_4 = 0
			local var_92_5 = 0.3

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(121471022)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 12 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 12)

				if (12 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 12)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471022", "story_v_out_121471.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471022", "story_v_out_121471.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_121471", "121471022", "story_v_out_121471.awb")

						arg_89_1:RecordAudio("121471022", var_92_11)
						arg_89_1:RecordAudio("121471022", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_121471", "121471022", "story_v_out_121471.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_121471", "121471022", "story_v_out_121471.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play121471023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 121471023
		arg_93_1.duration_ = 3.9

		local var_93_0 = {
			ja = 3.133,
			ko = 3.9,
			zh = 3.9
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
				arg_93_0:Play121471024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1076ui_story"]) and arg_93_1.var_.characterEffect1076ui_story == nil then
				arg_93_1.var_.characterEffect1076ui_story = arg_93_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1076ui_story"]) then
				if arg_93_1.var_.characterEffect1076ui_story and not isNil(arg_93_1.actors_["1076ui_story"]) then
					arg_93_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1076ui_story"]) and arg_93_1.var_.characterEffect1076ui_story then
				arg_93_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_96_1 = arg_93_1.actors_["1075ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1075ui_story == nil then
				arg_93_1.var_.characterEffect1075ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1075ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1075ui_story then
				arg_93_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_96_4 = 0
			local var_96_5 = 0.15

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(121471023)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 6 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 6)

				if (6 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 6)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471023", "story_v_out_121471.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471023", "story_v_out_121471.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_121471", "121471023", "story_v_out_121471.awb")

						arg_93_1:RecordAudio("121471023", var_96_11)
						arg_93_1:RecordAudio("121471023", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_121471", "121471023", "story_v_out_121471.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_121471", "121471023", "story_v_out_121471.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play121471024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 121471024
		arg_97_1.duration_ = 12.2

		local var_97_0 = {
			ja = 12.2,
			ko = 5.8,
			zh = 5.8
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
				arg_97_0:Play121471025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1075ui_story"]) and arg_97_1.var_.characterEffect1075ui_story == nil then
				arg_97_1.var_.characterEffect1075ui_story = arg_97_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1075ui_story"]) then
				if arg_97_1.var_.characterEffect1075ui_story and not isNil(arg_97_1.actors_["1075ui_story"]) then
					arg_97_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1075ui_story"]) and arg_97_1.var_.characterEffect1075ui_story then
				arg_97_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_100_1 = arg_97_1.actors_["1076ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1076ui_story == nil then
				arg_97_1.var_.characterEffect1076ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect1076ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1076ui_story then
				arg_97_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_100_4 = 0
			local var_100_5 = 0.625

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(121471024)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 25 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 25)

				if (25 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 25)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471024", "story_v_out_121471.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471024", "story_v_out_121471.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_121471", "121471024", "story_v_out_121471.awb")

						arg_97_1:RecordAudio("121471024", var_100_11)
						arg_97_1:RecordAudio("121471024", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_121471", "121471024", "story_v_out_121471.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_121471", "121471024", "story_v_out_121471.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play121471025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 121471025
		arg_101_1.duration_ = 8.7

		local var_101_0 = {
			ja = 8.7,
			ko = 4.7,
			zh = 4.7
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
				arg_101_0:Play121471026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.575

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(121471025)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 23 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 23)

				if (23 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 23)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471025", "story_v_out_121471.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471025", "story_v_out_121471.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_121471", "121471025", "story_v_out_121471.awb")

						arg_101_1:RecordAudio("121471025", var_104_6)
						arg_101_1:RecordAudio("121471025", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_121471", "121471025", "story_v_out_121471.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_121471", "121471025", "story_v_out_121471.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play121471026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 121471026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play121471027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1076ui_story"]) and arg_105_1.var_.characterEffect1076ui_story == nil then
				arg_105_1.var_.characterEffect1076ui_story = arg_105_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1076ui_story"]) then
				if arg_105_1.var_.characterEffect1076ui_story and not isNil(arg_105_1.actors_["1076ui_story"]) then
					arg_105_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1076ui_story"]) and arg_105_1.var_.characterEffect1076ui_story then
				arg_105_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 0.925

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(121471026).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 37 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 37)

				if (37 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 37)) > 0 and var_108_2 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_6 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_6 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_6

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_6 and arg_105_1.time_ < var_108_1 + var_108_6 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play121471027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 121471027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play121471028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.625

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(121471027).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 25 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 25)

				if (25 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 25)) > 0 and var_112_0 < var_112_3 then
					arg_109_1.talkMaxDuration = var_112_3

					if var_112_3 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_3 + 0
					end
				end

				arg_109_1.text_.text = var_112_1
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_4 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_4

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play121471028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 121471028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play121471029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.325

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(121471028).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 13 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 13)

				if (13 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 13)) > 0 and var_116_0 < var_116_3 then
					arg_113_1.talkMaxDuration = var_116_3

					if var_116_3 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_3 + 0
					end
				end

				arg_113_1.text_.text = var_116_1
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_4 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_4

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play121471029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 121471029
		arg_117_1.duration_ = 8.97

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play121471030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if arg_117_1.bgs_.STblack == nil then
				local var_120_0 = Object.Instantiate(arg_117_1.paintGo_)

				var_120_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_120_0.name = "STblack"
				var_120_0.transform.parent = arg_117_1.stage_.transform
				var_120_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.bgs_.STblack = var_120_0
			end

			if 1.96599999815226 < arg_117_1.time_ and arg_117_1.time_ <= 1.96599999815226 + arg_120_0 then
				local var_120_1 = arg_117_1.bgs_.STblack

				arg_117_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_120_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_2 = var_120_1:GetComponent("SpriteRenderer")

				if var_120_2 and var_120_2.sprite then
					local var_120_3 = 2 * (var_120_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_120_1.transform.localScale = Vector3.New(var_120_3 / var_120_2.sprite.bounds.size.y < var_120_3 * manager.ui.mainCameraCom_.aspect / var_120_2.sprite.bounds.size.x and var_120_3 * manager.ui.mainCameraCom_.aspect / var_120_2.sprite.bounds.size.x or var_120_3 / var_120_2.sprite.bounds.size.y, var_120_3 / var_120_2.sprite.bounds.size.y < var_120_3 * manager.ui.mainCameraCom_.aspect / var_120_2.sprite.bounds.size.x and var_120_3 * manager.ui.mainCameraCom_.aspect / var_120_2.sprite.bounds.size.x or var_120_3 / var_120_2.sprite.bounds.size.y, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "STblack" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_120_4 = 0

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_5 = 2

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_5 then
				local var_120_6 = Color.New(0, 0, 0)

				var_120_6.a = Mathf.Lerp(0, 1, (arg_117_1.time_ - var_120_4) / var_120_5)
				arg_117_1.mask_.color = var_120_6
			end

			if arg_117_1.time_ >= var_120_4 + var_120_5 and arg_117_1.time_ < var_120_4 + var_120_5 + arg_120_0 then
				local var_120_7 = Color.New(0, 0, 0)

				var_120_7.a = 1
				arg_117_1.mask_.color = var_120_7
			end

			local var_120_8 = 2

			if 2 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_9 = 2

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_9 then
				local var_120_10 = Color.New(0, 0, 0)

				var_120_10.a = Mathf.Lerp(1, 0, (arg_117_1.time_ - var_120_8) / var_120_9)
				arg_117_1.mask_.color = var_120_10
			end

			if arg_117_1.time_ >= var_120_8 + var_120_9 and arg_117_1.time_ < var_120_8 + var_120_9 + arg_120_0 then
				local var_120_11 = Color.New(0, 0, 0)

				arg_117_1.mask_.enabled = false
				var_120_11.a = 0
				arg_117_1.mask_.color = var_120_11
			end

			local var_120_12 = arg_117_1.actors_["1076ui_story"].transform

			if 1.96599999815226 < arg_117_1.time_ and arg_117_1.time_ <= 1.96599999815226 + arg_120_0 then
				arg_117_1.var_.moveOldPos1076ui_story = var_120_12.localPosition
			end

			local var_120_13 = 0.001

			if 1.96599999815226 <= arg_117_1.time_ and arg_117_1.time_ < 1.96599999815226 + var_120_13 then
				var_120_12.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 1.96599999815226) / var_120_13)
				var_120_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_12.position).x, (manager.ui.mainCamera.transform.position - var_120_12.position).y, (manager.ui.mainCamera.transform.position - var_120_12.position).z)
				var_120_12.localEulerAngles.z = 0
				var_120_12.localEulerAngles.x = 0
				var_120_12.localEulerAngles = var_120_12.localEulerAngles
			end

			if arg_117_1.time_ >= 1.96599999815226 + var_120_13 and arg_117_1.time_ < 1.96599999815226 + var_120_13 + arg_120_0 then
				var_120_12.localPosition = Vector3.New(0, 100, 0)
				var_120_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_12.position).x, (manager.ui.mainCamera.transform.position - var_120_12.position).y, (manager.ui.mainCamera.transform.position - var_120_12.position).z)
				var_120_12.localEulerAngles.z = 0
				var_120_12.localEulerAngles.x = 0
				var_120_12.localEulerAngles = var_120_12.localEulerAngles
			end

			local var_120_14 = arg_117_1.actors_["1076ui_story"]

			if 1.98333333333333 < arg_117_1.time_ and arg_117_1.time_ <= 1.98333333333333 + arg_120_0 and not isNil(var_120_14) and arg_117_1.var_.characterEffect1076ui_story == nil then
				arg_117_1.var_.characterEffect1076ui_story = var_120_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_15 = 0.0166666666666667

			if 1.98333333333333 <= arg_117_1.time_ and arg_117_1.time_ < 1.98333333333333 + var_120_15 and not isNil(var_120_14) then
				if arg_117_1.var_.characterEffect1076ui_story and not isNil(var_120_14) then
					arg_117_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 1.98333333333333) / var_120_15)
				end
			end

			if arg_117_1.time_ >= 1.98333333333333 + var_120_15 and arg_117_1.time_ < 1.98333333333333 + var_120_15 + arg_120_0 and not isNil(var_120_14) and arg_117_1.var_.characterEffect1076ui_story then
				arg_117_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_120_16 = arg_117_1.actors_["1075ui_story"].transform

			if 1.96599999815226 < arg_117_1.time_ and arg_117_1.time_ <= 1.96599999815226 + arg_120_0 then
				arg_117_1.var_.moveOldPos1075ui_story = var_120_16.localPosition
			end

			local var_120_17 = 0.001

			if 1.96599999815226 <= arg_117_1.time_ and arg_117_1.time_ < 1.96599999815226 + var_120_17 then
				var_120_16.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 1.96599999815226) / var_120_17)
				var_120_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_16.position).x, (manager.ui.mainCamera.transform.position - var_120_16.position).y, (manager.ui.mainCamera.transform.position - var_120_16.position).z)
				var_120_16.localEulerAngles.z = 0
				var_120_16.localEulerAngles.x = 0
				var_120_16.localEulerAngles = var_120_16.localEulerAngles
			end

			if arg_117_1.time_ >= 1.96599999815226 + var_120_17 and arg_117_1.time_ < 1.96599999815226 + var_120_17 + arg_120_0 then
				var_120_16.localPosition = Vector3.New(0, 100, 0)
				var_120_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_16.position).x, (manager.ui.mainCamera.transform.position - var_120_16.position).y, (manager.ui.mainCamera.transform.position - var_120_16.position).z)
				var_120_16.localEulerAngles.z = 0
				var_120_16.localEulerAngles.x = 0
				var_120_16.localEulerAngles = var_120_16.localEulerAngles
			end

			local var_120_18 = arg_117_1.actors_["1075ui_story"]

			if 1.98333333333333 < arg_117_1.time_ and arg_117_1.time_ <= 1.98333333333333 + arg_120_0 and not isNil(var_120_18) and arg_117_1.var_.characterEffect1075ui_story == nil then
				arg_117_1.var_.characterEffect1075ui_story = var_120_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_19 = 0.0166666666666667

			if 1.98333333333333 <= arg_117_1.time_ and arg_117_1.time_ < 1.98333333333333 + var_120_19 and not isNil(var_120_18) then
				if arg_117_1.var_.characterEffect1075ui_story and not isNil(var_120_18) then
					arg_117_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 1.98333333333333) / var_120_19)
				end
			end

			if arg_117_1.time_ >= 1.98333333333333 + var_120_19 and arg_117_1.time_ < 1.98333333333333 + var_120_19 + arg_120_0 and not isNil(var_120_18) and arg_117_1.var_.characterEffect1075ui_story then
				arg_117_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 1.66666666666667 < arg_117_1.time_ and arg_117_1.time_ <= 1.66666666666667 + arg_120_0 then
				arg_117_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_crowd_loop", "")
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_21 = 3.96599999815226
			local var_120_22 = 1

			if 3.96599999815226 < arg_117_1.time_ and arg_117_1.time_ <= var_120_21 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_23 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_23:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_24 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(121471029).content)

				arg_117_1.text_.text = var_120_24

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_26 = 40 <= 0 and var_120_22 or var_120_22 * (utf8.len(var_120_24) / 40)

				if (40 <= 0 and var_120_22 or var_120_22 * (utf8.len(var_120_24) / 40)) > 0 and var_120_22 < var_120_26 then
					arg_117_1.talkMaxDuration = var_120_26
					var_120_21 = var_120_21 + 0.3

					if var_120_26 + var_120_21 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_26 + var_120_21
					end
				end

				arg_117_1.text_.text = var_120_24
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_27 = var_120_21 + 0.3
			local var_120_28 = math.max(var_120_22, arg_117_1.talkMaxDuration)

			if var_120_21 + 0.3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_27 + var_120_28 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_27) / var_120_28

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_27 + var_120_28 and arg_117_1.time_ < var_120_27 + var_120_28 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play121471030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 121471030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play121471031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_door", "")
			end

			local var_126_1 = 0
			local var_126_2 = 0.925

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(121471030).content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 37 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 37)

				if (37 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 37)) > 0 and var_126_2 < var_126_5 then
					arg_123_1.talkMaxDuration = var_126_5

					if var_126_5 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_6 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_6 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_6

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_6 and arg_123_1.time_ < var_126_1 + var_126_6 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play121471031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 121471031
		arg_127_1.duration_ = 4.67

		local var_127_0 = {
			ja = 4.666,
			ko = 4.166666666666,
			zh = 4.166666666666
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
				arg_127_0:Play121471032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if arg_127_1.bgs_.ST42 == nil then
				local var_130_0 = Object.Instantiate(arg_127_1.paintGo_)

				var_130_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST42")
				var_130_0.name = "ST42"
				var_130_0.transform.parent = arg_127_1.stage_.transform
				var_130_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.bgs_.ST42 = var_130_0
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				local var_130_1 = arg_127_1.bgs_.ST42

				arg_127_1.bgs_.ST42.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_130_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_130_2 = var_130_1:GetComponent("SpriteRenderer")

				if var_130_2 and var_130_2.sprite then
					local var_130_3 = 2 * (var_130_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_130_1.transform.localScale = Vector3.New(var_130_3 / var_130_2.sprite.bounds.size.y < var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x and var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x or var_130_3 / var_130_2.sprite.bounds.size.y, var_130_3 / var_130_2.sprite.bounds.size.y < var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x and var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x or var_130_3 / var_130_2.sprite.bounds.size.y, 0)
				end

				for iter_130_0, iter_130_1 in pairs(arg_127_1.bgs_) do
					if iter_130_0 ~= "ST42" then
						iter_130_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_130_4 = 0

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_5 = 2

			if var_130_4 <= arg_127_1.time_ and arg_127_1.time_ < var_130_4 + var_130_5 then
				local var_130_6 = Color.New(0, 0, 0)

				var_130_6.a = Mathf.Lerp(1, 0, (arg_127_1.time_ - var_130_4) / var_130_5)
				arg_127_1.mask_.color = var_130_6
			end

			if arg_127_1.time_ >= var_130_4 + var_130_5 and arg_127_1.time_ < var_130_4 + var_130_5 + arg_130_0 then
				local var_130_7 = Color.New(0, 0, 0)

				arg_127_1.mask_.enabled = false
				var_130_7.a = 0
				arg_127_1.mask_.color = var_130_7
			end

			local var_130_8 = "1069ui_story"

			if arg_127_1.actors_["1069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1069ui_story"))) then
				local var_130_9 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_127_1.stage_.transform)

				var_130_9.name = var_130_8
				var_130_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.actors_[var_130_8] = var_130_9

				local var_130_10 = var_130_9:GetComponentInChildren(typeof(CharacterEffect))

				var_130_10.enabled = true

				local var_130_11 = GameObjectTools.GetOrAddComponent(var_130_9, typeof(DynamicBoneHelper))

				if var_130_11 then
					var_130_11:EnableDynamicBone(false)
				end

				arg_127_1:ShowWeapon(var_130_10.transform, false)

				arg_127_1.var_[var_130_8 .. "Animator"] = var_130_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_127_1.var_[var_130_8 .. "Animator"].applyRootMotion = true
				arg_127_1.var_[var_130_8 .. "LipSync"] = var_130_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_130_12 = arg_127_1.actors_["1069ui_story"].transform

			if 1.8 < arg_127_1.time_ and arg_127_1.time_ <= 1.8 + arg_130_0 then
				arg_127_1.var_.moveOldPos1069ui_story = var_130_12.localPosition
			end

			local var_130_13 = 0.001

			if 1.8 <= arg_127_1.time_ and arg_127_1.time_ < 1.8 + var_130_13 then
				var_130_12.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1069ui_story, Vector3.New(-0.7, -1, -6), (arg_127_1.time_ - 1.8) / var_130_13)
				var_130_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_12.position).x, (manager.ui.mainCamera.transform.position - var_130_12.position).y, (manager.ui.mainCamera.transform.position - var_130_12.position).z)
				var_130_12.localEulerAngles.z = 0
				var_130_12.localEulerAngles.x = 0
				var_130_12.localEulerAngles = var_130_12.localEulerAngles
			end

			if arg_127_1.time_ >= 1.8 + var_130_13 and arg_127_1.time_ < 1.8 + var_130_13 + arg_130_0 then
				var_130_12.localPosition = Vector3.New(-0.7, -1, -6)
				var_130_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_12.position).x, (manager.ui.mainCamera.transform.position - var_130_12.position).y, (manager.ui.mainCamera.transform.position - var_130_12.position).z)
				var_130_12.localEulerAngles.z = 0
				var_130_12.localEulerAngles.x = 0
				var_130_12.localEulerAngles = var_130_12.localEulerAngles
			end

			local var_130_14 = arg_127_1.actors_["1069ui_story"]

			if 1.8 < arg_127_1.time_ and arg_127_1.time_ <= 1.8 + arg_130_0 and not isNil(var_130_14) and arg_127_1.var_.characterEffect1069ui_story == nil then
				arg_127_1.var_.characterEffect1069ui_story = var_130_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_15 = 0.200000002980232

			if 1.8 <= arg_127_1.time_ and arg_127_1.time_ < 1.8 + var_130_15 and not isNil(var_130_14) then
				if arg_127_1.var_.characterEffect1069ui_story and not isNil(var_130_14) then
					arg_127_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 1.8 + var_130_15 and arg_127_1.time_ < 1.8 + var_130_15 + arg_130_0 and not isNil(var_130_14) and arg_127_1.var_.characterEffect1069ui_story then
				arg_127_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 1.8 < arg_127_1.time_ and arg_127_1.time_ <= 1.8 + arg_130_0 then
				arg_127_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			if 1.8 < arg_127_1.time_ and arg_127_1.time_ <= 1.8 + arg_130_0 then
				arg_127_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_130_17 = arg_127_1.actors_["1076ui_story"].transform

			if 1.8 < arg_127_1.time_ and arg_127_1.time_ <= 1.8 + arg_130_0 then
				arg_127_1.var_.moveOldPos1076ui_story = var_130_17.localPosition
			end

			local var_130_18 = 0.001

			if 1.8 <= arg_127_1.time_ and arg_127_1.time_ < 1.8 + var_130_18 then
				var_130_17.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_127_1.time_ - 1.8) / var_130_18)
				var_130_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_17.position).x, (manager.ui.mainCamera.transform.position - var_130_17.position).y, (manager.ui.mainCamera.transform.position - var_130_17.position).z)
				var_130_17.localEulerAngles.z = 0
				var_130_17.localEulerAngles.x = 0
				var_130_17.localEulerAngles = var_130_17.localEulerAngles
			end

			if arg_127_1.time_ >= 1.8 + var_130_18 and arg_127_1.time_ < 1.8 + var_130_18 + arg_130_0 then
				var_130_17.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_130_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_17.position).x, (manager.ui.mainCamera.transform.position - var_130_17.position).y, (manager.ui.mainCamera.transform.position - var_130_17.position).z)
				var_130_17.localEulerAngles.z = 0
				var_130_17.localEulerAngles.x = 0
				var_130_17.localEulerAngles = var_130_17.localEulerAngles
			end

			local var_130_19 = arg_127_1.actors_["1076ui_story"]

			if 1.8 < arg_127_1.time_ and arg_127_1.time_ <= 1.8 + arg_130_0 and not isNil(var_130_19) and arg_127_1.var_.characterEffect1076ui_story == nil then
				arg_127_1.var_.characterEffect1076ui_story = var_130_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_20 = 0.200000002980232

			if 1.8 <= arg_127_1.time_ and arg_127_1.time_ < 1.8 + var_130_20 and not isNil(var_130_19) then
				if arg_127_1.var_.characterEffect1076ui_story and not isNil(var_130_19) then
					arg_127_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 1.8) / var_130_20)
				end
			end

			if arg_127_1.time_ >= 1.8 + var_130_20 and arg_127_1.time_ < 1.8 + var_130_20 + arg_130_0 and not isNil(var_130_19) and arg_127_1.var_.characterEffect1076ui_story then
				arg_127_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:AudioAction("stop", "music", "se_story_121_04", "se_story_121_04_crowd_loop", "")

				local var_130_23 = manager.audio:GetAudioName("se_story_121_04", "se_story_121_04_crowd_loop")

				if "" ~= "" then
					if arg_127_1.bgmTxt_.text ~= var_130_23 and arg_127_1.bgmTxt_.text ~= "" then
						if arg_127_1.bgmTxt2_.text ~= "" then
							arg_127_1.bgmTxt_.text = arg_127_1.bgmTxt2_.text
						end

						arg_127_1.bgmTxt2_.text = var_130_23

						arg_127_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_127_1.bgmTxt_.text = var_130_23
						arg_127_1.bgmTxt2_.text = var_130_23
					end

					if arg_127_1.bgmTimer then
						arg_127_1.bgmTimer:Stop()

						arg_127_1.bgmTimer = nil
					end

					if arg_127_1.settingData.show_music_name == 1 then
						arg_127_1.musicController:SetSelectedState("show")
						arg_127_1.musicAnimator_:Play("open", 0, 0)

						if arg_127_1.settingData.music_time ~= 0 then
							arg_127_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_127_1.settingData.music_time), function()
								if arg_127_1 == nil or isNil(arg_127_1.bgmTxt_) then
									return
								end

								arg_127_1.musicController:SetSelectedState("hide")
								arg_127_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_24 = 2
			local var_130_25 = 0.125

			if 2 < arg_127_1.time_ and arg_127_1.time_ <= var_130_24 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_26 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_26:setOnUpdate(LuaHelper.FloatAction(function(arg_132_0)
					arg_127_1.dialogCg_.alpha = arg_132_0
				end))
				var_130_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_27 = arg_127_1:GetWordFromCfg(121471031)
				local var_130_28 = arg_127_1:FormatText(var_130_27.content)

				arg_127_1.text_.text = var_130_28

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_30 = 5 <= 0 and var_130_25 or var_130_25 * (utf8.len(var_130_28) / 5)

				if (5 <= 0 and var_130_25 or var_130_25 * (utf8.len(var_130_28) / 5)) > 0 and var_130_25 < var_130_30 then
					arg_127_1.talkMaxDuration = var_130_30
					var_130_24 = var_130_24 + 0.3

					if var_130_30 + var_130_24 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_30 + var_130_24
					end
				end

				arg_127_1.text_.text = var_130_28
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471031", "story_v_out_121471.awb") ~= 0 then
					local var_130_31 = manager.audio:GetVoiceLength("story_v_out_121471", "121471031", "story_v_out_121471.awb") / 1000

					if var_130_31 + var_130_24 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_31 + var_130_24
					end

					if var_130_27.prefab_name ~= "" and arg_127_1.actors_[var_130_27.prefab_name] ~= nil then
						local var_130_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_27.prefab_name].transform, "story_v_out_121471", "121471031", "story_v_out_121471.awb")

						arg_127_1:RecordAudio("121471031", var_130_32)
						arg_127_1:RecordAudio("121471031", var_130_32)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_121471", "121471031", "story_v_out_121471.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_121471", "121471031", "story_v_out_121471.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_33 = var_130_24 + 0.3
			local var_130_34 = math.max(var_130_25, arg_127_1.talkMaxDuration)

			if var_130_24 + 0.3 <= arg_127_1.time_ and arg_127_1.time_ < var_130_33 + var_130_34 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_33) / var_130_34

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_33 + var_130_34 and arg_127_1.time_ < var_130_33 + var_130_34 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play121471032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 121471032
		arg_134_1.duration_ = 1.63

		local var_134_0 = {
			ja = 1.633,
			ko = 1.6,
			zh = 1.6
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play121471033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1069ui_story"]) and arg_134_1.var_.characterEffect1069ui_story == nil then
				arg_134_1.var_.characterEffect1069ui_story = arg_134_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1069ui_story"]) then
				if arg_134_1.var_.characterEffect1069ui_story and not isNil(arg_134_1.actors_["1069ui_story"]) then
					arg_134_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_0)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1069ui_story"]) and arg_134_1.var_.characterEffect1069ui_story then
				arg_134_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_137_1 = arg_134_1.actors_["1076ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect1076ui_story == nil then
				arg_134_1.var_.characterEffect1076ui_story = var_137_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_2 and not isNil(var_137_1) then
				if arg_134_1.var_.characterEffect1076ui_story and not isNil(var_137_1) then
					arg_134_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_2 and arg_134_1.time_ < 0 + var_137_2 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect1076ui_story then
				arg_134_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_137_4 = 0
			local var_137_5 = 0.15

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_6 = arg_134_1:GetWordFromCfg(121471032)
				local var_137_7 = arg_134_1:FormatText(var_137_6.content)

				arg_134_1.text_.text = var_137_7

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_9 = 6 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 6)

				if (6 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 6)) > 0 and var_137_5 < var_137_9 then
					arg_134_1.talkMaxDuration = var_137_9

					if var_137_9 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_9 + var_137_4
					end
				end

				arg_134_1.text_.text = var_137_7
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471032", "story_v_out_121471.awb") ~= 0 then
					local var_137_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471032", "story_v_out_121471.awb") / 1000

					if var_137_10 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_10 + var_137_4
					end

					if var_137_6.prefab_name ~= "" and arg_134_1.actors_[var_137_6.prefab_name] ~= nil then
						local var_137_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_6.prefab_name].transform, "story_v_out_121471", "121471032", "story_v_out_121471.awb")

						arg_134_1:RecordAudio("121471032", var_137_11)
						arg_134_1:RecordAudio("121471032", var_137_11)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_121471", "121471032", "story_v_out_121471.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_121471", "121471032", "story_v_out_121471.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_12 = math.max(var_137_5, arg_134_1.talkMaxDuration)

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_12 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_4) / var_137_12

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_4 + var_137_12 and arg_134_1.time_ < var_137_4 + var_137_12 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play121471033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 121471033
		arg_138_1.duration_ = 6.63

		local var_138_0 = {
			ja = 6.633,
			ko = 3.833,
			zh = 3.833
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play121471034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1076ui_story"]) and arg_138_1.var_.characterEffect1076ui_story == nil then
				arg_138_1.var_.characterEffect1076ui_story = arg_138_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1076ui_story"]) then
				if arg_138_1.var_.characterEffect1076ui_story and not isNil(arg_138_1.actors_["1076ui_story"]) then
					arg_138_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_0)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1076ui_story"]) and arg_138_1.var_.characterEffect1076ui_story then
				arg_138_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_141_1 = arg_138_1.actors_["1069ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_1) and arg_138_1.var_.characterEffect1069ui_story == nil then
				arg_138_1.var_.characterEffect1069ui_story = var_141_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_2 and not isNil(var_141_1) then
				if arg_138_1.var_.characterEffect1069ui_story and not isNil(var_141_1) then
					arg_138_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_2 and arg_138_1.time_ < 0 + var_141_2 + arg_141_0 and not isNil(var_141_1) and arg_138_1.var_.characterEffect1069ui_story then
				arg_138_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_141_4 = 0
			local var_141_5 = 0.45

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_4 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_6 = arg_138_1:GetWordFromCfg(121471033)
				local var_141_7 = arg_138_1:FormatText(var_141_6.content)

				arg_138_1.text_.text = var_141_7

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_9 = 18 <= 0 and var_141_5 or var_141_5 * (utf8.len(var_141_7) / 18)

				if (18 <= 0 and var_141_5 or var_141_5 * (utf8.len(var_141_7) / 18)) > 0 and var_141_5 < var_141_9 then
					arg_138_1.talkMaxDuration = var_141_9

					if var_141_9 + var_141_4 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_9 + var_141_4
					end
				end

				arg_138_1.text_.text = var_141_7
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471033", "story_v_out_121471.awb") ~= 0 then
					local var_141_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471033", "story_v_out_121471.awb") / 1000

					if var_141_10 + var_141_4 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_10 + var_141_4
					end

					if var_141_6.prefab_name ~= "" and arg_138_1.actors_[var_141_6.prefab_name] ~= nil then
						local var_141_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_6.prefab_name].transform, "story_v_out_121471", "121471033", "story_v_out_121471.awb")

						arg_138_1:RecordAudio("121471033", var_141_11)
						arg_138_1:RecordAudio("121471033", var_141_11)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_121471", "121471033", "story_v_out_121471.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_121471", "121471033", "story_v_out_121471.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_12 = math.max(var_141_5, arg_138_1.talkMaxDuration)

			if var_141_4 <= arg_138_1.time_ and arg_138_1.time_ < var_141_4 + var_141_12 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_4) / var_141_12

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_4 + var_141_12 and arg_138_1.time_ < var_141_4 + var_141_12 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play121471034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 121471034
		arg_142_1.duration_ = 10.7

		local var_142_0 = {
			ja = 10.7,
			ko = 6.266,
			zh = 6.266
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play121471035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1076ui_story"]) and arg_142_1.var_.characterEffect1076ui_story == nil then
				arg_142_1.var_.characterEffect1076ui_story = arg_142_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1076ui_story"]) then
				if arg_142_1.var_.characterEffect1076ui_story and not isNil(arg_142_1.actors_["1076ui_story"]) then
					arg_142_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1076ui_story"]) and arg_142_1.var_.characterEffect1076ui_story then
				arg_142_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_145_2 = arg_142_1.actors_["1069ui_story"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.characterEffect1069ui_story == nil then
				arg_142_1.var_.characterEffect1069ui_story = var_145_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_3 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_3 and not isNil(var_145_2) then
				if arg_142_1.var_.characterEffect1069ui_story and not isNil(var_145_2) then
					arg_142_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_3)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_3 and arg_142_1.time_ < 0 + var_145_3 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.characterEffect1069ui_story then
				arg_142_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_145_4 = 0
			local var_145_5 = 0.75

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_4 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_6 = arg_142_1:GetWordFromCfg(121471034)
				local var_145_7 = arg_142_1:FormatText(var_145_6.content)

				arg_142_1.text_.text = var_145_7

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_9 = 30 <= 0 and var_145_5 or var_145_5 * (utf8.len(var_145_7) / 30)

				if (30 <= 0 and var_145_5 or var_145_5 * (utf8.len(var_145_7) / 30)) > 0 and var_145_5 < var_145_9 then
					arg_142_1.talkMaxDuration = var_145_9

					if var_145_9 + var_145_4 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_9 + var_145_4
					end
				end

				arg_142_1.text_.text = var_145_7
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471034", "story_v_out_121471.awb") ~= 0 then
					local var_145_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471034", "story_v_out_121471.awb") / 1000

					if var_145_10 + var_145_4 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_10 + var_145_4
					end

					if var_145_6.prefab_name ~= "" and arg_142_1.actors_[var_145_6.prefab_name] ~= nil then
						local var_145_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_6.prefab_name].transform, "story_v_out_121471", "121471034", "story_v_out_121471.awb")

						arg_142_1:RecordAudio("121471034", var_145_11)
						arg_142_1:RecordAudio("121471034", var_145_11)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_121471", "121471034", "story_v_out_121471.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_121471", "121471034", "story_v_out_121471.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_12 = math.max(var_145_5, arg_142_1.talkMaxDuration)

			if var_145_4 <= arg_142_1.time_ and arg_142_1.time_ < var_145_4 + var_145_12 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_4) / var_145_12

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_4 + var_145_12 and arg_142_1.time_ < var_145_4 + var_145_12 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play121471035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 121471035
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play121471036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1069ui_story = arg_146_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_149_0 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 then
				arg_146_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_146_1.time_ - 0) / var_149_0)
				arg_146_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1069ui_story"].transform.position).z)
				arg_146_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["1069ui_story"].transform.localEulerAngles = arg_146_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 then
				arg_146_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_146_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1069ui_story"].transform.position).z)
				arg_146_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["1069ui_story"].transform.localEulerAngles = arg_146_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_149_1 = arg_146_1.actors_["1069ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_1) and arg_146_1.var_.characterEffect1069ui_story == nil then
				arg_146_1.var_.characterEffect1069ui_story = var_149_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_2 and not isNil(var_149_1) then
				if arg_146_1.var_.characterEffect1069ui_story and not isNil(var_149_1) then
					arg_146_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_146_1.time_ - 0) / var_149_2)
				end
			end

			if arg_146_1.time_ >= 0 + var_149_2 and arg_146_1.time_ < 0 + var_149_2 + arg_149_0 and not isNil(var_149_1) and arg_146_1.var_.characterEffect1069ui_story then
				arg_146_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_149_3 = arg_146_1.actors_["1076ui_story"].transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1076ui_story = var_149_3.localPosition
			end

			local var_149_4 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_4 then
				var_149_3.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_146_1.time_ - 0) / var_149_4)
				var_149_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_3.position).x, (manager.ui.mainCamera.transform.position - var_149_3.position).y, (manager.ui.mainCamera.transform.position - var_149_3.position).z)
				var_149_3.localEulerAngles.z = 0
				var_149_3.localEulerAngles.x = 0
				var_149_3.localEulerAngles = var_149_3.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_4 and arg_146_1.time_ < 0 + var_149_4 + arg_149_0 then
				var_149_3.localPosition = Vector3.New(0, 100, 0)
				var_149_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_3.position).x, (manager.ui.mainCamera.transform.position - var_149_3.position).y, (manager.ui.mainCamera.transform.position - var_149_3.position).z)
				var_149_3.localEulerAngles.z = 0
				var_149_3.localEulerAngles.x = 0
				var_149_3.localEulerAngles = var_149_3.localEulerAngles
			end

			local var_149_5 = arg_146_1.actors_["1076ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_5) and arg_146_1.var_.characterEffect1076ui_story == nil then
				arg_146_1.var_.characterEffect1076ui_story = var_149_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_6 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_6 and not isNil(var_149_5) then
				if arg_146_1.var_.characterEffect1076ui_story and not isNil(var_149_5) then
					arg_146_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_146_1.time_ - 0) / var_149_6)
				end
			end

			if arg_146_1.time_ >= 0 + var_149_6 and arg_146_1.time_ < 0 + var_149_6 + arg_149_0 and not isNil(var_149_5) and arg_146_1.var_.characterEffect1076ui_story then
				arg_146_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_149_7 = 0
			local var_149_8 = 1.3

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_7 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_9 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(121471035).content)

				arg_146_1.text_.text = var_149_9

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_11 = 52 <= 0 and var_149_8 or var_149_8 * (utf8.len(var_149_9) / 52)

				if (52 <= 0 and var_149_8 or var_149_8 * (utf8.len(var_149_9) / 52)) > 0 and var_149_8 < var_149_11 then
					arg_146_1.talkMaxDuration = var_149_11

					if var_149_11 + var_149_7 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_11 + var_149_7
					end
				end

				arg_146_1.text_.text = var_149_9
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_12 = math.max(var_149_8, arg_146_1.talkMaxDuration)

			if var_149_7 <= arg_146_1.time_ and arg_146_1.time_ < var_149_7 + var_149_12 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_7) / var_149_12

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_7 + var_149_12 and arg_146_1.time_ < var_149_7 + var_149_12 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play121471036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 121471036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play121471037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_walk", "")
			end

			local var_153_1 = 0
			local var_153_2 = 0.775

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_3 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(121471036).content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 31 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_3) / 31)

				if (31 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_3) / 31)) > 0 and var_153_2 < var_153_5 then
					arg_150_1.talkMaxDuration = var_153_5

					if var_153_5 + var_153_1 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + var_153_1
					end
				end

				arg_150_1.text_.text = var_153_3
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_6 = math.max(var_153_2, arg_150_1.talkMaxDuration)

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_6 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_1) / var_153_6

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_1 + var_153_6 and arg_150_1.time_ < var_153_1 + var_153_6 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play121471037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 121471037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play121471038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0.925

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_1 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(121471037).content)

				arg_154_1.text_.text = var_157_1

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_3 = 37 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 37)

				if (37 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 37)) > 0 and var_157_0 < var_157_3 then
					arg_154_1.talkMaxDuration = var_157_3

					if var_157_3 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_3 + 0
					end
				end

				arg_154_1.text_.text = var_157_1
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_4 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_4

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play121471038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 121471038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play121471039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 1.15

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_1 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(121471038).content)

				arg_158_1.text_.text = var_161_1

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_3 = 46 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 46)

				if (46 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 46)) > 0 and var_161_0 < var_161_3 then
					arg_158_1.talkMaxDuration = var_161_3

					if var_161_3 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_3 + 0
					end
				end

				arg_158_1.text_.text = var_161_1
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_4 = math.max(var_161_0, arg_158_1.talkMaxDuration)

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_4 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - 0) / var_161_4

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= 0 + var_161_4 and arg_158_1.time_ < 0 + var_161_4 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play121471039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 121471039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play121471040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 1.475

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_1 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(121471039).content)

				arg_162_1.text_.text = var_165_1

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_3 = 59 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 59)

				if (59 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 59)) > 0 and var_165_0 < var_165_3 then
					arg_162_1.talkMaxDuration = var_165_3

					if var_165_3 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_3 + 0
					end
				end

				arg_162_1.text_.text = var_165_1
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_4 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_4

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play121471040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 121471040
		arg_166_1.duration_ = 6.23

		local var_166_0 = {
			ja = 4.733,
			ko = 6.233,
			zh = 6.233
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play121471041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if arg_166_1.actors_["10042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10042ui_story"))) then
				local var_169_0 = Object.Instantiate(Asset.Load("Char/" .. "10042ui_story"), arg_166_1.stage_.transform)

				var_169_0.name = "10042ui_story"
				var_169_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.actors_["10042ui_story"] = var_169_0

				local var_169_1 = var_169_0:GetComponentInChildren(typeof(CharacterEffect))

				var_169_1.enabled = true

				local var_169_2 = GameObjectTools.GetOrAddComponent(var_169_0, typeof(DynamicBoneHelper))

				if var_169_2 then
					var_169_2:EnableDynamicBone(false)
				end

				arg_166_1:ShowWeapon(var_169_1.transform, false)

				arg_166_1.var_["10042ui_story" .. "Animator"] = var_169_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_166_1.var_["10042ui_story" .. "Animator"].applyRootMotion = true
				arg_166_1.var_["10042ui_story" .. "LipSync"] = var_169_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_169_3 = arg_166_1.actors_["10042ui_story"].transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos10042ui_story = var_169_3.localPosition
			end

			local var_169_4 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_4 then
				var_169_3.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10042ui_story, Vector3.New(0, -1.12, -6.2), (arg_166_1.time_ - 0) / var_169_4)
				var_169_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_3.position).x, (manager.ui.mainCamera.transform.position - var_169_3.position).y, (manager.ui.mainCamera.transform.position - var_169_3.position).z)
				var_169_3.localEulerAngles.z = 0
				var_169_3.localEulerAngles.x = 0
				var_169_3.localEulerAngles = var_169_3.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 then
				var_169_3.localPosition = Vector3.New(0, -1.12, -6.2)
				var_169_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_3.position).x, (manager.ui.mainCamera.transform.position - var_169_3.position).y, (manager.ui.mainCamera.transform.position - var_169_3.position).z)
				var_169_3.localEulerAngles.z = 0
				var_169_3.localEulerAngles.x = 0
				var_169_3.localEulerAngles = var_169_3.localEulerAngles
			end

			local var_169_5 = arg_166_1.actors_["10042ui_story"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_5) and arg_166_1.var_.characterEffect10042ui_story == nil then
				arg_166_1.var_.characterEffect10042ui_story = var_169_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_6 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_6 and not isNil(var_169_5) then
				if arg_166_1.var_.characterEffect10042ui_story and not isNil(var_169_5) then
					arg_166_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_6 and arg_166_1.time_ < 0 + var_169_6 + arg_169_0 and not isNil(var_169_5) and arg_166_1.var_.characterEffect10042ui_story then
				arg_166_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action1_1")
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_169_8 = 0
			local var_169_9 = 0.55

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_8 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_10 = arg_166_1:GetWordFromCfg(121471040)
				local var_169_11 = arg_166_1:FormatText(var_169_10.content)

				arg_166_1.text_.text = var_169_11

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_13 = 22 <= 0 and var_169_9 or var_169_9 * (utf8.len(var_169_11) / 22)

				if (22 <= 0 and var_169_9 or var_169_9 * (utf8.len(var_169_11) / 22)) > 0 and var_169_9 < var_169_13 then
					arg_166_1.talkMaxDuration = var_169_13

					if var_169_13 + var_169_8 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_13 + var_169_8
					end
				end

				arg_166_1.text_.text = var_169_11
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471040", "story_v_out_121471.awb") ~= 0 then
					local var_169_14 = manager.audio:GetVoiceLength("story_v_out_121471", "121471040", "story_v_out_121471.awb") / 1000

					if var_169_14 + var_169_8 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_14 + var_169_8
					end

					if var_169_10.prefab_name ~= "" and arg_166_1.actors_[var_169_10.prefab_name] ~= nil then
						local var_169_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_10.prefab_name].transform, "story_v_out_121471", "121471040", "story_v_out_121471.awb")

						arg_166_1:RecordAudio("121471040", var_169_15)
						arg_166_1:RecordAudio("121471040", var_169_15)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_121471", "121471040", "story_v_out_121471.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_121471", "121471040", "story_v_out_121471.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_16 = math.max(var_169_9, arg_166_1.talkMaxDuration)

			if var_169_8 <= arg_166_1.time_ and arg_166_1.time_ < var_169_8 + var_169_16 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_8) / var_169_16

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_8 + var_169_16 and arg_166_1.time_ < var_169_8 + var_169_16 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play121471041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 121471041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play121471042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["10042ui_story"]) and arg_170_1.var_.characterEffect10042ui_story == nil then
				arg_170_1.var_.characterEffect10042ui_story = arg_170_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_0 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["10042ui_story"]) then
				if arg_170_1.var_.characterEffect10042ui_story and not isNil(arg_170_1.actors_["10042ui_story"]) then
					arg_170_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_170_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_170_1.time_ - 0) / var_173_0)
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["10042ui_story"]) and arg_170_1.var_.characterEffect10042ui_story then
				arg_170_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_170_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			local var_173_1 = 0
			local var_173_2 = 0.075

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_3 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(121471041).content)

				arg_170_1.text_.text = var_173_3

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 3 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_3) / 3)

				if (3 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_3) / 3)) > 0 and var_173_2 < var_173_5 then
					arg_170_1.talkMaxDuration = var_173_5

					if var_173_5 + var_173_1 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + var_173_1
					end
				end

				arg_170_1.text_.text = var_173_3
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_6 = math.max(var_173_2, arg_170_1.talkMaxDuration)

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_6 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_1) / var_173_6

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_1 + var_173_6 and arg_170_1.time_ < var_173_1 + var_173_6 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play121471042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 121471042
		arg_174_1.duration_ = 7

		local var_174_0 = {
			ja = 5.633,
			ko = 7,
			zh = 7
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play121471043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos10042ui_story = arg_174_1.actors_["10042ui_story"].transform.localPosition
			end

			local var_177_0 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 then
				arg_174_1.actors_["10042ui_story"].transform.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10042ui_story, Vector3.New(0, 100, 0), (arg_174_1.time_ - 0) / var_177_0)
				arg_174_1.actors_["10042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["10042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["10042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["10042ui_story"].transform.position).z)
				arg_174_1.actors_["10042ui_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["10042ui_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["10042ui_story"].transform.localEulerAngles = arg_174_1.actors_["10042ui_story"].transform.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 then
				arg_174_1.actors_["10042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_174_1.actors_["10042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["10042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["10042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["10042ui_story"].transform.position).z)
				arg_174_1.actors_["10042ui_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["10042ui_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["10042ui_story"].transform.localEulerAngles = arg_174_1.actors_["10042ui_story"].transform.localEulerAngles
			end

			local var_177_1 = arg_174_1.actors_["10042ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_1) and arg_174_1.var_.characterEffect10042ui_story == nil then
				arg_174_1.var_.characterEffect10042ui_story = var_177_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_2 and not isNil(var_177_1) then
				if arg_174_1.var_.characterEffect10042ui_story and not isNil(var_177_1) then
					arg_174_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_174_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_2)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_2 and arg_174_1.time_ < 0 + var_177_2 + arg_177_0 and not isNil(var_177_1) and arg_174_1.var_.characterEffect10042ui_story then
				arg_174_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_174_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			local var_177_3 = "1084ui_story"

			if arg_174_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_177_4 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_174_1.stage_.transform)

				var_177_4.name = var_177_3
				var_177_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_174_1.actors_[var_177_3] = var_177_4

				local var_177_5 = var_177_4:GetComponentInChildren(typeof(CharacterEffect))

				var_177_5.enabled = true

				local var_177_6 = GameObjectTools.GetOrAddComponent(var_177_4, typeof(DynamicBoneHelper))

				if var_177_6 then
					var_177_6:EnableDynamicBone(false)
				end

				arg_174_1:ShowWeapon(var_177_5.transform, false)

				arg_174_1.var_[var_177_3 .. "Animator"] = var_177_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_174_1.var_[var_177_3 .. "Animator"].applyRootMotion = true
				arg_174_1.var_[var_177_3 .. "LipSync"] = var_177_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_177_7 = arg_174_1.actors_["1084ui_story"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1084ui_story = var_177_7.localPosition
			end

			local var_177_8 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_8 then
				var_177_7.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_174_1.time_ - 0) / var_177_8)
				var_177_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_7.position).x, (manager.ui.mainCamera.transform.position - var_177_7.position).y, (manager.ui.mainCamera.transform.position - var_177_7.position).z)
				var_177_7.localEulerAngles.z = 0
				var_177_7.localEulerAngles.x = 0
				var_177_7.localEulerAngles = var_177_7.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_8 and arg_174_1.time_ < 0 + var_177_8 + arg_177_0 then
				var_177_7.localPosition = Vector3.New(0, -0.97, -6)
				var_177_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_7.position).x, (manager.ui.mainCamera.transform.position - var_177_7.position).y, (manager.ui.mainCamera.transform.position - var_177_7.position).z)
				var_177_7.localEulerAngles.z = 0
				var_177_7.localEulerAngles.x = 0
				var_177_7.localEulerAngles = var_177_7.localEulerAngles
			end

			local var_177_9 = arg_174_1.actors_["1084ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_9) and arg_174_1.var_.characterEffect1084ui_story == nil then
				arg_174_1.var_.characterEffect1084ui_story = var_177_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_10 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_10 and not isNil(var_177_9) then
				if arg_174_1.var_.characterEffect1084ui_story and not isNil(var_177_9) then
					arg_174_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_10 and arg_174_1.time_ < 0 + var_177_10 + arg_177_0 and not isNil(var_177_9) and arg_174_1.var_.characterEffect1084ui_story then
				arg_174_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_177_12 = 0
			local var_177_13 = 0.875

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_12 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_14 = arg_174_1:GetWordFromCfg(121471042)
				local var_177_15 = arg_174_1:FormatText(var_177_14.content)

				arg_174_1.text_.text = var_177_15

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_17 = 35 <= 0 and var_177_13 or var_177_13 * (utf8.len(var_177_15) / 35)

				if (35 <= 0 and var_177_13 or var_177_13 * (utf8.len(var_177_15) / 35)) > 0 and var_177_13 < var_177_17 then
					arg_174_1.talkMaxDuration = var_177_17

					if var_177_17 + var_177_12 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_17 + var_177_12
					end
				end

				arg_174_1.text_.text = var_177_15
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471042", "story_v_out_121471.awb") ~= 0 then
					local var_177_18 = manager.audio:GetVoiceLength("story_v_out_121471", "121471042", "story_v_out_121471.awb") / 1000

					if var_177_18 + var_177_12 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_18 + var_177_12
					end

					if var_177_14.prefab_name ~= "" and arg_174_1.actors_[var_177_14.prefab_name] ~= nil then
						local var_177_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_14.prefab_name].transform, "story_v_out_121471", "121471042", "story_v_out_121471.awb")

						arg_174_1:RecordAudio("121471042", var_177_19)
						arg_174_1:RecordAudio("121471042", var_177_19)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_121471", "121471042", "story_v_out_121471.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_121471", "121471042", "story_v_out_121471.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_20 = math.max(var_177_13, arg_174_1.talkMaxDuration)

			if var_177_12 <= arg_174_1.time_ and arg_174_1.time_ < var_177_12 + var_177_20 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_12) / var_177_20

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_12 + var_177_20 and arg_174_1.time_ < var_177_12 + var_177_20 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play121471043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 121471043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play121471044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["1084ui_story"]) and arg_178_1.var_.characterEffect1084ui_story == nil then
				arg_178_1.var_.characterEffect1084ui_story = arg_178_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_0 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["1084ui_story"]) then
				if arg_178_1.var_.characterEffect1084ui_story and not isNil(arg_178_1.actors_["1084ui_story"]) then
					arg_178_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_0)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["1084ui_story"]) and arg_178_1.var_.characterEffect1084ui_story then
				arg_178_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_181_1 = 0
			local var_181_2 = 0.85

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_3 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(121471043).content)

				arg_178_1.text_.text = var_181_3

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 34 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_3) / 34)

				if (34 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_3) / 34)) > 0 and var_181_2 < var_181_5 then
					arg_178_1.talkMaxDuration = var_181_5

					if var_181_5 + var_181_1 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_5 + var_181_1
					end
				end

				arg_178_1.text_.text = var_181_3
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_6 = math.max(var_181_2, arg_178_1.talkMaxDuration)

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_6 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_1) / var_181_6

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_1 + var_181_6 and arg_178_1.time_ < var_181_1 + var_181_6 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play121471044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 121471044
		arg_182_1.duration_ = 5

		local var_182_0 = {
			ja = 5,
			ko = 2,
			zh = 2
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play121471045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos1084ui_story = arg_182_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_185_0 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 then
				arg_182_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_182_1.time_ - 0) / var_185_0)
				arg_182_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1084ui_story"].transform.position).z)
				arg_182_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["1084ui_story"].transform.localEulerAngles = arg_182_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 then
				arg_182_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_182_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1084ui_story"].transform.position).z)
				arg_182_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["1084ui_story"].transform.localEulerAngles = arg_182_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_185_1 = arg_182_1.actors_["1084ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1084ui_story == nil then
				arg_182_1.var_.characterEffect1084ui_story = var_185_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 and not isNil(var_185_1) then
				if arg_182_1.var_.characterEffect1084ui_story and not isNil(var_185_1) then
					arg_182_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_2)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1084ui_story then
				arg_182_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_185_3 = arg_182_1.actors_["10042ui_story"].transform

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos10042ui_story = var_185_3.localPosition
			end

			local var_185_4 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_4 then
				var_185_3.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10042ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_182_1.time_ - 0) / var_185_4)
				var_185_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_3.position).x, (manager.ui.mainCamera.transform.position - var_185_3.position).y, (manager.ui.mainCamera.transform.position - var_185_3.position).z)
				var_185_3.localEulerAngles.z = 0
				var_185_3.localEulerAngles.x = 0
				var_185_3.localEulerAngles = var_185_3.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_4 and arg_182_1.time_ < 0 + var_185_4 + arg_185_0 then
				var_185_3.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				var_185_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_3.position).x, (manager.ui.mainCamera.transform.position - var_185_3.position).y, (manager.ui.mainCamera.transform.position - var_185_3.position).z)
				var_185_3.localEulerAngles.z = 0
				var_185_3.localEulerAngles.x = 0
				var_185_3.localEulerAngles = var_185_3.localEulerAngles
			end

			local var_185_5 = arg_182_1.actors_["10042ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_5) and arg_182_1.var_.characterEffect10042ui_story == nil then
				arg_182_1.var_.characterEffect10042ui_story = var_185_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_6 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_6 and not isNil(var_185_5) then
				if arg_182_1.var_.characterEffect10042ui_story and not isNil(var_185_5) then
					arg_182_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_6 and arg_182_1.time_ < 0 + var_185_6 + arg_185_0 and not isNil(var_185_5) and arg_182_1.var_.characterEffect10042ui_story then
				arg_182_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action1_1")
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_185_8 = arg_182_1.actors_["1076ui_story"].transform

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos1076ui_story = var_185_8.localPosition
			end

			local var_185_9 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_9 then
				var_185_8.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_182_1.time_ - 0) / var_185_9)
				var_185_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_8.position).x, (manager.ui.mainCamera.transform.position - var_185_8.position).y, (manager.ui.mainCamera.transform.position - var_185_8.position).z)
				var_185_8.localEulerAngles.z = 0
				var_185_8.localEulerAngles.x = 0
				var_185_8.localEulerAngles = var_185_8.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_9 and arg_182_1.time_ < 0 + var_185_9 + arg_185_0 then
				var_185_8.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_185_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_8.position).x, (manager.ui.mainCamera.transform.position - var_185_8.position).y, (manager.ui.mainCamera.transform.position - var_185_8.position).z)
				var_185_8.localEulerAngles.z = 0
				var_185_8.localEulerAngles.x = 0
				var_185_8.localEulerAngles = var_185_8.localEulerAngles
			end

			local var_185_10 = arg_182_1.actors_["1076ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_10) and arg_182_1.var_.characterEffect1076ui_story == nil then
				arg_182_1.var_.characterEffect1076ui_story = var_185_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_11 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_11 and not isNil(var_185_10) then
				if arg_182_1.var_.characterEffect1076ui_story and not isNil(var_185_10) then
					arg_182_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_11)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_11 and arg_182_1.time_ < 0 + var_185_11 + arg_185_0 and not isNil(var_185_10) and arg_182_1.var_.characterEffect1076ui_story then
				arg_182_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_185_12 = 0
			local var_185_13 = 0.2

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_12 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_14 = arg_182_1:GetWordFromCfg(121471044)
				local var_185_15 = arg_182_1:FormatText(var_185_14.content)

				arg_182_1.text_.text = var_185_15

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_17 = 8 <= 0 and var_185_13 or var_185_13 * (utf8.len(var_185_15) / 8)

				if (8 <= 0 and var_185_13 or var_185_13 * (utf8.len(var_185_15) / 8)) > 0 and var_185_13 < var_185_17 then
					arg_182_1.talkMaxDuration = var_185_17

					if var_185_17 + var_185_12 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_17 + var_185_12
					end
				end

				arg_182_1.text_.text = var_185_15
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471044", "story_v_out_121471.awb") ~= 0 then
					local var_185_18 = manager.audio:GetVoiceLength("story_v_out_121471", "121471044", "story_v_out_121471.awb") / 1000

					if var_185_18 + var_185_12 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_18 + var_185_12
					end

					if var_185_14.prefab_name ~= "" and arg_182_1.actors_[var_185_14.prefab_name] ~= nil then
						local var_185_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_14.prefab_name].transform, "story_v_out_121471", "121471044", "story_v_out_121471.awb")

						arg_182_1:RecordAudio("121471044", var_185_19)
						arg_182_1:RecordAudio("121471044", var_185_19)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_121471", "121471044", "story_v_out_121471.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_121471", "121471044", "story_v_out_121471.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_20 = math.max(var_185_13, arg_182_1.talkMaxDuration)

			if var_185_12 <= arg_182_1.time_ and arg_182_1.time_ < var_185_12 + var_185_20 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_12) / var_185_20

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_12 + var_185_20 and arg_182_1.time_ < var_185_12 + var_185_20 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play121471045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 121471045
		arg_186_1.duration_ = 8.1

		local var_186_0 = {
			ja = 4.833,
			ko = 8.1,
			zh = 8.1
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play121471046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["10042ui_story"]) and arg_186_1.var_.characterEffect10042ui_story == nil then
				arg_186_1.var_.characterEffect10042ui_story = arg_186_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["10042ui_story"]) then
				if arg_186_1.var_.characterEffect10042ui_story and not isNil(arg_186_1.actors_["10042ui_story"]) then
					arg_186_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_186_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_0)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["10042ui_story"]) and arg_186_1.var_.characterEffect10042ui_story then
				arg_186_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_186_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			local var_189_1 = arg_186_1.actors_["1076ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect1076ui_story == nil then
				arg_186_1.var_.characterEffect1076ui_story = var_189_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_2 and not isNil(var_189_1) then
				if arg_186_1.var_.characterEffect1076ui_story and not isNil(var_189_1) then
					arg_186_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_2 and arg_186_1.time_ < 0 + var_189_2 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect1076ui_story then
				arg_186_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_189_4 = 0
			local var_189_5 = 0.825

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_4 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_6 = arg_186_1:GetWordFromCfg(121471045)
				local var_189_7 = arg_186_1:FormatText(var_189_6.content)

				arg_186_1.text_.text = var_189_7

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_9 = 33 <= 0 and var_189_5 or var_189_5 * (utf8.len(var_189_7) / 33)

				if (33 <= 0 and var_189_5 or var_189_5 * (utf8.len(var_189_7) / 33)) > 0 and var_189_5 < var_189_9 then
					arg_186_1.talkMaxDuration = var_189_9

					if var_189_9 + var_189_4 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_9 + var_189_4
					end
				end

				arg_186_1.text_.text = var_189_7
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471045", "story_v_out_121471.awb") ~= 0 then
					local var_189_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471045", "story_v_out_121471.awb") / 1000

					if var_189_10 + var_189_4 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_10 + var_189_4
					end

					if var_189_6.prefab_name ~= "" and arg_186_1.actors_[var_189_6.prefab_name] ~= nil then
						local var_189_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_6.prefab_name].transform, "story_v_out_121471", "121471045", "story_v_out_121471.awb")

						arg_186_1:RecordAudio("121471045", var_189_11)
						arg_186_1:RecordAudio("121471045", var_189_11)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_121471", "121471045", "story_v_out_121471.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_121471", "121471045", "story_v_out_121471.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_12 = math.max(var_189_5, arg_186_1.talkMaxDuration)

			if var_189_4 <= arg_186_1.time_ and arg_186_1.time_ < var_189_4 + var_189_12 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_4) / var_189_12

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_4 + var_189_12 and arg_186_1.time_ < var_189_4 + var_189_12 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play121471046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 121471046
		arg_190_1.duration_ = 8.27

		local var_190_0 = {
			ja = 8.266,
			ko = 3.633,
			zh = 3.633
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play121471047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["10042ui_story"]) and arg_190_1.var_.characterEffect10042ui_story == nil then
				arg_190_1.var_.characterEffect10042ui_story = arg_190_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["10042ui_story"]) then
				if arg_190_1.var_.characterEffect10042ui_story and not isNil(arg_190_1.actors_["10042ui_story"]) then
					arg_190_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["10042ui_story"]) and arg_190_1.var_.characterEffect10042ui_story then
				arg_190_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_193_2 = arg_190_1.actors_["1076ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_2) and arg_190_1.var_.characterEffect1076ui_story == nil then
				arg_190_1.var_.characterEffect1076ui_story = var_193_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_3 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_3 and not isNil(var_193_2) then
				if arg_190_1.var_.characterEffect1076ui_story and not isNil(var_193_2) then
					arg_190_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_3)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_3 and arg_190_1.time_ < 0 + var_193_3 + arg_193_0 and not isNil(var_193_2) and arg_190_1.var_.characterEffect1076ui_story then
				arg_190_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_193_4 = 0
			local var_193_5 = 0.375

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_6 = arg_190_1:GetWordFromCfg(121471046)
				local var_193_7 = arg_190_1:FormatText(var_193_6.content)

				arg_190_1.text_.text = var_193_7

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 15 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 15)

				if (15 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 15)) > 0 and var_193_5 < var_193_9 then
					arg_190_1.talkMaxDuration = var_193_9

					if var_193_9 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_9 + var_193_4
					end
				end

				arg_190_1.text_.text = var_193_7
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471046", "story_v_out_121471.awb") ~= 0 then
					local var_193_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471046", "story_v_out_121471.awb") / 1000

					if var_193_10 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_10 + var_193_4
					end

					if var_193_6.prefab_name ~= "" and arg_190_1.actors_[var_193_6.prefab_name] ~= nil then
						local var_193_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_6.prefab_name].transform, "story_v_out_121471", "121471046", "story_v_out_121471.awb")

						arg_190_1:RecordAudio("121471046", var_193_11)
						arg_190_1:RecordAudio("121471046", var_193_11)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_121471", "121471046", "story_v_out_121471.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_121471", "121471046", "story_v_out_121471.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_12 = math.max(var_193_5, arg_190_1.talkMaxDuration)

			if var_193_4 <= arg_190_1.time_ and arg_190_1.time_ < var_193_4 + var_193_12 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_4) / var_193_12

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_4 + var_193_12 and arg_190_1.time_ < var_193_4 + var_193_12 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play121471047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 121471047
		arg_194_1.duration_ = 10.67

		local var_194_0 = {
			ja = 10.666,
			ko = 9.333,
			zh = 9.333
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play121471048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 1.175

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_1 = arg_194_1:GetWordFromCfg(121471047)
				local var_197_2 = arg_194_1:FormatText(var_197_1.content)

				arg_194_1.text_.text = var_197_2

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_4 = 47 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 47)

				if (47 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 47)) > 0 and var_197_0 < var_197_4 then
					arg_194_1.talkMaxDuration = var_197_4

					if var_197_4 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_4 + 0
					end
				end

				arg_194_1.text_.text = var_197_2
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471047", "story_v_out_121471.awb") ~= 0 then
					local var_197_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471047", "story_v_out_121471.awb") / 1000

					if var_197_5 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + 0
					end

					if var_197_1.prefab_name ~= "" and arg_194_1.actors_[var_197_1.prefab_name] ~= nil then
						local var_197_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_1.prefab_name].transform, "story_v_out_121471", "121471047", "story_v_out_121471.awb")

						arg_194_1:RecordAudio("121471047", var_197_6)
						arg_194_1:RecordAudio("121471047", var_197_6)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_121471", "121471047", "story_v_out_121471.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_121471", "121471047", "story_v_out_121471.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_7 = math.max(var_197_0, arg_194_1.talkMaxDuration)

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_7 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - 0) / var_197_7

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= 0 + var_197_7 and arg_194_1.time_ < 0 + var_197_7 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play121471048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 121471048
		arg_198_1.duration_ = 12.07

		local var_198_0 = {
			ja = 12.066,
			ko = 11.966,
			zh = 11.966
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play121471049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 1.225

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_1 = arg_198_1:GetWordFromCfg(121471048)
				local var_201_2 = arg_198_1:FormatText(var_201_1.content)

				arg_198_1.text_.text = var_201_2

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_4 = 49 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_2) / 49)

				if (49 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_2) / 49)) > 0 and var_201_0 < var_201_4 then
					arg_198_1.talkMaxDuration = var_201_4

					if var_201_4 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_4 + 0
					end
				end

				arg_198_1.text_.text = var_201_2
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471048", "story_v_out_121471.awb") ~= 0 then
					local var_201_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471048", "story_v_out_121471.awb") / 1000

					if var_201_5 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + 0
					end

					if var_201_1.prefab_name ~= "" and arg_198_1.actors_[var_201_1.prefab_name] ~= nil then
						local var_201_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_1.prefab_name].transform, "story_v_out_121471", "121471048", "story_v_out_121471.awb")

						arg_198_1:RecordAudio("121471048", var_201_6)
						arg_198_1:RecordAudio("121471048", var_201_6)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_121471", "121471048", "story_v_out_121471.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_121471", "121471048", "story_v_out_121471.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_7 = math.max(var_201_0, arg_198_1.talkMaxDuration)

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_7 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - 0) / var_201_7

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= 0 + var_201_7 and arg_198_1.time_ < 0 + var_201_7 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play121471049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 121471049
		arg_202_1.duration_ = 5.27

		local var_202_0 = {
			ja = 5.266,
			ko = 4.5,
			zh = 4.5
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play121471050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0.5

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_1 = arg_202_1:GetWordFromCfg(121471049)
				local var_205_2 = arg_202_1:FormatText(var_205_1.content)

				arg_202_1.text_.text = var_205_2

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_4 = 20 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 20)

				if (20 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 20)) > 0 and var_205_0 < var_205_4 then
					arg_202_1.talkMaxDuration = var_205_4

					if var_205_4 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_4 + 0
					end
				end

				arg_202_1.text_.text = var_205_2
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471049", "story_v_out_121471.awb") ~= 0 then
					local var_205_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471049", "story_v_out_121471.awb") / 1000

					if var_205_5 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + 0
					end

					if var_205_1.prefab_name ~= "" and arg_202_1.actors_[var_205_1.prefab_name] ~= nil then
						local var_205_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_1.prefab_name].transform, "story_v_out_121471", "121471049", "story_v_out_121471.awb")

						arg_202_1:RecordAudio("121471049", var_205_6)
						arg_202_1:RecordAudio("121471049", var_205_6)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_121471", "121471049", "story_v_out_121471.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_121471", "121471049", "story_v_out_121471.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_7 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_7 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_7

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_7 and arg_202_1.time_ < 0 + var_205_7 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play121471050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 121471050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play121471051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["10042ui_story"]) and arg_206_1.var_.characterEffect10042ui_story == nil then
				arg_206_1.var_.characterEffect10042ui_story = arg_206_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_0 = 0.2

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["10042ui_story"]) then
				if arg_206_1.var_.characterEffect10042ui_story and not isNil(arg_206_1.actors_["10042ui_story"]) then
					arg_206_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_206_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_206_1.time_ - 0) / var_209_0)
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["10042ui_story"]) and arg_206_1.var_.characterEffect10042ui_story then
				arg_206_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_206_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			local var_209_1 = 0
			local var_209_2 = 1.05

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_3 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(121471050).content)

				arg_206_1.text_.text = var_209_3

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_5 = 42 <= 0 and var_209_2 or var_209_2 * (utf8.len(var_209_3) / 42)

				if (42 <= 0 and var_209_2 or var_209_2 * (utf8.len(var_209_3) / 42)) > 0 and var_209_2 < var_209_5 then
					arg_206_1.talkMaxDuration = var_209_5

					if var_209_5 + var_209_1 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_5 + var_209_1
					end
				end

				arg_206_1.text_.text = var_209_3
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_6 = math.max(var_209_2, arg_206_1.talkMaxDuration)

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_6 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_1) / var_209_6

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_1 + var_209_6 and arg_206_1.time_ < var_209_1 + var_209_6 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play121471051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 121471051
		arg_210_1.duration_ = 10.77

		local var_210_0 = {
			ja = 10.766,
			ko = 6.033,
			zh = 6.033
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play121471052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["10042ui_story"]) and arg_210_1.var_.characterEffect10042ui_story == nil then
				arg_210_1.var_.characterEffect10042ui_story = arg_210_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["10042ui_story"]) then
				if arg_210_1.var_.characterEffect10042ui_story and not isNil(arg_210_1.actors_["10042ui_story"]) then
					arg_210_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["10042ui_story"]) and arg_210_1.var_.characterEffect10042ui_story then
				arg_210_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action2_1")
			end

			local var_213_2 = 0
			local var_213_3 = 0.625

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_2 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_4 = arg_210_1:GetWordFromCfg(121471051)
				local var_213_5 = arg_210_1:FormatText(var_213_4.content)

				arg_210_1.text_.text = var_213_5

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_7 = 25 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_5) / 25)

				if (25 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_5) / 25)) > 0 and var_213_3 < var_213_7 then
					arg_210_1.talkMaxDuration = var_213_7

					if var_213_7 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_2
					end
				end

				arg_210_1.text_.text = var_213_5
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471051", "story_v_out_121471.awb") ~= 0 then
					local var_213_8 = manager.audio:GetVoiceLength("story_v_out_121471", "121471051", "story_v_out_121471.awb") / 1000

					if var_213_8 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_8 + var_213_2
					end

					if var_213_4.prefab_name ~= "" and arg_210_1.actors_[var_213_4.prefab_name] ~= nil then
						local var_213_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_4.prefab_name].transform, "story_v_out_121471", "121471051", "story_v_out_121471.awb")

						arg_210_1:RecordAudio("121471051", var_213_9)
						arg_210_1:RecordAudio("121471051", var_213_9)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_121471", "121471051", "story_v_out_121471.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_121471", "121471051", "story_v_out_121471.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_3, arg_210_1.talkMaxDuration)

			if var_213_2 <= arg_210_1.time_ and arg_210_1.time_ < var_213_2 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_2) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_2 + var_213_10 and arg_210_1.time_ < var_213_2 + var_213_10 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play121471052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 121471052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play121471053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["10042ui_story"]) and arg_214_1.var_.characterEffect10042ui_story == nil then
				arg_214_1.var_.characterEffect10042ui_story = arg_214_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["10042ui_story"]) then
				if arg_214_1.var_.characterEffect10042ui_story and not isNil(arg_214_1.actors_["10042ui_story"]) then
					arg_214_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_214_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_0)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["10042ui_story"]) and arg_214_1.var_.characterEffect10042ui_story then
				arg_214_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_214_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			local var_217_1 = 0
			local var_217_2 = 0.65

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_3 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(121471052).content)

				arg_214_1.text_.text = var_217_3

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 26 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 26)

				if (26 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 26)) > 0 and var_217_2 < var_217_5 then
					arg_214_1.talkMaxDuration = var_217_5

					if var_217_5 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + var_217_1
					end
				end

				arg_214_1.text_.text = var_217_3
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_6 = math.max(var_217_2, arg_214_1.talkMaxDuration)

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_6 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_1) / var_217_6

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_1 + var_217_6 and arg_214_1.time_ < var_217_1 + var_217_6 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play121471053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 121471053
		arg_218_1.duration_ = 2

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play121471054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["1076ui_story"]) and arg_218_1.var_.characterEffect1076ui_story == nil then
				arg_218_1.var_.characterEffect1076ui_story = arg_218_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_0 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["1076ui_story"]) then
				if arg_218_1.var_.characterEffect1076ui_story and not isNil(arg_218_1.actors_["1076ui_story"]) then
					arg_218_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["1076ui_story"]) and arg_218_1.var_.characterEffect1076ui_story then
				arg_218_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_221_2 = 0
			local var_221_3 = 0.125

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_2 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_4 = arg_218_1:GetWordFromCfg(121471053)
				local var_221_5 = arg_218_1:FormatText(var_221_4.content)

				arg_218_1.text_.text = var_221_5

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_7 = 5 <= 0 and var_221_3 or var_221_3 * (utf8.len(var_221_5) / 5)

				if (5 <= 0 and var_221_3 or var_221_3 * (utf8.len(var_221_5) / 5)) > 0 and var_221_3 < var_221_7 then
					arg_218_1.talkMaxDuration = var_221_7

					if var_221_7 + var_221_2 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_7 + var_221_2
					end
				end

				arg_218_1.text_.text = var_221_5
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471053", "story_v_out_121471.awb") ~= 0 then
					local var_221_8 = manager.audio:GetVoiceLength("story_v_out_121471", "121471053", "story_v_out_121471.awb") / 1000

					if var_221_8 + var_221_2 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_8 + var_221_2
					end

					if var_221_4.prefab_name ~= "" and arg_218_1.actors_[var_221_4.prefab_name] ~= nil then
						local var_221_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_4.prefab_name].transform, "story_v_out_121471", "121471053", "story_v_out_121471.awb")

						arg_218_1:RecordAudio("121471053", var_221_9)
						arg_218_1:RecordAudio("121471053", var_221_9)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_121471", "121471053", "story_v_out_121471.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_121471", "121471053", "story_v_out_121471.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_10 = math.max(var_221_3, arg_218_1.talkMaxDuration)

			if var_221_2 <= arg_218_1.time_ and arg_218_1.time_ < var_221_2 + var_221_10 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_2) / var_221_10

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_2 + var_221_10 and arg_218_1.time_ < var_221_2 + var_221_10 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play121471054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 121471054
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play121471055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["1076ui_story"]) and arg_222_1.var_.characterEffect1076ui_story == nil then
				arg_222_1.var_.characterEffect1076ui_story = arg_222_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_0 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["1076ui_story"]) then
				if arg_222_1.var_.characterEffect1076ui_story and not isNil(arg_222_1.actors_["1076ui_story"]) then
					arg_222_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 0) / var_225_0)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["1076ui_story"]) and arg_222_1.var_.characterEffect1076ui_story then
				arg_222_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_225_1 = 0
			local var_225_2 = 1.625

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_3 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(121471054).content)

				arg_222_1.text_.text = var_225_3

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 65 <= 0 and var_225_2 or var_225_2 * (utf8.len(var_225_3) / 65)

				if (65 <= 0 and var_225_2 or var_225_2 * (utf8.len(var_225_3) / 65)) > 0 and var_225_2 < var_225_5 then
					arg_222_1.talkMaxDuration = var_225_5

					if var_225_5 + var_225_1 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + var_225_1
					end
				end

				arg_222_1.text_.text = var_225_3
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_6 = math.max(var_225_2, arg_222_1.talkMaxDuration)

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_6 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_1) / var_225_6

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_1 + var_225_6 and arg_222_1.time_ < var_225_1 + var_225_6 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play121471055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 121471055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play121471056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0.95

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_1 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(121471055).content)

				arg_226_1.text_.text = var_229_1

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_3 = 38 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 38)

				if (38 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 38)) > 0 and var_229_0 < var_229_3 then
					arg_226_1.talkMaxDuration = var_229_3

					if var_229_3 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_3 + 0
					end
				end

				arg_226_1.text_.text = var_229_1
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_4 = math.max(var_229_0, arg_226_1.talkMaxDuration)

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_4 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - 0) / var_229_4

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= 0 + var_229_4 and arg_226_1.time_ < 0 + var_229_4 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play121471056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 121471056
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play121471057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 1.325

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_1 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(121471056).content)

				arg_230_1.text_.text = var_233_1

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_3 = 51 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 51)

				if (51 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 51)) > 0 and var_233_0 < var_233_3 then
					arg_230_1.talkMaxDuration = var_233_3

					if var_233_3 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_3 + 0
					end
				end

				arg_230_1.text_.text = var_233_1
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_4 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_4 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_4

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_4 and arg_230_1.time_ < 0 + var_233_4 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play121471057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 121471057
		arg_234_1.duration_ = 8.73

		local var_234_0 = {
			ja = 8.733,
			ko = 6.366,
			zh = 6.366
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play121471058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["1076ui_story"]) and arg_234_1.var_.characterEffect1076ui_story == nil then
				arg_234_1.var_.characterEffect1076ui_story = arg_234_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_0 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["1076ui_story"]) then
				if arg_234_1.var_.characterEffect1076ui_story and not isNil(arg_234_1.actors_["1076ui_story"]) then
					arg_234_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["1076ui_story"]) and arg_234_1.var_.characterEffect1076ui_story then
				arg_234_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_237_2 = 0
			local var_237_3 = 0.575

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_2 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_4 = arg_234_1:GetWordFromCfg(121471057)
				local var_237_5 = arg_234_1:FormatText(var_237_4.content)

				arg_234_1.text_.text = var_237_5

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_7 = 23 <= 0 and var_237_3 or var_237_3 * (utf8.len(var_237_5) / 23)

				if (23 <= 0 and var_237_3 or var_237_3 * (utf8.len(var_237_5) / 23)) > 0 and var_237_3 < var_237_7 then
					arg_234_1.talkMaxDuration = var_237_7

					if var_237_7 + var_237_2 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_7 + var_237_2
					end
				end

				arg_234_1.text_.text = var_237_5
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471057", "story_v_out_121471.awb") ~= 0 then
					local var_237_8 = manager.audio:GetVoiceLength("story_v_out_121471", "121471057", "story_v_out_121471.awb") / 1000

					if var_237_8 + var_237_2 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_8 + var_237_2
					end

					if var_237_4.prefab_name ~= "" and arg_234_1.actors_[var_237_4.prefab_name] ~= nil then
						local var_237_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_4.prefab_name].transform, "story_v_out_121471", "121471057", "story_v_out_121471.awb")

						arg_234_1:RecordAudio("121471057", var_237_9)
						arg_234_1:RecordAudio("121471057", var_237_9)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_121471", "121471057", "story_v_out_121471.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_121471", "121471057", "story_v_out_121471.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_10 = math.max(var_237_3, arg_234_1.talkMaxDuration)

			if var_237_2 <= arg_234_1.time_ and arg_234_1.time_ < var_237_2 + var_237_10 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_2) / var_237_10

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_2 + var_237_10 and arg_234_1.time_ < var_237_2 + var_237_10 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play121471058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 121471058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play121471059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["1076ui_story"]) and arg_238_1.var_.characterEffect1076ui_story == nil then
				arg_238_1.var_.characterEffect1076ui_story = arg_238_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["1076ui_story"]) then
				if arg_238_1.var_.characterEffect1076ui_story and not isNil(arg_238_1.actors_["1076ui_story"]) then
					arg_238_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_0)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["1076ui_story"]) and arg_238_1.var_.characterEffect1076ui_story then
				arg_238_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_241_1 = 0
			local var_241_2 = 1.15

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_3 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(121471058).content)

				arg_238_1.text_.text = var_241_3

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 46 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 46)

				if (46 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 46)) > 0 and var_241_2 < var_241_5 then
					arg_238_1.talkMaxDuration = var_241_5

					if var_241_5 + var_241_1 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + var_241_1
					end
				end

				arg_238_1.text_.text = var_241_3
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_6 = math.max(var_241_2, arg_238_1.talkMaxDuration)

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_6 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_1) / var_241_6

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_1 + var_241_6 and arg_238_1.time_ < var_241_1 + var_241_6 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play121471059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 121471059
		arg_242_1.duration_ = 6.6

		local var_242_0 = {
			ja = 6.6,
			ko = 2.6,
			zh = 2.6
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play121471060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0.325

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[437].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_1 = arg_242_1:GetWordFromCfg(121471059)
				local var_245_2 = arg_242_1:FormatText(var_245_1.content)

				arg_242_1.text_.text = var_245_2

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_4 = 13 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_2) / 13)

				if (13 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_2) / 13)) > 0 and var_245_0 < var_245_4 then
					arg_242_1.talkMaxDuration = var_245_4

					if var_245_4 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_4 + 0
					end
				end

				arg_242_1.text_.text = var_245_2
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471059", "story_v_out_121471.awb") ~= 0 then
					local var_245_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471059", "story_v_out_121471.awb") / 1000

					if var_245_5 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_5 + 0
					end

					if var_245_1.prefab_name ~= "" and arg_242_1.actors_[var_245_1.prefab_name] ~= nil then
						local var_245_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_1.prefab_name].transform, "story_v_out_121471", "121471059", "story_v_out_121471.awb")

						arg_242_1:RecordAudio("121471059", var_245_6)
						arg_242_1:RecordAudio("121471059", var_245_6)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_121471", "121471059", "story_v_out_121471.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_121471", "121471059", "story_v_out_121471.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_7 = math.max(var_245_0, arg_242_1.talkMaxDuration)

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_7 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - 0) / var_245_7

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= 0 + var_245_7 and arg_242_1.time_ < 0 + var_245_7 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play121471060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 121471060
		arg_246_1.duration_ = 4.03

		local var_246_0 = {
			ja = 4.033,
			ko = 3.733,
			zh = 3.733
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play121471061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0.475

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[438].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_1 = arg_246_1:GetWordFromCfg(121471060)
				local var_249_2 = arg_246_1:FormatText(var_249_1.content)

				arg_246_1.text_.text = var_249_2

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_4 = 19 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_2) / 19)

				if (19 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_2) / 19)) > 0 and var_249_0 < var_249_4 then
					arg_246_1.talkMaxDuration = var_249_4

					if var_249_4 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_4 + 0
					end
				end

				arg_246_1.text_.text = var_249_2
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471060", "story_v_out_121471.awb") ~= 0 then
					local var_249_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471060", "story_v_out_121471.awb") / 1000

					if var_249_5 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_5 + 0
					end

					if var_249_1.prefab_name ~= "" and arg_246_1.actors_[var_249_1.prefab_name] ~= nil then
						local var_249_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_1.prefab_name].transform, "story_v_out_121471", "121471060", "story_v_out_121471.awb")

						arg_246_1:RecordAudio("121471060", var_249_6)
						arg_246_1:RecordAudio("121471060", var_249_6)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_121471", "121471060", "story_v_out_121471.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_121471", "121471060", "story_v_out_121471.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_7 and arg_246_1.time_ < 0 + var_249_7 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play121471061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 121471061
		arg_250_1.duration_ = 7.83

		local var_250_0 = {
			ja = 7.833,
			ko = 4.433,
			zh = 4.433
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play121471062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0.65

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[439].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_1 = arg_250_1:GetWordFromCfg(121471061)
				local var_253_2 = arg_250_1:FormatText(var_253_1.content)

				arg_250_1.text_.text = var_253_2

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_4 = 26 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 26)

				if (26 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 26)) > 0 and var_253_0 < var_253_4 then
					arg_250_1.talkMaxDuration = var_253_4

					if var_253_4 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_4 + 0
					end
				end

				arg_250_1.text_.text = var_253_2
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471061", "story_v_out_121471.awb") ~= 0 then
					local var_253_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471061", "story_v_out_121471.awb") / 1000

					if var_253_5 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + 0
					end

					if var_253_1.prefab_name ~= "" and arg_250_1.actors_[var_253_1.prefab_name] ~= nil then
						local var_253_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_1.prefab_name].transform, "story_v_out_121471", "121471061", "story_v_out_121471.awb")

						arg_250_1:RecordAudio("121471061", var_253_6)
						arg_250_1:RecordAudio("121471061", var_253_6)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_121471", "121471061", "story_v_out_121471.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_121471", "121471061", "story_v_out_121471.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_7 = math.max(var_253_0, arg_250_1.talkMaxDuration)

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_7 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - 0) / var_253_7

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= 0 + var_253_7 and arg_250_1.time_ < 0 + var_253_7 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play121471062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 121471062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play121471063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 1.125

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_1 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(121471062).content)

				arg_254_1.text_.text = var_257_1

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_3 = 45 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 45)

				if (45 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 45)) > 0 and var_257_0 < var_257_3 then
					arg_254_1.talkMaxDuration = var_257_3

					if var_257_3 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_3 + 0
					end
				end

				arg_254_1.text_.text = var_257_1
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_4 = math.max(var_257_0, arg_254_1.talkMaxDuration)

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_4 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - 0) / var_257_4

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play121471063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 121471063
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play121471064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 1.275

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_1 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(121471063).content)

				arg_258_1.text_.text = var_261_1

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_3 = 51 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 51)

				if (51 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 51)) > 0 and var_261_0 < var_261_3 then
					arg_258_1.talkMaxDuration = var_261_3

					if var_261_3 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_3 + 0
					end
				end

				arg_258_1.text_.text = var_261_1
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_4 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_4

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play121471064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 121471064
		arg_262_1.duration_ = 12.43

		local var_262_0 = {
			ja = 12.433,
			ko = 10.4,
			zh = 10.4
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play121471065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042actionlink/10042action423")
			end

			local var_265_0 = arg_262_1.actors_["10042ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect10042ui_story == nil then
				arg_262_1.var_.characterEffect10042ui_story = var_265_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_1 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_1 and not isNil(var_265_0) then
				if arg_262_1.var_.characterEffect10042ui_story and not isNil(var_265_0) then
					arg_262_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= 0 + var_265_1 and arg_262_1.time_ < 0 + var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect10042ui_story then
				arg_262_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_265_3 = 0
			local var_265_4 = 1.05

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_3 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_5 = arg_262_1:GetWordFromCfg(121471064)
				local var_265_6 = arg_262_1:FormatText(var_265_5.content)

				arg_262_1.text_.text = var_265_6

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_8 = 42 <= 0 and var_265_4 or var_265_4 * (utf8.len(var_265_6) / 42)

				if (42 <= 0 and var_265_4 or var_265_4 * (utf8.len(var_265_6) / 42)) > 0 and var_265_4 < var_265_8 then
					arg_262_1.talkMaxDuration = var_265_8

					if var_265_8 + var_265_3 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_8 + var_265_3
					end
				end

				arg_262_1.text_.text = var_265_6
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471064", "story_v_out_121471.awb") ~= 0 then
					local var_265_9 = manager.audio:GetVoiceLength("story_v_out_121471", "121471064", "story_v_out_121471.awb") / 1000

					if var_265_9 + var_265_3 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_9 + var_265_3
					end

					if var_265_5.prefab_name ~= "" and arg_262_1.actors_[var_265_5.prefab_name] ~= nil then
						local var_265_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_5.prefab_name].transform, "story_v_out_121471", "121471064", "story_v_out_121471.awb")

						arg_262_1:RecordAudio("121471064", var_265_10)
						arg_262_1:RecordAudio("121471064", var_265_10)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_121471", "121471064", "story_v_out_121471.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_121471", "121471064", "story_v_out_121471.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_11 = math.max(var_265_4, arg_262_1.talkMaxDuration)

			if var_265_3 <= arg_262_1.time_ and arg_262_1.time_ < var_265_3 + var_265_11 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_3) / var_265_11

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_3 + var_265_11 and arg_262_1.time_ < var_265_3 + var_265_11 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play121471065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 121471065
		arg_266_1.duration_ = 12.7

		local var_266_0 = {
			ja = 12.7,
			ko = 9.066,
			zh = 9.066
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play121471066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0.975

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_1 = arg_266_1:GetWordFromCfg(121471065)
				local var_269_2 = arg_266_1:FormatText(var_269_1.content)

				arg_266_1.text_.text = var_269_2

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_4 = 39 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_2) / 39)

				if (39 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_2) / 39)) > 0 and var_269_0 < var_269_4 then
					arg_266_1.talkMaxDuration = var_269_4

					if var_269_4 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_4 + 0
					end
				end

				arg_266_1.text_.text = var_269_2
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471065", "story_v_out_121471.awb") ~= 0 then
					local var_269_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471065", "story_v_out_121471.awb") / 1000

					if var_269_5 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + 0
					end

					if var_269_1.prefab_name ~= "" and arg_266_1.actors_[var_269_1.prefab_name] ~= nil then
						local var_269_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_1.prefab_name].transform, "story_v_out_121471", "121471065", "story_v_out_121471.awb")

						arg_266_1:RecordAudio("121471065", var_269_6)
						arg_266_1:RecordAudio("121471065", var_269_6)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_121471", "121471065", "story_v_out_121471.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_121471", "121471065", "story_v_out_121471.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_7 = math.max(var_269_0, arg_266_1.talkMaxDuration)

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_7 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - 0) / var_269_7

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= 0 + var_269_7 and arg_266_1.time_ < 0 + var_269_7 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play121471066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 121471066
		arg_270_1.duration_ = 2.97

		local var_270_0 = {
			ja = 2.966,
			ko = 2.933,
			zh = 2.933
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play121471067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["10042ui_story"]) and arg_270_1.var_.characterEffect10042ui_story == nil then
				arg_270_1.var_.characterEffect10042ui_story = arg_270_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_0 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["10042ui_story"]) then
				if arg_270_1.var_.characterEffect10042ui_story and not isNil(arg_270_1.actors_["10042ui_story"]) then
					arg_270_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_270_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_270_1.time_ - 0) / var_273_0)
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["10042ui_story"]) and arg_270_1.var_.characterEffect10042ui_story then
				arg_270_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_270_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			local var_273_1 = arg_270_1.actors_["1076ui_story"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_1) and arg_270_1.var_.characterEffect1076ui_story == nil then
				arg_270_1.var_.characterEffect1076ui_story = var_273_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_2 and not isNil(var_273_1) then
				if arg_270_1.var_.characterEffect1076ui_story and not isNil(var_273_1) then
					arg_270_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= 0 + var_273_2 and arg_270_1.time_ < 0 + var_273_2 + arg_273_0 and not isNil(var_273_1) and arg_270_1.var_.characterEffect1076ui_story then
				arg_270_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_273_4 = 0
			local var_273_5 = 0.2

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_4 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_6 = arg_270_1:GetWordFromCfg(121471066)
				local var_273_7 = arg_270_1:FormatText(var_273_6.content)

				arg_270_1.text_.text = var_273_7

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_9 = 8 <= 0 and var_273_5 or var_273_5 * (utf8.len(var_273_7) / 8)

				if (8 <= 0 and var_273_5 or var_273_5 * (utf8.len(var_273_7) / 8)) > 0 and var_273_5 < var_273_9 then
					arg_270_1.talkMaxDuration = var_273_9

					if var_273_9 + var_273_4 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_9 + var_273_4
					end
				end

				arg_270_1.text_.text = var_273_7
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471066", "story_v_out_121471.awb") ~= 0 then
					local var_273_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471066", "story_v_out_121471.awb") / 1000

					if var_273_10 + var_273_4 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_10 + var_273_4
					end

					if var_273_6.prefab_name ~= "" and arg_270_1.actors_[var_273_6.prefab_name] ~= nil then
						local var_273_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_6.prefab_name].transform, "story_v_out_121471", "121471066", "story_v_out_121471.awb")

						arg_270_1:RecordAudio("121471066", var_273_11)
						arg_270_1:RecordAudio("121471066", var_273_11)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_121471", "121471066", "story_v_out_121471.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_121471", "121471066", "story_v_out_121471.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_12 = math.max(var_273_5, arg_270_1.talkMaxDuration)

			if var_273_4 <= arg_270_1.time_ and arg_270_1.time_ < var_273_4 + var_273_12 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_4) / var_273_12

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_4 + var_273_12 and arg_270_1.time_ < var_273_4 + var_273_12 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play121471067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 121471067
		arg_274_1.duration_ = 7.07

		local var_274_0 = {
			ja = 7.066,
			ko = 4.533,
			zh = 4.533
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play121471068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["10042ui_story"]) and arg_274_1.var_.characterEffect10042ui_story == nil then
				arg_274_1.var_.characterEffect10042ui_story = arg_274_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_0 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["10042ui_story"]) then
				if arg_274_1.var_.characterEffect10042ui_story and not isNil(arg_274_1.actors_["10042ui_story"]) then
					arg_274_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["10042ui_story"]) and arg_274_1.var_.characterEffect10042ui_story then
				arg_274_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_277_2 = arg_274_1.actors_["1076ui_story"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_2) and arg_274_1.var_.characterEffect1076ui_story == nil then
				arg_274_1.var_.characterEffect1076ui_story = var_277_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_3 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_3 and not isNil(var_277_2) then
				if arg_274_1.var_.characterEffect1076ui_story and not isNil(var_277_2) then
					arg_274_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_274_1.time_ - 0) / var_277_3)
				end
			end

			if arg_274_1.time_ >= 0 + var_277_3 and arg_274_1.time_ < 0 + var_277_3 + arg_277_0 and not isNil(var_277_2) and arg_274_1.var_.characterEffect1076ui_story then
				arg_274_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action3_2")
			end

			local var_277_4 = 0
			local var_277_5 = 0.625

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_4 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_6 = arg_274_1:GetWordFromCfg(121471067)
				local var_277_7 = arg_274_1:FormatText(var_277_6.content)

				arg_274_1.text_.text = var_277_7

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_9 = 25 <= 0 and var_277_5 or var_277_5 * (utf8.len(var_277_7) / 25)

				if (25 <= 0 and var_277_5 or var_277_5 * (utf8.len(var_277_7) / 25)) > 0 and var_277_5 < var_277_9 then
					arg_274_1.talkMaxDuration = var_277_9

					if var_277_9 + var_277_4 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_9 + var_277_4
					end
				end

				arg_274_1.text_.text = var_277_7
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471067", "story_v_out_121471.awb") ~= 0 then
					local var_277_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471067", "story_v_out_121471.awb") / 1000

					if var_277_10 + var_277_4 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_10 + var_277_4
					end

					if var_277_6.prefab_name ~= "" and arg_274_1.actors_[var_277_6.prefab_name] ~= nil then
						local var_277_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_6.prefab_name].transform, "story_v_out_121471", "121471067", "story_v_out_121471.awb")

						arg_274_1:RecordAudio("121471067", var_277_11)
						arg_274_1:RecordAudio("121471067", var_277_11)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_121471", "121471067", "story_v_out_121471.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_121471", "121471067", "story_v_out_121471.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_12 = math.max(var_277_5, arg_274_1.talkMaxDuration)

			if var_277_4 <= arg_274_1.time_ and arg_274_1.time_ < var_277_4 + var_277_12 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_4) / var_277_12

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_4 + var_277_12 and arg_274_1.time_ < var_277_4 + var_277_12 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play121471068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 121471068
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play121471069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(arg_278_1.actors_["10042ui_story"]) and arg_278_1.var_.characterEffect10042ui_story == nil then
				arg_278_1.var_.characterEffect10042ui_story = arg_278_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_0 = 0.200000002980232

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 and not isNil(arg_278_1.actors_["10042ui_story"]) then
				if arg_278_1.var_.characterEffect10042ui_story and not isNil(arg_278_1.actors_["10042ui_story"]) then
					arg_278_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_278_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_278_1.time_ - 0) / var_281_0)
				end
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 and not isNil(arg_278_1.actors_["10042ui_story"]) and arg_278_1.var_.characterEffect10042ui_story then
				arg_278_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_278_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			local var_281_1 = 0
			local var_281_2 = 1.175

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_3 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(121471068).content)

				arg_278_1.text_.text = var_281_3

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 47 <= 0 and var_281_2 or var_281_2 * (utf8.len(var_281_3) / 47)

				if (47 <= 0 and var_281_2 or var_281_2 * (utf8.len(var_281_3) / 47)) > 0 and var_281_2 < var_281_5 then
					arg_278_1.talkMaxDuration = var_281_5

					if var_281_5 + var_281_1 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_5 + var_281_1
					end
				end

				arg_278_1.text_.text = var_281_3
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_6 = math.max(var_281_2, arg_278_1.talkMaxDuration)

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_6 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_1) / var_281_6

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_1 + var_281_6 and arg_278_1.time_ < var_281_1 + var_281_6 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play121471069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 121471069
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play121471070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 1.475

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_1 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(121471069).content)

				arg_282_1.text_.text = var_285_1

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_3 = 59 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 59)

				if (59 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 59)) > 0 and var_285_0 < var_285_3 then
					arg_282_1.talkMaxDuration = var_285_3

					if var_285_3 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_3 + 0
					end
				end

				arg_282_1.text_.text = var_285_1
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_4 = math.max(var_285_0, arg_282_1.talkMaxDuration)

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_4 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - 0) / var_285_4

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= 0 + var_285_4 and arg_282_1.time_ < 0 + var_285_4 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play121471070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 121471070
		arg_286_1.duration_ = 4.67

		local var_286_0 = {
			ja = 4.666,
			ko = 4.066,
			zh = 4.066
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play121471071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(arg_286_1.actors_["10042ui_story"]) and arg_286_1.var_.characterEffect10042ui_story == nil then
				arg_286_1.var_.characterEffect10042ui_story = arg_286_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_0 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 and not isNil(arg_286_1.actors_["10042ui_story"]) then
				if arg_286_1.var_.characterEffect10042ui_story and not isNil(arg_286_1.actors_["10042ui_story"]) then
					arg_286_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 and not isNil(arg_286_1.actors_["10042ui_story"]) and arg_286_1.var_.characterEffect10042ui_story then
				arg_286_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_289_2 = 0
			local var_289_3 = 0.525

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_2 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_4 = arg_286_1:GetWordFromCfg(121471070)
				local var_289_5 = arg_286_1:FormatText(var_289_4.content)

				arg_286_1.text_.text = var_289_5

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_7 = 21 <= 0 and var_289_3 or var_289_3 * (utf8.len(var_289_5) / 21)

				if (21 <= 0 and var_289_3 or var_289_3 * (utf8.len(var_289_5) / 21)) > 0 and var_289_3 < var_289_7 then
					arg_286_1.talkMaxDuration = var_289_7

					if var_289_7 + var_289_2 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_7 + var_289_2
					end
				end

				arg_286_1.text_.text = var_289_5
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471070", "story_v_out_121471.awb") ~= 0 then
					local var_289_8 = manager.audio:GetVoiceLength("story_v_out_121471", "121471070", "story_v_out_121471.awb") / 1000

					if var_289_8 + var_289_2 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_8 + var_289_2
					end

					if var_289_4.prefab_name ~= "" and arg_286_1.actors_[var_289_4.prefab_name] ~= nil then
						local var_289_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_4.prefab_name].transform, "story_v_out_121471", "121471070", "story_v_out_121471.awb")

						arg_286_1:RecordAudio("121471070", var_289_9)
						arg_286_1:RecordAudio("121471070", var_289_9)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_121471", "121471070", "story_v_out_121471.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_121471", "121471070", "story_v_out_121471.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_10 = math.max(var_289_3, arg_286_1.talkMaxDuration)

			if var_289_2 <= arg_286_1.time_ and arg_286_1.time_ < var_289_2 + var_289_10 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_2) / var_289_10

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_2 + var_289_10 and arg_286_1.time_ < var_289_2 + var_289_10 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play121471071 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 121471071
		arg_290_1.duration_ = 1.9

		local var_290_0 = {
			ja = 1.9,
			ko = 1.133,
			zh = 1.133
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play121471072(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["10042ui_story"]) and arg_290_1.var_.characterEffect10042ui_story == nil then
				arg_290_1.var_.characterEffect10042ui_story = arg_290_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_0 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["10042ui_story"]) then
				if arg_290_1.var_.characterEffect10042ui_story and not isNil(arg_290_1.actors_["10042ui_story"]) then
					arg_290_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_290_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_290_1.time_ - 0) / var_293_0)
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["10042ui_story"]) and arg_290_1.var_.characterEffect10042ui_story then
				arg_290_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_290_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			local var_293_1 = arg_290_1.actors_["1076ui_story"]

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(var_293_1) and arg_290_1.var_.characterEffect1076ui_story == nil then
				arg_290_1.var_.characterEffect1076ui_story = var_293_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_2 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_2 and not isNil(var_293_1) then
				if arg_290_1.var_.characterEffect1076ui_story and not isNil(var_293_1) then
					arg_290_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= 0 + var_293_2 and arg_290_1.time_ < 0 + var_293_2 + arg_293_0 and not isNil(var_293_1) and arg_290_1.var_.characterEffect1076ui_story then
				arg_290_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_293_4 = 0
			local var_293_5 = 0.1

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_4 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_6 = arg_290_1:GetWordFromCfg(121471071)
				local var_293_7 = arg_290_1:FormatText(var_293_6.content)

				arg_290_1.text_.text = var_293_7

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_9 = 4 <= 0 and var_293_5 or var_293_5 * (utf8.len(var_293_7) / 4)

				if (4 <= 0 and var_293_5 or var_293_5 * (utf8.len(var_293_7) / 4)) > 0 and var_293_5 < var_293_9 then
					arg_290_1.talkMaxDuration = var_293_9

					if var_293_9 + var_293_4 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_9 + var_293_4
					end
				end

				arg_290_1.text_.text = var_293_7
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471071", "story_v_out_121471.awb") ~= 0 then
					local var_293_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471071", "story_v_out_121471.awb") / 1000

					if var_293_10 + var_293_4 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_10 + var_293_4
					end

					if var_293_6.prefab_name ~= "" and arg_290_1.actors_[var_293_6.prefab_name] ~= nil then
						local var_293_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_6.prefab_name].transform, "story_v_out_121471", "121471071", "story_v_out_121471.awb")

						arg_290_1:RecordAudio("121471071", var_293_11)
						arg_290_1:RecordAudio("121471071", var_293_11)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_121471", "121471071", "story_v_out_121471.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_121471", "121471071", "story_v_out_121471.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_12 = math.max(var_293_5, arg_290_1.talkMaxDuration)

			if var_293_4 <= arg_290_1.time_ and arg_290_1.time_ < var_293_4 + var_293_12 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_4) / var_293_12

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_4 + var_293_12 and arg_290_1.time_ < var_293_4 + var_293_12 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play121471072 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 121471072
		arg_294_1.duration_ = 5.93

		local var_294_0 = {
			ja = 5.933,
			ko = 3.533,
			zh = 3.533
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play121471073(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_walk", "")
			end

			local var_297_1 = 0
			local var_297_2 = 0.35

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_3 = arg_294_1:GetWordFromCfg(121471072)
				local var_297_4 = arg_294_1:FormatText(var_297_3.content)

				arg_294_1.text_.text = var_297_4

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_6 = 14 <= 0 and var_297_2 or var_297_2 * (utf8.len(var_297_4) / 14)

				if (14 <= 0 and var_297_2 or var_297_2 * (utf8.len(var_297_4) / 14)) > 0 and var_297_2 < var_297_6 then
					arg_294_1.talkMaxDuration = var_297_6

					if var_297_6 + var_297_1 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_6 + var_297_1
					end
				end

				arg_294_1.text_.text = var_297_4
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471072", "story_v_out_121471.awb") ~= 0 then
					local var_297_7 = manager.audio:GetVoiceLength("story_v_out_121471", "121471072", "story_v_out_121471.awb") / 1000

					if var_297_7 + var_297_1 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_7 + var_297_1
					end

					if var_297_3.prefab_name ~= "" and arg_294_1.actors_[var_297_3.prefab_name] ~= nil then
						local var_297_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_3.prefab_name].transform, "story_v_out_121471", "121471072", "story_v_out_121471.awb")

						arg_294_1:RecordAudio("121471072", var_297_8)
						arg_294_1:RecordAudio("121471072", var_297_8)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_121471", "121471072", "story_v_out_121471.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_121471", "121471072", "story_v_out_121471.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_9 = math.max(var_297_2, arg_294_1.talkMaxDuration)

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_9 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_1) / var_297_9

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_1 + var_297_9 and arg_294_1.time_ < var_297_1 + var_297_9 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play121471073 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 121471073
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play121471074(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos1076ui_story = arg_298_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_301_0 = 0.001

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 then
				arg_298_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_298_1.time_ - 0) / var_301_0)
				arg_298_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_298_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1076ui_story"].transform.position).z)
				arg_298_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_298_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_298_1.actors_["1076ui_story"].transform.localEulerAngles = arg_298_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 then
				arg_298_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_298_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_298_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1076ui_story"].transform.position).z)
				arg_298_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_298_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_298_1.actors_["1076ui_story"].transform.localEulerAngles = arg_298_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_301_1 = arg_298_1.actors_["10042ui_story"].transform

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos10042ui_story = var_301_1.localPosition
			end

			local var_301_2 = 0.001

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_2 then
				var_301_1.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos10042ui_story, Vector3.New(0, 100, 0), (arg_298_1.time_ - 0) / var_301_2)
				var_301_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_301_1.position).x, (manager.ui.mainCamera.transform.position - var_301_1.position).y, (manager.ui.mainCamera.transform.position - var_301_1.position).z)
				var_301_1.localEulerAngles.z = 0
				var_301_1.localEulerAngles.x = 0
				var_301_1.localEulerAngles = var_301_1.localEulerAngles
			end

			if arg_298_1.time_ >= 0 + var_301_2 and arg_298_1.time_ < 0 + var_301_2 + arg_301_0 then
				var_301_1.localPosition = Vector3.New(0, 100, 0)
				var_301_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_301_1.position).x, (manager.ui.mainCamera.transform.position - var_301_1.position).y, (manager.ui.mainCamera.transform.position - var_301_1.position).z)
				var_301_1.localEulerAngles.z = 0
				var_301_1.localEulerAngles.x = 0
				var_301_1.localEulerAngles = var_301_1.localEulerAngles
			end

			local var_301_3 = 0
			local var_301_4 = 0.625

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_3 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_5 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(121471073).content)

				arg_298_1.text_.text = var_301_5

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_7 = 25 <= 0 and var_301_4 or var_301_4 * (utf8.len(var_301_5) / 25)

				if (25 <= 0 and var_301_4 or var_301_4 * (utf8.len(var_301_5) / 25)) > 0 and var_301_4 < var_301_7 then
					arg_298_1.talkMaxDuration = var_301_7

					if var_301_7 + var_301_3 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_7 + var_301_3
					end
				end

				arg_298_1.text_.text = var_301_5
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_8 = math.max(var_301_4, arg_298_1.talkMaxDuration)

			if var_301_3 <= arg_298_1.time_ and arg_298_1.time_ < var_301_3 + var_301_8 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_3) / var_301_8

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_3 + var_301_8 and arg_298_1.time_ < var_301_3 + var_301_8 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play121471074 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 121471074
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play121471075(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0.85

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_1 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(121471074).content)

				arg_302_1.text_.text = var_305_1

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_3 = 34 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 34)

				if (34 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 34)) > 0 and var_305_0 < var_305_3 then
					arg_302_1.talkMaxDuration = var_305_3

					if var_305_3 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_3 + 0
					end
				end

				arg_302_1.text_.text = var_305_1
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_4 = math.max(var_305_0, arg_302_1.talkMaxDuration)

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_4 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - 0) / var_305_4

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= 0 + var_305_4 and arg_302_1.time_ < 0 + var_305_4 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play121471075 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 121471075
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play121471076(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0.725

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_1 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(121471075).content)

				arg_306_1.text_.text = var_309_1

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_3 = 29 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_1) / 29)

				if (29 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_1) / 29)) > 0 and var_309_0 < var_309_3 then
					arg_306_1.talkMaxDuration = var_309_3

					if var_309_3 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_3 + 0
					end
				end

				arg_306_1.text_.text = var_309_1
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_4 = math.max(var_309_0, arg_306_1.talkMaxDuration)

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_4 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - 0) / var_309_4

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= 0 + var_309_4 and arg_306_1.time_ < 0 + var_309_4 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play121471076 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 121471076
		arg_310_1.duration_ = 5.03

		local var_310_0 = {
			ja = 5.033,
			ko = 4.133,
			zh = 4.133
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play121471077(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_1")
			end

			local var_313_0 = arg_310_1.actors_["1076ui_story"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1076ui_story == nil then
				arg_310_1.var_.characterEffect1076ui_story = var_313_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_1 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_1 and not isNil(var_313_0) then
				if arg_310_1.var_.characterEffect1076ui_story and not isNil(var_313_0) then
					arg_310_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= 0 + var_313_1 and arg_310_1.time_ < 0 + var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1076ui_story then
				arg_310_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_313_3 = arg_310_1.actors_["1076ui_story"].transform

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.moveOldPos1076ui_story = var_313_3.localPosition
			end

			local var_313_4 = 0.001

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_4 then
				var_313_3.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_310_1.time_ - 0) / var_313_4)
				var_313_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_313_3.position).x, (manager.ui.mainCamera.transform.position - var_313_3.position).y, (manager.ui.mainCamera.transform.position - var_313_3.position).z)
				var_313_3.localEulerAngles.z = 0
				var_313_3.localEulerAngles.x = 0
				var_313_3.localEulerAngles = var_313_3.localEulerAngles
			end

			if arg_310_1.time_ >= 0 + var_313_4 and arg_310_1.time_ < 0 + var_313_4 + arg_313_0 then
				var_313_3.localPosition = Vector3.New(0, -1.06, -6.2)
				var_313_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_313_3.position).x, (manager.ui.mainCamera.transform.position - var_313_3.position).y, (manager.ui.mainCamera.transform.position - var_313_3.position).z)
				var_313_3.localEulerAngles.z = 0
				var_313_3.localEulerAngles.x = 0
				var_313_3.localEulerAngles = var_313_3.localEulerAngles
			end

			local var_313_5 = 0
			local var_313_6 = 0.45

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_5 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_7 = arg_310_1:GetWordFromCfg(121471076)
				local var_313_8 = arg_310_1:FormatText(var_313_7.content)

				arg_310_1.text_.text = var_313_8

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_10 = 18 <= 0 and var_313_6 or var_313_6 * (utf8.len(var_313_8) / 18)

				if (18 <= 0 and var_313_6 or var_313_6 * (utf8.len(var_313_8) / 18)) > 0 and var_313_6 < var_313_10 then
					arg_310_1.talkMaxDuration = var_313_10

					if var_313_10 + var_313_5 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_10 + var_313_5
					end
				end

				arg_310_1.text_.text = var_313_8
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471076", "story_v_out_121471.awb") ~= 0 then
					local var_313_11 = manager.audio:GetVoiceLength("story_v_out_121471", "121471076", "story_v_out_121471.awb") / 1000

					if var_313_11 + var_313_5 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_11 + var_313_5
					end

					if var_313_7.prefab_name ~= "" and arg_310_1.actors_[var_313_7.prefab_name] ~= nil then
						local var_313_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_7.prefab_name].transform, "story_v_out_121471", "121471076", "story_v_out_121471.awb")

						arg_310_1:RecordAudio("121471076", var_313_12)
						arg_310_1:RecordAudio("121471076", var_313_12)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_121471", "121471076", "story_v_out_121471.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_121471", "121471076", "story_v_out_121471.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_13 = math.max(var_313_6, arg_310_1.talkMaxDuration)

			if var_313_5 <= arg_310_1.time_ and arg_310_1.time_ < var_313_5 + var_313_13 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_5) / var_313_13

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_5 + var_313_13 and arg_310_1.time_ < var_313_5 + var_313_13 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play121471077 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 121471077
		arg_314_1.duration_ = 10.6

		local var_314_0 = {
			ja = 10.6,
			ko = 7.033,
			zh = 7.033
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play121471078(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0.625

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_1 = arg_314_1:GetWordFromCfg(121471077)
				local var_317_2 = arg_314_1:FormatText(var_317_1.content)

				arg_314_1.text_.text = var_317_2

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_4 = 25 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_2) / 25)

				if (25 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_2) / 25)) > 0 and var_317_0 < var_317_4 then
					arg_314_1.talkMaxDuration = var_317_4

					if var_317_4 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_4 + 0
					end
				end

				arg_314_1.text_.text = var_317_2
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471077", "story_v_out_121471.awb") ~= 0 then
					local var_317_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471077", "story_v_out_121471.awb") / 1000

					if var_317_5 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + 0
					end

					if var_317_1.prefab_name ~= "" and arg_314_1.actors_[var_317_1.prefab_name] ~= nil then
						local var_317_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_1.prefab_name].transform, "story_v_out_121471", "121471077", "story_v_out_121471.awb")

						arg_314_1:RecordAudio("121471077", var_317_6)
						arg_314_1:RecordAudio("121471077", var_317_6)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_121471", "121471077", "story_v_out_121471.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_121471", "121471077", "story_v_out_121471.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_7 = math.max(var_317_0, arg_314_1.talkMaxDuration)

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_7 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - 0) / var_317_7

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= 0 + var_317_7 and arg_314_1.time_ < 0 + var_317_7 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play121471078 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 121471078
		arg_318_1.duration_ = 9.17

		local var_318_0 = {
			ja = 9.166,
			ko = 6.766,
			zh = 6.766
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play121471079(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0.525

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_1 = arg_318_1:GetWordFromCfg(121471078)
				local var_321_2 = arg_318_1:FormatText(var_321_1.content)

				arg_318_1.text_.text = var_321_2

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_4 = 21 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_2) / 21)

				if (21 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_2) / 21)) > 0 and var_321_0 < var_321_4 then
					arg_318_1.talkMaxDuration = var_321_4

					if var_321_4 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_4 + 0
					end
				end

				arg_318_1.text_.text = var_321_2
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471078", "story_v_out_121471.awb") ~= 0 then
					local var_321_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471078", "story_v_out_121471.awb") / 1000

					if var_321_5 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_5 + 0
					end

					if var_321_1.prefab_name ~= "" and arg_318_1.actors_[var_321_1.prefab_name] ~= nil then
						local var_321_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_1.prefab_name].transform, "story_v_out_121471", "121471078", "story_v_out_121471.awb")

						arg_318_1:RecordAudio("121471078", var_321_6)
						arg_318_1:RecordAudio("121471078", var_321_6)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_121471", "121471078", "story_v_out_121471.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_121471", "121471078", "story_v_out_121471.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_7 = math.max(var_321_0, arg_318_1.talkMaxDuration)

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_7 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - 0) / var_321_7

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= 0 + var_321_7 and arg_318_1.time_ < 0 + var_321_7 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play121471079 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 121471079
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play121471080(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["1076ui_story"]) and arg_322_1.var_.characterEffect1076ui_story == nil then
				arg_322_1.var_.characterEffect1076ui_story = arg_322_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_0 = 0.200000002980232

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["1076ui_story"]) then
				if arg_322_1.var_.characterEffect1076ui_story and not isNil(arg_322_1.actors_["1076ui_story"]) then
					arg_322_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["1076ui_story"]) and arg_322_1.var_.characterEffect1076ui_story then
				arg_322_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_2")
			end

			local var_325_2 = 0
			local var_325_3 = 0.7

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_2 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_4 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(121471079).content)

				arg_322_1.text_.text = var_325_4

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_6 = 28 <= 0 and var_325_3 or var_325_3 * (utf8.len(var_325_4) / 28)

				if (28 <= 0 and var_325_3 or var_325_3 * (utf8.len(var_325_4) / 28)) > 0 and var_325_3 < var_325_6 then
					arg_322_1.talkMaxDuration = var_325_6

					if var_325_6 + var_325_2 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_6 + var_325_2
					end
				end

				arg_322_1.text_.text = var_325_4
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_7 = math.max(var_325_3, arg_322_1.talkMaxDuration)

			if var_325_2 <= arg_322_1.time_ and arg_322_1.time_ < var_325_2 + var_325_7 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_2) / var_325_7

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_2 + var_325_7 and arg_322_1.time_ < var_325_2 + var_325_7 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play121471080 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 121471080
		arg_326_1.duration_ = 18

		local var_326_0 = {
			ja = 18,
			ko = 5.466,
			zh = 5.466
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play121471081(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0.625

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_1 = arg_326_1:GetWordFromCfg(121471080)
				local var_329_2 = arg_326_1:FormatText(var_329_1.content)

				arg_326_1.text_.text = var_329_2

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_4 = 25 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 25)

				if (25 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 25)) > 0 and var_329_0 < var_329_4 then
					arg_326_1.talkMaxDuration = var_329_4

					if var_329_4 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_4 + 0
					end
				end

				arg_326_1.text_.text = var_329_2
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471080", "story_v_out_121471.awb") ~= 0 then
					local var_329_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471080", "story_v_out_121471.awb") / 1000

					if var_329_5 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_5 + 0
					end

					if var_329_1.prefab_name ~= "" and arg_326_1.actors_[var_329_1.prefab_name] ~= nil then
						local var_329_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_1.prefab_name].transform, "story_v_out_121471", "121471080", "story_v_out_121471.awb")

						arg_326_1:RecordAudio("121471080", var_329_6)
						arg_326_1:RecordAudio("121471080", var_329_6)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_121471", "121471080", "story_v_out_121471.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_121471", "121471080", "story_v_out_121471.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_7 = math.max(var_329_0, arg_326_1.talkMaxDuration)

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_7 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - 0) / var_329_7

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= 0 + var_329_7 and arg_326_1.time_ < 0 + var_329_7 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play121471081 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 121471081
		arg_330_1.duration_ = 9.07

		local var_330_0 = {
			ja = 9.066,
			ko = 8.9,
			zh = 8.9
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play121471082(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0.85

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_1 = arg_330_1:GetWordFromCfg(121471081)
				local var_333_2 = arg_330_1:FormatText(var_333_1.content)

				arg_330_1.text_.text = var_333_2

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_4 = 34 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 34)

				if (34 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 34)) > 0 and var_333_0 < var_333_4 then
					arg_330_1.talkMaxDuration = var_333_4

					if var_333_4 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_4 + 0
					end
				end

				arg_330_1.text_.text = var_333_2
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471081", "story_v_out_121471.awb") ~= 0 then
					local var_333_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471081", "story_v_out_121471.awb") / 1000

					if var_333_5 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + 0
					end

					if var_333_1.prefab_name ~= "" and arg_330_1.actors_[var_333_1.prefab_name] ~= nil then
						local var_333_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_1.prefab_name].transform, "story_v_out_121471", "121471081", "story_v_out_121471.awb")

						arg_330_1:RecordAudio("121471081", var_333_6)
						arg_330_1:RecordAudio("121471081", var_333_6)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_121471", "121471081", "story_v_out_121471.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_121471", "121471081", "story_v_out_121471.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_7 = math.max(var_333_0, arg_330_1.talkMaxDuration)

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_7 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - 0) / var_333_7

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= 0 + var_333_7 and arg_330_1.time_ < 0 + var_333_7 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play121471082 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 121471082
		arg_334_1.duration_ = 6.5

		local var_334_0 = {
			ja = 6.5,
			ko = 6.1,
			zh = 6.1
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play121471083(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0.525

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_1 = arg_334_1:GetWordFromCfg(121471082)
				local var_337_2 = arg_334_1:FormatText(var_337_1.content)

				arg_334_1.text_.text = var_337_2

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_4 = 21 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_2) / 21)

				if (21 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_2) / 21)) > 0 and var_337_0 < var_337_4 then
					arg_334_1.talkMaxDuration = var_337_4

					if var_337_4 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_4 + 0
					end
				end

				arg_334_1.text_.text = var_337_2
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471082", "story_v_out_121471.awb") ~= 0 then
					local var_337_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471082", "story_v_out_121471.awb") / 1000

					if var_337_5 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_5 + 0
					end

					if var_337_1.prefab_name ~= "" and arg_334_1.actors_[var_337_1.prefab_name] ~= nil then
						local var_337_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_1.prefab_name].transform, "story_v_out_121471", "121471082", "story_v_out_121471.awb")

						arg_334_1:RecordAudio("121471082", var_337_6)
						arg_334_1:RecordAudio("121471082", var_337_6)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_121471", "121471082", "story_v_out_121471.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_121471", "121471082", "story_v_out_121471.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_7 = math.max(var_337_0, arg_334_1.talkMaxDuration)

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_7 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - 0) / var_337_7

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= 0 + var_337_7 and arg_334_1.time_ < 0 + var_337_7 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play121471083 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 121471083
		arg_338_1.duration_ = 11.1

		local var_338_0 = {
			ja = 11.1,
			ko = 8.3,
			zh = 8.3
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play121471084(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0.8

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_1 = arg_338_1:GetWordFromCfg(121471083)
				local var_341_2 = arg_338_1:FormatText(var_341_1.content)

				arg_338_1.text_.text = var_341_2

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_4 = 32 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_2) / 32)

				if (32 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_2) / 32)) > 0 and var_341_0 < var_341_4 then
					arg_338_1.talkMaxDuration = var_341_4

					if var_341_4 + 0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_4 + 0
					end
				end

				arg_338_1.text_.text = var_341_2
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471083", "story_v_out_121471.awb") ~= 0 then
					local var_341_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471083", "story_v_out_121471.awb") / 1000

					if var_341_5 + 0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_5 + 0
					end

					if var_341_1.prefab_name ~= "" and arg_338_1.actors_[var_341_1.prefab_name] ~= nil then
						local var_341_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_1.prefab_name].transform, "story_v_out_121471", "121471083", "story_v_out_121471.awb")

						arg_338_1:RecordAudio("121471083", var_341_6)
						arg_338_1:RecordAudio("121471083", var_341_6)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_121471", "121471083", "story_v_out_121471.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_121471", "121471083", "story_v_out_121471.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_7 = math.max(var_341_0, arg_338_1.talkMaxDuration)

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_7 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - 0) / var_341_7

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= 0 + var_341_7 and arg_338_1.time_ < 0 + var_341_7 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play121471084 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 121471084
		arg_342_1.duration_ = 4.67

		local var_342_0 = {
			ja = 4.666,
			ko = 4.133,
			zh = 4.133
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play121471085(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0.325

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_1 = arg_342_1:GetWordFromCfg(121471084)
				local var_345_2 = arg_342_1:FormatText(var_345_1.content)

				arg_342_1.text_.text = var_345_2

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_4 = 13 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_2) / 13)

				if (13 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_2) / 13)) > 0 and var_345_0 < var_345_4 then
					arg_342_1.talkMaxDuration = var_345_4

					if var_345_4 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_4 + 0
					end
				end

				arg_342_1.text_.text = var_345_2
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471084", "story_v_out_121471.awb") ~= 0 then
					local var_345_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471084", "story_v_out_121471.awb") / 1000

					if var_345_5 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_5 + 0
					end

					if var_345_1.prefab_name ~= "" and arg_342_1.actors_[var_345_1.prefab_name] ~= nil then
						local var_345_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_1.prefab_name].transform, "story_v_out_121471", "121471084", "story_v_out_121471.awb")

						arg_342_1:RecordAudio("121471084", var_345_6)
						arg_342_1:RecordAudio("121471084", var_345_6)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_121471", "121471084", "story_v_out_121471.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_121471", "121471084", "story_v_out_121471.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_7 = math.max(var_345_0, arg_342_1.talkMaxDuration)

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_7 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - 0) / var_345_7

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= 0 + var_345_7 and arg_342_1.time_ < 0 + var_345_7 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play121471085 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 121471085
		arg_346_1.duration_ = 9

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play121471086(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if arg_346_1.bgs_.ST31 == nil then
				local var_349_0 = Object.Instantiate(arg_346_1.paintGo_)

				var_349_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST31")
				var_349_0.name = "ST31"
				var_349_0.transform.parent = arg_346_1.stage_.transform
				var_349_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_346_1.bgs_.ST31 = var_349_0
			end

			if 2 < arg_346_1.time_ and arg_346_1.time_ <= 2 + arg_349_0 then
				local var_349_1 = arg_346_1.bgs_.ST31

				arg_346_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_349_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_349_2 = var_349_1:GetComponent("SpriteRenderer")

				if var_349_2 and var_349_2.sprite then
					local var_349_3 = 2 * (var_349_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_349_1.transform.localScale = Vector3.New(var_349_3 / var_349_2.sprite.bounds.size.y < var_349_3 * manager.ui.mainCameraCom_.aspect / var_349_2.sprite.bounds.size.x and var_349_3 * manager.ui.mainCameraCom_.aspect / var_349_2.sprite.bounds.size.x or var_349_3 / var_349_2.sprite.bounds.size.y, var_349_3 / var_349_2.sprite.bounds.size.y < var_349_3 * manager.ui.mainCameraCom_.aspect / var_349_2.sprite.bounds.size.x and var_349_3 * manager.ui.mainCameraCom_.aspect / var_349_2.sprite.bounds.size.x or var_349_3 / var_349_2.sprite.bounds.size.y, 0)
				end

				for iter_349_0, iter_349_1 in pairs(arg_346_1.bgs_) do
					if iter_349_0 ~= "ST31" then
						iter_349_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_349_4 = 0

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_4 + arg_349_0 then
				arg_346_1.mask_.enabled = true
				arg_346_1.mask_.raycastTarget = true

				arg_346_1:SetGaussion(false)
			end

			local var_349_5 = 2

			if var_349_4 <= arg_346_1.time_ and arg_346_1.time_ < var_349_4 + var_349_5 then
				local var_349_6 = Color.New(0, 0, 0)

				var_349_6.a = Mathf.Lerp(0, 1, (arg_346_1.time_ - var_349_4) / var_349_5)
				arg_346_1.mask_.color = var_349_6
			end

			if arg_346_1.time_ >= var_349_4 + var_349_5 and arg_346_1.time_ < var_349_4 + var_349_5 + arg_349_0 then
				local var_349_7 = Color.New(0, 0, 0)

				var_349_7.a = 1
				arg_346_1.mask_.color = var_349_7
			end

			local var_349_8 = 2

			if 2 < arg_346_1.time_ and arg_346_1.time_ <= var_349_8 + arg_349_0 then
				arg_346_1.mask_.enabled = true
				arg_346_1.mask_.raycastTarget = true

				arg_346_1:SetGaussion(false)
			end

			local var_349_9 = 2

			if var_349_8 <= arg_346_1.time_ and arg_346_1.time_ < var_349_8 + var_349_9 then
				local var_349_10 = Color.New(0, 0, 0)

				var_349_10.a = Mathf.Lerp(1, 0, (arg_346_1.time_ - var_349_8) / var_349_9)
				arg_346_1.mask_.color = var_349_10
			end

			if arg_346_1.time_ >= var_349_8 + var_349_9 and arg_346_1.time_ < var_349_8 + var_349_9 + arg_349_0 then
				local var_349_11 = Color.New(0, 0, 0)

				arg_346_1.mask_.enabled = false
				var_349_11.a = 0
				arg_346_1.mask_.color = var_349_11
			end

			local var_349_12 = arg_346_1.actors_["1076ui_story"].transform

			if 1.96599999815226 < arg_346_1.time_ and arg_346_1.time_ <= 1.96599999815226 + arg_349_0 then
				arg_346_1.var_.moveOldPos1076ui_story = var_349_12.localPosition
			end

			local var_349_13 = 0.001

			if 1.96599999815226 <= arg_346_1.time_ and arg_346_1.time_ < 1.96599999815226 + var_349_13 then
				var_349_12.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_346_1.time_ - 1.96599999815226) / var_349_13)
				var_349_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_349_12.position).x, (manager.ui.mainCamera.transform.position - var_349_12.position).y, (manager.ui.mainCamera.transform.position - var_349_12.position).z)
				var_349_12.localEulerAngles.z = 0
				var_349_12.localEulerAngles.x = 0
				var_349_12.localEulerAngles = var_349_12.localEulerAngles
			end

			if arg_346_1.time_ >= 1.96599999815226 + var_349_13 and arg_346_1.time_ < 1.96599999815226 + var_349_13 + arg_349_0 then
				var_349_12.localPosition = Vector3.New(0, 100, 0)
				var_349_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_349_12.position).x, (manager.ui.mainCamera.transform.position - var_349_12.position).y, (manager.ui.mainCamera.transform.position - var_349_12.position).z)
				var_349_12.localEulerAngles.z = 0
				var_349_12.localEulerAngles.x = 0
				var_349_12.localEulerAngles = var_349_12.localEulerAngles
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_349_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_346_1.bgmTxt_.text ~= var_349_16 and arg_346_1.bgmTxt_.text ~= "" then
						if arg_346_1.bgmTxt2_.text ~= "" then
							arg_346_1.bgmTxt_.text = arg_346_1.bgmTxt2_.text
						end

						arg_346_1.bgmTxt2_.text = var_349_16

						arg_346_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_346_1.bgmTxt_.text = var_349_16
						arg_346_1.bgmTxt2_.text = var_349_16
					end

					if arg_346_1.bgmTimer then
						arg_346_1.bgmTimer:Stop()

						arg_346_1.bgmTimer = nil
					end

					if arg_346_1.settingData.show_music_name == 1 then
						arg_346_1.musicController:SetSelectedState("show")
						arg_346_1.musicAnimator_:Play("open", 0, 0)

						if arg_346_1.settingData.music_time ~= 0 then
							arg_346_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_346_1.settingData.music_time), function()
								if arg_346_1 == nil or isNil(arg_346_1.bgmTxt_) then
									return
								end

								arg_346_1.musicController:SetSelectedState("hide")
								arg_346_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_346_1.time_ and arg_346_1.time_ <= 0.3 + arg_349_0 then
				arg_346_1:AudioAction("play", "music", "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city.awb")

				local var_349_19 = manager.audio:GetAudioName("bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city")

				if "" ~= "" then
					if arg_346_1.bgmTxt_.text ~= var_349_19 and arg_346_1.bgmTxt_.text ~= "" then
						if arg_346_1.bgmTxt2_.text ~= "" then
							arg_346_1.bgmTxt_.text = arg_346_1.bgmTxt2_.text
						end

						arg_346_1.bgmTxt2_.text = var_349_19

						arg_346_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_346_1.bgmTxt_.text = var_349_19
						arg_346_1.bgmTxt2_.text = var_349_19
					end

					if arg_346_1.bgmTimer then
						arg_346_1.bgmTimer:Stop()

						arg_346_1.bgmTimer = nil
					end

					if arg_346_1.settingData.show_music_name == 1 then
						arg_346_1.musicController:SetSelectedState("show")
						arg_346_1.musicAnimator_:Play("open", 0, 0)

						if arg_346_1.settingData.music_time ~= 0 then
							arg_346_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_346_1.settingData.music_time), function()
								if arg_346_1 == nil or isNil(arg_346_1.bgmTxt_) then
									return
								end

								arg_346_1.musicController:SetSelectedState("hide")
								arg_346_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_346_1.frameCnt_ <= 1 then
				arg_346_1.dialog_:SetActive(false)
			end

			local var_349_20 = 4
			local var_349_21 = 0.975

			if 4 < arg_346_1.time_ and arg_346_1.time_ <= var_349_20 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0

				arg_346_1.dialog_:SetActive(true)

				arg_346_1.dialogCg_.alpha = 0

				local var_349_22 = LeanTween.value(arg_346_1.dialog_, 0, 1, 0.3)

				var_349_22:setOnUpdate(LuaHelper.FloatAction(function(arg_352_0)
					arg_346_1.dialogCg_.alpha = arg_352_0
				end))
				var_349_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_346_1.dialog_)
					var_349_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_346_1.duration_ = arg_346_1.duration_ + 0.3

				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_23 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(121471085).content)

				arg_346_1.text_.text = var_349_23

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_25 = 79 <= 0 and var_349_21 or var_349_21 * (utf8.len(var_349_23) / 79)

				if (79 <= 0 and var_349_21 or var_349_21 * (utf8.len(var_349_23) / 79)) > 0 and var_349_21 < var_349_25 then
					arg_346_1.talkMaxDuration = var_349_25
					var_349_20 = var_349_20 + 0.3

					if var_349_25 + var_349_20 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_25 + var_349_20
					end
				end

				arg_346_1.text_.text = var_349_23
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_26 = var_349_20 + 0.3
			local var_349_27 = math.max(var_349_21, arg_346_1.talkMaxDuration)

			if var_349_20 + 0.3 <= arg_346_1.time_ and arg_346_1.time_ < var_349_26 + var_349_27 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_26) / var_349_27

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_26 + var_349_27 and arg_346_1.time_ < var_349_26 + var_349_27 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play121471086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 121471086
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play121471087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 1.1

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_1 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(121471086).content)

				arg_354_1.text_.text = var_357_1

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_3 = 44 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_1) / 44)

				if (44 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_1) / 44)) > 0 and var_357_0 < var_357_3 then
					arg_354_1.talkMaxDuration = var_357_3

					if var_357_3 + 0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_3 + 0
					end
				end

				arg_354_1.text_.text = var_357_1
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_4 = math.max(var_357_0, arg_354_1.talkMaxDuration)

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_4 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - 0) / var_357_4

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= 0 + var_357_4 and arg_354_1.time_ < 0 + var_357_4 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play121471087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 121471087
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play121471088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0.825

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_1 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(121471087).content)

				arg_358_1.text_.text = var_361_1

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_3 = 33 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_1) / 33)

				if (33 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_1) / 33)) > 0 and var_361_0 < var_361_3 then
					arg_358_1.talkMaxDuration = var_361_3

					if var_361_3 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_3 + 0
					end
				end

				arg_358_1.text_.text = var_361_1
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_4 = math.max(var_361_0, arg_358_1.talkMaxDuration)

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_4 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - 0) / var_361_4

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= 0 + var_361_4 and arg_358_1.time_ < 0 + var_361_4 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play121471088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 121471088
		arg_362_1.duration_ = 4.2

		local var_362_0 = {
			ja = 3.8,
			ko = 4.2,
			zh = 4.2
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play121471089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.var_.moveOldPos1084ui_story = arg_362_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_365_0 = 0.001

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 then
				arg_362_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_362_1.time_ - 0) / var_365_0)
				arg_362_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_362_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["1084ui_story"].transform.position).z)
				arg_362_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_362_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_362_1.actors_["1084ui_story"].transform.localEulerAngles = arg_362_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 then
				arg_362_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_362_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_362_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["1084ui_story"].transform.position).z)
				arg_362_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_362_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_362_1.actors_["1084ui_story"].transform.localEulerAngles = arg_362_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_365_1 = arg_362_1.actors_["1084ui_story"]

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(var_365_1) and arg_362_1.var_.characterEffect1084ui_story == nil then
				arg_362_1.var_.characterEffect1084ui_story = var_365_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_2 = 0.200000002980232

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_2 and not isNil(var_365_1) then
				if arg_362_1.var_.characterEffect1084ui_story and not isNil(var_365_1) then
					arg_362_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= 0 + var_365_2 and arg_362_1.time_ < 0 + var_365_2 + arg_365_0 and not isNil(var_365_1) and arg_362_1.var_.characterEffect1084ui_story then
				arg_362_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_365_4 = arg_362_1.actors_["10042ui_story"].transform

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.var_.moveOldPos10042ui_story = var_365_4.localPosition
			end

			local var_365_5 = 0.001

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_5 then
				var_365_4.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos10042ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_362_1.time_ - 0) / var_365_5)
				var_365_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_365_4.position).x, (manager.ui.mainCamera.transform.position - var_365_4.position).y, (manager.ui.mainCamera.transform.position - var_365_4.position).z)
				var_365_4.localEulerAngles.z = 0
				var_365_4.localEulerAngles.x = 0
				var_365_4.localEulerAngles = var_365_4.localEulerAngles
			end

			if arg_362_1.time_ >= 0 + var_365_5 and arg_362_1.time_ < 0 + var_365_5 + arg_365_0 then
				var_365_4.localPosition = Vector3.New(0.7, -1.12, -6.2)
				var_365_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_365_4.position).x, (manager.ui.mainCamera.transform.position - var_365_4.position).y, (manager.ui.mainCamera.transform.position - var_365_4.position).z)
				var_365_4.localEulerAngles.z = 0
				var_365_4.localEulerAngles.x = 0
				var_365_4.localEulerAngles = var_365_4.localEulerAngles
			end

			local var_365_6 = arg_362_1.actors_["10042ui_story"]

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(var_365_6) and arg_362_1.var_.characterEffect10042ui_story == nil then
				arg_362_1.var_.characterEffect10042ui_story = var_365_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_7 = 0.034000001847744

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_7 and not isNil(var_365_6) then
				if arg_362_1.var_.characterEffect10042ui_story and not isNil(var_365_6) then
					arg_362_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_362_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_362_1.time_ - 0) / var_365_7)
				end
			end

			if arg_362_1.time_ >= 0 + var_365_7 and arg_362_1.time_ < 0 + var_365_7 + arg_365_0 and not isNil(var_365_6) and arg_362_1.var_.characterEffect10042ui_story then
				arg_362_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_362_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			local var_365_8 = 0
			local var_365_9 = 0.375

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_8 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_10 = arg_362_1:GetWordFromCfg(121471088)
				local var_365_11 = arg_362_1:FormatText(var_365_10.content)

				arg_362_1.text_.text = var_365_11

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_13 = 15 <= 0 and var_365_9 or var_365_9 * (utf8.len(var_365_11) / 15)

				if (15 <= 0 and var_365_9 or var_365_9 * (utf8.len(var_365_11) / 15)) > 0 and var_365_9 < var_365_13 then
					arg_362_1.talkMaxDuration = var_365_13

					if var_365_13 + var_365_8 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_13 + var_365_8
					end
				end

				arg_362_1.text_.text = var_365_11
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471088", "story_v_out_121471.awb") ~= 0 then
					local var_365_14 = manager.audio:GetVoiceLength("story_v_out_121471", "121471088", "story_v_out_121471.awb") / 1000

					if var_365_14 + var_365_8 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_14 + var_365_8
					end

					if var_365_10.prefab_name ~= "" and arg_362_1.actors_[var_365_10.prefab_name] ~= nil then
						local var_365_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_10.prefab_name].transform, "story_v_out_121471", "121471088", "story_v_out_121471.awb")

						arg_362_1:RecordAudio("121471088", var_365_15)
						arg_362_1:RecordAudio("121471088", var_365_15)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_121471", "121471088", "story_v_out_121471.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_121471", "121471088", "story_v_out_121471.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_16 = math.max(var_365_9, arg_362_1.talkMaxDuration)

			if var_365_8 <= arg_362_1.time_ and arg_362_1.time_ < var_365_8 + var_365_16 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_8) / var_365_16

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_8 + var_365_16 and arg_362_1.time_ < var_365_8 + var_365_16 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_362_1:InitPlayNodeList()
	end,
	Play121471089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 121471089
		arg_366_1.duration_ = 1.13

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play121471090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(arg_366_1.actors_["1084ui_story"]) and arg_366_1.var_.characterEffect1084ui_story == nil then
				arg_366_1.var_.characterEffect1084ui_story = arg_366_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_0 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 and not isNil(arg_366_1.actors_["1084ui_story"]) then
				if arg_366_1.var_.characterEffect1084ui_story and not isNil(arg_366_1.actors_["1084ui_story"]) then
					arg_366_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_366_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_366_1.time_ - 0) / var_369_0)
				end
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 and not isNil(arg_366_1.actors_["1084ui_story"]) and arg_366_1.var_.characterEffect1084ui_story then
				arg_366_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_366_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_369_1 = arg_366_1.actors_["10042ui_story"]

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(var_369_1) and arg_366_1.var_.characterEffect10042ui_story == nil then
				arg_366_1.var_.characterEffect10042ui_story = var_369_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_2 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_2 and not isNil(var_369_1) then
				if arg_366_1.var_.characterEffect10042ui_story and not isNil(var_369_1) then
					arg_366_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= 0 + var_369_2 and arg_366_1.time_ < 0 + var_369_2 + arg_369_0 and not isNil(var_369_1) and arg_366_1.var_.characterEffect10042ui_story then
				arg_366_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_369_4 = 0
			local var_369_5 = 0.1

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_4 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_6 = arg_366_1:GetWordFromCfg(121471089)
				local var_369_7 = arg_366_1:FormatText(var_369_6.content)

				arg_366_1.text_.text = var_369_7

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_9 = 4 <= 0 and var_369_5 or var_369_5 * (utf8.len(var_369_7) / 4)

				if (4 <= 0 and var_369_5 or var_369_5 * (utf8.len(var_369_7) / 4)) > 0 and var_369_5 < var_369_9 then
					arg_366_1.talkMaxDuration = var_369_9

					if var_369_9 + var_369_4 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_9 + var_369_4
					end
				end

				arg_366_1.text_.text = var_369_7
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471089", "story_v_out_121471.awb") ~= 0 then
					local var_369_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471089", "story_v_out_121471.awb") / 1000

					if var_369_10 + var_369_4 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_10 + var_369_4
					end

					if var_369_6.prefab_name ~= "" and arg_366_1.actors_[var_369_6.prefab_name] ~= nil then
						local var_369_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_6.prefab_name].transform, "story_v_out_121471", "121471089", "story_v_out_121471.awb")

						arg_366_1:RecordAudio("121471089", var_369_11)
						arg_366_1:RecordAudio("121471089", var_369_11)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_121471", "121471089", "story_v_out_121471.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_121471", "121471089", "story_v_out_121471.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_12 = math.max(var_369_5, arg_366_1.talkMaxDuration)

			if var_369_4 <= arg_366_1.time_ and arg_366_1.time_ < var_369_4 + var_369_12 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_4) / var_369_12

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_4 + var_369_12 and arg_366_1.time_ < var_369_4 + var_369_12 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play121471090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 121471090
		arg_370_1.duration_ = 6

		local var_370_0 = {
			ja = 6,
			ko = 4.266,
			zh = 4.266
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play121471091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["1084ui_story"]) and arg_370_1.var_.characterEffect1084ui_story == nil then
				arg_370_1.var_.characterEffect1084ui_story = arg_370_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_0 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["1084ui_story"]) then
				if arg_370_1.var_.characterEffect1084ui_story and not isNil(arg_370_1.actors_["1084ui_story"]) then
					arg_370_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["1084ui_story"]) and arg_370_1.var_.characterEffect1084ui_story then
				arg_370_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_373_2 = 0
			local var_373_3 = 0.575

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_2 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_4 = arg_370_1:GetWordFromCfg(121471090)
				local var_373_5 = arg_370_1:FormatText(var_373_4.content)

				arg_370_1.text_.text = var_373_5

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_7 = 23 <= 0 and var_373_3 or var_373_3 * (utf8.len(var_373_5) / 23)

				if (23 <= 0 and var_373_3 or var_373_3 * (utf8.len(var_373_5) / 23)) > 0 and var_373_3 < var_373_7 then
					arg_370_1.talkMaxDuration = var_373_7

					if var_373_7 + var_373_2 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_7 + var_373_2
					end
				end

				arg_370_1.text_.text = var_373_5
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471090", "story_v_out_121471.awb") ~= 0 then
					local var_373_8 = manager.audio:GetVoiceLength("story_v_out_121471", "121471090", "story_v_out_121471.awb") / 1000

					if var_373_8 + var_373_2 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_8 + var_373_2
					end

					if var_373_4.prefab_name ~= "" and arg_370_1.actors_[var_373_4.prefab_name] ~= nil then
						local var_373_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_4.prefab_name].transform, "story_v_out_121471", "121471090", "story_v_out_121471.awb")

						arg_370_1:RecordAudio("121471090", var_373_9)
						arg_370_1:RecordAudio("121471090", var_373_9)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_121471", "121471090", "story_v_out_121471.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_121471", "121471090", "story_v_out_121471.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_10 = math.max(var_373_3, arg_370_1.talkMaxDuration)

			if var_373_2 <= arg_370_1.time_ and arg_370_1.time_ < var_373_2 + var_373_10 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_2) / var_373_10

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_2 + var_373_10 and arg_370_1.time_ < var_373_2 + var_373_10 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play121471091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 121471091
		arg_374_1.duration_ = 4.27

		local var_374_0 = {
			ja = 4.266,
			ko = 3.7,
			zh = 3.7
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play121471092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0.4

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_1 = arg_374_1:GetWordFromCfg(121471091)
				local var_377_2 = arg_374_1:FormatText(var_377_1.content)

				arg_374_1.text_.text = var_377_2

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_4 = 16 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 16)

				if (16 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 16)) > 0 and var_377_0 < var_377_4 then
					arg_374_1.talkMaxDuration = var_377_4

					if var_377_4 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_4 + 0
					end
				end

				arg_374_1.text_.text = var_377_2
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471091", "story_v_out_121471.awb") ~= 0 then
					local var_377_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471091", "story_v_out_121471.awb") / 1000

					if var_377_5 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_5 + 0
					end

					if var_377_1.prefab_name ~= "" and arg_374_1.actors_[var_377_1.prefab_name] ~= nil then
						local var_377_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_1.prefab_name].transform, "story_v_out_121471", "121471091", "story_v_out_121471.awb")

						arg_374_1:RecordAudio("121471091", var_377_6)
						arg_374_1:RecordAudio("121471091", var_377_6)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_121471", "121471091", "story_v_out_121471.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_121471", "121471091", "story_v_out_121471.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_7 = math.max(var_377_0, arg_374_1.talkMaxDuration)

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_7 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - 0) / var_377_7

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= 0 + var_377_7 and arg_374_1.time_ < 0 + var_377_7 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play121471092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 121471092
		arg_378_1.duration_ = 6.27

		local var_378_0 = {
			ja = 6.266,
			ko = 5.433,
			zh = 5.433
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play121471093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(arg_378_1.actors_["1084ui_story"]) and arg_378_1.var_.characterEffect1084ui_story == nil then
				arg_378_1.var_.characterEffect1084ui_story = arg_378_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_0 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 and not isNil(arg_378_1.actors_["1084ui_story"]) then
				if arg_378_1.var_.characterEffect1084ui_story and not isNil(arg_378_1.actors_["1084ui_story"]) then
					arg_378_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_378_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_378_1.time_ - 0) / var_381_0)
				end
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 and not isNil(arg_378_1.actors_["1084ui_story"]) and arg_378_1.var_.characterEffect1084ui_story then
				arg_378_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_378_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_381_1 = arg_378_1.actors_["10042ui_story"]

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(var_381_1) and arg_378_1.var_.characterEffect10042ui_story == nil then
				arg_378_1.var_.characterEffect10042ui_story = var_381_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_2 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_2 and not isNil(var_381_1) then
				if arg_378_1.var_.characterEffect10042ui_story and not isNil(var_381_1) then
					arg_378_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= 0 + var_381_2 and arg_378_1.time_ < 0 + var_381_2 + arg_381_0 and not isNil(var_381_1) and arg_378_1.var_.characterEffect10042ui_story then
				arg_378_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_381_4 = 0
			local var_381_5 = 0.5

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_4 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_6 = arg_378_1:GetWordFromCfg(121471092)
				local var_381_7 = arg_378_1:FormatText(var_381_6.content)

				arg_378_1.text_.text = var_381_7

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_9 = 20 <= 0 and var_381_5 or var_381_5 * (utf8.len(var_381_7) / 20)

				if (20 <= 0 and var_381_5 or var_381_5 * (utf8.len(var_381_7) / 20)) > 0 and var_381_5 < var_381_9 then
					arg_378_1.talkMaxDuration = var_381_9

					if var_381_9 + var_381_4 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_9 + var_381_4
					end
				end

				arg_378_1.text_.text = var_381_7
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471092", "story_v_out_121471.awb") ~= 0 then
					local var_381_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471092", "story_v_out_121471.awb") / 1000

					if var_381_10 + var_381_4 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_10 + var_381_4
					end

					if var_381_6.prefab_name ~= "" and arg_378_1.actors_[var_381_6.prefab_name] ~= nil then
						local var_381_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_6.prefab_name].transform, "story_v_out_121471", "121471092", "story_v_out_121471.awb")

						arg_378_1:RecordAudio("121471092", var_381_11)
						arg_378_1:RecordAudio("121471092", var_381_11)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_121471", "121471092", "story_v_out_121471.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_121471", "121471092", "story_v_out_121471.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_12 = math.max(var_381_5, arg_378_1.talkMaxDuration)

			if var_381_4 <= arg_378_1.time_ and arg_378_1.time_ < var_381_4 + var_381_12 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_4) / var_381_12

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_4 + var_381_12 and arg_378_1.time_ < var_381_4 + var_381_12 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play121471093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 121471093
		arg_382_1.duration_ = 4.1

		local var_382_0 = {
			ja = 3.833,
			ko = 4.1,
			zh = 4.1
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play121471094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0.55

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_1 = arg_382_1:GetWordFromCfg(121471093)
				local var_385_2 = arg_382_1:FormatText(var_385_1.content)

				arg_382_1.text_.text = var_385_2

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_4 = 22 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_2) / 22)

				if (22 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_2) / 22)) > 0 and var_385_0 < var_385_4 then
					arg_382_1.talkMaxDuration = var_385_4

					if var_385_4 + 0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_4 + 0
					end
				end

				arg_382_1.text_.text = var_385_2
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471093", "story_v_out_121471.awb") ~= 0 then
					local var_385_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471093", "story_v_out_121471.awb") / 1000

					if var_385_5 + 0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_5 + 0
					end

					if var_385_1.prefab_name ~= "" and arg_382_1.actors_[var_385_1.prefab_name] ~= nil then
						local var_385_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_1.prefab_name].transform, "story_v_out_121471", "121471093", "story_v_out_121471.awb")

						arg_382_1:RecordAudio("121471093", var_385_6)
						arg_382_1:RecordAudio("121471093", var_385_6)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_121471", "121471093", "story_v_out_121471.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_121471", "121471093", "story_v_out_121471.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_7 = math.max(var_385_0, arg_382_1.talkMaxDuration)

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_7 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - 0) / var_385_7

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= 0 + var_385_7 and arg_382_1.time_ < 0 + var_385_7 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play121471094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 121471094
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play121471095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(arg_386_1.actors_["10042ui_story"]) and arg_386_1.var_.characterEffect10042ui_story == nil then
				arg_386_1.var_.characterEffect10042ui_story = arg_386_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_0 = 0.200000002980232

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 and not isNil(arg_386_1.actors_["10042ui_story"]) then
				if arg_386_1.var_.characterEffect10042ui_story and not isNil(arg_386_1.actors_["10042ui_story"]) then
					arg_386_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_386_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_386_1.time_ - 0) / var_389_0)
				end
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 and not isNil(arg_386_1.actors_["10042ui_story"]) and arg_386_1.var_.characterEffect10042ui_story then
				arg_386_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_386_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			local var_389_1 = 0
			local var_389_2 = 0.175

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_3 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(121471094).content)

				arg_386_1.text_.text = var_389_3

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 7 <= 0 and var_389_2 or var_389_2 * (utf8.len(var_389_3) / 7)

				if (7 <= 0 and var_389_2 or var_389_2 * (utf8.len(var_389_3) / 7)) > 0 and var_389_2 < var_389_5 then
					arg_386_1.talkMaxDuration = var_389_5

					if var_389_5 + var_389_1 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_5 + var_389_1
					end
				end

				arg_386_1.text_.text = var_389_3
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_6 = math.max(var_389_2, arg_386_1.talkMaxDuration)

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_6 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_1) / var_389_6

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_1 + var_389_6 and arg_386_1.time_ < var_389_1 + var_389_6 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play121471095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 121471095
		arg_390_1.duration_ = 9.9

		local var_390_0 = {
			ja = 9.9,
			ko = 6.2,
			zh = 6.2
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play121471096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(arg_390_1.actors_["10042ui_story"]) and arg_390_1.var_.characterEffect10042ui_story == nil then
				arg_390_1.var_.characterEffect10042ui_story = arg_390_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_0 = 0.200000002980232

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 and not isNil(arg_390_1.actors_["10042ui_story"]) then
				if arg_390_1.var_.characterEffect10042ui_story and not isNil(arg_390_1.actors_["10042ui_story"]) then
					arg_390_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 and not isNil(arg_390_1.actors_["10042ui_story"]) and arg_390_1.var_.characterEffect10042ui_story then
				arg_390_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_393_2 = 0
			local var_393_3 = 0.475

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_2 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_4 = arg_390_1:GetWordFromCfg(121471095)
				local var_393_5 = arg_390_1:FormatText(var_393_4.content)

				arg_390_1.text_.text = var_393_5

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_7 = 19 <= 0 and var_393_3 or var_393_3 * (utf8.len(var_393_5) / 19)

				if (19 <= 0 and var_393_3 or var_393_3 * (utf8.len(var_393_5) / 19)) > 0 and var_393_3 < var_393_7 then
					arg_390_1.talkMaxDuration = var_393_7

					if var_393_7 + var_393_2 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_7 + var_393_2
					end
				end

				arg_390_1.text_.text = var_393_5
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471095", "story_v_out_121471.awb") ~= 0 then
					local var_393_8 = manager.audio:GetVoiceLength("story_v_out_121471", "121471095", "story_v_out_121471.awb") / 1000

					if var_393_8 + var_393_2 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_8 + var_393_2
					end

					if var_393_4.prefab_name ~= "" and arg_390_1.actors_[var_393_4.prefab_name] ~= nil then
						local var_393_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_4.prefab_name].transform, "story_v_out_121471", "121471095", "story_v_out_121471.awb")

						arg_390_1:RecordAudio("121471095", var_393_9)
						arg_390_1:RecordAudio("121471095", var_393_9)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_121471", "121471095", "story_v_out_121471.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_121471", "121471095", "story_v_out_121471.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_10 = math.max(var_393_3, arg_390_1.talkMaxDuration)

			if var_393_2 <= arg_390_1.time_ and arg_390_1.time_ < var_393_2 + var_393_10 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_2) / var_393_10

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_2 + var_393_10 and arg_390_1.time_ < var_393_2 + var_393_10 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play121471096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 121471096
		arg_394_1.duration_ = 11.93

		local var_394_0 = {
			ja = 9.133,
			ko = 11.933,
			zh = 11.933
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play121471097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(arg_394_1.actors_["1084ui_story"]) and arg_394_1.var_.characterEffect1084ui_story == nil then
				arg_394_1.var_.characterEffect1084ui_story = arg_394_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_0 = 0.200000002980232

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 and not isNil(arg_394_1.actors_["1084ui_story"]) then
				if arg_394_1.var_.characterEffect1084ui_story and not isNil(arg_394_1.actors_["1084ui_story"]) then
					arg_394_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 and not isNil(arg_394_1.actors_["1084ui_story"]) and arg_394_1.var_.characterEffect1084ui_story then
				arg_394_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_397_2 = arg_394_1.actors_["10042ui_story"]

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(var_397_2) and arg_394_1.var_.characterEffect10042ui_story == nil then
				arg_394_1.var_.characterEffect10042ui_story = var_397_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_3 = 0.200000002980232

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_3 and not isNil(var_397_2) then
				if arg_394_1.var_.characterEffect10042ui_story and not isNil(var_397_2) then
					arg_394_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_394_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_394_1.time_ - 0) / var_397_3)
				end
			end

			if arg_394_1.time_ >= 0 + var_397_3 and arg_394_1.time_ < 0 + var_397_3 + arg_397_0 and not isNil(var_397_2) and arg_394_1.var_.characterEffect10042ui_story then
				arg_394_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_394_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_397_4 = 0
			local var_397_5 = 1.075

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_4 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_6 = arg_394_1:GetWordFromCfg(121471096)
				local var_397_7 = arg_394_1:FormatText(var_397_6.content)

				arg_394_1.text_.text = var_397_7

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_9 = 43 <= 0 and var_397_5 or var_397_5 * (utf8.len(var_397_7) / 43)

				if (43 <= 0 and var_397_5 or var_397_5 * (utf8.len(var_397_7) / 43)) > 0 and var_397_5 < var_397_9 then
					arg_394_1.talkMaxDuration = var_397_9

					if var_397_9 + var_397_4 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_9 + var_397_4
					end
				end

				arg_394_1.text_.text = var_397_7
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471096", "story_v_out_121471.awb") ~= 0 then
					local var_397_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471096", "story_v_out_121471.awb") / 1000

					if var_397_10 + var_397_4 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_10 + var_397_4
					end

					if var_397_6.prefab_name ~= "" and arg_394_1.actors_[var_397_6.prefab_name] ~= nil then
						local var_397_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_6.prefab_name].transform, "story_v_out_121471", "121471096", "story_v_out_121471.awb")

						arg_394_1:RecordAudio("121471096", var_397_11)
						arg_394_1:RecordAudio("121471096", var_397_11)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_121471", "121471096", "story_v_out_121471.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_121471", "121471096", "story_v_out_121471.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_12 = math.max(var_397_5, arg_394_1.talkMaxDuration)

			if var_397_4 <= arg_394_1.time_ and arg_394_1.time_ < var_397_4 + var_397_12 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_4) / var_397_12

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_4 + var_397_12 and arg_394_1.time_ < var_397_4 + var_397_12 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play121471097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 121471097
		arg_398_1.duration_ = 6.67

		local var_398_0 = {
			ja = 6.666,
			ko = 3.6,
			zh = 3.6
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play121471098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_401_0 = 0
			local var_401_1 = 0.375

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_2 = arg_398_1:GetWordFromCfg(121471097)
				local var_401_3 = arg_398_1:FormatText(var_401_2.content)

				arg_398_1.text_.text = var_401_3

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 15 <= 0 and var_401_1 or var_401_1 * (utf8.len(var_401_3) / 15)

				if (15 <= 0 and var_401_1 or var_401_1 * (utf8.len(var_401_3) / 15)) > 0 and var_401_1 < var_401_5 then
					arg_398_1.talkMaxDuration = var_401_5

					if var_401_5 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_5 + var_401_0
					end
				end

				arg_398_1.text_.text = var_401_3
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471097", "story_v_out_121471.awb") ~= 0 then
					local var_401_6 = manager.audio:GetVoiceLength("story_v_out_121471", "121471097", "story_v_out_121471.awb") / 1000

					if var_401_6 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_6 + var_401_0
					end

					if var_401_2.prefab_name ~= "" and arg_398_1.actors_[var_401_2.prefab_name] ~= nil then
						local var_401_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_2.prefab_name].transform, "story_v_out_121471", "121471097", "story_v_out_121471.awb")

						arg_398_1:RecordAudio("121471097", var_401_7)
						arg_398_1:RecordAudio("121471097", var_401_7)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_121471", "121471097", "story_v_out_121471.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_121471", "121471097", "story_v_out_121471.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_8 = math.max(var_401_1, arg_398_1.talkMaxDuration)

			if var_401_0 <= arg_398_1.time_ and arg_398_1.time_ < var_401_0 + var_401_8 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_0) / var_401_8

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_0 + var_401_8 and arg_398_1.time_ < var_401_0 + var_401_8 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play121471098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 121471098
		arg_402_1.duration_ = 6.5

		local var_402_0 = {
			ja = 5.8,
			ko = 6.5,
			zh = 6.5
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play121471099(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(arg_402_1.actors_["1084ui_story"]) and arg_402_1.var_.characterEffect1084ui_story == nil then
				arg_402_1.var_.characterEffect1084ui_story = arg_402_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_0 = 0.200000002980232

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_0 and not isNil(arg_402_1.actors_["1084ui_story"]) then
				if arg_402_1.var_.characterEffect1084ui_story and not isNil(arg_402_1.actors_["1084ui_story"]) then
					arg_402_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_402_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_402_1.time_ - 0) / var_405_0)
				end
			end

			if arg_402_1.time_ >= 0 + var_405_0 and arg_402_1.time_ < 0 + var_405_0 + arg_405_0 and not isNil(arg_402_1.actors_["1084ui_story"]) and arg_402_1.var_.characterEffect1084ui_story then
				arg_402_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_402_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_405_1 = arg_402_1.actors_["10042ui_story"]

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(var_405_1) and arg_402_1.var_.characterEffect10042ui_story == nil then
				arg_402_1.var_.characterEffect10042ui_story = var_405_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_2 = 0.200000002980232

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_2 and not isNil(var_405_1) then
				if arg_402_1.var_.characterEffect10042ui_story and not isNil(var_405_1) then
					arg_402_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_402_1.time_ >= 0 + var_405_2 and arg_402_1.time_ < 0 + var_405_2 + arg_405_0 and not isNil(var_405_1) and arg_402_1.var_.characterEffect10042ui_story then
				arg_402_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_405_4 = 0
			local var_405_5 = 0.775

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_4 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_6 = arg_402_1:GetWordFromCfg(121471098)
				local var_405_7 = arg_402_1:FormatText(var_405_6.content)

				arg_402_1.text_.text = var_405_7

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_9 = 31 <= 0 and var_405_5 or var_405_5 * (utf8.len(var_405_7) / 31)

				if (31 <= 0 and var_405_5 or var_405_5 * (utf8.len(var_405_7) / 31)) > 0 and var_405_5 < var_405_9 then
					arg_402_1.talkMaxDuration = var_405_9

					if var_405_9 + var_405_4 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_9 + var_405_4
					end
				end

				arg_402_1.text_.text = var_405_7
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471098", "story_v_out_121471.awb") ~= 0 then
					local var_405_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471098", "story_v_out_121471.awb") / 1000

					if var_405_10 + var_405_4 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_10 + var_405_4
					end

					if var_405_6.prefab_name ~= "" and arg_402_1.actors_[var_405_6.prefab_name] ~= nil then
						local var_405_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_6.prefab_name].transform, "story_v_out_121471", "121471098", "story_v_out_121471.awb")

						arg_402_1:RecordAudio("121471098", var_405_11)
						arg_402_1:RecordAudio("121471098", var_405_11)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_121471", "121471098", "story_v_out_121471.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_121471", "121471098", "story_v_out_121471.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_12 = math.max(var_405_5, arg_402_1.talkMaxDuration)

			if var_405_4 <= arg_402_1.time_ and arg_402_1.time_ < var_405_4 + var_405_12 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_4) / var_405_12

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_4 + var_405_12 and arg_402_1.time_ < var_405_4 + var_405_12 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play121471099 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 121471099
		arg_406_1.duration_ = 3.9

		local var_406_0 = {
			ja = 3.9,
			ko = 3.833,
			zh = 3.833
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play121471100(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0.425

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_1 = arg_406_1:GetWordFromCfg(121471099)
				local var_409_2 = arg_406_1:FormatText(var_409_1.content)

				arg_406_1.text_.text = var_409_2

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_4 = 17 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 17)

				if (17 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 17)) > 0 and var_409_0 < var_409_4 then
					arg_406_1.talkMaxDuration = var_409_4

					if var_409_4 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_4 + 0
					end
				end

				arg_406_1.text_.text = var_409_2
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471099", "story_v_out_121471.awb") ~= 0 then
					local var_409_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471099", "story_v_out_121471.awb") / 1000

					if var_409_5 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_5 + 0
					end

					if var_409_1.prefab_name ~= "" and arg_406_1.actors_[var_409_1.prefab_name] ~= nil then
						local var_409_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_1.prefab_name].transform, "story_v_out_121471", "121471099", "story_v_out_121471.awb")

						arg_406_1:RecordAudio("121471099", var_409_6)
						arg_406_1:RecordAudio("121471099", var_409_6)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_121471", "121471099", "story_v_out_121471.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_121471", "121471099", "story_v_out_121471.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_7 = math.max(var_409_0, arg_406_1.talkMaxDuration)

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_7 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - 0) / var_409_7

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= 0 + var_409_7 and arg_406_1.time_ < 0 + var_409_7 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play121471100 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 121471100
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play121471101(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(arg_410_1.actors_["10042ui_story"]) and arg_410_1.var_.characterEffect10042ui_story == nil then
				arg_410_1.var_.characterEffect10042ui_story = arg_410_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_0 = 0.200000002980232

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 and not isNil(arg_410_1.actors_["10042ui_story"]) then
				if arg_410_1.var_.characterEffect10042ui_story and not isNil(arg_410_1.actors_["10042ui_story"]) then
					arg_410_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_410_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_410_1.time_ - 0) / var_413_0)
				end
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 and not isNil(arg_410_1.actors_["10042ui_story"]) and arg_410_1.var_.characterEffect10042ui_story then
				arg_410_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_410_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			local var_413_1 = 0
			local var_413_2 = 0.275

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_3 = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(121471100).content)

				arg_410_1.text_.text = var_413_3

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_5 = 11 <= 0 and var_413_2 or var_413_2 * (utf8.len(var_413_3) / 11)

				if (11 <= 0 and var_413_2 or var_413_2 * (utf8.len(var_413_3) / 11)) > 0 and var_413_2 < var_413_5 then
					arg_410_1.talkMaxDuration = var_413_5

					if var_413_5 + var_413_1 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_5 + var_413_1
					end
				end

				arg_410_1.text_.text = var_413_3
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_6 = math.max(var_413_2, arg_410_1.talkMaxDuration)

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_6 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_1) / var_413_6

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_1 + var_413_6 and arg_410_1.time_ < var_413_1 + var_413_6 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play121471101 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 121471101
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play121471102(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0.425

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, false)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_1 = arg_414_1:FormatText(arg_414_1:GetWordFromCfg(121471101).content)

				arg_414_1.text_.text = var_417_1

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_3 = 17 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_1) / 17)

				if (17 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_1) / 17)) > 0 and var_417_0 < var_417_3 then
					arg_414_1.talkMaxDuration = var_417_3

					if var_417_3 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_3 + 0
					end
				end

				arg_414_1.text_.text = var_417_1
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_4 = math.max(var_417_0, arg_414_1.talkMaxDuration)

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_4 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - 0) / var_417_4

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= 0 + var_417_4 and arg_414_1.time_ < 0 + var_417_4 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play121471102 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 121471102
		arg_418_1.duration_ = 7.83

		local var_418_0 = {
			ja = 7.833,
			ko = 6.933,
			zh = 6.933
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play121471103(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(arg_418_1.actors_["1084ui_story"]) and arg_418_1.var_.characterEffect1084ui_story == nil then
				arg_418_1.var_.characterEffect1084ui_story = arg_418_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_0 = 0.200000002980232

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 and not isNil(arg_418_1.actors_["1084ui_story"]) then
				if arg_418_1.var_.characterEffect1084ui_story and not isNil(arg_418_1.actors_["1084ui_story"]) then
					arg_418_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 and not isNil(arg_418_1.actors_["1084ui_story"]) and arg_418_1.var_.characterEffect1084ui_story then
				arg_418_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_421_2 = 0
			local var_421_3 = 0.825

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_2 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_4 = arg_418_1:GetWordFromCfg(121471102)
				local var_421_5 = arg_418_1:FormatText(var_421_4.content)

				arg_418_1.text_.text = var_421_5

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_7 = 33 <= 0 and var_421_3 or var_421_3 * (utf8.len(var_421_5) / 33)

				if (33 <= 0 and var_421_3 or var_421_3 * (utf8.len(var_421_5) / 33)) > 0 and var_421_3 < var_421_7 then
					arg_418_1.talkMaxDuration = var_421_7

					if var_421_7 + var_421_2 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_7 + var_421_2
					end
				end

				arg_418_1.text_.text = var_421_5
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471102", "story_v_out_121471.awb") ~= 0 then
					local var_421_8 = manager.audio:GetVoiceLength("story_v_out_121471", "121471102", "story_v_out_121471.awb") / 1000

					if var_421_8 + var_421_2 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_8 + var_421_2
					end

					if var_421_4.prefab_name ~= "" and arg_418_1.actors_[var_421_4.prefab_name] ~= nil then
						local var_421_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_4.prefab_name].transform, "story_v_out_121471", "121471102", "story_v_out_121471.awb")

						arg_418_1:RecordAudio("121471102", var_421_9)
						arg_418_1:RecordAudio("121471102", var_421_9)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_121471", "121471102", "story_v_out_121471.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_121471", "121471102", "story_v_out_121471.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_10 = math.max(var_421_3, arg_418_1.talkMaxDuration)

			if var_421_2 <= arg_418_1.time_ and arg_418_1.time_ < var_421_2 + var_421_10 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_2) / var_421_10

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_2 + var_421_10 and arg_418_1.time_ < var_421_2 + var_421_10 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play121471103 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 121471103
		arg_422_1.duration_ = 12.13

		local var_422_0 = {
			ja = 12.133,
			ko = 6.466,
			zh = 6.466
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play121471104(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_425_0 = 0
			local var_425_1 = 0.7

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_2 = arg_422_1:GetWordFromCfg(121471103)
				local var_425_3 = arg_422_1:FormatText(var_425_2.content)

				arg_422_1.text_.text = var_425_3

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_5 = 28 <= 0 and var_425_1 or var_425_1 * (utf8.len(var_425_3) / 28)

				if (28 <= 0 and var_425_1 or var_425_1 * (utf8.len(var_425_3) / 28)) > 0 and var_425_1 < var_425_5 then
					arg_422_1.talkMaxDuration = var_425_5

					if var_425_5 + var_425_0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_5 + var_425_0
					end
				end

				arg_422_1.text_.text = var_425_3
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471103", "story_v_out_121471.awb") ~= 0 then
					local var_425_6 = manager.audio:GetVoiceLength("story_v_out_121471", "121471103", "story_v_out_121471.awb") / 1000

					if var_425_6 + var_425_0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_6 + var_425_0
					end

					if var_425_2.prefab_name ~= "" and arg_422_1.actors_[var_425_2.prefab_name] ~= nil then
						local var_425_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_2.prefab_name].transform, "story_v_out_121471", "121471103", "story_v_out_121471.awb")

						arg_422_1:RecordAudio("121471103", var_425_7)
						arg_422_1:RecordAudio("121471103", var_425_7)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_121471", "121471103", "story_v_out_121471.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_121471", "121471103", "story_v_out_121471.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_8 = math.max(var_425_1, arg_422_1.talkMaxDuration)

			if var_425_0 <= arg_422_1.time_ and arg_422_1.time_ < var_425_0 + var_425_8 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_0) / var_425_8

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_0 + var_425_8 and arg_422_1.time_ < var_425_0 + var_425_8 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play121471104 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 121471104
		arg_426_1.duration_ = 7.67

		local var_426_0 = {
			ja = 7.666,
			ko = 3.666,
			zh = 3.666
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play121471105(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(arg_426_1.actors_["1084ui_story"]) and arg_426_1.var_.characterEffect1084ui_story == nil then
				arg_426_1.var_.characterEffect1084ui_story = arg_426_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_0 = 0.200000002980232

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_0 and not isNil(arg_426_1.actors_["1084ui_story"]) then
				if arg_426_1.var_.characterEffect1084ui_story and not isNil(arg_426_1.actors_["1084ui_story"]) then
					arg_426_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_426_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_426_1.time_ - 0) / var_429_0)
				end
			end

			if arg_426_1.time_ >= 0 + var_429_0 and arg_426_1.time_ < 0 + var_429_0 + arg_429_0 and not isNil(arg_426_1.actors_["1084ui_story"]) and arg_426_1.var_.characterEffect1084ui_story then
				arg_426_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_426_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_429_1 = arg_426_1.actors_["10042ui_story"]

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(var_429_1) and arg_426_1.var_.characterEffect10042ui_story == nil then
				arg_426_1.var_.characterEffect10042ui_story = var_429_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_2 = 0.200000002980232

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_2 and not isNil(var_429_1) then
				if arg_426_1.var_.characterEffect10042ui_story and not isNil(var_429_1) then
					arg_426_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_426_1.time_ >= 0 + var_429_2 and arg_426_1.time_ < 0 + var_429_2 + arg_429_0 and not isNil(var_429_1) and arg_426_1.var_.characterEffect10042ui_story then
				arg_426_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_429_4 = 0
			local var_429_5 = 0.4

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_4 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_6 = arg_426_1:GetWordFromCfg(121471104)
				local var_429_7 = arg_426_1:FormatText(var_429_6.content)

				arg_426_1.text_.text = var_429_7

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_9 = 16 <= 0 and var_429_5 or var_429_5 * (utf8.len(var_429_7) / 16)

				if (16 <= 0 and var_429_5 or var_429_5 * (utf8.len(var_429_7) / 16)) > 0 and var_429_5 < var_429_9 then
					arg_426_1.talkMaxDuration = var_429_9

					if var_429_9 + var_429_4 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_9 + var_429_4
					end
				end

				arg_426_1.text_.text = var_429_7
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471104", "story_v_out_121471.awb") ~= 0 then
					local var_429_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471104", "story_v_out_121471.awb") / 1000

					if var_429_10 + var_429_4 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_10 + var_429_4
					end

					if var_429_6.prefab_name ~= "" and arg_426_1.actors_[var_429_6.prefab_name] ~= nil then
						local var_429_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_6.prefab_name].transform, "story_v_out_121471", "121471104", "story_v_out_121471.awb")

						arg_426_1:RecordAudio("121471104", var_429_11)
						arg_426_1:RecordAudio("121471104", var_429_11)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_121471", "121471104", "story_v_out_121471.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_121471", "121471104", "story_v_out_121471.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_12 = math.max(var_429_5, arg_426_1.talkMaxDuration)

			if var_429_4 <= arg_426_1.time_ and arg_426_1.time_ < var_429_4 + var_429_12 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_4) / var_429_12

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_4 + var_429_12 and arg_426_1.time_ < var_429_4 + var_429_12 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play121471105 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 121471105
		arg_430_1.duration_ = 7.13

		local var_430_0 = {
			ja = 7.133,
			ko = 5.566,
			zh = 5.566
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play121471106(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(arg_430_1.actors_["1084ui_story"]) and arg_430_1.var_.characterEffect1084ui_story == nil then
				arg_430_1.var_.characterEffect1084ui_story = arg_430_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_0 = 0.200000002980232

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 and not isNil(arg_430_1.actors_["1084ui_story"]) then
				if arg_430_1.var_.characterEffect1084ui_story and not isNil(arg_430_1.actors_["1084ui_story"]) then
					arg_430_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 and not isNil(arg_430_1.actors_["1084ui_story"]) and arg_430_1.var_.characterEffect1084ui_story then
				arg_430_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_433_2 = arg_430_1.actors_["10042ui_story"]

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(var_433_2) and arg_430_1.var_.characterEffect10042ui_story == nil then
				arg_430_1.var_.characterEffect10042ui_story = var_433_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_3 = 0.200000002980232

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_3 and not isNil(var_433_2) then
				if arg_430_1.var_.characterEffect10042ui_story and not isNil(var_433_2) then
					arg_430_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_430_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_430_1.time_ - 0) / var_433_3)
				end
			end

			if arg_430_1.time_ >= 0 + var_433_3 and arg_430_1.time_ < 0 + var_433_3 + arg_433_0 and not isNil(var_433_2) and arg_430_1.var_.characterEffect10042ui_story then
				arg_430_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_430_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_433_4 = 0
			local var_433_5 = 0.625

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_4 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_6 = arg_430_1:GetWordFromCfg(121471105)
				local var_433_7 = arg_430_1:FormatText(var_433_6.content)

				arg_430_1.text_.text = var_433_7

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_9 = 25 <= 0 and var_433_5 or var_433_5 * (utf8.len(var_433_7) / 25)

				if (25 <= 0 and var_433_5 or var_433_5 * (utf8.len(var_433_7) / 25)) > 0 and var_433_5 < var_433_9 then
					arg_430_1.talkMaxDuration = var_433_9

					if var_433_9 + var_433_4 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_9 + var_433_4
					end
				end

				arg_430_1.text_.text = var_433_7
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471105", "story_v_out_121471.awb") ~= 0 then
					local var_433_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471105", "story_v_out_121471.awb") / 1000

					if var_433_10 + var_433_4 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_10 + var_433_4
					end

					if var_433_6.prefab_name ~= "" and arg_430_1.actors_[var_433_6.prefab_name] ~= nil then
						local var_433_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_6.prefab_name].transform, "story_v_out_121471", "121471105", "story_v_out_121471.awb")

						arg_430_1:RecordAudio("121471105", var_433_11)
						arg_430_1:RecordAudio("121471105", var_433_11)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_121471", "121471105", "story_v_out_121471.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_121471", "121471105", "story_v_out_121471.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_12 = math.max(var_433_5, arg_430_1.talkMaxDuration)

			if var_433_4 <= arg_430_1.time_ and arg_430_1.time_ < var_433_4 + var_433_12 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_4) / var_433_12

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_4 + var_433_12 and arg_430_1.time_ < var_433_4 + var_433_12 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play121471106 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 121471106
		arg_434_1.duration_ = 7.8

		local var_434_0 = {
			ja = 7.8,
			ko = 4.566,
			zh = 4.566
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play121471107(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(arg_434_1.actors_["1084ui_story"]) and arg_434_1.var_.characterEffect1084ui_story == nil then
				arg_434_1.var_.characterEffect1084ui_story = arg_434_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_0 = 0.200000002980232

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_0 and not isNil(arg_434_1.actors_["1084ui_story"]) then
				if arg_434_1.var_.characterEffect1084ui_story and not isNil(arg_434_1.actors_["1084ui_story"]) then
					arg_434_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_434_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_434_1.time_ - 0) / var_437_0)
				end
			end

			if arg_434_1.time_ >= 0 + var_437_0 and arg_434_1.time_ < 0 + var_437_0 + arg_437_0 and not isNil(arg_434_1.actors_["1084ui_story"]) and arg_434_1.var_.characterEffect1084ui_story then
				arg_434_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_434_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_437_1 = arg_434_1.actors_["10042ui_story"]

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(var_437_1) and arg_434_1.var_.characterEffect10042ui_story == nil then
				arg_434_1.var_.characterEffect10042ui_story = var_437_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_2 = 0.200000002980232

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_2 and not isNil(var_437_1) then
				if arg_434_1.var_.characterEffect10042ui_story and not isNil(var_437_1) then
					arg_434_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_434_1.time_ >= 0 + var_437_2 and arg_434_1.time_ < 0 + var_437_2 + arg_437_0 and not isNil(var_437_1) and arg_434_1.var_.characterEffect10042ui_story then
				arg_434_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_437_4 = 0
			local var_437_5 = 0.575

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_4 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_6 = arg_434_1:GetWordFromCfg(121471106)
				local var_437_7 = arg_434_1:FormatText(var_437_6.content)

				arg_434_1.text_.text = var_437_7

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_9 = 23 <= 0 and var_437_5 or var_437_5 * (utf8.len(var_437_7) / 23)

				if (23 <= 0 and var_437_5 or var_437_5 * (utf8.len(var_437_7) / 23)) > 0 and var_437_5 < var_437_9 then
					arg_434_1.talkMaxDuration = var_437_9

					if var_437_9 + var_437_4 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_9 + var_437_4
					end
				end

				arg_434_1.text_.text = var_437_7
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471106", "story_v_out_121471.awb") ~= 0 then
					local var_437_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471106", "story_v_out_121471.awb") / 1000

					if var_437_10 + var_437_4 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_10 + var_437_4
					end

					if var_437_6.prefab_name ~= "" and arg_434_1.actors_[var_437_6.prefab_name] ~= nil then
						local var_437_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_6.prefab_name].transform, "story_v_out_121471", "121471106", "story_v_out_121471.awb")

						arg_434_1:RecordAudio("121471106", var_437_11)
						arg_434_1:RecordAudio("121471106", var_437_11)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_121471", "121471106", "story_v_out_121471.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_121471", "121471106", "story_v_out_121471.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_12 = math.max(var_437_5, arg_434_1.talkMaxDuration)

			if var_437_4 <= arg_434_1.time_ and arg_434_1.time_ < var_437_4 + var_437_12 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_4) / var_437_12

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_4 + var_437_12 and arg_434_1.time_ < var_437_4 + var_437_12 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play121471107 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 121471107
		arg_438_1.duration_ = 12.8

		local var_438_0 = {
			ja = 9.633,
			ko = 12.8,
			zh = 12.8
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play121471108(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 1.325

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_1 = arg_438_1:GetWordFromCfg(121471107)
				local var_441_2 = arg_438_1:FormatText(var_441_1.content)

				arg_438_1.text_.text = var_441_2

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_4 = 54 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_2) / 54)

				if (54 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_2) / 54)) > 0 and var_441_0 < var_441_4 then
					arg_438_1.talkMaxDuration = var_441_4

					if var_441_4 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_4 + 0
					end
				end

				arg_438_1.text_.text = var_441_2
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471107", "story_v_out_121471.awb") ~= 0 then
					local var_441_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471107", "story_v_out_121471.awb") / 1000

					if var_441_5 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_5 + 0
					end

					if var_441_1.prefab_name ~= "" and arg_438_1.actors_[var_441_1.prefab_name] ~= nil then
						local var_441_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_1.prefab_name].transform, "story_v_out_121471", "121471107", "story_v_out_121471.awb")

						arg_438_1:RecordAudio("121471107", var_441_6)
						arg_438_1:RecordAudio("121471107", var_441_6)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_121471", "121471107", "story_v_out_121471.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_121471", "121471107", "story_v_out_121471.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_7 = math.max(var_441_0, arg_438_1.talkMaxDuration)

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_7 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - 0) / var_441_7

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= 0 + var_441_7 and arg_438_1.time_ < 0 + var_441_7 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play121471108 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 121471108
		arg_442_1.duration_ = 13.47

		local var_442_0 = {
			ja = 13.466,
			ko = 8.566,
			zh = 8.566
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play121471109(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0.8

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_1 = arg_442_1:GetWordFromCfg(121471108)
				local var_445_2 = arg_442_1:FormatText(var_445_1.content)

				arg_442_1.text_.text = var_445_2

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_4 = 32 <= 0 and var_445_0 or var_445_0 * (utf8.len(var_445_2) / 32)

				if (32 <= 0 and var_445_0 or var_445_0 * (utf8.len(var_445_2) / 32)) > 0 and var_445_0 < var_445_4 then
					arg_442_1.talkMaxDuration = var_445_4

					if var_445_4 + 0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_4 + 0
					end
				end

				arg_442_1.text_.text = var_445_2
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471108", "story_v_out_121471.awb") ~= 0 then
					local var_445_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471108", "story_v_out_121471.awb") / 1000

					if var_445_5 + 0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_5 + 0
					end

					if var_445_1.prefab_name ~= "" and arg_442_1.actors_[var_445_1.prefab_name] ~= nil then
						local var_445_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_1.prefab_name].transform, "story_v_out_121471", "121471108", "story_v_out_121471.awb")

						arg_442_1:RecordAudio("121471108", var_445_6)
						arg_442_1:RecordAudio("121471108", var_445_6)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_121471", "121471108", "story_v_out_121471.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_121471", "121471108", "story_v_out_121471.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_7 = math.max(var_445_0, arg_442_1.talkMaxDuration)

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_7 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - 0) / var_445_7

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= 0 + var_445_7 and arg_442_1.time_ < 0 + var_445_7 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play121471109 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 121471109
		arg_446_1.duration_ = 9.67

		local var_446_0 = {
			ja = 9.666,
			ko = 8.933,
			zh = 8.933
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play121471110(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(arg_446_1.actors_["1084ui_story"]) and arg_446_1.var_.characterEffect1084ui_story == nil then
				arg_446_1.var_.characterEffect1084ui_story = arg_446_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_0 = 0.200000002980232

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_0 and not isNil(arg_446_1.actors_["1084ui_story"]) then
				if arg_446_1.var_.characterEffect1084ui_story and not isNil(arg_446_1.actors_["1084ui_story"]) then
					arg_446_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_446_1.time_ >= 0 + var_449_0 and arg_446_1.time_ < 0 + var_449_0 + arg_449_0 and not isNil(arg_446_1.actors_["1084ui_story"]) and arg_446_1.var_.characterEffect1084ui_story then
				arg_446_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_449_2 = arg_446_1.actors_["10042ui_story"]

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(var_449_2) and arg_446_1.var_.characterEffect10042ui_story == nil then
				arg_446_1.var_.characterEffect10042ui_story = var_449_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_3 = 0.200000002980232

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_3 and not isNil(var_449_2) then
				if arg_446_1.var_.characterEffect10042ui_story and not isNil(var_449_2) then
					arg_446_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_446_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_446_1.time_ - 0) / var_449_3)
				end
			end

			if arg_446_1.time_ >= 0 + var_449_3 and arg_446_1.time_ < 0 + var_449_3 + arg_449_0 and not isNil(var_449_2) and arg_446_1.var_.characterEffect10042ui_story then
				arg_446_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_446_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_449_4 = 0
			local var_449_5 = 0.75

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_4 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_6 = arg_446_1:GetWordFromCfg(121471109)
				local var_449_7 = arg_446_1:FormatText(var_449_6.content)

				arg_446_1.text_.text = var_449_7

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_9 = 30 <= 0 and var_449_5 or var_449_5 * (utf8.len(var_449_7) / 30)

				if (30 <= 0 and var_449_5 or var_449_5 * (utf8.len(var_449_7) / 30)) > 0 and var_449_5 < var_449_9 then
					arg_446_1.talkMaxDuration = var_449_9

					if var_449_9 + var_449_4 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_9 + var_449_4
					end
				end

				arg_446_1.text_.text = var_449_7
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471109", "story_v_out_121471.awb") ~= 0 then
					local var_449_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471109", "story_v_out_121471.awb") / 1000

					if var_449_10 + var_449_4 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_10 + var_449_4
					end

					if var_449_6.prefab_name ~= "" and arg_446_1.actors_[var_449_6.prefab_name] ~= nil then
						local var_449_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_6.prefab_name].transform, "story_v_out_121471", "121471109", "story_v_out_121471.awb")

						arg_446_1:RecordAudio("121471109", var_449_11)
						arg_446_1:RecordAudio("121471109", var_449_11)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_121471", "121471109", "story_v_out_121471.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_121471", "121471109", "story_v_out_121471.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_12 = math.max(var_449_5, arg_446_1.talkMaxDuration)

			if var_449_4 <= arg_446_1.time_ and arg_446_1.time_ < var_449_4 + var_449_12 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_4) / var_449_12

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_4 + var_449_12 and arg_446_1.time_ < var_449_4 + var_449_12 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play121471110 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 121471110
		arg_450_1.duration_ = 5.53

		local var_450_0 = {
			ja = 4.366,
			ko = 5.533,
			zh = 5.533
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play121471111(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_453_0 = 0
			local var_453_1 = 0.55

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_2 = arg_450_1:GetWordFromCfg(121471110)
				local var_453_3 = arg_450_1:FormatText(var_453_2.content)

				arg_450_1.text_.text = var_453_3

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_5 = 22 <= 0 and var_453_1 or var_453_1 * (utf8.len(var_453_3) / 22)

				if (22 <= 0 and var_453_1 or var_453_1 * (utf8.len(var_453_3) / 22)) > 0 and var_453_1 < var_453_5 then
					arg_450_1.talkMaxDuration = var_453_5

					if var_453_5 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_5 + var_453_0
					end
				end

				arg_450_1.text_.text = var_453_3
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471110", "story_v_out_121471.awb") ~= 0 then
					local var_453_6 = manager.audio:GetVoiceLength("story_v_out_121471", "121471110", "story_v_out_121471.awb") / 1000

					if var_453_6 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_6 + var_453_0
					end

					if var_453_2.prefab_name ~= "" and arg_450_1.actors_[var_453_2.prefab_name] ~= nil then
						local var_453_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_2.prefab_name].transform, "story_v_out_121471", "121471110", "story_v_out_121471.awb")

						arg_450_1:RecordAudio("121471110", var_453_7)
						arg_450_1:RecordAudio("121471110", var_453_7)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_121471", "121471110", "story_v_out_121471.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_121471", "121471110", "story_v_out_121471.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_8 = math.max(var_453_1, arg_450_1.talkMaxDuration)

			if var_453_0 <= arg_450_1.time_ and arg_450_1.time_ < var_453_0 + var_453_8 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_0) / var_453_8

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_0 + var_453_8 and arg_450_1.time_ < var_453_0 + var_453_8 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play121471111 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 121471111
		arg_454_1.duration_ = 1.23

		local var_454_0 = {
			ja = 1.2,
			ko = 1.233,
			zh = 1.233
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play121471112(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(arg_454_1.actors_["1084ui_story"]) and arg_454_1.var_.characterEffect1084ui_story == nil then
				arg_454_1.var_.characterEffect1084ui_story = arg_454_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_0 = 0.200000002980232

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_0 and not isNil(arg_454_1.actors_["1084ui_story"]) then
				if arg_454_1.var_.characterEffect1084ui_story and not isNil(arg_454_1.actors_["1084ui_story"]) then
					arg_454_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_454_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_454_1.time_ - 0) / var_457_0)
				end
			end

			if arg_454_1.time_ >= 0 + var_457_0 and arg_454_1.time_ < 0 + var_457_0 + arg_457_0 and not isNil(arg_454_1.actors_["1084ui_story"]) and arg_454_1.var_.characterEffect1084ui_story then
				arg_454_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_454_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_457_1 = arg_454_1.actors_["10042ui_story"]

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(var_457_1) and arg_454_1.var_.characterEffect10042ui_story == nil then
				arg_454_1.var_.characterEffect10042ui_story = var_457_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_2 = 0.200000002980232

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_2 and not isNil(var_457_1) then
				if arg_454_1.var_.characterEffect10042ui_story and not isNil(var_457_1) then
					arg_454_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_454_1.time_ >= 0 + var_457_2 and arg_454_1.time_ < 0 + var_457_2 + arg_457_0 and not isNil(var_457_1) and arg_454_1.var_.characterEffect10042ui_story then
				arg_454_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_457_4 = 0
			local var_457_5 = 0.075

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_4 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_6 = arg_454_1:GetWordFromCfg(121471111)
				local var_457_7 = arg_454_1:FormatText(var_457_6.content)

				arg_454_1.text_.text = var_457_7

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_9 = 2 <= 0 and var_457_5 or var_457_5 * (utf8.len(var_457_7) / 2)

				if (2 <= 0 and var_457_5 or var_457_5 * (utf8.len(var_457_7) / 2)) > 0 and var_457_5 < var_457_9 then
					arg_454_1.talkMaxDuration = var_457_9

					if var_457_9 + var_457_4 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_9 + var_457_4
					end
				end

				arg_454_1.text_.text = var_457_7
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471111", "story_v_out_121471.awb") ~= 0 then
					local var_457_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471111", "story_v_out_121471.awb") / 1000

					if var_457_10 + var_457_4 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_10 + var_457_4
					end

					if var_457_6.prefab_name ~= "" and arg_454_1.actors_[var_457_6.prefab_name] ~= nil then
						local var_457_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_6.prefab_name].transform, "story_v_out_121471", "121471111", "story_v_out_121471.awb")

						arg_454_1:RecordAudio("121471111", var_457_11)
						arg_454_1:RecordAudio("121471111", var_457_11)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_121471", "121471111", "story_v_out_121471.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_121471", "121471111", "story_v_out_121471.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_12 = math.max(var_457_5, arg_454_1.talkMaxDuration)

			if var_457_4 <= arg_454_1.time_ and arg_454_1.time_ < var_457_4 + var_457_12 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_4) / var_457_12

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_4 + var_457_12 and arg_454_1.time_ < var_457_4 + var_457_12 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play121471112 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 121471112
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play121471113(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(arg_458_1.actors_["10042ui_story"]) and arg_458_1.var_.characterEffect10042ui_story == nil then
				arg_458_1.var_.characterEffect10042ui_story = arg_458_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_0 = 0.200000002980232

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 and not isNil(arg_458_1.actors_["10042ui_story"]) then
				if arg_458_1.var_.characterEffect10042ui_story and not isNil(arg_458_1.actors_["10042ui_story"]) then
					arg_458_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_458_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_458_1.time_ - 0) / var_461_0)
				end
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 and not isNil(arg_458_1.actors_["10042ui_story"]) and arg_458_1.var_.characterEffect10042ui_story then
				arg_458_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_458_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			local var_461_1 = 0
			local var_461_2 = 0.725

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_3 = arg_458_1:FormatText(arg_458_1:GetWordFromCfg(121471112).content)

				arg_458_1.text_.text = var_461_3

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_5 = 29 <= 0 and var_461_2 or var_461_2 * (utf8.len(var_461_3) / 29)

				if (29 <= 0 and var_461_2 or var_461_2 * (utf8.len(var_461_3) / 29)) > 0 and var_461_2 < var_461_5 then
					arg_458_1.talkMaxDuration = var_461_5

					if var_461_5 + var_461_1 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_5 + var_461_1
					end
				end

				arg_458_1.text_.text = var_461_3
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_6 = math.max(var_461_2, arg_458_1.talkMaxDuration)

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_6 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_1) / var_461_6

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_1 + var_461_6 and arg_458_1.time_ < var_461_1 + var_461_6 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play121471113 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 121471113
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play121471114(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = 0.75

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, false)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_1 = arg_462_1:FormatText(arg_462_1:GetWordFromCfg(121471113).content)

				arg_462_1.text_.text = var_465_1

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_3 = 30 <= 0 and var_465_0 or var_465_0 * (utf8.len(var_465_1) / 30)

				if (30 <= 0 and var_465_0 or var_465_0 * (utf8.len(var_465_1) / 30)) > 0 and var_465_0 < var_465_3 then
					arg_462_1.talkMaxDuration = var_465_3

					if var_465_3 + 0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_3 + 0
					end
				end

				arg_462_1.text_.text = var_465_1
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_4 = math.max(var_465_0, arg_462_1.talkMaxDuration)

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_4 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - 0) / var_465_4

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= 0 + var_465_4 and arg_462_1.time_ < 0 + var_465_4 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play121471114 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 121471114
		arg_466_1.duration_ = 8.5

		local var_466_0 = {
			ja = 8.5,
			ko = 4.166,
			zh = 4.166
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play121471115(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(arg_466_1.actors_["10042ui_story"]) and arg_466_1.var_.characterEffect10042ui_story == nil then
				arg_466_1.var_.characterEffect10042ui_story = arg_466_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_0 = 0.200000002980232

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_0 and not isNil(arg_466_1.actors_["10042ui_story"]) then
				if arg_466_1.var_.characterEffect10042ui_story and not isNil(arg_466_1.actors_["10042ui_story"]) then
					arg_466_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_466_1.time_ >= 0 + var_469_0 and arg_466_1.time_ < 0 + var_469_0 + arg_469_0 and not isNil(arg_466_1.actors_["10042ui_story"]) and arg_466_1.var_.characterEffect10042ui_story then
				arg_466_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_469_2 = 0
			local var_469_3 = 0.5

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_2 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_4 = arg_466_1:GetWordFromCfg(121471114)
				local var_469_5 = arg_466_1:FormatText(var_469_4.content)

				arg_466_1.text_.text = var_469_5

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_7 = 20 <= 0 and var_469_3 or var_469_3 * (utf8.len(var_469_5) / 20)

				if (20 <= 0 and var_469_3 or var_469_3 * (utf8.len(var_469_5) / 20)) > 0 and var_469_3 < var_469_7 then
					arg_466_1.talkMaxDuration = var_469_7

					if var_469_7 + var_469_2 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_7 + var_469_2
					end
				end

				arg_466_1.text_.text = var_469_5
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471114", "story_v_out_121471.awb") ~= 0 then
					local var_469_8 = manager.audio:GetVoiceLength("story_v_out_121471", "121471114", "story_v_out_121471.awb") / 1000

					if var_469_8 + var_469_2 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_8 + var_469_2
					end

					if var_469_4.prefab_name ~= "" and arg_466_1.actors_[var_469_4.prefab_name] ~= nil then
						local var_469_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_4.prefab_name].transform, "story_v_out_121471", "121471114", "story_v_out_121471.awb")

						arg_466_1:RecordAudio("121471114", var_469_9)
						arg_466_1:RecordAudio("121471114", var_469_9)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_121471", "121471114", "story_v_out_121471.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_121471", "121471114", "story_v_out_121471.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_10 = math.max(var_469_3, arg_466_1.talkMaxDuration)

			if var_469_2 <= arg_466_1.time_ and arg_466_1.time_ < var_469_2 + var_469_10 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_2) / var_469_10

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_2 + var_469_10 and arg_466_1.time_ < var_469_2 + var_469_10 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play121471115 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 121471115
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play121471116(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.var_.moveOldPos10042ui_story = arg_470_1.actors_["10042ui_story"].transform.localPosition
			end

			local var_473_0 = 0.001

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_0 then
				arg_470_1.actors_["10042ui_story"].transform.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos10042ui_story, Vector3.New(0, 100, 0), (arg_470_1.time_ - 0) / var_473_0)
				arg_470_1.actors_["10042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["10042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["10042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["10042ui_story"].transform.position).z)
				arg_470_1.actors_["10042ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["10042ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["10042ui_story"].transform.localEulerAngles = arg_470_1.actors_["10042ui_story"].transform.localEulerAngles
			end

			if arg_470_1.time_ >= 0 + var_473_0 and arg_470_1.time_ < 0 + var_473_0 + arg_473_0 then
				arg_470_1.actors_["10042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_470_1.actors_["10042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["10042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["10042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["10042ui_story"].transform.position).z)
				arg_470_1.actors_["10042ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["10042ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["10042ui_story"].transform.localEulerAngles = arg_470_1.actors_["10042ui_story"].transform.localEulerAngles
			end

			local var_473_1 = arg_470_1.actors_["1084ui_story"].transform

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.var_.moveOldPos1084ui_story = var_473_1.localPosition
			end

			local var_473_2 = 0.001

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_2 then
				var_473_1.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_470_1.time_ - 0) / var_473_2)
				var_473_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_473_1.position).x, (manager.ui.mainCamera.transform.position - var_473_1.position).y, (manager.ui.mainCamera.transform.position - var_473_1.position).z)
				var_473_1.localEulerAngles.z = 0
				var_473_1.localEulerAngles.x = 0
				var_473_1.localEulerAngles = var_473_1.localEulerAngles
			end

			if arg_470_1.time_ >= 0 + var_473_2 and arg_470_1.time_ < 0 + var_473_2 + arg_473_0 then
				var_473_1.localPosition = Vector3.New(0, 100, 0)
				var_473_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_473_1.position).x, (manager.ui.mainCamera.transform.position - var_473_1.position).y, (manager.ui.mainCamera.transform.position - var_473_1.position).z)
				var_473_1.localEulerAngles.z = 0
				var_473_1.localEulerAngles.x = 0
				var_473_1.localEulerAngles = var_473_1.localEulerAngles
			end

			local var_473_3 = 0
			local var_473_4 = 0.6

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_3 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_5 = arg_470_1:FormatText(arg_470_1:GetWordFromCfg(121471115).content)

				arg_470_1.text_.text = var_473_5

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_7 = 24 <= 0 and var_473_4 or var_473_4 * (utf8.len(var_473_5) / 24)

				if (24 <= 0 and var_473_4 or var_473_4 * (utf8.len(var_473_5) / 24)) > 0 and var_473_4 < var_473_7 then
					arg_470_1.talkMaxDuration = var_473_7

					if var_473_7 + var_473_3 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_7 + var_473_3
					end
				end

				arg_470_1.text_.text = var_473_5
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_8 = math.max(var_473_4, arg_470_1.talkMaxDuration)

			if var_473_3 <= arg_470_1.time_ and arg_470_1.time_ < var_473_3 + var_473_8 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_3) / var_473_8

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_3 + var_473_8 and arg_470_1.time_ < var_473_3 + var_473_8 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_470_1:InitPlayNodeList()
	end,
	Play121471116 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 121471116
		arg_474_1.duration_ = 6.77

		local var_474_0 = {
			ja = 6.766,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_474_1 = manager.audio:GetLocalizationFlag()

		if var_474_0[var_474_1] ~= nil then
			arg_474_1.duration_ = var_474_0[var_474_1]
		end

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play121471117(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.var_.moveOldPos1084ui_story = arg_474_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_477_0 = 0.001

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_0 then
				arg_474_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_474_1.time_ - 0) / var_477_0)
				arg_474_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_474_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1084ui_story"].transform.position).z)
				arg_474_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_474_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_474_1.actors_["1084ui_story"].transform.localEulerAngles = arg_474_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_474_1.time_ >= 0 + var_477_0 and arg_474_1.time_ < 0 + var_477_0 + arg_477_0 then
				arg_474_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_474_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_474_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1084ui_story"].transform.position).z)
				arg_474_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_474_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_474_1.actors_["1084ui_story"].transform.localEulerAngles = arg_474_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_477_1 = arg_474_1.actors_["1084ui_story"]

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 and not isNil(var_477_1) and arg_474_1.var_.characterEffect1084ui_story == nil then
				arg_474_1.var_.characterEffect1084ui_story = var_477_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_2 = 0.2

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_2 and not isNil(var_477_1) then
				if arg_474_1.var_.characterEffect1084ui_story and not isNil(var_477_1) then
					arg_474_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_474_1.time_ >= 0 + var_477_2 and arg_474_1.time_ < 0 + var_477_2 + arg_477_0 and not isNil(var_477_1) and arg_474_1.var_.characterEffect1084ui_story then
				arg_474_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_477_4 = 0
			local var_477_5 = 0.15

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_4 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				arg_474_1.leftNameTxt_.text = arg_474_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_6 = arg_474_1:GetWordFromCfg(121471116)
				local var_477_7 = arg_474_1:FormatText(var_477_6.content)

				arg_474_1.text_.text = var_477_7

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_9 = 6 <= 0 and var_477_5 or var_477_5 * (utf8.len(var_477_7) / 6)

				if (6 <= 0 and var_477_5 or var_477_5 * (utf8.len(var_477_7) / 6)) > 0 and var_477_5 < var_477_9 then
					arg_474_1.talkMaxDuration = var_477_9

					if var_477_9 + var_477_4 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_9 + var_477_4
					end
				end

				arg_474_1.text_.text = var_477_7
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471116", "story_v_out_121471.awb") ~= 0 then
					local var_477_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471116", "story_v_out_121471.awb") / 1000

					if var_477_10 + var_477_4 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_10 + var_477_4
					end

					if var_477_6.prefab_name ~= "" and arg_474_1.actors_[var_477_6.prefab_name] ~= nil then
						local var_477_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_6.prefab_name].transform, "story_v_out_121471", "121471116", "story_v_out_121471.awb")

						arg_474_1:RecordAudio("121471116", var_477_11)
						arg_474_1:RecordAudio("121471116", var_477_11)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_121471", "121471116", "story_v_out_121471.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_121471", "121471116", "story_v_out_121471.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_12 = math.max(var_477_5, arg_474_1.talkMaxDuration)

			if var_477_4 <= arg_474_1.time_ and arg_474_1.time_ < var_477_4 + var_477_12 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_4) / var_477_12

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_4 + var_477_12 and arg_474_1.time_ < var_477_4 + var_477_12 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_474_1:InitPlayNodeList()
	end,
	Play121471117 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 121471117
		arg_478_1.duration_ = 5

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play121471118(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(arg_478_1.actors_["1084ui_story"]) and arg_478_1.var_.characterEffect1084ui_story == nil then
				arg_478_1.var_.characterEffect1084ui_story = arg_478_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_0 = 0.2

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_0 and not isNil(arg_478_1.actors_["1084ui_story"]) then
				if arg_478_1.var_.characterEffect1084ui_story and not isNil(arg_478_1.actors_["1084ui_story"]) then
					arg_478_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_478_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_478_1.time_ - 0) / var_481_0)
				end
			end

			if arg_478_1.time_ >= 0 + var_481_0 and arg_478_1.time_ < 0 + var_481_0 + arg_481_0 and not isNil(arg_478_1.actors_["1084ui_story"]) and arg_478_1.var_.characterEffect1084ui_story then
				arg_478_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_478_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_481_1 = 0
			local var_481_2 = 0.85

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_1 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				arg_478_1.leftNameTxt_.text = arg_478_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, true)
				arg_478_1.iconController_:SetSelectedState("hero")

				arg_478_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_478_1.callingController_:SetSelectedState("normal")

				arg_478_1.keyicon_.color = Color.New(1, 1, 1)
				arg_478_1.icon_.color = Color.New(1, 1, 1)

				local var_481_3 = arg_478_1:FormatText(arg_478_1:GetWordFromCfg(121471117).content)

				arg_478_1.text_.text = var_481_3

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_5 = 34 <= 0 and var_481_2 or var_481_2 * (utf8.len(var_481_3) / 34)

				if (34 <= 0 and var_481_2 or var_481_2 * (utf8.len(var_481_3) / 34)) > 0 and var_481_2 < var_481_5 then
					arg_478_1.talkMaxDuration = var_481_5

					if var_481_5 + var_481_1 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_5 + var_481_1
					end
				end

				arg_478_1.text_.text = var_481_3
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_6 = math.max(var_481_2, arg_478_1.talkMaxDuration)

			if var_481_1 <= arg_478_1.time_ and arg_478_1.time_ < var_481_1 + var_481_6 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_1) / var_481_6

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_1 + var_481_6 and arg_478_1.time_ < var_481_1 + var_481_6 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play121471118 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 121471118
		arg_482_1.duration_ = 2.2

		local var_482_0 = {
			ja = 2.2,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play121471119(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 and not isNil(arg_482_1.actors_["1084ui_story"]) and arg_482_1.var_.characterEffect1084ui_story == nil then
				arg_482_1.var_.characterEffect1084ui_story = arg_482_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_0 = 0.2

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_0 and not isNil(arg_482_1.actors_["1084ui_story"]) then
				if arg_482_1.var_.characterEffect1084ui_story and not isNil(arg_482_1.actors_["1084ui_story"]) then
					arg_482_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_482_1.time_ >= 0 + var_485_0 and arg_482_1.time_ < 0 + var_485_0 + arg_485_0 and not isNil(arg_482_1.actors_["1084ui_story"]) and arg_482_1.var_.characterEffect1084ui_story then
				arg_482_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_485_2 = 0
			local var_485_3 = 0.05

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_2 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_4 = arg_482_1:GetWordFromCfg(121471118)
				local var_485_5 = arg_482_1:FormatText(var_485_4.content)

				arg_482_1.text_.text = var_485_5

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_7 = 2 <= 0 and var_485_3 or var_485_3 * (utf8.len(var_485_5) / 2)

				if (2 <= 0 and var_485_3 or var_485_3 * (utf8.len(var_485_5) / 2)) > 0 and var_485_3 < var_485_7 then
					arg_482_1.talkMaxDuration = var_485_7

					if var_485_7 + var_485_2 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_7 + var_485_2
					end
				end

				arg_482_1.text_.text = var_485_5
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471118", "story_v_out_121471.awb") ~= 0 then
					local var_485_8 = manager.audio:GetVoiceLength("story_v_out_121471", "121471118", "story_v_out_121471.awb") / 1000

					if var_485_8 + var_485_2 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_8 + var_485_2
					end

					if var_485_4.prefab_name ~= "" and arg_482_1.actors_[var_485_4.prefab_name] ~= nil then
						local var_485_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_4.prefab_name].transform, "story_v_out_121471", "121471118", "story_v_out_121471.awb")

						arg_482_1:RecordAudio("121471118", var_485_9)
						arg_482_1:RecordAudio("121471118", var_485_9)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_121471", "121471118", "story_v_out_121471.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_121471", "121471118", "story_v_out_121471.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_10 = math.max(var_485_3, arg_482_1.talkMaxDuration)

			if var_485_2 <= arg_482_1.time_ and arg_482_1.time_ < var_485_2 + var_485_10 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_2) / var_485_10

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_2 + var_485_10 and arg_482_1.time_ < var_485_2 + var_485_10 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play121471119 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 121471119
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play121471120(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 and not isNil(arg_486_1.actors_["1084ui_story"]) and arg_486_1.var_.characterEffect1084ui_story == nil then
				arg_486_1.var_.characterEffect1084ui_story = arg_486_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_0 = 0.2

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_0 and not isNil(arg_486_1.actors_["1084ui_story"]) then
				if arg_486_1.var_.characterEffect1084ui_story and not isNil(arg_486_1.actors_["1084ui_story"]) then
					arg_486_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_486_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_486_1.time_ - 0) / var_489_0)
				end
			end

			if arg_486_1.time_ >= 0 + var_489_0 and arg_486_1.time_ < 0 + var_489_0 + arg_489_0 and not isNil(arg_486_1.actors_["1084ui_story"]) and arg_486_1.var_.characterEffect1084ui_story then
				arg_486_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_486_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_489_1 = 0
			local var_489_2 = 0.975

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				arg_486_1.leftNameTxt_.text = arg_486_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, true)
				arg_486_1.iconController_:SetSelectedState("hero")

				arg_486_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_486_1.callingController_:SetSelectedState("normal")

				arg_486_1.keyicon_.color = Color.New(1, 1, 1)
				arg_486_1.icon_.color = Color.New(1, 1, 1)

				local var_489_3 = arg_486_1:FormatText(arg_486_1:GetWordFromCfg(121471119).content)

				arg_486_1.text_.text = var_489_3

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_5 = 39 <= 0 and var_489_2 or var_489_2 * (utf8.len(var_489_3) / 39)

				if (39 <= 0 and var_489_2 or var_489_2 * (utf8.len(var_489_3) / 39)) > 0 and var_489_2 < var_489_5 then
					arg_486_1.talkMaxDuration = var_489_5

					if var_489_5 + var_489_1 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_5 + var_489_1
					end
				end

				arg_486_1.text_.text = var_489_3
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_6 = math.max(var_489_2, arg_486_1.talkMaxDuration)

			if var_489_1 <= arg_486_1.time_ and arg_486_1.time_ < var_489_1 + var_489_6 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_1) / var_489_6

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_1 + var_489_6 and arg_486_1.time_ < var_489_1 + var_489_6 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play121471120 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 121471120
		arg_490_1.duration_ = 15.17

		local var_490_0 = {
			ja = 15.166,
			ko = 14.333,
			zh = 14.333
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play121471121(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 and not isNil(arg_490_1.actors_["1084ui_story"]) and arg_490_1.var_.characterEffect1084ui_story == nil then
				arg_490_1.var_.characterEffect1084ui_story = arg_490_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_0 = 0.2

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_0 and not isNil(arg_490_1.actors_["1084ui_story"]) then
				if arg_490_1.var_.characterEffect1084ui_story and not isNil(arg_490_1.actors_["1084ui_story"]) then
					arg_490_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_490_1.time_ >= 0 + var_493_0 and arg_490_1.time_ < 0 + var_493_0 + arg_493_0 and not isNil(arg_490_1.actors_["1084ui_story"]) and arg_490_1.var_.characterEffect1084ui_story then
				arg_490_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_493_2 = 0
			local var_493_3 = 1.25

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_2 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_4 = arg_490_1:GetWordFromCfg(121471120)
				local var_493_5 = arg_490_1:FormatText(var_493_4.content)

				arg_490_1.text_.text = var_493_5

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_7 = 50 <= 0 and var_493_3 or var_493_3 * (utf8.len(var_493_5) / 50)

				if (50 <= 0 and var_493_3 or var_493_3 * (utf8.len(var_493_5) / 50)) > 0 and var_493_3 < var_493_7 then
					arg_490_1.talkMaxDuration = var_493_7

					if var_493_7 + var_493_2 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_7 + var_493_2
					end
				end

				arg_490_1.text_.text = var_493_5
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471120", "story_v_out_121471.awb") ~= 0 then
					local var_493_8 = manager.audio:GetVoiceLength("story_v_out_121471", "121471120", "story_v_out_121471.awb") / 1000

					if var_493_8 + var_493_2 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_8 + var_493_2
					end

					if var_493_4.prefab_name ~= "" and arg_490_1.actors_[var_493_4.prefab_name] ~= nil then
						local var_493_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_4.prefab_name].transform, "story_v_out_121471", "121471120", "story_v_out_121471.awb")

						arg_490_1:RecordAudio("121471120", var_493_9)
						arg_490_1:RecordAudio("121471120", var_493_9)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_121471", "121471120", "story_v_out_121471.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_121471", "121471120", "story_v_out_121471.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_10 = math.max(var_493_3, arg_490_1.talkMaxDuration)

			if var_493_2 <= arg_490_1.time_ and arg_490_1.time_ < var_493_2 + var_493_10 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_2) / var_493_10

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_2 + var_493_10 and arg_490_1.time_ < var_493_2 + var_493_10 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play121471121 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 121471121
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play121471122(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 and not isNil(arg_494_1.actors_["1084ui_story"]) and arg_494_1.var_.characterEffect1084ui_story == nil then
				arg_494_1.var_.characterEffect1084ui_story = arg_494_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_0 = 0.2

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_0 and not isNil(arg_494_1.actors_["1084ui_story"]) then
				if arg_494_1.var_.characterEffect1084ui_story and not isNil(arg_494_1.actors_["1084ui_story"]) then
					arg_494_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_494_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_494_1.time_ - 0) / var_497_0)
				end
			end

			if arg_494_1.time_ >= 0 + var_497_0 and arg_494_1.time_ < 0 + var_497_0 + arg_497_0 and not isNil(arg_494_1.actors_["1084ui_story"]) and arg_494_1.var_.characterEffect1084ui_story then
				arg_494_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_494_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_497_1 = 0
			local var_497_2 = 0.15

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_3 = arg_494_1:FormatText(arg_494_1:GetWordFromCfg(121471121).content)

				arg_494_1.text_.text = var_497_3

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_5 = 6 <= 0 and var_497_2 or var_497_2 * (utf8.len(var_497_3) / 6)

				if (6 <= 0 and var_497_2 or var_497_2 * (utf8.len(var_497_3) / 6)) > 0 and var_497_2 < var_497_5 then
					arg_494_1.talkMaxDuration = var_497_5

					if var_497_5 + var_497_1 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_5 + var_497_1
					end
				end

				arg_494_1.text_.text = var_497_3
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_6 = math.max(var_497_2, arg_494_1.talkMaxDuration)

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_6 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_1) / var_497_6

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_1 + var_497_6 and arg_494_1.time_ < var_497_1 + var_497_6 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play121471122 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 121471122
		arg_498_1.duration_ = 5.1

		local var_498_0 = {
			ja = 5.1,
			ko = 3.166,
			zh = 3.166
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play121471123(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 and not isNil(arg_498_1.actors_["1084ui_story"]) and arg_498_1.var_.characterEffect1084ui_story == nil then
				arg_498_1.var_.characterEffect1084ui_story = arg_498_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_0 = 0.2

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_0 and not isNil(arg_498_1.actors_["1084ui_story"]) then
				if arg_498_1.var_.characterEffect1084ui_story and not isNil(arg_498_1.actors_["1084ui_story"]) then
					arg_498_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= 0 + var_501_0 and arg_498_1.time_ < 0 + var_501_0 + arg_501_0 and not isNil(arg_498_1.actors_["1084ui_story"]) and arg_498_1.var_.characterEffect1084ui_story then
				arg_498_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_501_2 = 0
			local var_501_3 = 0.3

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_2 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_4 = arg_498_1:GetWordFromCfg(121471122)
				local var_501_5 = arg_498_1:FormatText(var_501_4.content)

				arg_498_1.text_.text = var_501_5

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_7 = 12 <= 0 and var_501_3 or var_501_3 * (utf8.len(var_501_5) / 12)

				if (12 <= 0 and var_501_3 or var_501_3 * (utf8.len(var_501_5) / 12)) > 0 and var_501_3 < var_501_7 then
					arg_498_1.talkMaxDuration = var_501_7

					if var_501_7 + var_501_2 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_7 + var_501_2
					end
				end

				arg_498_1.text_.text = var_501_5
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471122", "story_v_out_121471.awb") ~= 0 then
					local var_501_8 = manager.audio:GetVoiceLength("story_v_out_121471", "121471122", "story_v_out_121471.awb") / 1000

					if var_501_8 + var_501_2 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_8 + var_501_2
					end

					if var_501_4.prefab_name ~= "" and arg_498_1.actors_[var_501_4.prefab_name] ~= nil then
						local var_501_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_4.prefab_name].transform, "story_v_out_121471", "121471122", "story_v_out_121471.awb")

						arg_498_1:RecordAudio("121471122", var_501_9)
						arg_498_1:RecordAudio("121471122", var_501_9)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_out_121471", "121471122", "story_v_out_121471.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_out_121471", "121471122", "story_v_out_121471.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_10 = math.max(var_501_3, arg_498_1.talkMaxDuration)

			if var_501_2 <= arg_498_1.time_ and arg_498_1.time_ < var_501_2 + var_501_10 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_2) / var_501_10

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_2 + var_501_10 and arg_498_1.time_ < var_501_2 + var_501_10 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play121471123 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 121471123
		arg_502_1.duration_ = 12

		local var_502_0 = {
			ja = 12,
			ko = 6.933,
			zh = 6.933
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play121471124(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = 0.8

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_1 = arg_502_1:GetWordFromCfg(121471123)
				local var_505_2 = arg_502_1:FormatText(var_505_1.content)

				arg_502_1.text_.text = var_505_2

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_4 = 32 <= 0 and var_505_0 or var_505_0 * (utf8.len(var_505_2) / 32)

				if (32 <= 0 and var_505_0 or var_505_0 * (utf8.len(var_505_2) / 32)) > 0 and var_505_0 < var_505_4 then
					arg_502_1.talkMaxDuration = var_505_4

					if var_505_4 + 0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_4 + 0
					end
				end

				arg_502_1.text_.text = var_505_2
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471123", "story_v_out_121471.awb") ~= 0 then
					local var_505_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471123", "story_v_out_121471.awb") / 1000

					if var_505_5 + 0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_5 + 0
					end

					if var_505_1.prefab_name ~= "" and arg_502_1.actors_[var_505_1.prefab_name] ~= nil then
						local var_505_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_1.prefab_name].transform, "story_v_out_121471", "121471123", "story_v_out_121471.awb")

						arg_502_1:RecordAudio("121471123", var_505_6)
						arg_502_1:RecordAudio("121471123", var_505_6)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_out_121471", "121471123", "story_v_out_121471.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_out_121471", "121471123", "story_v_out_121471.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_7 = math.max(var_505_0, arg_502_1.talkMaxDuration)

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_7 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - 0) / var_505_7

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= 0 + var_505_7 and arg_502_1.time_ < 0 + var_505_7 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play121471124 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 121471124
		arg_506_1.duration_ = 13.3

		local var_506_0 = {
			ja = 13.3,
			ko = 12.633,
			zh = 12.633
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play121471125(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_509_0 = 0
			local var_509_1 = 1.55

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				arg_506_1.leftNameTxt_.text = arg_506_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_2 = arg_506_1:GetWordFromCfg(121471124)
				local var_509_3 = arg_506_1:FormatText(var_509_2.content)

				arg_506_1.text_.text = var_509_3

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_5 = 62 <= 0 and var_509_1 or var_509_1 * (utf8.len(var_509_3) / 62)

				if (62 <= 0 and var_509_1 or var_509_1 * (utf8.len(var_509_3) / 62)) > 0 and var_509_1 < var_509_5 then
					arg_506_1.talkMaxDuration = var_509_5

					if var_509_5 + var_509_0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_5 + var_509_0
					end
				end

				arg_506_1.text_.text = var_509_3
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471124", "story_v_out_121471.awb") ~= 0 then
					local var_509_6 = manager.audio:GetVoiceLength("story_v_out_121471", "121471124", "story_v_out_121471.awb") / 1000

					if var_509_6 + var_509_0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_6 + var_509_0
					end

					if var_509_2.prefab_name ~= "" and arg_506_1.actors_[var_509_2.prefab_name] ~= nil then
						local var_509_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_2.prefab_name].transform, "story_v_out_121471", "121471124", "story_v_out_121471.awb")

						arg_506_1:RecordAudio("121471124", var_509_7)
						arg_506_1:RecordAudio("121471124", var_509_7)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_out_121471", "121471124", "story_v_out_121471.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_out_121471", "121471124", "story_v_out_121471.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_8 = math.max(var_509_1, arg_506_1.talkMaxDuration)

			if var_509_0 <= arg_506_1.time_ and arg_506_1.time_ < var_509_0 + var_509_8 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_0) / var_509_8

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_0 + var_509_8 and arg_506_1.time_ < var_509_0 + var_509_8 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play121471125 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 121471125
		arg_510_1.duration_ = 15.1

		local var_510_0 = {
			ja = 15.1,
			ko = 9.333,
			zh = 9.333
		}
		local var_510_1 = manager.audio:GetLocalizationFlag()

		if var_510_0[var_510_1] ~= nil then
			arg_510_1.duration_ = var_510_0[var_510_1]
		end

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play121471126(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = 0.0329999998211861

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				arg_510_1.leftNameTxt_.text = arg_510_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_1 = arg_510_1:GetWordFromCfg(121471125)
				local var_513_2 = arg_510_1:FormatText(var_513_1.content)

				arg_510_1.text_.text = var_513_2

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_4 = 50 <= 0 and var_513_0 or var_513_0 * (utf8.len(var_513_2) / 50)

				if (50 <= 0 and var_513_0 or var_513_0 * (utf8.len(var_513_2) / 50)) > 0 and var_513_0 < var_513_4 then
					arg_510_1.talkMaxDuration = var_513_4

					if var_513_4 + 0 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_4 + 0
					end
				end

				arg_510_1.text_.text = var_513_2
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471125", "story_v_out_121471.awb") ~= 0 then
					local var_513_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471125", "story_v_out_121471.awb") / 1000

					if var_513_5 + 0 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_5 + 0
					end

					if var_513_1.prefab_name ~= "" and arg_510_1.actors_[var_513_1.prefab_name] ~= nil then
						local var_513_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_1.prefab_name].transform, "story_v_out_121471", "121471125", "story_v_out_121471.awb")

						arg_510_1:RecordAudio("121471125", var_513_6)
						arg_510_1:RecordAudio("121471125", var_513_6)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_out_121471", "121471125", "story_v_out_121471.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_out_121471", "121471125", "story_v_out_121471.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_7 = math.max(var_513_0, arg_510_1.talkMaxDuration)

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_7 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - 0) / var_513_7

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= 0 + var_513_7 and arg_510_1.time_ < 0 + var_513_7 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play121471126 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 121471126
		arg_514_1.duration_ = 6.53

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play121471127(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if arg_514_1.bgs_.J12f == nil then
				local var_517_0 = Object.Instantiate(arg_514_1.paintGo_)

				var_517_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J12f")
				var_517_0.name = "J12f"
				var_517_0.transform.parent = arg_514_1.stage_.transform
				var_517_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_514_1.bgs_.J12f = var_517_0
			end

			if 1.999999999999 < arg_514_1.time_ and arg_514_1.time_ <= 1.999999999999 + arg_517_0 then
				local var_517_1 = arg_514_1.bgs_.J12f

				arg_514_1.bgs_.J12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_517_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_517_2 = var_517_1:GetComponent("SpriteRenderer")

				if var_517_2 and var_517_2.sprite then
					local var_517_3 = 2 * (var_517_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_517_1.transform.localScale = Vector3.New(var_517_3 / var_517_2.sprite.bounds.size.y < var_517_3 * manager.ui.mainCameraCom_.aspect / var_517_2.sprite.bounds.size.x and var_517_3 * manager.ui.mainCameraCom_.aspect / var_517_2.sprite.bounds.size.x or var_517_3 / var_517_2.sprite.bounds.size.y, var_517_3 / var_517_2.sprite.bounds.size.y < var_517_3 * manager.ui.mainCameraCom_.aspect / var_517_2.sprite.bounds.size.x and var_517_3 * manager.ui.mainCameraCom_.aspect / var_517_2.sprite.bounds.size.x or var_517_3 / var_517_2.sprite.bounds.size.y, 0)
				end

				for iter_517_0, iter_517_1 in pairs(arg_514_1.bgs_) do
					if iter_517_0 ~= "J12f" then
						iter_517_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_517_4 = 0

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_4 + arg_517_0 then
				arg_514_1.mask_.enabled = true
				arg_514_1.mask_.raycastTarget = true

				arg_514_1:SetGaussion(false)
			end

			local var_517_5 = 2

			if var_517_4 <= arg_514_1.time_ and arg_514_1.time_ < var_517_4 + var_517_5 then
				local var_517_6 = Color.New(0, 0, 0)

				var_517_6.a = Mathf.Lerp(0, 1, (arg_514_1.time_ - var_517_4) / var_517_5)
				arg_514_1.mask_.color = var_517_6
			end

			if arg_514_1.time_ >= var_517_4 + var_517_5 and arg_514_1.time_ < var_517_4 + var_517_5 + arg_517_0 then
				local var_517_7 = Color.New(0, 0, 0)

				var_517_7.a = 1
				arg_514_1.mask_.color = var_517_7
			end

			local var_517_8 = 1.999999999999

			if 1.999999999999 < arg_514_1.time_ and arg_514_1.time_ <= var_517_8 + arg_517_0 then
				arg_514_1.mask_.enabled = true
				arg_514_1.mask_.raycastTarget = true

				arg_514_1:SetGaussion(false)
			end

			local var_517_9 = 2

			if var_517_8 <= arg_514_1.time_ and arg_514_1.time_ < var_517_8 + var_517_9 then
				local var_517_10 = Color.New(0, 0, 0)

				var_517_10.a = Mathf.Lerp(1, 0, (arg_514_1.time_ - var_517_8) / var_517_9)
				arg_514_1.mask_.color = var_517_10
			end

			if arg_514_1.time_ >= var_517_8 + var_517_9 and arg_514_1.time_ < var_517_8 + var_517_9 + arg_517_0 then
				local var_517_11 = Color.New(0, 0, 0)

				arg_514_1.mask_.enabled = false
				var_517_11.a = 0
				arg_514_1.mask_.color = var_517_11
			end

			local var_517_12 = arg_514_1.actors_["1084ui_story"].transform

			if 1.96599999815226 < arg_514_1.time_ and arg_514_1.time_ <= 1.96599999815226 + arg_517_0 then
				arg_514_1.var_.moveOldPos1084ui_story = var_517_12.localPosition
			end

			local var_517_13 = 0.001

			if 1.96599999815226 <= arg_514_1.time_ and arg_514_1.time_ < 1.96599999815226 + var_517_13 then
				var_517_12.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_514_1.time_ - 1.96599999815226) / var_517_13)
				var_517_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_517_12.position).x, (manager.ui.mainCamera.transform.position - var_517_12.position).y, (manager.ui.mainCamera.transform.position - var_517_12.position).z)
				var_517_12.localEulerAngles.z = 0
				var_517_12.localEulerAngles.x = 0
				var_517_12.localEulerAngles = var_517_12.localEulerAngles
			end

			if arg_514_1.time_ >= 1.96599999815226 + var_517_13 and arg_514_1.time_ < 1.96599999815226 + var_517_13 + arg_517_0 then
				var_517_12.localPosition = Vector3.New(0, 100, 0)
				var_517_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_517_12.position).x, (manager.ui.mainCamera.transform.position - var_517_12.position).y, (manager.ui.mainCamera.transform.position - var_517_12.position).z)
				var_517_12.localEulerAngles.z = 0
				var_517_12.localEulerAngles.x = 0
				var_517_12.localEulerAngles = var_517_12.localEulerAngles
			end

			local var_517_14 = arg_514_1.actors_["1084ui_story"]

			if 1.96599999815226 < arg_514_1.time_ and arg_514_1.time_ <= 1.96599999815226 + arg_517_0 and not isNil(var_517_14) and arg_514_1.var_.characterEffect1084ui_story == nil then
				arg_514_1.var_.characterEffect1084ui_story = var_517_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_15 = 0.034000001847744

			if 1.96599999815226 <= arg_514_1.time_ and arg_514_1.time_ < 1.96599999815226 + var_517_15 and not isNil(var_517_14) then
				if arg_514_1.var_.characterEffect1084ui_story and not isNil(var_517_14) then
					arg_514_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_514_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_514_1.time_ - 1.96599999815226) / var_517_15)
				end
			end

			if arg_514_1.time_ >= 1.96599999815226 + var_517_15 and arg_514_1.time_ < 1.96599999815226 + var_517_15 + arg_517_0 and not isNil(var_517_14) and arg_514_1.var_.characterEffect1084ui_story then
				arg_514_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_514_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_517_16 = "1029ui_story"

			if arg_514_1.actors_["1029ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1029ui_story"))) then
				local var_517_17 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_514_1.stage_.transform)

				var_517_17.name = var_517_16
				var_517_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_514_1.actors_[var_517_16] = var_517_17

				local var_517_18 = var_517_17:GetComponentInChildren(typeof(CharacterEffect))

				var_517_18.enabled = true

				local var_517_19 = GameObjectTools.GetOrAddComponent(var_517_17, typeof(DynamicBoneHelper))

				if var_517_19 then
					var_517_19:EnableDynamicBone(false)
				end

				arg_514_1:ShowWeapon(var_517_18.transform, false)

				arg_514_1.var_[var_517_16 .. "Animator"] = var_517_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_514_1.var_[var_517_16 .. "Animator"].applyRootMotion = true
				arg_514_1.var_[var_517_16 .. "LipSync"] = var_517_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_517_20 = arg_514_1.actors_["1029ui_story"].transform

			if 3.8 < arg_514_1.time_ and arg_514_1.time_ <= 3.8 + arg_517_0 then
				arg_514_1.var_.moveOldPos1029ui_story = var_517_20.localPosition
			end

			local var_517_21 = 0.001

			if 3.8 <= arg_514_1.time_ and arg_514_1.time_ < 3.8 + var_517_21 then
				var_517_20.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_514_1.time_ - 3.8) / var_517_21)
				var_517_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_517_20.position).x, (manager.ui.mainCamera.transform.position - var_517_20.position).y, (manager.ui.mainCamera.transform.position - var_517_20.position).z)
				var_517_20.localEulerAngles.z = 0
				var_517_20.localEulerAngles.x = 0
				var_517_20.localEulerAngles = var_517_20.localEulerAngles
			end

			if arg_514_1.time_ >= 3.8 + var_517_21 and arg_514_1.time_ < 3.8 + var_517_21 + arg_517_0 then
				var_517_20.localPosition = Vector3.New(0, -1.09, -6.2)
				var_517_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_517_20.position).x, (manager.ui.mainCamera.transform.position - var_517_20.position).y, (manager.ui.mainCamera.transform.position - var_517_20.position).z)
				var_517_20.localEulerAngles.z = 0
				var_517_20.localEulerAngles.x = 0
				var_517_20.localEulerAngles = var_517_20.localEulerAngles
			end

			local var_517_22 = arg_514_1.actors_["1029ui_story"]

			if 3.8 < arg_514_1.time_ and arg_514_1.time_ <= 3.8 + arg_517_0 and not isNil(var_517_22) and arg_514_1.var_.characterEffect1029ui_story == nil then
				arg_514_1.var_.characterEffect1029ui_story = var_517_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_23 = 0.200000002980232

			if 3.8 <= arg_514_1.time_ and arg_514_1.time_ < 3.8 + var_517_23 and not isNil(var_517_22) then
				if arg_514_1.var_.characterEffect1029ui_story and not isNil(var_517_22) then
					arg_514_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_514_1.time_ >= 3.8 + var_517_23 and arg_514_1.time_ < 3.8 + var_517_23 + arg_517_0 and not isNil(var_517_22) and arg_514_1.var_.characterEffect1029ui_story then
				arg_514_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 3.8 < arg_514_1.time_ and arg_514_1.time_ <= 3.8 + arg_517_0 then
				arg_514_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 3.8 < arg_514_1.time_ and arg_514_1.time_ <= 3.8 + arg_517_0 then
				arg_514_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if 3.8 < arg_514_1.time_ and arg_514_1.time_ <= 3.8 + arg_517_0 then
				if arg_514_1.var_.characterEffect1029ui_story == nil then
					arg_514_1.var_.characterEffect1029ui_story = arg_514_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_517_25 = arg_514_1.var_.characterEffect1029ui_story

				arg_514_1.var_.characterEffect1029ui_story.imageEffect:turnOff()

				var_517_25.interferenceEffect.enabled = true
				var_517_25.interferenceEffect.noise = 0.001
				var_517_25.interferenceEffect.simTimeScale = 1
				var_517_25.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 3.8 < arg_514_1.time_ and arg_514_1.time_ <= 3.8 + arg_517_0 then
				if arg_514_1.var_.characterEffect1029ui_story == nil then
					arg_514_1.var_.characterEffect1029ui_story = arg_514_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_514_1.var_.characterEffect1029ui_story.imageEffect:turnOn(false)
			end

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_harbor_loop", "")
			end

			if arg_514_1.frameCnt_ <= 1 then
				arg_514_1.dialog_:SetActive(false)
			end

			local var_517_28 = 4
			local var_517_29 = 0.05

			if 4 < arg_514_1.time_ and arg_514_1.time_ <= var_517_28 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0

				arg_514_1.dialog_:SetActive(true)

				arg_514_1.dialogCg_.alpha = 0

				local var_517_30 = LeanTween.value(arg_514_1.dialog_, 0, 1, 0.3)

				var_517_30:setOnUpdate(LuaHelper.FloatAction(function(arg_518_0)
					arg_514_1.dialogCg_.alpha = arg_518_0
				end))
				var_517_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_514_1.dialog_)
					var_517_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_514_1.duration_ = arg_514_1.duration_ + 0.3

				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_31 = arg_514_1:GetWordFromCfg(121471126)
				local var_517_32 = arg_514_1:FormatText(var_517_31.content)

				arg_514_1.text_.text = var_517_32

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_34 = 2 <= 0 and var_517_29 or var_517_29 * (utf8.len(var_517_32) / 2)

				if (2 <= 0 and var_517_29 or var_517_29 * (utf8.len(var_517_32) / 2)) > 0 and var_517_29 < var_517_34 then
					arg_514_1.talkMaxDuration = var_517_34
					var_517_28 = var_517_28 + 0.3

					if var_517_34 + var_517_28 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_34 + var_517_28
					end
				end

				arg_514_1.text_.text = var_517_32
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471126", "story_v_out_121471.awb") ~= 0 then
					local var_517_35 = manager.audio:GetVoiceLength("story_v_out_121471", "121471126", "story_v_out_121471.awb") / 1000

					if var_517_35 + var_517_28 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_35 + var_517_28
					end

					if var_517_31.prefab_name ~= "" and arg_514_1.actors_[var_517_31.prefab_name] ~= nil then
						local var_517_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_31.prefab_name].transform, "story_v_out_121471", "121471126", "story_v_out_121471.awb")

						arg_514_1:RecordAudio("121471126", var_517_36)
						arg_514_1:RecordAudio("121471126", var_517_36)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_121471", "121471126", "story_v_out_121471.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_121471", "121471126", "story_v_out_121471.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_37 = var_517_28 + 0.3
			local var_517_38 = math.max(var_517_29, arg_514_1.talkMaxDuration)

			if var_517_28 + 0.3 <= arg_514_1.time_ and arg_514_1.time_ < var_517_37 + var_517_38 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_37) / var_517_38

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_37 + var_517_38 and arg_514_1.time_ < var_517_37 + var_517_38 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_514_1:InitPlayNodeList()
	end,
	Play121471127 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 121471127
		arg_520_1.duration_ = 3.1

		local var_520_0 = {
			ja = 2.266,
			ko = 3.1,
			zh = 3.1
		}
		local var_520_1 = manager.audio:GetLocalizationFlag()

		if var_520_0[var_520_1] ~= nil then
			arg_520_1.duration_ = var_520_0[var_520_1]
		end

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play121471128(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = 0.25

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				arg_520_1.leftNameTxt_.text = arg_520_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_1 = arg_520_1:GetWordFromCfg(121471127)
				local var_523_2 = arg_520_1:FormatText(var_523_1.content)

				arg_520_1.text_.text = var_523_2

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_4 = 10 <= 0 and var_523_0 or var_523_0 * (utf8.len(var_523_2) / 10)

				if (10 <= 0 and var_523_0 or var_523_0 * (utf8.len(var_523_2) / 10)) > 0 and var_523_0 < var_523_4 then
					arg_520_1.talkMaxDuration = var_523_4

					if var_523_4 + 0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_4 + 0
					end
				end

				arg_520_1.text_.text = var_523_2
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471127", "story_v_out_121471.awb") ~= 0 then
					local var_523_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471127", "story_v_out_121471.awb") / 1000

					if var_523_5 + 0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_5 + 0
					end

					if var_523_1.prefab_name ~= "" and arg_520_1.actors_[var_523_1.prefab_name] ~= nil then
						local var_523_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_1.prefab_name].transform, "story_v_out_121471", "121471127", "story_v_out_121471.awb")

						arg_520_1:RecordAudio("121471127", var_523_6)
						arg_520_1:RecordAudio("121471127", var_523_6)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_out_121471", "121471127", "story_v_out_121471.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_out_121471", "121471127", "story_v_out_121471.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_7 = math.max(var_523_0, arg_520_1.talkMaxDuration)

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_7 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - 0) / var_523_7

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= 0 + var_523_7 and arg_520_1.time_ < 0 + var_523_7 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play121471128 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 121471128
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play121471129(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1.var_.moveOldPos1029ui_story = arg_524_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_527_0 = 0.001

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_0 then
				arg_524_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_524_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_524_1.time_ - 0) / var_527_0)
				arg_524_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_524_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["1029ui_story"].transform.position).z)
				arg_524_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_524_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_524_1.actors_["1029ui_story"].transform.localEulerAngles = arg_524_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_524_1.time_ >= 0 + var_527_0 and arg_524_1.time_ < 0 + var_527_0 + arg_527_0 then
				arg_524_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_524_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_524_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["1029ui_story"].transform.position).z)
				arg_524_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_524_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_524_1.actors_["1029ui_story"].transform.localEulerAngles = arg_524_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_527_1 = arg_524_1.actors_["1029ui_story"]

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 and not isNil(var_527_1) and arg_524_1.var_.characterEffect1029ui_story == nil then
				arg_524_1.var_.characterEffect1029ui_story = var_527_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_2 = 0.200000002980232

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_2 and not isNil(var_527_1) then
				if arg_524_1.var_.characterEffect1029ui_story and not isNil(var_527_1) then
					arg_524_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_524_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_524_1.time_ - 0) / var_527_2)
				end
			end

			if arg_524_1.time_ >= 0 + var_527_2 and arg_524_1.time_ < 0 + var_527_2 + arg_527_0 and not isNil(var_527_1) and arg_524_1.var_.characterEffect1029ui_story then
				arg_524_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_524_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_527_3 = 0
			local var_527_4 = 1.4

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_3 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, false)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_5 = arg_524_1:FormatText(arg_524_1:GetWordFromCfg(121471128).content)

				arg_524_1.text_.text = var_527_5

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_7 = 56 <= 0 and var_527_4 or var_527_4 * (utf8.len(var_527_5) / 56)

				if (56 <= 0 and var_527_4 or var_527_4 * (utf8.len(var_527_5) / 56)) > 0 and var_527_4 < var_527_7 then
					arg_524_1.talkMaxDuration = var_527_7

					if var_527_7 + var_527_3 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_7 + var_527_3
					end
				end

				arg_524_1.text_.text = var_527_5
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_8 = math.max(var_527_4, arg_524_1.talkMaxDuration)

			if var_527_3 <= arg_524_1.time_ and arg_524_1.time_ < var_527_3 + var_527_8 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_3) / var_527_8

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_3 + var_527_8 and arg_524_1.time_ < var_527_3 + var_527_8 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_524_1:InitPlayNodeList()
	end,
	Play121471129 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 121471129
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play121471130(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 1.275

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, false)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_1 = arg_528_1:FormatText(arg_528_1:GetWordFromCfg(121471129).content)

				arg_528_1.text_.text = var_531_1

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_3 = 51 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_1) / 51)

				if (51 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_1) / 51)) > 0 and var_531_0 < var_531_3 then
					arg_528_1.talkMaxDuration = var_531_3

					if var_531_3 + 0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_3 + 0
					end
				end

				arg_528_1.text_.text = var_531_1
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_4 = math.max(var_531_0, arg_528_1.talkMaxDuration)

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_4 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - 0) / var_531_4

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= 0 + var_531_4 and arg_528_1.time_ < 0 + var_531_4 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play121471130 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 121471130
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play121471131(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 1.075

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, false)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_1 = arg_532_1:FormatText(arg_532_1:GetWordFromCfg(121471130).content)

				arg_532_1.text_.text = var_535_1

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_3 = 43 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_1) / 43)

				if (43 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_1) / 43)) > 0 and var_535_0 < var_535_3 then
					arg_532_1.talkMaxDuration = var_535_3

					if var_535_3 + 0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_3 + 0
					end
				end

				arg_532_1.text_.text = var_535_1
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_4 = math.max(var_535_0, arg_532_1.talkMaxDuration)

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_4 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - 0) / var_535_4

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= 0 + var_535_4 and arg_532_1.time_ < 0 + var_535_4 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play121471131 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 121471131
		arg_536_1.duration_ = 7

		local var_536_0 = {
			ja = 7,
			ko = 5.2,
			zh = 5.2
		}
		local var_536_1 = manager.audio:GetLocalizationFlag()

		if var_536_0[var_536_1] ~= nil then
			arg_536_1.duration_ = var_536_0[var_536_1]
		end

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play121471132(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1.var_.moveOldPos1029ui_story = arg_536_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_539_0 = 0.001

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_0 then
				arg_536_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_536_1.var_.moveOldPos1029ui_story, Vector3.New(-0.7, -1.09, -6.2), (arg_536_1.time_ - 0) / var_539_0)
				arg_536_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_536_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["1029ui_story"].transform.position).z)
				arg_536_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_536_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_536_1.actors_["1029ui_story"].transform.localEulerAngles = arg_536_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_536_1.time_ >= 0 + var_539_0 and arg_536_1.time_ < 0 + var_539_0 + arg_539_0 then
				arg_536_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(-0.7, -1.09, -6.2)
				arg_536_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_536_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["1029ui_story"].transform.position).z)
				arg_536_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_536_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_536_1.actors_["1029ui_story"].transform.localEulerAngles = arg_536_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_539_1 = arg_536_1.actors_["1029ui_story"]

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 and not isNil(var_539_1) and arg_536_1.var_.characterEffect1029ui_story == nil then
				arg_536_1.var_.characterEffect1029ui_story = var_539_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_2 = 0.200000002980232

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_2 and not isNil(var_539_1) then
				if arg_536_1.var_.characterEffect1029ui_story and not isNil(var_539_1) then
					arg_536_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_536_1.time_ >= 0 + var_539_2 and arg_536_1.time_ < 0 + var_539_2 + arg_539_0 and not isNil(var_539_1) and arg_536_1.var_.characterEffect1029ui_story then
				arg_536_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_539_4 = arg_536_1.actors_["1084ui_story"].transform

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1.var_.moveOldPos1084ui_story = var_539_4.localPosition
			end

			local var_539_5 = 0.001

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_5 then
				var_539_4.localPosition = Vector3.Lerp(arg_536_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_536_1.time_ - 0) / var_539_5)
				var_539_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_539_4.position).x, (manager.ui.mainCamera.transform.position - var_539_4.position).y, (manager.ui.mainCamera.transform.position - var_539_4.position).z)
				var_539_4.localEulerAngles.z = 0
				var_539_4.localEulerAngles.x = 0
				var_539_4.localEulerAngles = var_539_4.localEulerAngles
			end

			if arg_536_1.time_ >= 0 + var_539_5 and arg_536_1.time_ < 0 + var_539_5 + arg_539_0 then
				var_539_4.localPosition = Vector3.New(0.7, -0.97, -6)
				var_539_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_539_4.position).x, (manager.ui.mainCamera.transform.position - var_539_4.position).y, (manager.ui.mainCamera.transform.position - var_539_4.position).z)
				var_539_4.localEulerAngles.z = 0
				var_539_4.localEulerAngles.x = 0
				var_539_4.localEulerAngles = var_539_4.localEulerAngles
			end

			local var_539_6 = arg_536_1.actors_["1084ui_story"]

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 and not isNil(var_539_6) and arg_536_1.var_.characterEffect1084ui_story == nil then
				arg_536_1.var_.characterEffect1084ui_story = var_539_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_7 = 0.200000002980232

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_7 and not isNil(var_539_6) then
				if arg_536_1.var_.characterEffect1084ui_story and not isNil(var_539_6) then
					arg_536_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_536_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_536_1.time_ - 0) / var_539_7)
				end
			end

			if arg_536_1.time_ >= 0 + var_539_7 and arg_536_1.time_ < 0 + var_539_7 + arg_539_0 and not isNil(var_539_6) and arg_536_1.var_.characterEffect1084ui_story then
				arg_536_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_536_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_539_8 = 0
			local var_539_9 = 0.725

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_8 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				arg_536_1.leftNameTxt_.text = arg_536_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_10 = arg_536_1:GetWordFromCfg(121471131)
				local var_539_11 = arg_536_1:FormatText(var_539_10.content)

				arg_536_1.text_.text = var_539_11

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_13 = 29 <= 0 and var_539_9 or var_539_9 * (utf8.len(var_539_11) / 29)

				if (29 <= 0 and var_539_9 or var_539_9 * (utf8.len(var_539_11) / 29)) > 0 and var_539_9 < var_539_13 then
					arg_536_1.talkMaxDuration = var_539_13

					if var_539_13 + var_539_8 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_13 + var_539_8
					end
				end

				arg_536_1.text_.text = var_539_11
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471131", "story_v_out_121471.awb") ~= 0 then
					local var_539_14 = manager.audio:GetVoiceLength("story_v_out_121471", "121471131", "story_v_out_121471.awb") / 1000

					if var_539_14 + var_539_8 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_14 + var_539_8
					end

					if var_539_10.prefab_name ~= "" and arg_536_1.actors_[var_539_10.prefab_name] ~= nil then
						local var_539_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_10.prefab_name].transform, "story_v_out_121471", "121471131", "story_v_out_121471.awb")

						arg_536_1:RecordAudio("121471131", var_539_15)
						arg_536_1:RecordAudio("121471131", var_539_15)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_out_121471", "121471131", "story_v_out_121471.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_out_121471", "121471131", "story_v_out_121471.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_16 = math.max(var_539_9, arg_536_1.talkMaxDuration)

			if var_539_8 <= arg_536_1.time_ and arg_536_1.time_ < var_539_8 + var_539_16 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_8) / var_539_16

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_8 + var_539_16 and arg_536_1.time_ < var_539_8 + var_539_16 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_536_1:InitPlayNodeList()
	end,
	Play121471132 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 121471132
		arg_540_1.duration_ = 5.4

		local var_540_0 = {
			ja = 5.4,
			ko = 5.2,
			zh = 5.2
		}
		local var_540_1 = manager.audio:GetLocalizationFlag()

		if var_540_0[var_540_1] ~= nil then
			arg_540_1.duration_ = var_540_0[var_540_1]
		end

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play121471133(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = 0.65

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				arg_540_1.leftNameTxt_.text = arg_540_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_1 = arg_540_1:GetWordFromCfg(121471132)
				local var_543_2 = arg_540_1:FormatText(var_543_1.content)

				arg_540_1.text_.text = var_543_2

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_4 = 26 <= 0 and var_543_0 or var_543_0 * (utf8.len(var_543_2) / 26)

				if (26 <= 0 and var_543_0 or var_543_0 * (utf8.len(var_543_2) / 26)) > 0 and var_543_0 < var_543_4 then
					arg_540_1.talkMaxDuration = var_543_4

					if var_543_4 + 0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_4 + 0
					end
				end

				arg_540_1.text_.text = var_543_2
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471132", "story_v_out_121471.awb") ~= 0 then
					local var_543_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471132", "story_v_out_121471.awb") / 1000

					if var_543_5 + 0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_5 + 0
					end

					if var_543_1.prefab_name ~= "" and arg_540_1.actors_[var_543_1.prefab_name] ~= nil then
						local var_543_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_540_1.actors_[var_543_1.prefab_name].transform, "story_v_out_121471", "121471132", "story_v_out_121471.awb")

						arg_540_1:RecordAudio("121471132", var_543_6)
						arg_540_1:RecordAudio("121471132", var_543_6)
					else
						arg_540_1:AudioAction("play", "voice", "story_v_out_121471", "121471132", "story_v_out_121471.awb")
					end

					arg_540_1:RecordHistoryTalkVoice("story_v_out_121471", "121471132", "story_v_out_121471.awb")
				end

				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_7 = math.max(var_543_0, arg_540_1.talkMaxDuration)

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_7 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - 0) / var_543_7

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= 0 + var_543_7 and arg_540_1.time_ < 0 + var_543_7 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play121471133 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 121471133
		arg_544_1.duration_ = 2.1

		local var_544_0 = {
			ja = 1.999999999999,
			ko = 2.1,
			zh = 2.1
		}
		local var_544_1 = manager.audio:GetLocalizationFlag()

		if var_544_0[var_544_1] ~= nil then
			arg_544_1.duration_ = var_544_0[var_544_1]
		end

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play121471134(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 and not isNil(arg_544_1.actors_["1084ui_story"]) and arg_544_1.var_.characterEffect1084ui_story == nil then
				arg_544_1.var_.characterEffect1084ui_story = arg_544_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_547_0 = 0.200000002980232

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_0 and not isNil(arg_544_1.actors_["1084ui_story"]) then
				if arg_544_1.var_.characterEffect1084ui_story and not isNil(arg_544_1.actors_["1084ui_story"]) then
					arg_544_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_544_1.time_ >= 0 + var_547_0 and arg_544_1.time_ < 0 + var_547_0 + arg_547_0 and not isNil(arg_544_1.actors_["1084ui_story"]) and arg_544_1.var_.characterEffect1084ui_story then
				arg_544_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_547_2 = arg_544_1.actors_["1029ui_story"]

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 and not isNil(var_547_2) and arg_544_1.var_.characterEffect1029ui_story == nil then
				arg_544_1.var_.characterEffect1029ui_story = var_547_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_547_3 = 0.200000002980232

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_3 and not isNil(var_547_2) then
				if arg_544_1.var_.characterEffect1029ui_story and not isNil(var_547_2) then
					arg_544_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_544_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_544_1.time_ - 0) / var_547_3)
				end
			end

			if arg_544_1.time_ >= 0 + var_547_3 and arg_544_1.time_ < 0 + var_547_3 + arg_547_0 and not isNil(var_547_2) and arg_544_1.var_.characterEffect1029ui_story then
				arg_544_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_544_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_547_4 = 0
			local var_547_5 = 0.05

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_4 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				arg_544_1.leftNameTxt_.text = arg_544_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_6 = arg_544_1:GetWordFromCfg(121471133)
				local var_547_7 = arg_544_1:FormatText(var_547_6.content)

				arg_544_1.text_.text = var_547_7

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_9 = 2 <= 0 and var_547_5 or var_547_5 * (utf8.len(var_547_7) / 2)

				if (2 <= 0 and var_547_5 or var_547_5 * (utf8.len(var_547_7) / 2)) > 0 and var_547_5 < var_547_9 then
					arg_544_1.talkMaxDuration = var_547_9

					if var_547_9 + var_547_4 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_9 + var_547_4
					end
				end

				arg_544_1.text_.text = var_547_7
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471133", "story_v_out_121471.awb") ~= 0 then
					local var_547_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471133", "story_v_out_121471.awb") / 1000

					if var_547_10 + var_547_4 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_10 + var_547_4
					end

					if var_547_6.prefab_name ~= "" and arg_544_1.actors_[var_547_6.prefab_name] ~= nil then
						local var_547_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_6.prefab_name].transform, "story_v_out_121471", "121471133", "story_v_out_121471.awb")

						arg_544_1:RecordAudio("121471133", var_547_11)
						arg_544_1:RecordAudio("121471133", var_547_11)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_out_121471", "121471133", "story_v_out_121471.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_out_121471", "121471133", "story_v_out_121471.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_12 = math.max(var_547_5, arg_544_1.talkMaxDuration)

			if var_547_4 <= arg_544_1.time_ and arg_544_1.time_ < var_547_4 + var_547_12 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_4) / var_547_12

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_4 + var_547_12 and arg_544_1.time_ < var_547_4 + var_547_12 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play121471134 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 121471134
		arg_548_1.duration_ = 8.17

		local var_548_0 = {
			ja = 8.166,
			ko = 6.5,
			zh = 6.5
		}
		local var_548_1 = manager.audio:GetLocalizationFlag()

		if var_548_0[var_548_1] ~= nil then
			arg_548_1.duration_ = var_548_0[var_548_1]
		end

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play121471135(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 and not isNil(arg_548_1.actors_["1084ui_story"]) and arg_548_1.var_.characterEffect1084ui_story == nil then
				arg_548_1.var_.characterEffect1084ui_story = arg_548_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_551_0 = 0.200000002980232

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_0 and not isNil(arg_548_1.actors_["1084ui_story"]) then
				if arg_548_1.var_.characterEffect1084ui_story and not isNil(arg_548_1.actors_["1084ui_story"]) then
					arg_548_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_548_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_548_1.time_ - 0) / var_551_0)
				end
			end

			if arg_548_1.time_ >= 0 + var_551_0 and arg_548_1.time_ < 0 + var_551_0 + arg_551_0 and not isNil(arg_548_1.actors_["1084ui_story"]) and arg_548_1.var_.characterEffect1084ui_story then
				arg_548_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_548_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_551_1 = arg_548_1.actors_["1029ui_story"]

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 and not isNil(var_551_1) and arg_548_1.var_.characterEffect1029ui_story == nil then
				arg_548_1.var_.characterEffect1029ui_story = var_551_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_551_2 = 0.200000002980232

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_2 and not isNil(var_551_1) then
				if arg_548_1.var_.characterEffect1029ui_story and not isNil(var_551_1) then
					arg_548_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_548_1.time_ >= 0 + var_551_2 and arg_548_1.time_ < 0 + var_551_2 + arg_551_0 and not isNil(var_551_1) and arg_548_1.var_.characterEffect1029ui_story then
				arg_548_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_551_4 = 0
			local var_551_5 = 0.775

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_4 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				arg_548_1.leftNameTxt_.text = arg_548_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_6 = arg_548_1:GetWordFromCfg(121471134)
				local var_551_7 = arg_548_1:FormatText(var_551_6.content)

				arg_548_1.text_.text = var_551_7

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_9 = 31 <= 0 and var_551_5 or var_551_5 * (utf8.len(var_551_7) / 31)

				if (31 <= 0 and var_551_5 or var_551_5 * (utf8.len(var_551_7) / 31)) > 0 and var_551_5 < var_551_9 then
					arg_548_1.talkMaxDuration = var_551_9

					if var_551_9 + var_551_4 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_9 + var_551_4
					end
				end

				arg_548_1.text_.text = var_551_7
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471134", "story_v_out_121471.awb") ~= 0 then
					local var_551_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471134", "story_v_out_121471.awb") / 1000

					if var_551_10 + var_551_4 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_10 + var_551_4
					end

					if var_551_6.prefab_name ~= "" and arg_548_1.actors_[var_551_6.prefab_name] ~= nil then
						local var_551_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_548_1.actors_[var_551_6.prefab_name].transform, "story_v_out_121471", "121471134", "story_v_out_121471.awb")

						arg_548_1:RecordAudio("121471134", var_551_11)
						arg_548_1:RecordAudio("121471134", var_551_11)
					else
						arg_548_1:AudioAction("play", "voice", "story_v_out_121471", "121471134", "story_v_out_121471.awb")
					end

					arg_548_1:RecordHistoryTalkVoice("story_v_out_121471", "121471134", "story_v_out_121471.awb")
				end

				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_12 = math.max(var_551_5, arg_548_1.talkMaxDuration)

			if var_551_4 <= arg_548_1.time_ and arg_548_1.time_ < var_551_4 + var_551_12 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_4) / var_551_12

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_4 + var_551_12 and arg_548_1.time_ < var_551_4 + var_551_12 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play121471135 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 121471135
		arg_552_1.duration_ = 3.5

		local var_552_0 = {
			ja = 3.5,
			ko = 3.333,
			zh = 3.333
		}
		local var_552_1 = manager.audio:GetLocalizationFlag()

		if var_552_0[var_552_1] ~= nil then
			arg_552_1.duration_ = var_552_0[var_552_1]
		end

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play121471136(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 0.375

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				arg_552_1.leftNameTxt_.text = arg_552_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, false)
				arg_552_1.callingController_:SetSelectedState("normal")

				local var_555_1 = arg_552_1:GetWordFromCfg(121471135)
				local var_555_2 = arg_552_1:FormatText(var_555_1.content)

				arg_552_1.text_.text = var_555_2

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_4 = 15 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_2) / 15)

				if (15 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_2) / 15)) > 0 and var_555_0 < var_555_4 then
					arg_552_1.talkMaxDuration = var_555_4

					if var_555_4 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_4 + 0
					end
				end

				arg_552_1.text_.text = var_555_2
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471135", "story_v_out_121471.awb") ~= 0 then
					local var_555_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471135", "story_v_out_121471.awb") / 1000

					if var_555_5 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_5 + 0
					end

					if var_555_1.prefab_name ~= "" and arg_552_1.actors_[var_555_1.prefab_name] ~= nil then
						local var_555_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_552_1.actors_[var_555_1.prefab_name].transform, "story_v_out_121471", "121471135", "story_v_out_121471.awb")

						arg_552_1:RecordAudio("121471135", var_555_6)
						arg_552_1:RecordAudio("121471135", var_555_6)
					else
						arg_552_1:AudioAction("play", "voice", "story_v_out_121471", "121471135", "story_v_out_121471.awb")
					end

					arg_552_1:RecordHistoryTalkVoice("story_v_out_121471", "121471135", "story_v_out_121471.awb")
				end

				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_7 = math.max(var_555_0, arg_552_1.talkMaxDuration)

			if 0 <= arg_552_1.time_ and arg_552_1.time_ < 0 + var_555_7 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - 0) / var_555_7

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= 0 + var_555_7 and arg_552_1.time_ < 0 + var_555_7 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play121471136 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 121471136
		arg_556_1.duration_ = 5.87

		local var_556_0 = {
			ja = 5.866,
			ko = 5.433,
			zh = 5.433
		}
		local var_556_1 = manager.audio:GetLocalizationFlag()

		if var_556_0[var_556_1] ~= nil then
			arg_556_1.duration_ = var_556_0[var_556_1]
		end

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play121471137(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 and not isNil(arg_556_1.actors_["1084ui_story"]) and arg_556_1.var_.characterEffect1084ui_story == nil then
				arg_556_1.var_.characterEffect1084ui_story = arg_556_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_559_0 = 0.200000002980232

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_0 and not isNil(arg_556_1.actors_["1084ui_story"]) then
				if arg_556_1.var_.characterEffect1084ui_story and not isNil(arg_556_1.actors_["1084ui_story"]) then
					arg_556_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_556_1.time_ >= 0 + var_559_0 and arg_556_1.time_ < 0 + var_559_0 + arg_559_0 and not isNil(arg_556_1.actors_["1084ui_story"]) and arg_556_1.var_.characterEffect1084ui_story then
				arg_556_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_559_2 = arg_556_1.actors_["1029ui_story"]

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 and not isNil(var_559_2) and arg_556_1.var_.characterEffect1029ui_story == nil then
				arg_556_1.var_.characterEffect1029ui_story = var_559_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_559_3 = 0.200000002980232

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_3 and not isNil(var_559_2) then
				if arg_556_1.var_.characterEffect1029ui_story and not isNil(var_559_2) then
					arg_556_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_556_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_556_1.time_ - 0) / var_559_3)
				end
			end

			if arg_556_1.time_ >= 0 + var_559_3 and arg_556_1.time_ < 0 + var_559_3 + arg_559_0 and not isNil(var_559_2) and arg_556_1.var_.characterEffect1029ui_story then
				arg_556_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_556_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_559_4 = 0
			local var_559_5 = 0.575

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= var_559_4 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				arg_556_1.leftNameTxt_.text = arg_556_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_6 = arg_556_1:GetWordFromCfg(121471136)
				local var_559_7 = arg_556_1:FormatText(var_559_6.content)

				arg_556_1.text_.text = var_559_7

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_9 = 23 <= 0 and var_559_5 or var_559_5 * (utf8.len(var_559_7) / 23)

				if (23 <= 0 and var_559_5 or var_559_5 * (utf8.len(var_559_7) / 23)) > 0 and var_559_5 < var_559_9 then
					arg_556_1.talkMaxDuration = var_559_9

					if var_559_9 + var_559_4 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_9 + var_559_4
					end
				end

				arg_556_1.text_.text = var_559_7
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471136", "story_v_out_121471.awb") ~= 0 then
					local var_559_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471136", "story_v_out_121471.awb") / 1000

					if var_559_10 + var_559_4 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_10 + var_559_4
					end

					if var_559_6.prefab_name ~= "" and arg_556_1.actors_[var_559_6.prefab_name] ~= nil then
						local var_559_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_556_1.actors_[var_559_6.prefab_name].transform, "story_v_out_121471", "121471136", "story_v_out_121471.awb")

						arg_556_1:RecordAudio("121471136", var_559_11)
						arg_556_1:RecordAudio("121471136", var_559_11)
					else
						arg_556_1:AudioAction("play", "voice", "story_v_out_121471", "121471136", "story_v_out_121471.awb")
					end

					arg_556_1:RecordHistoryTalkVoice("story_v_out_121471", "121471136", "story_v_out_121471.awb")
				end

				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_12 = math.max(var_559_5, arg_556_1.talkMaxDuration)

			if var_559_4 <= arg_556_1.time_ and arg_556_1.time_ < var_559_4 + var_559_12 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_4) / var_559_12

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_4 + var_559_12 and arg_556_1.time_ < var_559_4 + var_559_12 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play121471137 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 121471137
		arg_560_1.duration_ = 2.63

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play121471138(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 and not isNil(arg_560_1.actors_["1084ui_story"]) and arg_560_1.var_.characterEffect1084ui_story == nil then
				arg_560_1.var_.characterEffect1084ui_story = arg_560_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_563_0 = 0.200000002980232

			if 0 <= arg_560_1.time_ and arg_560_1.time_ < 0 + var_563_0 and not isNil(arg_560_1.actors_["1084ui_story"]) then
				if arg_560_1.var_.characterEffect1084ui_story and not isNil(arg_560_1.actors_["1084ui_story"]) then
					arg_560_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_560_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_560_1.time_ - 0) / var_563_0)
				end
			end

			if arg_560_1.time_ >= 0 + var_563_0 and arg_560_1.time_ < 0 + var_563_0 + arg_563_0 and not isNil(arg_560_1.actors_["1084ui_story"]) and arg_560_1.var_.characterEffect1084ui_story then
				arg_560_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_560_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 then
				arg_560_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action5_1")
			end

			local var_563_1 = arg_560_1.actors_["1029ui_story"]

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 and not isNil(var_563_1) and arg_560_1.var_.characterEffect1029ui_story == nil then
				arg_560_1.var_.characterEffect1029ui_story = var_563_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_563_2 = 0.200000002980232

			if 0 <= arg_560_1.time_ and arg_560_1.time_ < 0 + var_563_2 and not isNil(var_563_1) then
				if arg_560_1.var_.characterEffect1029ui_story and not isNil(var_563_1) then
					arg_560_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_560_1.time_ >= 0 + var_563_2 and arg_560_1.time_ < 0 + var_563_2 + arg_563_0 and not isNil(var_563_1) and arg_560_1.var_.characterEffect1029ui_story then
				arg_560_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 then
				arg_560_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_563_4 = 0
			local var_563_5 = 0.225

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= var_563_4 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				arg_560_1.leftNameTxt_.text = arg_560_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, false)
				arg_560_1.callingController_:SetSelectedState("normal")

				local var_563_6 = arg_560_1:GetWordFromCfg(121471137)
				local var_563_7 = arg_560_1:FormatText(var_563_6.content)

				arg_560_1.text_.text = var_563_7

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_9 = 9 <= 0 and var_563_5 or var_563_5 * (utf8.len(var_563_7) / 9)

				if (9 <= 0 and var_563_5 or var_563_5 * (utf8.len(var_563_7) / 9)) > 0 and var_563_5 < var_563_9 then
					arg_560_1.talkMaxDuration = var_563_9

					if var_563_9 + var_563_4 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_9 + var_563_4
					end
				end

				arg_560_1.text_.text = var_563_7
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471137", "story_v_out_121471.awb") ~= 0 then
					local var_563_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471137", "story_v_out_121471.awb") / 1000

					if var_563_10 + var_563_4 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_10 + var_563_4
					end

					if var_563_6.prefab_name ~= "" and arg_560_1.actors_[var_563_6.prefab_name] ~= nil then
						local var_563_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_560_1.actors_[var_563_6.prefab_name].transform, "story_v_out_121471", "121471137", "story_v_out_121471.awb")

						arg_560_1:RecordAudio("121471137", var_563_11)
						arg_560_1:RecordAudio("121471137", var_563_11)
					else
						arg_560_1:AudioAction("play", "voice", "story_v_out_121471", "121471137", "story_v_out_121471.awb")
					end

					arg_560_1:RecordHistoryTalkVoice("story_v_out_121471", "121471137", "story_v_out_121471.awb")
				end

				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_12 = math.max(var_563_5, arg_560_1.talkMaxDuration)

			if var_563_4 <= arg_560_1.time_ and arg_560_1.time_ < var_563_4 + var_563_12 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_4) / var_563_12

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_4 + var_563_12 and arg_560_1.time_ < var_563_4 + var_563_12 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play121471138 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 121471138
		arg_564_1.duration_ = 5

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play121471139(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 and not isNil(arg_564_1.actors_["1029ui_story"]) and arg_564_1.var_.characterEffect1029ui_story == nil then
				arg_564_1.var_.characterEffect1029ui_story = arg_564_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_567_0 = 0.200000002980232

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_0 and not isNil(arg_564_1.actors_["1029ui_story"]) then
				if arg_564_1.var_.characterEffect1029ui_story and not isNil(arg_564_1.actors_["1029ui_story"]) then
					arg_564_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_564_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_564_1.time_ - 0) / var_567_0)
				end
			end

			if arg_564_1.time_ >= 0 + var_567_0 and arg_564_1.time_ < 0 + var_567_0 + arg_567_0 and not isNil(arg_564_1.actors_["1029ui_story"]) and arg_564_1.var_.characterEffect1029ui_story then
				arg_564_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_564_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_567_1 = 0
			local var_567_2 = 1.15

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= var_567_1 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, false)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_564_1.iconTrs_.gameObject, false)
				arg_564_1.callingController_:SetSelectedState("normal")

				local var_567_3 = arg_564_1:FormatText(arg_564_1:GetWordFromCfg(121471138).content)

				arg_564_1.text_.text = var_567_3

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_5 = 46 <= 0 and var_567_2 or var_567_2 * (utf8.len(var_567_3) / 46)

				if (46 <= 0 and var_567_2 or var_567_2 * (utf8.len(var_567_3) / 46)) > 0 and var_567_2 < var_567_5 then
					arg_564_1.talkMaxDuration = var_567_5

					if var_567_5 + var_567_1 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_5 + var_567_1
					end
				end

				arg_564_1.text_.text = var_567_3
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)
				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_6 = math.max(var_567_2, arg_564_1.talkMaxDuration)

			if var_567_1 <= arg_564_1.time_ and arg_564_1.time_ < var_567_1 + var_567_6 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_1) / var_567_6

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_1 + var_567_6 and arg_564_1.time_ < var_567_1 + var_567_6 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play121471139 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 121471139
		arg_568_1.duration_ = 8.03

		local var_568_0 = {
			ja = 8.033,
			ko = 5.5,
			zh = 5.5
		}
		local var_568_1 = manager.audio:GetLocalizationFlag()

		if var_568_0[var_568_1] ~= nil then
			arg_568_1.duration_ = var_568_0[var_568_1]
		end

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play121471140(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			if 0 < arg_568_1.time_ and arg_568_1.time_ <= 0 + arg_571_0 and not isNil(arg_568_1.actors_["1029ui_story"]) and arg_568_1.var_.characterEffect1029ui_story == nil then
				arg_568_1.var_.characterEffect1029ui_story = arg_568_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_571_0 = 0.200000002980232

			if 0 <= arg_568_1.time_ and arg_568_1.time_ < 0 + var_571_0 and not isNil(arg_568_1.actors_["1029ui_story"]) then
				if arg_568_1.var_.characterEffect1029ui_story and not isNil(arg_568_1.actors_["1029ui_story"]) then
					arg_568_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_568_1.time_ >= 0 + var_571_0 and arg_568_1.time_ < 0 + var_571_0 + arg_571_0 and not isNil(arg_568_1.actors_["1029ui_story"]) and arg_568_1.var_.characterEffect1029ui_story then
				arg_568_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_571_2 = 0
			local var_571_3 = 0.575

			if 0 < arg_568_1.time_ and arg_568_1.time_ <= var_571_2 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, true)

				arg_568_1.leftNameTxt_.text = arg_568_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_568_1.leftNameTxt_.transform)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1.leftNameTxt_.text)
				SetActive(arg_568_1.iconTrs_.gameObject, false)
				arg_568_1.callingController_:SetSelectedState("normal")

				local var_571_4 = arg_568_1:GetWordFromCfg(121471139)
				local var_571_5 = arg_568_1:FormatText(var_571_4.content)

				arg_568_1.text_.text = var_571_5

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_7 = 23 <= 0 and var_571_3 or var_571_3 * (utf8.len(var_571_5) / 23)

				if (23 <= 0 and var_571_3 or var_571_3 * (utf8.len(var_571_5) / 23)) > 0 and var_571_3 < var_571_7 then
					arg_568_1.talkMaxDuration = var_571_7

					if var_571_7 + var_571_2 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_7 + var_571_2
					end
				end

				arg_568_1.text_.text = var_571_5
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471139", "story_v_out_121471.awb") ~= 0 then
					local var_571_8 = manager.audio:GetVoiceLength("story_v_out_121471", "121471139", "story_v_out_121471.awb") / 1000

					if var_571_8 + var_571_2 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_8 + var_571_2
					end

					if var_571_4.prefab_name ~= "" and arg_568_1.actors_[var_571_4.prefab_name] ~= nil then
						local var_571_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_568_1.actors_[var_571_4.prefab_name].transform, "story_v_out_121471", "121471139", "story_v_out_121471.awb")

						arg_568_1:RecordAudio("121471139", var_571_9)
						arg_568_1:RecordAudio("121471139", var_571_9)
					else
						arg_568_1:AudioAction("play", "voice", "story_v_out_121471", "121471139", "story_v_out_121471.awb")
					end

					arg_568_1:RecordHistoryTalkVoice("story_v_out_121471", "121471139", "story_v_out_121471.awb")
				end

				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_10 = math.max(var_571_3, arg_568_1.talkMaxDuration)

			if var_571_2 <= arg_568_1.time_ and arg_568_1.time_ < var_571_2 + var_571_10 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_2) / var_571_10

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_2 + var_571_10 and arg_568_1.time_ < var_571_2 + var_571_10 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {}

		arg_568_1:InitPlayNodeList()
	end,
	Play121471140 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 121471140
		arg_572_1.duration_ = 13.1

		local var_572_0 = {
			ja = 13.1,
			ko = 9.9,
			zh = 9.9
		}
		local var_572_1 = manager.audio:GetLocalizationFlag()

		if var_572_0[var_572_1] ~= nil then
			arg_572_1.duration_ = var_572_0[var_572_1]
		end

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play121471141(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action5_2")
			end

			local var_575_0 = 0
			local var_575_1 = 0.975

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= var_575_0 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				arg_572_1.leftNameTxt_.text = arg_572_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_2 = arg_572_1:GetWordFromCfg(121471140)
				local var_575_3 = arg_572_1:FormatText(var_575_2.content)

				arg_572_1.text_.text = var_575_3

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_5 = 39 <= 0 and var_575_1 or var_575_1 * (utf8.len(var_575_3) / 39)

				if (39 <= 0 and var_575_1 or var_575_1 * (utf8.len(var_575_3) / 39)) > 0 and var_575_1 < var_575_5 then
					arg_572_1.talkMaxDuration = var_575_5

					if var_575_5 + var_575_0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_5 + var_575_0
					end
				end

				arg_572_1.text_.text = var_575_3
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471140", "story_v_out_121471.awb") ~= 0 then
					local var_575_6 = manager.audio:GetVoiceLength("story_v_out_121471", "121471140", "story_v_out_121471.awb") / 1000

					if var_575_6 + var_575_0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_6 + var_575_0
					end

					if var_575_2.prefab_name ~= "" and arg_572_1.actors_[var_575_2.prefab_name] ~= nil then
						local var_575_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_572_1.actors_[var_575_2.prefab_name].transform, "story_v_out_121471", "121471140", "story_v_out_121471.awb")

						arg_572_1:RecordAudio("121471140", var_575_7)
						arg_572_1:RecordAudio("121471140", var_575_7)
					else
						arg_572_1:AudioAction("play", "voice", "story_v_out_121471", "121471140", "story_v_out_121471.awb")
					end

					arg_572_1:RecordHistoryTalkVoice("story_v_out_121471", "121471140", "story_v_out_121471.awb")
				end

				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_8 = math.max(var_575_1, arg_572_1.talkMaxDuration)

			if var_575_0 <= arg_572_1.time_ and arg_572_1.time_ < var_575_0 + var_575_8 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_0) / var_575_8

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_0 + var_575_8 and arg_572_1.time_ < var_575_0 + var_575_8 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play121471141 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 121471141
		arg_576_1.duration_ = 2.5

		local var_576_0 = {
			ja = 1.999999999999,
			ko = 2.5,
			zh = 2.5
		}
		local var_576_1 = manager.audio:GetLocalizationFlag()

		if var_576_0[var_576_1] ~= nil then
			arg_576_1.duration_ = var_576_0[var_576_1]
		end

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play121471142(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 and not isNil(arg_576_1.actors_["1029ui_story"]) and arg_576_1.var_.characterEffect1029ui_story == nil then
				arg_576_1.var_.characterEffect1029ui_story = arg_576_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_579_0 = 0.200000002980232

			if 0 <= arg_576_1.time_ and arg_576_1.time_ < 0 + var_579_0 and not isNil(arg_576_1.actors_["1029ui_story"]) then
				if arg_576_1.var_.characterEffect1029ui_story and not isNil(arg_576_1.actors_["1029ui_story"]) then
					arg_576_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_576_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_576_1.time_ - 0) / var_579_0)
				end
			end

			if arg_576_1.time_ >= 0 + var_579_0 and arg_576_1.time_ < 0 + var_579_0 + arg_579_0 and not isNil(arg_576_1.actors_["1029ui_story"]) and arg_576_1.var_.characterEffect1029ui_story then
				arg_576_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_576_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_579_1 = arg_576_1.actors_["1084ui_story"]

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 and not isNil(var_579_1) and arg_576_1.var_.characterEffect1084ui_story == nil then
				arg_576_1.var_.characterEffect1084ui_story = var_579_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_579_2 = 0.200000002980232

			if 0 <= arg_576_1.time_ and arg_576_1.time_ < 0 + var_579_2 and not isNil(var_579_1) then
				if arg_576_1.var_.characterEffect1084ui_story and not isNil(var_579_1) then
					arg_576_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_576_1.time_ >= 0 + var_579_2 and arg_576_1.time_ < 0 + var_579_2 + arg_579_0 and not isNil(var_579_1) and arg_576_1.var_.characterEffect1084ui_story then
				arg_576_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 then
				arg_576_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 then
				arg_576_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_579_4 = 0
			local var_579_5 = 0.175

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= var_579_4 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, true)

				arg_576_1.leftNameTxt_.text = arg_576_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_576_1.leftNameTxt_.transform)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1.leftNameTxt_.text)
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_6 = arg_576_1:GetWordFromCfg(121471141)
				local var_579_7 = arg_576_1:FormatText(var_579_6.content)

				arg_576_1.text_.text = var_579_7

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_9 = 7 <= 0 and var_579_5 or var_579_5 * (utf8.len(var_579_7) / 7)

				if (7 <= 0 and var_579_5 or var_579_5 * (utf8.len(var_579_7) / 7)) > 0 and var_579_5 < var_579_9 then
					arg_576_1.talkMaxDuration = var_579_9

					if var_579_9 + var_579_4 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_9 + var_579_4
					end
				end

				arg_576_1.text_.text = var_579_7
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471141", "story_v_out_121471.awb") ~= 0 then
					local var_579_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471141", "story_v_out_121471.awb") / 1000

					if var_579_10 + var_579_4 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_10 + var_579_4
					end

					if var_579_6.prefab_name ~= "" and arg_576_1.actors_[var_579_6.prefab_name] ~= nil then
						local var_579_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_576_1.actors_[var_579_6.prefab_name].transform, "story_v_out_121471", "121471141", "story_v_out_121471.awb")

						arg_576_1:RecordAudio("121471141", var_579_11)
						arg_576_1:RecordAudio("121471141", var_579_11)
					else
						arg_576_1:AudioAction("play", "voice", "story_v_out_121471", "121471141", "story_v_out_121471.awb")
					end

					arg_576_1:RecordHistoryTalkVoice("story_v_out_121471", "121471141", "story_v_out_121471.awb")
				end

				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_12 = math.max(var_579_5, arg_576_1.talkMaxDuration)

			if var_579_4 <= arg_576_1.time_ and arg_576_1.time_ < var_579_4 + var_579_12 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_4) / var_579_12

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_4 + var_579_12 and arg_576_1.time_ < var_579_4 + var_579_12 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play121471142 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 121471142
		arg_580_1.duration_ = 9.4

		local var_580_0 = {
			ja = 9.4,
			ko = 6.833,
			zh = 6.833
		}
		local var_580_1 = manager.audio:GetLocalizationFlag()

		if var_580_0[var_580_1] ~= nil then
			arg_580_1.duration_ = var_580_0[var_580_1]
		end

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play121471143(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 and not isNil(arg_580_1.actors_["1029ui_story"]) and arg_580_1.var_.characterEffect1029ui_story == nil then
				arg_580_1.var_.characterEffect1029ui_story = arg_580_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_583_0 = 0.200000002980232

			if 0 <= arg_580_1.time_ and arg_580_1.time_ < 0 + var_583_0 and not isNil(arg_580_1.actors_["1029ui_story"]) then
				if arg_580_1.var_.characterEffect1029ui_story and not isNil(arg_580_1.actors_["1029ui_story"]) then
					arg_580_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_580_1.time_ >= 0 + var_583_0 and arg_580_1.time_ < 0 + var_583_0 + arg_583_0 and not isNil(arg_580_1.actors_["1029ui_story"]) and arg_580_1.var_.characterEffect1029ui_story then
				arg_580_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_583_2 = arg_580_1.actors_["1084ui_story"]

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 and not isNil(var_583_2) and arg_580_1.var_.characterEffect1084ui_story == nil then
				arg_580_1.var_.characterEffect1084ui_story = var_583_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_583_3 = 0.200000002980232

			if 0 <= arg_580_1.time_ and arg_580_1.time_ < 0 + var_583_3 and not isNil(var_583_2) then
				if arg_580_1.var_.characterEffect1084ui_story and not isNil(var_583_2) then
					arg_580_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_580_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_580_1.time_ - 0) / var_583_3)
				end
			end

			if arg_580_1.time_ >= 0 + var_583_3 and arg_580_1.time_ < 0 + var_583_3 + arg_583_0 and not isNil(var_583_2) and arg_580_1.var_.characterEffect1084ui_story then
				arg_580_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_580_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_583_4 = 0
			local var_583_5 = 0.725

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= var_583_4 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, true)

				arg_580_1.leftNameTxt_.text = arg_580_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_580_1.leftNameTxt_.transform)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1.leftNameTxt_.text)
				SetActive(arg_580_1.iconTrs_.gameObject, false)
				arg_580_1.callingController_:SetSelectedState("normal")

				local var_583_6 = arg_580_1:GetWordFromCfg(121471142)
				local var_583_7 = arg_580_1:FormatText(var_583_6.content)

				arg_580_1.text_.text = var_583_7

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_9 = 29 <= 0 and var_583_5 or var_583_5 * (utf8.len(var_583_7) / 29)

				if (29 <= 0 and var_583_5 or var_583_5 * (utf8.len(var_583_7) / 29)) > 0 and var_583_5 < var_583_9 then
					arg_580_1.talkMaxDuration = var_583_9

					if var_583_9 + var_583_4 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_9 + var_583_4
					end
				end

				arg_580_1.text_.text = var_583_7
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471142", "story_v_out_121471.awb") ~= 0 then
					local var_583_10 = manager.audio:GetVoiceLength("story_v_out_121471", "121471142", "story_v_out_121471.awb") / 1000

					if var_583_10 + var_583_4 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_10 + var_583_4
					end

					if var_583_6.prefab_name ~= "" and arg_580_1.actors_[var_583_6.prefab_name] ~= nil then
						local var_583_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_580_1.actors_[var_583_6.prefab_name].transform, "story_v_out_121471", "121471142", "story_v_out_121471.awb")

						arg_580_1:RecordAudio("121471142", var_583_11)
						arg_580_1:RecordAudio("121471142", var_583_11)
					else
						arg_580_1:AudioAction("play", "voice", "story_v_out_121471", "121471142", "story_v_out_121471.awb")
					end

					arg_580_1:RecordHistoryTalkVoice("story_v_out_121471", "121471142", "story_v_out_121471.awb")
				end

				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_12 = math.max(var_583_5, arg_580_1.talkMaxDuration)

			if var_583_4 <= arg_580_1.time_ and arg_580_1.time_ < var_583_4 + var_583_12 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_4) / var_583_12

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_4 + var_583_12 and arg_580_1.time_ < var_583_4 + var_583_12 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {}

		arg_580_1:InitPlayNodeList()
	end,
	Play121471143 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 121471143
		arg_584_1.duration_ = 11.4

		local var_584_0 = {
			ja = 11.266,
			ko = 11.4,
			zh = 11.4
		}
		local var_584_1 = manager.audio:GetLocalizationFlag()

		if var_584_0[var_584_1] ~= nil then
			arg_584_1.duration_ = var_584_0[var_584_1]
		end

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play121471144(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			local var_587_0 = 1.3

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, true)

				arg_584_1.leftNameTxt_.text = arg_584_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_584_1.leftNameTxt_.transform)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1.leftNameTxt_.text)
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_1 = arg_584_1:GetWordFromCfg(121471143)
				local var_587_2 = arg_584_1:FormatText(var_587_1.content)

				arg_584_1.text_.text = var_587_2

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_4 = 52 <= 0 and var_587_0 or var_587_0 * (utf8.len(var_587_2) / 52)

				if (52 <= 0 and var_587_0 or var_587_0 * (utf8.len(var_587_2) / 52)) > 0 and var_587_0 < var_587_4 then
					arg_584_1.talkMaxDuration = var_587_4

					if var_587_4 + 0 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_4 + 0
					end
				end

				arg_584_1.text_.text = var_587_2
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471143", "story_v_out_121471.awb") ~= 0 then
					local var_587_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471143", "story_v_out_121471.awb") / 1000

					if var_587_5 + 0 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_5 + 0
					end

					if var_587_1.prefab_name ~= "" and arg_584_1.actors_[var_587_1.prefab_name] ~= nil then
						local var_587_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_584_1.actors_[var_587_1.prefab_name].transform, "story_v_out_121471", "121471143", "story_v_out_121471.awb")

						arg_584_1:RecordAudio("121471143", var_587_6)
						arg_584_1:RecordAudio("121471143", var_587_6)
					else
						arg_584_1:AudioAction("play", "voice", "story_v_out_121471", "121471143", "story_v_out_121471.awb")
					end

					arg_584_1:RecordHistoryTalkVoice("story_v_out_121471", "121471143", "story_v_out_121471.awb")
				end

				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_7 = math.max(var_587_0, arg_584_1.talkMaxDuration)

			if 0 <= arg_584_1.time_ and arg_584_1.time_ < 0 + var_587_7 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - 0) / var_587_7

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= 0 + var_587_7 and arg_584_1.time_ < 0 + var_587_7 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {}

		arg_584_1:InitPlayNodeList()
	end,
	Play121471144 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 121471144
		arg_588_1.duration_ = 4.83

		local var_588_0 = {
			ja = 4.233,
			ko = 4.833,
			zh = 4.833
		}
		local var_588_1 = manager.audio:GetLocalizationFlag()

		if var_588_0[var_588_1] ~= nil then
			arg_588_1.duration_ = var_588_0[var_588_1]
		end

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
			arg_588_1.auto_ = false
		end

		function arg_588_1.playNext_(arg_590_0)
			arg_588_1.onStoryFinished_()
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			local var_591_0 = 0.325

			if 0 < arg_588_1.time_ and arg_588_1.time_ <= 0 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				arg_588_1.leftNameTxt_.text = arg_588_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_1 = arg_588_1:GetWordFromCfg(121471144)
				local var_591_2 = arg_588_1:FormatText(var_591_1.content)

				arg_588_1.text_.text = var_591_2

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_4 = 13 <= 0 and var_591_0 or var_591_0 * (utf8.len(var_591_2) / 13)

				if (13 <= 0 and var_591_0 or var_591_0 * (utf8.len(var_591_2) / 13)) > 0 and var_591_0 < var_591_4 then
					arg_588_1.talkMaxDuration = var_591_4

					if var_591_4 + 0 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_4 + 0
					end
				end

				arg_588_1.text_.text = var_591_2
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121471", "121471144", "story_v_out_121471.awb") ~= 0 then
					local var_591_5 = manager.audio:GetVoiceLength("story_v_out_121471", "121471144", "story_v_out_121471.awb") / 1000

					if var_591_5 + 0 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_5 + 0
					end

					if var_591_1.prefab_name ~= "" and arg_588_1.actors_[var_591_1.prefab_name] ~= nil then
						local var_591_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_588_1.actors_[var_591_1.prefab_name].transform, "story_v_out_121471", "121471144", "story_v_out_121471.awb")

						arg_588_1:RecordAudio("121471144", var_591_6)
						arg_588_1:RecordAudio("121471144", var_591_6)
					else
						arg_588_1:AudioAction("play", "voice", "story_v_out_121471", "121471144", "story_v_out_121471.awb")
					end

					arg_588_1:RecordHistoryTalkVoice("story_v_out_121471", "121471144", "story_v_out_121471.awb")
				end

				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_7 = math.max(var_591_0, arg_588_1.talkMaxDuration)

			if 0 <= arg_588_1.time_ and arg_588_1.time_ < 0 + var_591_7 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - 0) / var_591_7

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= 0 + var_591_7 and arg_588_1.time_ < 0 + var_591_7 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {}

		arg_588_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST41",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST42",
		"TextureConfig/Background/ST31",
		"TextureConfig/Background/J12f"
	},
	voices = {
		"story_v_out_121471.awb"
	}
}
