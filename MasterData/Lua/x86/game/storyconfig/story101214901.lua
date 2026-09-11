return {
	Play121491001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 121491001
		arg_1_1.duration_ = 10.2

		local var_1_0 = {
			ja = 10.2000000029802,
			ko = 7.66600000298023,
			zh = 7.66600000298023
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
				arg_1_0:Play121491002(arg_1_1)
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

			local var_4_8 = "1084ui_story"

			if arg_1_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1084ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_1_1.time_ - 1.8) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_13 and arg_1_1.time_ < 1.8 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1084ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_4_17 = "1076ui_story"

			if arg_1_1.actors_["1076ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1076ui_story"))) then
				local var_4_18 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_1_1.stage_.transform)

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

			local var_4_21 = arg_1_1.actors_["1076ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1076ui_story = var_4_21.localPosition
			end

			local var_4_22 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_22 then
				var_4_21.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_1_1.time_ - 1.8) / var_4_22)
				var_4_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_21.position).x, (manager.ui.mainCamera.transform.position - var_4_21.position).y, (manager.ui.mainCamera.transform.position - var_4_21.position).z)
				var_4_21.localEulerAngles.z = 0
				var_4_21.localEulerAngles.x = 0
				var_4_21.localEulerAngles = var_4_21.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_22 and arg_1_1.time_ < 1.8 + var_4_22 + arg_4_0 then
				var_4_21.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_4_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_21.position).x, (manager.ui.mainCamera.transform.position - var_4_21.position).y, (manager.ui.mainCamera.transform.position - var_4_21.position).z)
				var_4_21.localEulerAngles.z = 0
				var_4_21.localEulerAngles.x = 0
				var_4_21.localEulerAngles = var_4_21.localEulerAngles
			end

			local var_4_23 = arg_1_1.actors_["1076ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_23) and arg_1_1.var_.characterEffect1076ui_story == nil then
				arg_1_1.var_.characterEffect1076ui_story = var_4_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_24 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_24 and not isNil(var_4_23) then
				if arg_1_1.var_.characterEffect1076ui_story and not isNil(var_4_23) then
					arg_1_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_1_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_1_1.time_ - 1.8) / var_4_24)
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_24 and arg_1_1.time_ < 1.8 + var_4_24 + arg_4_0 and not isNil(var_4_23) and arg_1_1.var_.characterEffect1076ui_story then
				arg_1_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_1_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
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

			if 0.366666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.366666666666667 + arg_4_0 then
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_31 = 2.00000000298023
			local var_4_32 = 0.8

			if 2.00000000298023 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_33 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_33:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_34 = arg_1_1:GetWordFromCfg(121491001)
				local var_4_35 = arg_1_1:FormatText(var_4_34.content)

				arg_1_1.text_.text = var_4_35

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_37 = 32 <= 0 and var_4_32 or var_4_32 * (utf8.len(var_4_35) / 32)

				if (32 <= 0 and var_4_32 or var_4_32 * (utf8.len(var_4_35) / 32)) > 0 and var_4_32 < var_4_37 then
					arg_1_1.talkMaxDuration = var_4_37
					var_4_31 = var_4_31 + 0.3

					if var_4_37 + var_4_31 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_37 + var_4_31
					end
				end

				arg_1_1.text_.text = var_4_35
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491001", "story_v_out_121491.awb") ~= 0 then
					local var_4_38 = manager.audio:GetVoiceLength("story_v_out_121491", "121491001", "story_v_out_121491.awb") / 1000

					if var_4_38 + var_4_31 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_38 + var_4_31
					end

					if var_4_34.prefab_name ~= "" and arg_1_1.actors_[var_4_34.prefab_name] ~= nil then
						local var_4_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_34.prefab_name].transform, "story_v_out_121491", "121491001", "story_v_out_121491.awb")

						arg_1_1:RecordAudio("121491001", var_4_39)
						arg_1_1:RecordAudio("121491001", var_4_39)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_121491", "121491001", "story_v_out_121491.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_121491", "121491001", "story_v_out_121491.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_40 = var_4_31 + 0.3
			local var_4_41 = math.max(var_4_32, arg_1_1.talkMaxDuration)

			if var_4_31 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_40) / var_4_41

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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

		arg_1_1:InitPlayNodeList()
	end,
	Play121491002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 121491002
		arg_9_1.duration_ = 2.8

		local var_9_0 = {
			ja = 2.266,
			ko = 2.8,
			zh = 2.8
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
				arg_9_0:Play121491003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1084ui_story"]) and arg_9_1.var_.characterEffect1084ui_story == nil then
				arg_9_1.var_.characterEffect1084ui_story = arg_9_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1084ui_story"]) then
				if arg_9_1.var_.characterEffect1084ui_story and not isNil(arg_9_1.actors_["1084ui_story"]) then
					arg_9_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1084ui_story"]) and arg_9_1.var_.characterEffect1084ui_story then
				arg_9_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_12_1 = arg_9_1.actors_["1076ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1076ui_story == nil then
				arg_9_1.var_.characterEffect1076ui_story = var_12_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 and not isNil(var_12_1) then
				if arg_9_1.var_.characterEffect1076ui_story and not isNil(var_12_1) then
					arg_9_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1076ui_story then
				arg_9_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_12_4 = 0
			local var_12_5 = 0.25

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_6 = arg_9_1:GetWordFromCfg(121491002)
				local var_12_7 = arg_9_1:FormatText(var_12_6.content)

				arg_9_1.text_.text = var_12_7

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_9 = 10 <= 0 and var_12_5 or var_12_5 * (utf8.len(var_12_7) / 10)

				if (10 <= 0 and var_12_5 or var_12_5 * (utf8.len(var_12_7) / 10)) > 0 and var_12_5 < var_12_9 then
					arg_9_1.talkMaxDuration = var_12_9

					if var_12_9 + var_12_4 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_9 + var_12_4
					end
				end

				arg_9_1.text_.text = var_12_7
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491002", "story_v_out_121491.awb") ~= 0 then
					local var_12_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491002", "story_v_out_121491.awb") / 1000

					if var_12_10 + var_12_4 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_10 + var_12_4
					end

					if var_12_6.prefab_name ~= "" and arg_9_1.actors_[var_12_6.prefab_name] ~= nil then
						local var_12_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_6.prefab_name].transform, "story_v_out_121491", "121491002", "story_v_out_121491.awb")

						arg_9_1:RecordAudio("121491002", var_12_11)
						arg_9_1:RecordAudio("121491002", var_12_11)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_121491", "121491002", "story_v_out_121491.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_121491", "121491002", "story_v_out_121491.awb")
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
	Play121491003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 121491003
		arg_13_1.duration_ = 6.93

		local var_13_0 = {
			ja = 6.433,
			ko = 6.933,
			zh = 6.933
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
				arg_13_0:Play121491004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.825

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(121491003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 33 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 33)

				if (33 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 33)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491003", "story_v_out_121491.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_121491", "121491003", "story_v_out_121491.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_121491", "121491003", "story_v_out_121491.awb")

						arg_13_1:RecordAudio("121491003", var_16_6)
						arg_13_1:RecordAudio("121491003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_121491", "121491003", "story_v_out_121491.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_121491", "121491003", "story_v_out_121491.awb")
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
	Play121491004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 121491004
		arg_17_1.duration_ = 9.43

		local var_17_0 = {
			ja = 9.433,
			ko = 3.6,
			zh = 3.6
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
				arg_17_0:Play121491005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1084ui_story"]) and arg_17_1.var_.characterEffect1084ui_story == nil then
				arg_17_1.var_.characterEffect1084ui_story = arg_17_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1084ui_story"]) then
				if arg_17_1.var_.characterEffect1084ui_story and not isNil(arg_17_1.actors_["1084ui_story"]) then
					arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1084ui_story"]) and arg_17_1.var_.characterEffect1084ui_story then
				arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_20_2 = arg_17_1.actors_["1076ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.characterEffect1076ui_story == nil then
				arg_17_1.var_.characterEffect1076ui_story = var_20_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_3 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.characterEffect1076ui_story and not isNil(var_20_2) then
					arg_17_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_3)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.characterEffect1076ui_story then
				arg_17_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_20_4 = 0
			local var_20_5 = 0.375

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(121491004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 15 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 15)

				if (15 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 15)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491004", "story_v_out_121491.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491004", "story_v_out_121491.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_121491", "121491004", "story_v_out_121491.awb")

						arg_17_1:RecordAudio("121491004", var_20_11)
						arg_17_1:RecordAudio("121491004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_121491", "121491004", "story_v_out_121491.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_121491", "121491004", "story_v_out_121491.awb")
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
	Play121491005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 121491005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play121491006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1084ui_story"]) and arg_21_1.var_.characterEffect1084ui_story == nil then
				arg_21_1.var_.characterEffect1084ui_story = arg_21_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1084ui_story"]) then
				if arg_21_1.var_.characterEffect1084ui_story and not isNil(arg_21_1.actors_["1084ui_story"]) then
					arg_21_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1084ui_story"]) and arg_21_1.var_.characterEffect1084ui_story then
				arg_21_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.775

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(121491005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 31 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 31)

				if (31 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 31)) > 0 and var_24_2 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_6 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_6 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_6

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_6 and arg_21_1.time_ < var_24_1 + var_24_6 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play121491006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 121491006
		arg_25_1.duration_ = 9.4

		local var_25_0 = {
			ja = 9.4,
			ko = 7.1,
			zh = 7.1
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
				arg_25_0:Play121491007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1076ui_story"]) and arg_25_1.var_.characterEffect1076ui_story == nil then
				arg_25_1.var_.characterEffect1076ui_story = arg_25_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1076ui_story"]) then
				if arg_25_1.var_.characterEffect1076ui_story and not isNil(arg_25_1.actors_["1076ui_story"]) then
					arg_25_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1076ui_story"]) and arg_25_1.var_.characterEffect1076ui_story then
				arg_25_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_28_2 = 0
			local var_28_3 = 0.875

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_4 = arg_25_1:GetWordFromCfg(121491006)
				local var_28_5 = arg_25_1:FormatText(var_28_4.content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 35 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 35)

				if (35 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 35)) > 0 and var_28_3 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491006", "story_v_out_121491.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_121491", "121491006", "story_v_out_121491.awb") / 1000

					if var_28_8 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_2
					end

					if var_28_4.prefab_name ~= "" and arg_25_1.actors_[var_28_4.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_4.prefab_name].transform, "story_v_out_121491", "121491006", "story_v_out_121491.awb")

						arg_25_1:RecordAudio("121491006", var_28_9)
						arg_25_1:RecordAudio("121491006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_121491", "121491006", "story_v_out_121491.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_121491", "121491006", "story_v_out_121491.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_3, arg_25_1.talkMaxDuration)

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_2) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_2 + var_28_10 and arg_25_1.time_ < var_28_2 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play121491007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 121491007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play121491008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1076ui_story"]) and arg_29_1.var_.characterEffect1076ui_story == nil then
				arg_29_1.var_.characterEffect1076ui_story = arg_29_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1076ui_story"]) then
				if arg_29_1.var_.characterEffect1076ui_story and not isNil(arg_29_1.actors_["1076ui_story"]) then
					arg_29_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1076ui_story"]) and arg_29_1.var_.characterEffect1076ui_story then
				arg_29_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = 0.2

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(121491007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 8 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 8)

				if (8 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 8)) > 0 and var_32_2 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_6 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_6 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_6

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_6 and arg_29_1.time_ < var_32_1 + var_32_6 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play121491008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 121491008
		arg_33_1.duration_ = 4.3

		local var_33_0 = {
			ja = 4.3,
			ko = 2.366,
			zh = 2.366
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
				arg_33_0:Play121491009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1076ui_story"]) and arg_33_1.var_.characterEffect1076ui_story == nil then
				arg_33_1.var_.characterEffect1076ui_story = arg_33_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1076ui_story"]) then
				if arg_33_1.var_.characterEffect1076ui_story and not isNil(arg_33_1.actors_["1076ui_story"]) then
					arg_33_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1076ui_story"]) and arg_33_1.var_.characterEffect1076ui_story then
				arg_33_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_36_2 = 0
			local var_36_3 = 0.25

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
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

				local var_36_4 = arg_33_1:GetWordFromCfg(121491008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 9 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 9)

				if (9 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 9)) > 0 and var_36_3 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491008", "story_v_out_121491.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_121491", "121491008", "story_v_out_121491.awb") / 1000

					if var_36_8 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_2
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_out_121491", "121491008", "story_v_out_121491.awb")

						arg_33_1:RecordAudio("121491008", var_36_9)
						arg_33_1:RecordAudio("121491008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_121491", "121491008", "story_v_out_121491.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_121491", "121491008", "story_v_out_121491.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_10 and arg_33_1.time_ < var_36_2 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play121491009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 121491009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play121491010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1076ui_story"]) and arg_37_1.var_.characterEffect1076ui_story == nil then
				arg_37_1.var_.characterEffect1076ui_story = arg_37_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1076ui_story"]) then
				if arg_37_1.var_.characterEffect1076ui_story and not isNil(arg_37_1.actors_["1076ui_story"]) then
					arg_37_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1076ui_story"]) and arg_37_1.var_.characterEffect1076ui_story then
				arg_37_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.525

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(121491009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 21 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 21)

				if (21 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 21)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play121491010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 121491010
		arg_41_1.duration_ = 8.97

		local var_41_0 = {
			ja = 8.966,
			ko = 7.9,
			zh = 7.9
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
				arg_41_0:Play121491011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1076ui_story"]) and arg_41_1.var_.characterEffect1076ui_story == nil then
				arg_41_1.var_.characterEffect1076ui_story = arg_41_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1076ui_story"]) then
				if arg_41_1.var_.characterEffect1076ui_story and not isNil(arg_41_1.actors_["1076ui_story"]) then
					arg_41_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1076ui_story"]) and arg_41_1.var_.characterEffect1076ui_story then
				arg_41_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_44_2 = 0
			local var_44_3 = 0.825

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(121491010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 33 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 33)

				if (33 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 33)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491010", "story_v_out_121491.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_121491", "121491010", "story_v_out_121491.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_out_121491", "121491010", "story_v_out_121491.awb")

						arg_41_1:RecordAudio("121491010", var_44_9)
						arg_41_1:RecordAudio("121491010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_121491", "121491010", "story_v_out_121491.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_121491", "121491010", "story_v_out_121491.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_10 and arg_41_1.time_ < var_44_2 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play121491011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 121491011
		arg_45_1.duration_ = 12.4

		local var_45_0 = {
			ja = 12.4,
			ko = 7.9,
			zh = 7.9
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
				arg_45_0:Play121491012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action5_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_0 = 0
			local var_48_1 = 0.975

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
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

				local var_48_2 = arg_45_1:GetWordFromCfg(121491011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 39 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 39)

				if (39 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 39)) > 0 and var_48_1 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491011", "story_v_out_121491.awb") ~= 0 then
					local var_48_6 = manager.audio:GetVoiceLength("story_v_out_121491", "121491011", "story_v_out_121491.awb") / 1000

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end

					if var_48_2.prefab_name ~= "" and arg_45_1.actors_[var_48_2.prefab_name] ~= nil then
						local var_48_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_2.prefab_name].transform, "story_v_out_121491", "121491011", "story_v_out_121491.awb")

						arg_45_1:RecordAudio("121491011", var_48_7)
						arg_45_1:RecordAudio("121491011", var_48_7)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_121491", "121491011", "story_v_out_121491.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_121491", "121491011", "story_v_out_121491.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_8 and arg_45_1.time_ < var_48_0 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play121491012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 121491012
		arg_49_1.duration_ = 5.23

		local var_49_0 = {
			ja = 5.233,
			ko = 2.5,
			zh = 2.5
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
				arg_49_0:Play121491013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1084ui_story"]) and arg_49_1.var_.characterEffect1084ui_story == nil then
				arg_49_1.var_.characterEffect1084ui_story = arg_49_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1084ui_story"]) then
				if arg_49_1.var_.characterEffect1084ui_story and not isNil(arg_49_1.actors_["1084ui_story"]) then
					arg_49_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1084ui_story"]) and arg_49_1.var_.characterEffect1084ui_story then
				arg_49_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_2 = arg_49_1.actors_["1076ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1076ui_story = var_52_2.localPosition
			end

			local var_52_3 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 then
				var_52_2.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_49_1.time_ - 0) / var_52_3)
				var_52_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_2.position).x, (manager.ui.mainCamera.transform.position - var_52_2.position).y, (manager.ui.mainCamera.transform.position - var_52_2.position).z)
				var_52_2.localEulerAngles.z = 0
				var_52_2.localEulerAngles.x = 0
				var_52_2.localEulerAngles = var_52_2.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 then
				var_52_2.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_52_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_2.position).x, (manager.ui.mainCamera.transform.position - var_52_2.position).y, (manager.ui.mainCamera.transform.position - var_52_2.position).z)
				var_52_2.localEulerAngles.z = 0
				var_52_2.localEulerAngles.x = 0
				var_52_2.localEulerAngles = var_52_2.localEulerAngles
			end

			local var_52_4 = arg_49_1.actors_["1076ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1076ui_story == nil then
				arg_49_1.var_.characterEffect1076ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_5 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_5 and not isNil(var_52_4) then
				if arg_49_1.var_.characterEffect1076ui_story and not isNil(var_52_4) then
					arg_49_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_5)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_5 and arg_49_1.time_ < 0 + var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1076ui_story then
				arg_49_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_52_6 = 0
			local var_52_7 = 0.3

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(121491012)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 12 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 12)

				if (12 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 12)) > 0 and var_52_7 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491012", "story_v_out_121491.awb") ~= 0 then
					local var_52_12 = manager.audio:GetVoiceLength("story_v_out_121491", "121491012", "story_v_out_121491.awb") / 1000

					if var_52_12 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_6
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_out_121491", "121491012", "story_v_out_121491.awb")

						arg_49_1:RecordAudio("121491012", var_52_13)
						arg_49_1:RecordAudio("121491012", var_52_13)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_121491", "121491012", "story_v_out_121491.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_121491", "121491012", "story_v_out_121491.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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

		arg_49_1:InitPlayNodeList()
	end,
	Play121491013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 121491013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play121491014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1084ui_story"]) and arg_53_1.var_.characterEffect1084ui_story == nil then
				arg_53_1.var_.characterEffect1084ui_story = arg_53_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1084ui_story"]) then
				if arg_53_1.var_.characterEffect1084ui_story and not isNil(arg_53_1.actors_["1084ui_story"]) then
					arg_53_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1084ui_story"]) and arg_53_1.var_.characterEffect1084ui_story then
				arg_53_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action5_2")
			end

			local var_56_1 = 0
			local var_56_2 = 0.6

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(121491013).content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 24 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 24)

				if (24 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 24)) > 0 and var_56_2 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_6 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_6 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_6

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_6 and arg_53_1.time_ < var_56_1 + var_56_6 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play121491014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 121491014
		arg_57_1.duration_ = 6.87

		local var_57_0 = {
			ja = 6.866,
			ko = 2.766,
			zh = 2.766
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
				arg_57_0:Play121491015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1084ui_story"]) and arg_57_1.var_.characterEffect1084ui_story == nil then
				arg_57_1.var_.characterEffect1084ui_story = arg_57_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1084ui_story"]) then
				if arg_57_1.var_.characterEffect1084ui_story and not isNil(arg_57_1.actors_["1084ui_story"]) then
					arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1084ui_story"]) and arg_57_1.var_.characterEffect1084ui_story then
				arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_60_2 = 0
			local var_60_3 = 0.325

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(121491014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 13 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 13)

				if (13 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 13)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491014", "story_v_out_121491.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_121491", "121491014", "story_v_out_121491.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_out_121491", "121491014", "story_v_out_121491.awb")

						arg_57_1:RecordAudio("121491014", var_60_9)
						arg_57_1:RecordAudio("121491014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_121491", "121491014", "story_v_out_121491.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_121491", "121491014", "story_v_out_121491.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_10 and arg_57_1.time_ < var_60_2 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play121491015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 121491015
		arg_61_1.duration_ = 7.7

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play121491016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 1.76599999815226 < arg_61_1.time_ and arg_61_1.time_ <= 1.76599999815226 + arg_64_0 then
				arg_61_1.var_.moveOldPos1084ui_story = arg_61_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 1.76599999815226 <= arg_61_1.time_ and arg_61_1.time_ < 1.76599999815226 + var_64_0 then
				arg_61_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 1.76599999815226) / var_64_0)
				arg_61_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1084ui_story"].transform.position).z)
				arg_61_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1084ui_story"].transform.localEulerAngles = arg_61_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 1.76599999815226 + var_64_0 and arg_61_1.time_ < 1.76599999815226 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1084ui_story"].transform.position).z)
				arg_61_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1084ui_story"].transform.localEulerAngles = arg_61_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1084ui_story"]

			if 1.76599999815226 < arg_61_1.time_ and arg_61_1.time_ <= 1.76599999815226 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1084ui_story == nil then
				arg_61_1.var_.characterEffect1084ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.034000001847744

			if 1.76599999815226 <= arg_61_1.time_ and arg_61_1.time_ < 1.76599999815226 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1084ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 1.76599999815226) / var_64_2)
				end
			end

			if arg_61_1.time_ >= 1.76599999815226 + var_64_2 and arg_61_1.time_ < 1.76599999815226 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1084ui_story then
				arg_61_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_64_3 = arg_61_1.actors_["1076ui_story"].transform

			if 1.76599999815226 < arg_61_1.time_ and arg_61_1.time_ <= 1.76599999815226 + arg_64_0 then
				arg_61_1.var_.moveOldPos1076ui_story = var_64_3.localPosition
			end

			local var_64_4 = 0.001

			if 1.76599999815226 <= arg_61_1.time_ and arg_61_1.time_ < 1.76599999815226 + var_64_4 then
				var_64_3.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 1.76599999815226) / var_64_4)
				var_64_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_3.position).x, (manager.ui.mainCamera.transform.position - var_64_3.position).y, (manager.ui.mainCamera.transform.position - var_64_3.position).z)
				var_64_3.localEulerAngles.z = 0
				var_64_3.localEulerAngles.x = 0
				var_64_3.localEulerAngles = var_64_3.localEulerAngles
			end

			if arg_61_1.time_ >= 1.76599999815226 + var_64_4 and arg_61_1.time_ < 1.76599999815226 + var_64_4 + arg_64_0 then
				var_64_3.localPosition = Vector3.New(0, 100, 0)
				var_64_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_3.position).x, (manager.ui.mainCamera.transform.position - var_64_3.position).y, (manager.ui.mainCamera.transform.position - var_64_3.position).z)
				var_64_3.localEulerAngles.z = 0
				var_64_3.localEulerAngles.x = 0
				var_64_3.localEulerAngles = var_64_3.localEulerAngles
			end

			local var_64_5 = arg_61_1.actors_["1076ui_story"]

			if 1.76599999815226 < arg_61_1.time_ and arg_61_1.time_ <= 1.76599999815226 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect1076ui_story == nil then
				arg_61_1.var_.characterEffect1076ui_story = var_64_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_6 = 0.034000001847744

			if 1.76599999815226 <= arg_61_1.time_ and arg_61_1.time_ < 1.76599999815226 + var_64_6 and not isNil(var_64_5) then
				if arg_61_1.var_.characterEffect1076ui_story and not isNil(var_64_5) then
					arg_61_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 1.76599999815226) / var_64_6)
				end
			end

			if arg_61_1.time_ >= 1.76599999815226 + var_64_6 and arg_61_1.time_ < 1.76599999815226 + var_64_6 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect1076ui_story then
				arg_61_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 1.8 < arg_61_1.time_ and arg_61_1.time_ <= 1.8 + arg_64_0 then
				arg_61_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_tea", "")
			end

			local var_64_8 = 0

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_9 = 1.8

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_9 then
				local var_64_10 = Color.New(0, 0, 0)

				var_64_10.a = Mathf.Lerp(0, 1, (arg_61_1.time_ - var_64_8) / var_64_9)
				arg_61_1.mask_.color = var_64_10
			end

			if arg_61_1.time_ >= var_64_8 + var_64_9 and arg_61_1.time_ < var_64_8 + var_64_9 + arg_64_0 then
				local var_64_11 = Color.New(0, 0, 0)

				var_64_11.a = 1
				arg_61_1.mask_.color = var_64_11
			end

			local var_64_12 = 1.8

			if 1.8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_12 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_13 = 1.8

			if var_64_12 <= arg_61_1.time_ and arg_61_1.time_ < var_64_12 + var_64_13 then
				local var_64_14 = Color.New(0, 0, 0)

				var_64_14.a = Mathf.Lerp(1, 0, (arg_61_1.time_ - var_64_12) / var_64_13)
				arg_61_1.mask_.color = var_64_14
			end

			if arg_61_1.time_ >= var_64_12 + var_64_13 and arg_61_1.time_ < var_64_12 + var_64_13 + arg_64_0 then
				local var_64_15 = Color.New(0, 0, 0)

				arg_61_1.mask_.enabled = false
				var_64_15.a = 0
				arg_61_1.mask_.color = var_64_15
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_16 = 2.699999999999
			local var_64_17 = 0.9

			if 2.699999999999 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_18 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_18:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_19 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(121491015).content)

				arg_61_1.text_.text = var_64_19

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_21 = 36 <= 0 and var_64_17 or var_64_17 * (utf8.len(var_64_19) / 36)

				if (36 <= 0 and var_64_17 or var_64_17 * (utf8.len(var_64_19) / 36)) > 0 and var_64_17 < var_64_21 then
					arg_61_1.talkMaxDuration = var_64_21
					var_64_16 = var_64_16 + 0.3

					if var_64_21 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_21 + var_64_16
					end
				end

				arg_61_1.text_.text = var_64_19
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_22 = var_64_16 + 0.3
			local var_64_23 = math.max(var_64_17, arg_61_1.talkMaxDuration)

			if var_64_16 + 0.3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_22 + var_64_23 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_22) / var_64_23

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_22 + var_64_23 and arg_61_1.time_ < var_64_22 + var_64_23 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.76599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.76599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play121491016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 121491016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play121491017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.9

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(121491016).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 36 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 36)

				if (36 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 36)) > 0 and var_70_0 < var_70_3 then
					arg_67_1.talkMaxDuration = var_70_3

					if var_70_3 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_3 + 0
					end
				end

				arg_67_1.text_.text = var_70_1
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_4 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_4

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play121491017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 121491017
		arg_71_1.duration_ = 5.17

		local var_71_0 = {
			ja = 5.166,
			ko = 3.933,
			zh = 3.933
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
				arg_71_0:Play121491018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1076ui_story = arg_71_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1076ui_story"].transform.position).z)
				arg_71_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1076ui_story"].transform.localEulerAngles = arg_71_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_71_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1076ui_story"].transform.position).z)
				arg_71_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1076ui_story"].transform.localEulerAngles = arg_71_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["1076ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1076ui_story == nil then
				arg_71_1.var_.characterEffect1076ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect1076ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1076ui_story then
				arg_71_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_74_4 = 0
			local var_74_5 = 0.25

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(121491017)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 10 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 10)

				if (10 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 10)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491017", "story_v_out_121491.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491017", "story_v_out_121491.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_out_121491", "121491017", "story_v_out_121491.awb")

						arg_71_1:RecordAudio("121491017", var_74_11)
						arg_71_1:RecordAudio("121491017", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_121491", "121491017", "story_v_out_121491.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_121491", "121491017", "story_v_out_121491.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_12 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_12 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_4) / var_74_12

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_12 and arg_71_1.time_ < var_74_4 + var_74_12 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
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

		arg_71_1:InitPlayNodeList()
	end,
	Play121491018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 121491018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play121491019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1076ui_story"]) and arg_75_1.var_.characterEffect1076ui_story == nil then
				arg_75_1.var_.characterEffect1076ui_story = arg_75_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1076ui_story"]) then
				if arg_75_1.var_.characterEffect1076ui_story and not isNil(arg_75_1.actors_["1076ui_story"]) then
					arg_75_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1076ui_story"]) and arg_75_1.var_.characterEffect1076ui_story then
				arg_75_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:AudioAction("play", "effect", "se_story_side_1093", "se_story_1093_message_calling", "")
			end

			local var_78_2 = 0
			local var_78_3 = 1

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_2 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_4 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(121491018).content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_6 = 40 <= 0 and var_78_3 or var_78_3 * (utf8.len(var_78_4) / 40)

				if (40 <= 0 and var_78_3 or var_78_3 * (utf8.len(var_78_4) / 40)) > 0 and var_78_3 < var_78_6 then
					arg_75_1.talkMaxDuration = var_78_6

					if var_78_6 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_6 + var_78_2
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_3, arg_75_1.talkMaxDuration)

			if var_78_2 <= arg_75_1.time_ and arg_75_1.time_ < var_78_2 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_2) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_2 + var_78_7 and arg_75_1.time_ < var_78_2 + var_78_7 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play121491019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 121491019
		arg_79_1.duration_ = 2

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play121491020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1076ui_story"]) and arg_79_1.var_.characterEffect1076ui_story == nil then
				arg_79_1.var_.characterEffect1076ui_story = arg_79_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1076ui_story"]) then
				if arg_79_1.var_.characterEffect1076ui_story and not isNil(arg_79_1.actors_["1076ui_story"]) then
					arg_79_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1076ui_story"]) and arg_79_1.var_.characterEffect1076ui_story then
				arg_79_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_82_2 = 0
			local var_82_3 = 0.05

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_4 = arg_79_1:GetWordFromCfg(121491019)
				local var_82_5 = arg_79_1:FormatText(var_82_4.content)

				arg_79_1.text_.text = var_82_5

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_7 = 2 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 2)

				if (2 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 2)) > 0 and var_82_3 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_2
					end
				end

				arg_79_1.text_.text = var_82_5
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491019", "story_v_out_121491.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_out_121491", "121491019", "story_v_out_121491.awb") / 1000

					if var_82_8 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_2
					end

					if var_82_4.prefab_name ~= "" and arg_79_1.actors_[var_82_4.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_4.prefab_name].transform, "story_v_out_121491", "121491019", "story_v_out_121491.awb")

						arg_79_1:RecordAudio("121491019", var_82_9)
						arg_79_1:RecordAudio("121491019", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_121491", "121491019", "story_v_out_121491.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_121491", "121491019", "story_v_out_121491.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_3, arg_79_1.talkMaxDuration)

			if var_82_2 <= arg_79_1.time_ and arg_79_1.time_ < var_82_2 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_2) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_2 + var_82_10 and arg_79_1.time_ < var_82_2 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play121491020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 121491020
		arg_83_1.duration_ = 5.67

		local var_83_0 = {
			ja = 5.666,
			ko = 2,
			zh = 2
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
				arg_83_0:Play121491021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1076ui_story"]) and arg_83_1.var_.characterEffect1076ui_story == nil then
				arg_83_1.var_.characterEffect1076ui_story = arg_83_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1076ui_story"]) then
				if arg_83_1.var_.characterEffect1076ui_story and not isNil(arg_83_1.actors_["1076ui_story"]) then
					arg_83_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1076ui_story"]) and arg_83_1.var_.characterEffect1076ui_story then
				arg_83_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_86_1 = 0
			local var_86_2 = 0.15

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(121491020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_6 = 6 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_4) / 6)

				if (6 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_4) / 6)) > 0 and var_86_2 < var_86_6 then
					arg_83_1.talkMaxDuration = var_86_6

					if var_86_6 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491020", "story_v_out_121491.awb") ~= 0 then
					local var_86_7 = manager.audio:GetVoiceLength("story_v_out_121491", "121491020", "story_v_out_121491.awb") / 1000

					if var_86_7 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_1
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_121491", "121491020", "story_v_out_121491.awb")

						arg_83_1:RecordAudio("121491020", var_86_8)
						arg_83_1:RecordAudio("121491020", var_86_8)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_121491", "121491020", "story_v_out_121491.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_121491", "121491020", "story_v_out_121491.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_9 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_9 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_9

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_9 and arg_83_1.time_ < var_86_1 + var_86_9 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play121491021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 121491021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play121491022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1076ui_story = arg_87_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1076ui_story"].transform.position).z)
				arg_87_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1076ui_story"].transform.localEulerAngles = arg_87_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1076ui_story"].transform.position).z)
				arg_87_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1076ui_story"].transform.localEulerAngles = arg_87_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_90_1 = arg_87_1.actors_["1076ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1076ui_story == nil then
				arg_87_1.var_.characterEffect1076ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect1076ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_2)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1076ui_story then
				arg_87_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_slidingdoor_1", "")
			end

			local var_90_4 = 0
			local var_90_5 = 0.775

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_6 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(121491021).content)

				arg_87_1.text_.text = var_90_6

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_8 = 31 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_6) / 31)

				if (31 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_6) / 31)) > 0 and var_90_5 < var_90_8 then
					arg_87_1.talkMaxDuration = var_90_8

					if var_90_8 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_4
					end
				end

				arg_87_1.text_.text = var_90_6
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_9 = math.max(var_90_5, arg_87_1.talkMaxDuration)

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_9 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_4) / var_90_9

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_4 + var_90_9 and arg_87_1.time_ < var_90_4 + var_90_9 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	Play121491022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 121491022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play121491023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.925

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_1 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(121491022).content)

				arg_91_1.text_.text = var_94_1

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_3 = 37 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 37)

				if (37 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 37)) > 0 and var_94_0 < var_94_3 then
					arg_91_1.talkMaxDuration = var_94_3

					if var_94_3 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_3 + 0
					end
				end

				arg_91_1.text_.text = var_94_1
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_4 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_4

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play121491023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 121491023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play121491024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.6

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(121491023).content)

				arg_95_1.text_.text = var_98_1

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_3 = 24 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 24)

				if (24 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 24)) > 0 and var_98_0 < var_98_3 then
					arg_95_1.talkMaxDuration = var_98_3

					if var_98_3 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_3 + 0
					end
				end

				arg_95_1.text_.text = var_98_1
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_4 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_4

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play121491024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 121491024
		arg_99_1.duration_ = 11.7

		local var_99_0 = {
			ja = 11.7,
			ko = 7.133,
			zh = 7.133
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
				arg_99_0:Play121491025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if arg_99_1.actors_["1072ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1072ui_story"))) then
				local var_102_0 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_99_1.stage_.transform)

				var_102_0.name = "1072ui_story"
				var_102_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_["1072ui_story"] = var_102_0

				local var_102_1 = var_102_0:GetComponentInChildren(typeof(CharacterEffect))

				var_102_1.enabled = true

				local var_102_2 = GameObjectTools.GetOrAddComponent(var_102_0, typeof(DynamicBoneHelper))

				if var_102_2 then
					var_102_2:EnableDynamicBone(false)
				end

				arg_99_1:ShowWeapon(var_102_1.transform, false)

				arg_99_1.var_["1072ui_story" .. "Animator"] = var_102_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_99_1.var_["1072ui_story" .. "Animator"].applyRootMotion = true
				arg_99_1.var_["1072ui_story" .. "LipSync"] = var_102_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_102_3 = arg_99_1.actors_["1072ui_story"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1072ui_story = var_102_3.localPosition
			end

			local var_102_4 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				var_102_3.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_99_1.time_ - 0) / var_102_4)
				var_102_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_3.position).x, (manager.ui.mainCamera.transform.position - var_102_3.position).y, (manager.ui.mainCamera.transform.position - var_102_3.position).z)
				var_102_3.localEulerAngles.z = 0
				var_102_3.localEulerAngles.x = 0
				var_102_3.localEulerAngles = var_102_3.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				var_102_3.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_102_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_3.position).x, (manager.ui.mainCamera.transform.position - var_102_3.position).y, (manager.ui.mainCamera.transform.position - var_102_3.position).z)
				var_102_3.localEulerAngles.z = 0
				var_102_3.localEulerAngles.x = 0
				var_102_3.localEulerAngles = var_102_3.localEulerAngles
			end

			local var_102_5 = arg_99_1.actors_["1072ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_5) and arg_99_1.var_.characterEffect1072ui_story == nil then
				arg_99_1.var_.characterEffect1072ui_story = var_102_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_6 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_6 and not isNil(var_102_5) then
				if arg_99_1.var_.characterEffect1072ui_story and not isNil(var_102_5) then
					arg_99_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_6 and arg_99_1.time_ < 0 + var_102_6 + arg_102_0 and not isNil(var_102_5) and arg_99_1.var_.characterEffect1072ui_story then
				arg_99_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_102_8 = arg_99_1.actors_["1076ui_story"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1076ui_story = var_102_8.localPosition
			end

			local var_102_9 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_9 then
				var_102_8.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_99_1.time_ - 0) / var_102_9)
				var_102_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_8.position).x, (manager.ui.mainCamera.transform.position - var_102_8.position).y, (manager.ui.mainCamera.transform.position - var_102_8.position).z)
				var_102_8.localEulerAngles.z = 0
				var_102_8.localEulerAngles.x = 0
				var_102_8.localEulerAngles = var_102_8.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_9 and arg_99_1.time_ < 0 + var_102_9 + arg_102_0 then
				var_102_8.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_102_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_8.position).x, (manager.ui.mainCamera.transform.position - var_102_8.position).y, (manager.ui.mainCamera.transform.position - var_102_8.position).z)
				var_102_8.localEulerAngles.z = 0
				var_102_8.localEulerAngles.x = 0
				var_102_8.localEulerAngles = var_102_8.localEulerAngles
			end

			local var_102_10 = arg_99_1.actors_["1076ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_10) and arg_99_1.var_.characterEffect1076ui_story == nil then
				arg_99_1.var_.characterEffect1076ui_story = var_102_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_11 = 0.034000001847744

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_11 and not isNil(var_102_10) then
				if arg_99_1.var_.characterEffect1076ui_story and not isNil(var_102_10) then
					arg_99_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_11)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_11 and arg_99_1.time_ < 0 + var_102_11 + arg_102_0 and not isNil(var_102_10) and arg_99_1.var_.characterEffect1076ui_story then
				arg_99_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_102_12 = 0
			local var_102_13 = 0.875

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_12 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_14 = arg_99_1:GetWordFromCfg(121491024)
				local var_102_15 = arg_99_1:FormatText(var_102_14.content)

				arg_99_1.text_.text = var_102_15

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_17 = 34 <= 0 and var_102_13 or var_102_13 * (utf8.len(var_102_15) / 34)

				if (34 <= 0 and var_102_13 or var_102_13 * (utf8.len(var_102_15) / 34)) > 0 and var_102_13 < var_102_17 then
					arg_99_1.talkMaxDuration = var_102_17

					if var_102_17 + var_102_12 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_17 + var_102_12
					end
				end

				arg_99_1.text_.text = var_102_15
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491024", "story_v_out_121491.awb") ~= 0 then
					local var_102_18 = manager.audio:GetVoiceLength("story_v_out_121491", "121491024", "story_v_out_121491.awb") / 1000

					if var_102_18 + var_102_12 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_18 + var_102_12
					end

					if var_102_14.prefab_name ~= "" and arg_99_1.actors_[var_102_14.prefab_name] ~= nil then
						local var_102_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_14.prefab_name].transform, "story_v_out_121491", "121491024", "story_v_out_121491.awb")

						arg_99_1:RecordAudio("121491024", var_102_19)
						arg_99_1:RecordAudio("121491024", var_102_19)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_121491", "121491024", "story_v_out_121491.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_121491", "121491024", "story_v_out_121491.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_20 = math.max(var_102_13, arg_99_1.talkMaxDuration)

			if var_102_12 <= arg_99_1.time_ and arg_99_1.time_ < var_102_12 + var_102_20 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_12) / var_102_20

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_12 + var_102_20 and arg_99_1.time_ < var_102_12 + var_102_20 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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

		arg_99_1:InitPlayNodeList()
	end,
	Play121491025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 121491025
		arg_103_1.duration_ = 5.4

		local var_103_0 = {
			ja = 5.4,
			ko = 4.666,
			zh = 4.666
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
				arg_103_0:Play121491026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1072ui_story"]) and arg_103_1.var_.characterEffect1072ui_story == nil then
				arg_103_1.var_.characterEffect1072ui_story = arg_103_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1072ui_story"]) then
				if arg_103_1.var_.characterEffect1072ui_story and not isNil(arg_103_1.actors_["1072ui_story"]) then
					arg_103_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_0)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1072ui_story"]) and arg_103_1.var_.characterEffect1072ui_story then
				arg_103_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_106_1 = arg_103_1.actors_["1076ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1076ui_story == nil then
				arg_103_1.var_.characterEffect1076ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and not isNil(var_106_1) then
				if arg_103_1.var_.characterEffect1076ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1076ui_story then
				arg_103_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_106_4 = 0
			local var_106_5 = 0.4

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_6 = arg_103_1:GetWordFromCfg(121491025)
				local var_106_7 = arg_103_1:FormatText(var_106_6.content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 15 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 15)

				if (15 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 15)) > 0 and var_106_5 < var_106_9 then
					arg_103_1.talkMaxDuration = var_106_9

					if var_106_9 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491025", "story_v_out_121491.awb") ~= 0 then
					local var_106_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491025", "story_v_out_121491.awb") / 1000

					if var_106_10 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_4
					end

					if var_106_6.prefab_name ~= "" and arg_103_1.actors_[var_106_6.prefab_name] ~= nil then
						local var_106_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_6.prefab_name].transform, "story_v_out_121491", "121491025", "story_v_out_121491.awb")

						arg_103_1:RecordAudio("121491025", var_106_11)
						arg_103_1:RecordAudio("121491025", var_106_11)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_121491", "121491025", "story_v_out_121491.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_121491", "121491025", "story_v_out_121491.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_12 = math.max(var_106_5, arg_103_1.talkMaxDuration)

			if var_106_4 <= arg_103_1.time_ and arg_103_1.time_ < var_106_4 + var_106_12 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_4) / var_106_12

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_4 + var_106_12 and arg_103_1.time_ < var_106_4 + var_106_12 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play121491026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 121491026
		arg_107_1.duration_ = 4.2

		local var_107_0 = {
			ja = 3,
			ko = 4.2,
			zh = 4.2
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
				arg_107_0:Play121491027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1072ui_story"]) and arg_107_1.var_.characterEffect1072ui_story == nil then
				arg_107_1.var_.characterEffect1072ui_story = arg_107_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1072ui_story"]) then
				if arg_107_1.var_.characterEffect1072ui_story and not isNil(arg_107_1.actors_["1072ui_story"]) then
					arg_107_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1072ui_story"]) and arg_107_1.var_.characterEffect1072ui_story then
				arg_107_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_110_2 = arg_107_1.actors_["1076ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.characterEffect1076ui_story == nil then
				arg_107_1.var_.characterEffect1076ui_story = var_110_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_3 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_3 and not isNil(var_110_2) then
				if arg_107_1.var_.characterEffect1076ui_story and not isNil(var_110_2) then
					arg_107_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_3)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_3 and arg_107_1.time_ < 0 + var_110_3 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.characterEffect1076ui_story then
				arg_107_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_110_4 = 0
			local var_110_5 = 0.4

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_6 = arg_107_1:GetWordFromCfg(121491026)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_9 = 16 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 16)

				if (16 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 16)) > 0 and var_110_5 < var_110_9 then
					arg_107_1.talkMaxDuration = var_110_9

					if var_110_9 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491026", "story_v_out_121491.awb") ~= 0 then
					local var_110_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491026", "story_v_out_121491.awb") / 1000

					if var_110_10 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_4
					end

					if var_110_6.prefab_name ~= "" and arg_107_1.actors_[var_110_6.prefab_name] ~= nil then
						local var_110_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_6.prefab_name].transform, "story_v_out_121491", "121491026", "story_v_out_121491.awb")

						arg_107_1:RecordAudio("121491026", var_110_11)
						arg_107_1:RecordAudio("121491026", var_110_11)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_121491", "121491026", "story_v_out_121491.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_121491", "121491026", "story_v_out_121491.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_12 = math.max(var_110_5, arg_107_1.talkMaxDuration)

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_12 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_4) / var_110_12

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_4 + var_110_12 and arg_107_1.time_ < var_110_4 + var_110_12 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play121491027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 121491027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play121491028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1072ui_story"]) and arg_111_1.var_.characterEffect1072ui_story == nil then
				arg_111_1.var_.characterEffect1072ui_story = arg_111_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1072ui_story"]) then
				if arg_111_1.var_.characterEffect1072ui_story and not isNil(arg_111_1.actors_["1072ui_story"]) then
					arg_111_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_0)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1072ui_story"]) and arg_111_1.var_.characterEffect1072ui_story then
				arg_111_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_114_1 = 0
			local var_114_2 = 0.8

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(121491027).content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 32 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 32)

				if (32 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 32)) > 0 and var_114_2 < var_114_5 then
					arg_111_1.talkMaxDuration = var_114_5

					if var_114_5 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + var_114_1
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_6 = math.max(var_114_2, arg_111_1.talkMaxDuration)

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_6 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_1) / var_114_6

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_1 + var_114_6 and arg_111_1.time_ < var_114_1 + var_114_6 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play121491028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 121491028
		arg_115_1.duration_ = 6.93

		local var_115_0 = {
			ja = 6.933,
			ko = 4,
			zh = 4
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
				arg_115_0:Play121491029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["1072ui_story"]) and arg_115_1.var_.characterEffect1072ui_story == nil then
				arg_115_1.var_.characterEffect1072ui_story = arg_115_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["1072ui_story"]) then
				if arg_115_1.var_.characterEffect1072ui_story and not isNil(arg_115_1.actors_["1072ui_story"]) then
					arg_115_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["1072ui_story"]) and arg_115_1.var_.characterEffect1072ui_story then
				arg_115_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_2")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_2 = 0
			local var_118_3 = 0.475

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_4 = arg_115_1:GetWordFromCfg(121491028)
				local var_118_5 = arg_115_1:FormatText(var_118_4.content)

				arg_115_1.text_.text = var_118_5

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_7 = 19 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 19)

				if (19 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 19)) > 0 and var_118_3 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_2
					end
				end

				arg_115_1.text_.text = var_118_5
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491028", "story_v_out_121491.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_121491", "121491028", "story_v_out_121491.awb") / 1000

					if var_118_8 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_2
					end

					if var_118_4.prefab_name ~= "" and arg_115_1.actors_[var_118_4.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_4.prefab_name].transform, "story_v_out_121491", "121491028", "story_v_out_121491.awb")

						arg_115_1:RecordAudio("121491028", var_118_9)
						arg_115_1:RecordAudio("121491028", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_121491", "121491028", "story_v_out_121491.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_121491", "121491028", "story_v_out_121491.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_3, arg_115_1.talkMaxDuration)

			if var_118_2 <= arg_115_1.time_ and arg_115_1.time_ < var_118_2 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_2) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_2 + var_118_10 and arg_115_1.time_ < var_118_2 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play121491029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 121491029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play121491030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1072ui_story = arg_119_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1072ui_story"].transform.position).z)
				arg_119_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1072ui_story"].transform.localEulerAngles = arg_119_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1072ui_story"].transform.position).z)
				arg_119_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1072ui_story"].transform.localEulerAngles = arg_119_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["1072ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1072ui_story == nil then
				arg_119_1.var_.characterEffect1072ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect1072ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_2)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1072ui_story then
				arg_119_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_122_3 = arg_119_1.actors_["1076ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1076ui_story = var_122_3.localPosition
			end

			local var_122_4 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				var_122_3.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 0) / var_122_4)
				var_122_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_3.position).x, (manager.ui.mainCamera.transform.position - var_122_3.position).y, (manager.ui.mainCamera.transform.position - var_122_3.position).z)
				var_122_3.localEulerAngles.z = 0
				var_122_3.localEulerAngles.x = 0
				var_122_3.localEulerAngles = var_122_3.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				var_122_3.localPosition = Vector3.New(0, 100, 0)
				var_122_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_3.position).x, (manager.ui.mainCamera.transform.position - var_122_3.position).y, (manager.ui.mainCamera.transform.position - var_122_3.position).z)
				var_122_3.localEulerAngles.z = 0
				var_122_3.localEulerAngles.x = 0
				var_122_3.localEulerAngles = var_122_3.localEulerAngles
			end

			local var_122_5 = arg_119_1.actors_["1076ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.characterEffect1076ui_story == nil then
				arg_119_1.var_.characterEffect1076ui_story = var_122_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_6 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_6 and not isNil(var_122_5) then
				if arg_119_1.var_.characterEffect1076ui_story and not isNil(var_122_5) then
					arg_119_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_6)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_6 and arg_119_1.time_ < 0 + var_122_6 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.characterEffect1076ui_story then
				arg_119_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_122_7 = 0
			local var_122_8 = 0.425

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_9 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(121491029).content)

				arg_119_1.text_.text = var_122_9

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_11 = 17 <= 0 and var_122_8 or var_122_8 * (utf8.len(var_122_9) / 17)

				if (17 <= 0 and var_122_8 or var_122_8 * (utf8.len(var_122_9) / 17)) > 0 and var_122_8 < var_122_11 then
					arg_119_1.talkMaxDuration = var_122_11

					if var_122_11 + var_122_7 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_7
					end
				end

				arg_119_1.text_.text = var_122_9
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_12 = math.max(var_122_8, arg_119_1.talkMaxDuration)

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_12 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_7) / var_122_12

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_7 + var_122_12 and arg_119_1.time_ < var_122_7 + var_122_12 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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

		arg_119_1:InitPlayNodeList()
	end,
	Play121491030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 121491030
		arg_123_1.duration_ = 9

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play121491031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if arg_123_1.bgs_.ST42 == nil then
				local var_126_0 = Object.Instantiate(arg_123_1.paintGo_)

				var_126_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST42")
				var_126_0.name = "ST42"
				var_126_0.transform.parent = arg_123_1.stage_.transform
				var_126_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.bgs_.ST42 = var_126_0
			end

			if 2 < arg_123_1.time_ and arg_123_1.time_ <= 2 + arg_126_0 then
				local var_126_1 = arg_123_1.bgs_.ST42

				arg_123_1.bgs_.ST42.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_126_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_126_2 = var_126_1:GetComponent("SpriteRenderer")

				if var_126_2 and var_126_2.sprite then
					local var_126_3 = 2 * (var_126_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_126_1.transform.localScale = Vector3.New(var_126_3 / var_126_2.sprite.bounds.size.y < var_126_3 * manager.ui.mainCameraCom_.aspect / var_126_2.sprite.bounds.size.x and var_126_3 * manager.ui.mainCameraCom_.aspect / var_126_2.sprite.bounds.size.x or var_126_3 / var_126_2.sprite.bounds.size.y, var_126_3 / var_126_2.sprite.bounds.size.y < var_126_3 * manager.ui.mainCameraCom_.aspect / var_126_2.sprite.bounds.size.x and var_126_3 * manager.ui.mainCameraCom_.aspect / var_126_2.sprite.bounds.size.x or var_126_3 / var_126_2.sprite.bounds.size.y, 0)
				end

				for iter_126_0, iter_126_1 in pairs(arg_123_1.bgs_) do
					if iter_126_0 ~= "ST42" then
						iter_126_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_126_4 = 0

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_5 = 2

			if var_126_4 <= arg_123_1.time_ and arg_123_1.time_ < var_126_4 + var_126_5 then
				local var_126_6 = Color.New(0, 0, 0)

				var_126_6.a = Mathf.Lerp(0, 1, (arg_123_1.time_ - var_126_4) / var_126_5)
				arg_123_1.mask_.color = var_126_6
			end

			if arg_123_1.time_ >= var_126_4 + var_126_5 and arg_123_1.time_ < var_126_4 + var_126_5 + arg_126_0 then
				local var_126_7 = Color.New(0, 0, 0)

				var_126_7.a = 1
				arg_123_1.mask_.color = var_126_7
			end

			local var_126_8 = 2

			if 2 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_9 = 2

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_9 then
				local var_126_10 = Color.New(0, 0, 0)

				var_126_10.a = Mathf.Lerp(1, 0, (arg_123_1.time_ - var_126_8) / var_126_9)
				arg_123_1.mask_.color = var_126_10
			end

			if arg_123_1.time_ >= var_126_8 + var_126_9 and arg_123_1.time_ < var_126_8 + var_126_9 + arg_126_0 then
				local var_126_11 = Color.New(0, 0, 0)

				arg_123_1.mask_.enabled = false
				var_126_11.a = 0
				arg_123_1.mask_.color = var_126_11
			end

			if arg_123_1.frameCnt_ <= 1 then
				arg_123_1.dialog_:SetActive(false)
			end

			local var_126_12 = 3.999999999999
			local var_126_13 = 0.9

			if 3.999999999999 < arg_123_1.time_ and arg_123_1.time_ <= var_126_12 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				arg_123_1.dialog_:SetActive(true)

				arg_123_1.dialogCg_.alpha = 0

				local var_126_14 = LeanTween.value(arg_123_1.dialog_, 0, 1, 0.3)

				var_126_14:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_123_1.dialogCg_.alpha = arg_127_0
				end))
				var_126_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_123_1.dialog_)
					var_126_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_123_1.duration_ = arg_123_1.duration_ + 0.3

				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_15 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(121491030).content)

				arg_123_1.text_.text = var_126_15

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_17 = 36 <= 0 and var_126_13 or var_126_13 * (utf8.len(var_126_15) / 36)

				if (36 <= 0 and var_126_13 or var_126_13 * (utf8.len(var_126_15) / 36)) > 0 and var_126_13 < var_126_17 then
					arg_123_1.talkMaxDuration = var_126_17
					var_126_12 = var_126_12 + 0.3

					if var_126_17 + var_126_12 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_17 + var_126_12
					end
				end

				arg_123_1.text_.text = var_126_15
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_18 = var_126_12 + 0.3
			local var_126_19 = math.max(var_126_13, arg_123_1.talkMaxDuration)

			if var_126_12 + 0.3 <= arg_123_1.time_ and arg_123_1.time_ < var_126_18 + var_126_19 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_18) / var_126_19

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_18 + var_126_19 and arg_123_1.time_ < var_126_18 + var_126_19 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play121491031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 121491031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play121491032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 1.4

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(121491031).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 56 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 56)

				if (56 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 56)) > 0 and var_132_0 < var_132_3 then
					arg_129_1.talkMaxDuration = var_132_3

					if var_132_3 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_3 + 0
					end
				end

				arg_129_1.text_.text = var_132_1
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_4 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_4

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play121491032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 121491032
		arg_133_1.duration_ = 4.13

		local var_133_0 = {
			ja = 4.133,
			ko = 2.066,
			zh = 2.066
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play121491033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1072ui_story = arg_133_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1072ui_story"].transform.position).z)
				arg_133_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1072ui_story"].transform.localEulerAngles = arg_133_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_133_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1072ui_story"].transform.position).z)
				arg_133_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1072ui_story"].transform.localEulerAngles = arg_133_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1072ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1072ui_story == nil then
				arg_133_1.var_.characterEffect1072ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1072ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1072ui_story then
				arg_133_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_136_4 = arg_133_1.actors_["1076ui_story"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1076ui_story = var_136_4.localPosition
			end

			local var_136_5 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_5 then
				var_136_4.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_133_1.time_ - 0) / var_136_5)
				var_136_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_4.position).x, (manager.ui.mainCamera.transform.position - var_136_4.position).y, (manager.ui.mainCamera.transform.position - var_136_4.position).z)
				var_136_4.localEulerAngles.z = 0
				var_136_4.localEulerAngles.x = 0
				var_136_4.localEulerAngles = var_136_4.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_5 and arg_133_1.time_ < 0 + var_136_5 + arg_136_0 then
				var_136_4.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_136_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_4.position).x, (manager.ui.mainCamera.transform.position - var_136_4.position).y, (manager.ui.mainCamera.transform.position - var_136_4.position).z)
				var_136_4.localEulerAngles.z = 0
				var_136_4.localEulerAngles.x = 0
				var_136_4.localEulerAngles = var_136_4.localEulerAngles
			end

			local var_136_6 = arg_133_1.actors_["1076ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_6) and arg_133_1.var_.characterEffect1076ui_story == nil then
				arg_133_1.var_.characterEffect1076ui_story = var_136_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_7 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 and not isNil(var_136_6) then
				if arg_133_1.var_.characterEffect1076ui_story and not isNil(var_136_6) then
					arg_133_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_7)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 and not isNil(var_136_6) and arg_133_1.var_.characterEffect1076ui_story then
				arg_133_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_136_8 = 0
			local var_136_9 = 0.225

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_10 = arg_133_1:GetWordFromCfg(121491032)
				local var_136_11 = arg_133_1:FormatText(var_136_10.content)

				arg_133_1.text_.text = var_136_11

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_13 = 9 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 9)

				if (9 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 9)) > 0 and var_136_9 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_8
					end
				end

				arg_133_1.text_.text = var_136_11
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491032", "story_v_out_121491.awb") ~= 0 then
					local var_136_14 = manager.audio:GetVoiceLength("story_v_out_121491", "121491032", "story_v_out_121491.awb") / 1000

					if var_136_14 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_8
					end

					if var_136_10.prefab_name ~= "" and arg_133_1.actors_[var_136_10.prefab_name] ~= nil then
						local var_136_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_10.prefab_name].transform, "story_v_out_121491", "121491032", "story_v_out_121491.awb")

						arg_133_1:RecordAudio("121491032", var_136_15)
						arg_133_1:RecordAudio("121491032", var_136_15)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_121491", "121491032", "story_v_out_121491.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_121491", "121491032", "story_v_out_121491.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_16 = math.max(var_136_9, arg_133_1.talkMaxDuration)

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_16 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_8) / var_136_16

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_8 + var_136_16 and arg_133_1.time_ < var_136_8 + var_136_16 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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

		arg_133_1:InitPlayNodeList()
	end,
	Play121491033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 121491033
		arg_137_1.duration_ = 2.87

		local var_137_0 = {
			ja = 2.866,
			ko = 1.333,
			zh = 1.333
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play121491034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1072ui_story"]) and arg_137_1.var_.characterEffect1072ui_story == nil then
				arg_137_1.var_.characterEffect1072ui_story = arg_137_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1072ui_story"]) then
				if arg_137_1.var_.characterEffect1072ui_story and not isNil(arg_137_1.actors_["1072ui_story"]) then
					arg_137_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1072ui_story"]) and arg_137_1.var_.characterEffect1072ui_story then
				arg_137_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_140_1 = arg_137_1.actors_["1076ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1076ui_story == nil then
				arg_137_1.var_.characterEffect1076ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect1076ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1076ui_story then
				arg_137_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_140_4 = 0
			local var_140_5 = 0.125

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:GetWordFromCfg(121491033)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 5 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 5)

				if (5 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 5)) > 0 and var_140_5 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491033", "story_v_out_121491.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491033", "story_v_out_121491.awb") / 1000

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end

					if var_140_6.prefab_name ~= "" and arg_137_1.actors_[var_140_6.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_6.prefab_name].transform, "story_v_out_121491", "121491033", "story_v_out_121491.awb")

						arg_137_1:RecordAudio("121491033", var_140_11)
						arg_137_1:RecordAudio("121491033", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_121491", "121491033", "story_v_out_121491.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_121491", "121491033", "story_v_out_121491.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_12 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_12 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_12

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_12 and arg_137_1.time_ < var_140_4 + var_140_12 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play121491034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 121491034
		arg_141_1.duration_ = 5.3

		local var_141_0 = {
			ja = 5.066,
			ko = 5.3,
			zh = 5.3
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
				arg_141_0:Play121491035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1072ui_story"]) and arg_141_1.var_.characterEffect1072ui_story == nil then
				arg_141_1.var_.characterEffect1072ui_story = arg_141_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1072ui_story"]) then
				if arg_141_1.var_.characterEffect1072ui_story and not isNil(arg_141_1.actors_["1072ui_story"]) then
					arg_141_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1072ui_story"]) and arg_141_1.var_.characterEffect1072ui_story then
				arg_141_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_144_2 = arg_141_1.actors_["1076ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect1076ui_story == nil then
				arg_141_1.var_.characterEffect1076ui_story = var_144_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_3 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.characterEffect1076ui_story and not isNil(var_144_2) then
					arg_141_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_3)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect1076ui_story then
				arg_141_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_144_4 = 0
			local var_144_5 = 0.65

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(121491034)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 26 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 26)

				if (26 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 26)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491034", "story_v_out_121491.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491034", "story_v_out_121491.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_out_121491", "121491034", "story_v_out_121491.awb")

						arg_141_1:RecordAudio("121491034", var_144_11)
						arg_141_1:RecordAudio("121491034", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_121491", "121491034", "story_v_out_121491.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_121491", "121491034", "story_v_out_121491.awb")
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

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play121491035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 121491035
		arg_145_1.duration_ = 1

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play121491036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1072ui_story"]) and arg_145_1.var_.characterEffect1072ui_story == nil then
				arg_145_1.var_.characterEffect1072ui_story = arg_145_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1072ui_story"]) then
				if arg_145_1.var_.characterEffect1072ui_story and not isNil(arg_145_1.actors_["1072ui_story"]) then
					arg_145_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1072ui_story"]) and arg_145_1.var_.characterEffect1072ui_story then
				arg_145_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_148_1 = arg_145_1.actors_["1076ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1076ui_story == nil then
				arg_145_1.var_.characterEffect1076ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect1076ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1076ui_story then
				arg_145_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_148_4 = 0
			local var_148_5 = 0.05

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_6 = arg_145_1:GetWordFromCfg(121491035)
				local var_148_7 = arg_145_1:FormatText(var_148_6.content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 2 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 2)

				if (2 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 2)) > 0 and var_148_5 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_4
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491035", "story_v_out_121491.awb") ~= 0 then
					local var_148_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491035", "story_v_out_121491.awb") / 1000

					if var_148_10 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_4
					end

					if var_148_6.prefab_name ~= "" and arg_145_1.actors_[var_148_6.prefab_name] ~= nil then
						local var_148_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_6.prefab_name].transform, "story_v_out_121491", "121491035", "story_v_out_121491.awb")

						arg_145_1:RecordAudio("121491035", var_148_11)
						arg_145_1:RecordAudio("121491035", var_148_11)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_121491", "121491035", "story_v_out_121491.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_121491", "121491035", "story_v_out_121491.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_12 = math.max(var_148_5, arg_145_1.talkMaxDuration)

			if var_148_4 <= arg_145_1.time_ and arg_145_1.time_ < var_148_4 + var_148_12 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_4) / var_148_12

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_4 + var_148_12 and arg_145_1.time_ < var_148_4 + var_148_12 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play121491036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 121491036
		arg_149_1.duration_ = 10.17

		local var_149_0 = {
			ja = 10.166,
			ko = 9.966,
			zh = 9.966
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play121491037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1072ui_story = arg_149_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1072ui_story"].transform.position).z)
				arg_149_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1072ui_story"].transform.localEulerAngles = arg_149_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_149_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1072ui_story"].transform.position).z)
				arg_149_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1072ui_story"].transform.localEulerAngles = arg_149_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["1072ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1072ui_story == nil then
				arg_149_1.var_.characterEffect1072ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1072ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1072ui_story then
				arg_149_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action457")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_152_4 = arg_149_1.actors_["1076ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1076ui_story == nil then
				arg_149_1.var_.characterEffect1076ui_story = var_152_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_5 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_5 and not isNil(var_152_4) then
				if arg_149_1.var_.characterEffect1076ui_story and not isNil(var_152_4) then
					arg_149_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_5)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_5 and arg_149_1.time_ < 0 + var_152_5 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1076ui_story then
				arg_149_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_152_6 = 0
			local var_152_7 = 1.175

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_8 = arg_149_1:GetWordFromCfg(121491036)
				local var_152_9 = arg_149_1:FormatText(var_152_8.content)

				arg_149_1.text_.text = var_152_9

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 47 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 47)

				if (47 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 47)) > 0 and var_152_7 < var_152_11 then
					arg_149_1.talkMaxDuration = var_152_11

					if var_152_11 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_9
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491036", "story_v_out_121491.awb") ~= 0 then
					local var_152_12 = manager.audio:GetVoiceLength("story_v_out_121491", "121491036", "story_v_out_121491.awb") / 1000

					if var_152_12 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_12 + var_152_6
					end

					if var_152_8.prefab_name ~= "" and arg_149_1.actors_[var_152_8.prefab_name] ~= nil then
						local var_152_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_8.prefab_name].transform, "story_v_out_121491", "121491036", "story_v_out_121491.awb")

						arg_149_1:RecordAudio("121491036", var_152_13)
						arg_149_1:RecordAudio("121491036", var_152_13)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_121491", "121491036", "story_v_out_121491.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_121491", "121491036", "story_v_out_121491.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_14 = math.max(var_152_7, arg_149_1.talkMaxDuration)

			if var_152_6 <= arg_149_1.time_ and arg_149_1.time_ < var_152_6 + var_152_14 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_6) / var_152_14

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_6 + var_152_14 and arg_149_1.time_ < var_152_6 + var_152_14 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
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

		arg_149_1:InitPlayNodeList()
	end,
	Play121491037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 121491037
		arg_153_1.duration_ = 4.43

		local var_153_0 = {
			ja = 3.4,
			ko = 4.433,
			zh = 4.433
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play121491038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_2")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_156_0 = 0
			local var_156_1 = 0.55

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_2 = arg_153_1:GetWordFromCfg(121491037)
				local var_156_3 = arg_153_1:FormatText(var_156_2.content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 22 <= 0 and var_156_1 or var_156_1 * (utf8.len(var_156_3) / 22)

				if (22 <= 0 and var_156_1 or var_156_1 * (utf8.len(var_156_3) / 22)) > 0 and var_156_1 < var_156_5 then
					arg_153_1.talkMaxDuration = var_156_5

					if var_156_5 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491037", "story_v_out_121491.awb") ~= 0 then
					local var_156_6 = manager.audio:GetVoiceLength("story_v_out_121491", "121491037", "story_v_out_121491.awb") / 1000

					if var_156_6 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_0
					end

					if var_156_2.prefab_name ~= "" and arg_153_1.actors_[var_156_2.prefab_name] ~= nil then
						local var_156_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_2.prefab_name].transform, "story_v_out_121491", "121491037", "story_v_out_121491.awb")

						arg_153_1:RecordAudio("121491037", var_156_7)
						arg_153_1:RecordAudio("121491037", var_156_7)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_121491", "121491037", "story_v_out_121491.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_121491", "121491037", "story_v_out_121491.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_8 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_8 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_8

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_8 and arg_153_1.time_ < var_156_0 + var_156_8 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play121491038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 121491038
		arg_157_1.duration_ = 10.8

		local var_157_0 = {
			ja = 10.8,
			ko = 3.2,
			zh = 3.2
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
				arg_157_0:Play121491039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1072ui_story"]) and arg_157_1.var_.characterEffect1072ui_story == nil then
				arg_157_1.var_.characterEffect1072ui_story = arg_157_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1072ui_story"]) then
				if arg_157_1.var_.characterEffect1072ui_story and not isNil(arg_157_1.actors_["1072ui_story"]) then
					arg_157_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_0)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1072ui_story"]) and arg_157_1.var_.characterEffect1072ui_story then
				arg_157_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_160_1 = arg_157_1.actors_["1076ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1076ui_story == nil then
				arg_157_1.var_.characterEffect1076ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect1076ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1076ui_story then
				arg_157_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_160_4 = 0
			local var_160_5 = 0.375

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(121491038)
				local var_160_7 = arg_157_1:FormatText(var_160_6.content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_9 = 15 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 15)

				if (15 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 15)) > 0 and var_160_5 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491038", "story_v_out_121491.awb") ~= 0 then
					local var_160_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491038", "story_v_out_121491.awb") / 1000

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end

					if var_160_6.prefab_name ~= "" and arg_157_1.actors_[var_160_6.prefab_name] ~= nil then
						local var_160_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_6.prefab_name].transform, "story_v_out_121491", "121491038", "story_v_out_121491.awb")

						arg_157_1:RecordAudio("121491038", var_160_11)
						arg_157_1:RecordAudio("121491038", var_160_11)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_121491", "121491038", "story_v_out_121491.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_121491", "121491038", "story_v_out_121491.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_12 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_12 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_12

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_12 and arg_157_1.time_ < var_160_4 + var_160_12 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play121491039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 121491039
		arg_161_1.duration_ = 4.83

		local var_161_0 = {
			ja = 4.833,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_161_0:Play121491040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["1072ui_story"]) and arg_161_1.var_.characterEffect1072ui_story == nil then
				arg_161_1.var_.characterEffect1072ui_story = arg_161_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_0 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["1072ui_story"]) then
				if arg_161_1.var_.characterEffect1072ui_story and not isNil(arg_161_1.actors_["1072ui_story"]) then
					arg_161_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["1072ui_story"]) and arg_161_1.var_.characterEffect1072ui_story then
				arg_161_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_164_2 = arg_161_1.actors_["1076ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.characterEffect1076ui_story == nil then
				arg_161_1.var_.characterEffect1076ui_story = var_164_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_3 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_3 and not isNil(var_164_2) then
				if arg_161_1.var_.characterEffect1076ui_story and not isNil(var_164_2) then
					arg_161_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_3)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_3 and arg_161_1.time_ < 0 + var_164_3 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.characterEffect1076ui_story then
				arg_161_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_164_4 = 0
			local var_164_5 = 0.175

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_6 = arg_161_1:GetWordFromCfg(121491039)
				local var_164_7 = arg_161_1:FormatText(var_164_6.content)

				arg_161_1.text_.text = var_164_7

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 7 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 7)

				if (7 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 7)) > 0 and var_164_5 < var_164_9 then
					arg_161_1.talkMaxDuration = var_164_9

					if var_164_9 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_7
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491039", "story_v_out_121491.awb") ~= 0 then
					local var_164_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491039", "story_v_out_121491.awb") / 1000

					if var_164_10 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_4
					end

					if var_164_6.prefab_name ~= "" and arg_161_1.actors_[var_164_6.prefab_name] ~= nil then
						local var_164_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_6.prefab_name].transform, "story_v_out_121491", "121491039", "story_v_out_121491.awb")

						arg_161_1:RecordAudio("121491039", var_164_11)
						arg_161_1:RecordAudio("121491039", var_164_11)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_121491", "121491039", "story_v_out_121491.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_121491", "121491039", "story_v_out_121491.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_12 = math.max(var_164_5, arg_161_1.talkMaxDuration)

			if var_164_4 <= arg_161_1.time_ and arg_161_1.time_ < var_164_4 + var_164_12 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_4) / var_164_12

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_4 + var_164_12 and arg_161_1.time_ < var_164_4 + var_164_12 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play121491040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 121491040
		arg_165_1.duration_ = 7.67

		local var_165_0 = {
			ja = 7.666,
			ko = 3.933,
			zh = 3.933
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
				arg_165_0:Play121491041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1072ui_story"]) and arg_165_1.var_.characterEffect1072ui_story == nil then
				arg_165_1.var_.characterEffect1072ui_story = arg_165_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1072ui_story"]) then
				if arg_165_1.var_.characterEffect1072ui_story and not isNil(arg_165_1.actors_["1072ui_story"]) then
					arg_165_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1072ui_story"]) and arg_165_1.var_.characterEffect1072ui_story then
				arg_165_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_168_1 = arg_165_1.actors_["1076ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1076ui_story == nil then
				arg_165_1.var_.characterEffect1076ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1076ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1076ui_story then
				arg_165_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_168_4 = 0
			local var_168_5 = 0.425

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(121491040)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 17 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 17)

				if (17 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 17)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491040", "story_v_out_121491.awb") ~= 0 then
					local var_168_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491040", "story_v_out_121491.awb") / 1000

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end

					if var_168_6.prefab_name ~= "" and arg_165_1.actors_[var_168_6.prefab_name] ~= nil then
						local var_168_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_6.prefab_name].transform, "story_v_out_121491", "121491040", "story_v_out_121491.awb")

						arg_165_1:RecordAudio("121491040", var_168_11)
						arg_165_1:RecordAudio("121491040", var_168_11)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_121491", "121491040", "story_v_out_121491.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_121491", "121491040", "story_v_out_121491.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_12 = math.max(var_168_5, arg_165_1.talkMaxDuration)

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_12 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_4) / var_168_12

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_4 + var_168_12 and arg_165_1.time_ < var_168_4 + var_168_12 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play121491041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 121491041
		arg_169_1.duration_ = 8.13

		local var_169_0 = {
			ja = 7.333,
			ko = 8.133,
			zh = 8.133
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
				arg_169_0:Play121491042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1072ui_story"]) and arg_169_1.var_.characterEffect1072ui_story == nil then
				arg_169_1.var_.characterEffect1072ui_story = arg_169_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1072ui_story"]) then
				if arg_169_1.var_.characterEffect1072ui_story and not isNil(arg_169_1.actors_["1072ui_story"]) then
					arg_169_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1072ui_story"]) and arg_169_1.var_.characterEffect1072ui_story then
				arg_169_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_172_2 = arg_169_1.actors_["1076ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.characterEffect1076ui_story == nil then
				arg_169_1.var_.characterEffect1076ui_story = var_172_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_3 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_3 and not isNil(var_172_2) then
				if arg_169_1.var_.characterEffect1076ui_story and not isNil(var_172_2) then
					arg_169_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_3)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.characterEffect1076ui_story then
				arg_169_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_172_4 = 0
			local var_172_5 = 0.95

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(121491041)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 38 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 38)

				if (38 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 38)) > 0 and var_172_5 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491041", "story_v_out_121491.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491041", "story_v_out_121491.awb") / 1000

					if var_172_10 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_4
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_out_121491", "121491041", "story_v_out_121491.awb")

						arg_169_1:RecordAudio("121491041", var_172_11)
						arg_169_1:RecordAudio("121491041", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_121491", "121491041", "story_v_out_121491.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_121491", "121491041", "story_v_out_121491.awb")
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
	Play121491042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 121491042
		arg_173_1.duration_ = 3.67

		local var_173_0 = {
			ja = 3.666,
			ko = 1.933,
			zh = 1.933
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play121491043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1072ui_story"]) and arg_173_1.var_.characterEffect1072ui_story == nil then
				arg_173_1.var_.characterEffect1072ui_story = arg_173_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1072ui_story"]) then
				if arg_173_1.var_.characterEffect1072ui_story and not isNil(arg_173_1.actors_["1072ui_story"]) then
					arg_173_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_0)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1072ui_story"]) and arg_173_1.var_.characterEffect1072ui_story then
				arg_173_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_176_1 = arg_173_1.actors_["1076ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1076ui_story == nil then
				arg_173_1.var_.characterEffect1076ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1076ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1076ui_story then
				arg_173_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_176_4 = 0
			local var_176_5 = 0.25

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(121491042)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 10 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 10)

				if (10 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 10)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491042", "story_v_out_121491.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491042", "story_v_out_121491.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_121491", "121491042", "story_v_out_121491.awb")

						arg_173_1:RecordAudio("121491042", var_176_11)
						arg_173_1:RecordAudio("121491042", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_121491", "121491042", "story_v_out_121491.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_121491", "121491042", "story_v_out_121491.awb")
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
	Play121491043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 121491043
		arg_177_1.duration_ = 6.3

		local var_177_0 = {
			ja = 6.3,
			ko = 3.033,
			zh = 3.033
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
				arg_177_0:Play121491044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1072ui_story"]) and arg_177_1.var_.characterEffect1072ui_story == nil then
				arg_177_1.var_.characterEffect1072ui_story = arg_177_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1072ui_story"]) then
				if arg_177_1.var_.characterEffect1072ui_story and not isNil(arg_177_1.actors_["1072ui_story"]) then
					arg_177_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1072ui_story"]) and arg_177_1.var_.characterEffect1072ui_story then
				arg_177_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_180_2 = arg_177_1.actors_["1076ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect1076ui_story == nil then
				arg_177_1.var_.characterEffect1076ui_story = var_180_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_3 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.characterEffect1076ui_story and not isNil(var_180_2) then
					arg_177_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_3)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect1076ui_story then
				arg_177_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_180_4 = 0
			local var_180_5 = 0.225

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(121491043)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 9 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 9)

				if (9 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 9)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491043", "story_v_out_121491.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491043", "story_v_out_121491.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_out_121491", "121491043", "story_v_out_121491.awb")

						arg_177_1:RecordAudio("121491043", var_180_11)
						arg_177_1:RecordAudio("121491043", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_121491", "121491043", "story_v_out_121491.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_121491", "121491043", "story_v_out_121491.awb")
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
	Play121491044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 121491044
		arg_181_1.duration_ = 11.93

		local var_181_0 = {
			ja = 11.933,
			ko = 9.433,
			zh = 9.433
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
				arg_181_0:Play121491045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_2")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_184_0 = 0
			local var_184_1 = 1.1

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_2 = arg_181_1:GetWordFromCfg(121491044)
				local var_184_3 = arg_181_1:FormatText(var_184_2.content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 46 <= 0 and var_184_1 or var_184_1 * (utf8.len(var_184_3) / 46)

				if (46 <= 0 and var_184_1 or var_184_1 * (utf8.len(var_184_3) / 46)) > 0 and var_184_1 < var_184_5 then
					arg_181_1.talkMaxDuration = var_184_5

					if var_184_5 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491044", "story_v_out_121491.awb") ~= 0 then
					local var_184_6 = manager.audio:GetVoiceLength("story_v_out_121491", "121491044", "story_v_out_121491.awb") / 1000

					if var_184_6 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_6 + var_184_0
					end

					if var_184_2.prefab_name ~= "" and arg_181_1.actors_[var_184_2.prefab_name] ~= nil then
						local var_184_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_2.prefab_name].transform, "story_v_out_121491", "121491044", "story_v_out_121491.awb")

						arg_181_1:RecordAudio("121491044", var_184_7)
						arg_181_1:RecordAudio("121491044", var_184_7)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_121491", "121491044", "story_v_out_121491.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_121491", "121491044", "story_v_out_121491.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_8 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_8 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_8

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_8 and arg_181_1.time_ < var_184_0 + var_184_8 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play121491045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 121491045
		arg_185_1.duration_ = 10.97

		local var_185_0 = {
			ja = 10.966,
			ko = 4.333,
			zh = 4.333
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
				arg_185_0:Play121491046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.5

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:GetWordFromCfg(121491045)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 20 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 20)

				if (20 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 20)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491045", "story_v_out_121491.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_121491", "121491045", "story_v_out_121491.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_121491", "121491045", "story_v_out_121491.awb")

						arg_185_1:RecordAudio("121491045", var_188_6)
						arg_185_1:RecordAudio("121491045", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_121491", "121491045", "story_v_out_121491.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_121491", "121491045", "story_v_out_121491.awb")
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
	Play121491046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 121491046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play121491047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1072ui_story = arg_189_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1072ui_story"].transform.position).z)
				arg_189_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1072ui_story"].transform.localEulerAngles = arg_189_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1072ui_story"].transform.position).z)
				arg_189_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1072ui_story"].transform.localEulerAngles = arg_189_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_192_1 = arg_189_1.actors_["1072ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1072ui_story == nil then
				arg_189_1.var_.characterEffect1072ui_story = var_192_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 and not isNil(var_192_1) then
				if arg_189_1.var_.characterEffect1072ui_story and not isNil(var_192_1) then
					arg_189_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_2)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1072ui_story then
				arg_189_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_192_3 = arg_189_1.actors_["1076ui_story"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1076ui_story = var_192_3.localPosition
			end

			local var_192_4 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				var_192_3.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 0) / var_192_4)
				var_192_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_3.position).x, (manager.ui.mainCamera.transform.position - var_192_3.position).y, (manager.ui.mainCamera.transform.position - var_192_3.position).z)
				var_192_3.localEulerAngles.z = 0
				var_192_3.localEulerAngles.x = 0
				var_192_3.localEulerAngles = var_192_3.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				var_192_3.localPosition = Vector3.New(0, 100, 0)
				var_192_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_3.position).x, (manager.ui.mainCamera.transform.position - var_192_3.position).y, (manager.ui.mainCamera.transform.position - var_192_3.position).z)
				var_192_3.localEulerAngles.z = 0
				var_192_3.localEulerAngles.x = 0
				var_192_3.localEulerAngles = var_192_3.localEulerAngles
			end

			local var_192_5 = arg_189_1.actors_["1076ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.characterEffect1076ui_story == nil then
				arg_189_1.var_.characterEffect1076ui_story = var_192_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_6 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_6 and not isNil(var_192_5) then
				if arg_189_1.var_.characterEffect1076ui_story and not isNil(var_192_5) then
					arg_189_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_6)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_6 and arg_189_1.time_ < 0 + var_192_6 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.characterEffect1076ui_story then
				arg_189_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_192_7 = 0
			local var_192_8 = 1.575

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_7 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_9 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(121491046).content)

				arg_189_1.text_.text = var_192_9

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_11 = 63 <= 0 and var_192_8 or var_192_8 * (utf8.len(var_192_9) / 63)

				if (63 <= 0 and var_192_8 or var_192_8 * (utf8.len(var_192_9) / 63)) > 0 and var_192_8 < var_192_11 then
					arg_189_1.talkMaxDuration = var_192_11

					if var_192_11 + var_192_7 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_11 + var_192_7
					end
				end

				arg_189_1.text_.text = var_192_9
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_12 = math.max(var_192_8, arg_189_1.talkMaxDuration)

			if var_192_7 <= arg_189_1.time_ and arg_189_1.time_ < var_192_7 + var_192_12 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_7) / var_192_12

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_7 + var_192_12 and arg_189_1.time_ < var_192_7 + var_192_12 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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

		arg_189_1:InitPlayNodeList()
	end,
	Play121491047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 121491047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play121491048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.775

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(121491047).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 31 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 31)

				if (31 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 31)) > 0 and var_196_0 < var_196_3 then
					arg_193_1.talkMaxDuration = var_196_3

					if var_196_3 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_3 + 0
					end
				end

				arg_193_1.text_.text = var_196_1
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_4 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_4

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play121491048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 121491048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play121491049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 1.075

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(121491048).content)

				arg_197_1.text_.text = var_200_1

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_3 = 43 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 43)

				if (43 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 43)) > 0 and var_200_0 < var_200_3 then
					arg_197_1.talkMaxDuration = var_200_3

					if var_200_3 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_3 + 0
					end
				end

				arg_197_1.text_.text = var_200_1
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_4 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_4

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play121491049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 121491049
		arg_201_1.duration_ = 4.37

		local var_201_0 = {
			ja = 3.866,
			ko = 4.366,
			zh = 4.366
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
				arg_201_0:Play121491050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1072ui_story = arg_201_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1072ui_story"].transform.position).z)
				arg_201_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1072ui_story"].transform.localEulerAngles = arg_201_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_201_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1072ui_story"].transform.position).z)
				arg_201_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1072ui_story"].transform.localEulerAngles = arg_201_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["1072ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1072ui_story == nil then
				arg_201_1.var_.characterEffect1072ui_story = var_204_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 and not isNil(var_204_1) then
				if arg_201_1.var_.characterEffect1072ui_story and not isNil(var_204_1) then
					arg_201_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1072ui_story then
				arg_201_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_204_4 = arg_201_1.actors_["1076ui_story"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1076ui_story = var_204_4.localPosition
			end

			local var_204_5 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_5 then
				var_204_4.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_201_1.time_ - 0) / var_204_5)
				var_204_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_4.position).x, (manager.ui.mainCamera.transform.position - var_204_4.position).y, (manager.ui.mainCamera.transform.position - var_204_4.position).z)
				var_204_4.localEulerAngles.z = 0
				var_204_4.localEulerAngles.x = 0
				var_204_4.localEulerAngles = var_204_4.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_5 and arg_201_1.time_ < 0 + var_204_5 + arg_204_0 then
				var_204_4.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_204_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_4.position).x, (manager.ui.mainCamera.transform.position - var_204_4.position).y, (manager.ui.mainCamera.transform.position - var_204_4.position).z)
				var_204_4.localEulerAngles.z = 0
				var_204_4.localEulerAngles.x = 0
				var_204_4.localEulerAngles = var_204_4.localEulerAngles
			end

			local var_204_6 = arg_201_1.actors_["1076ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_6) and arg_201_1.var_.characterEffect1076ui_story == nil then
				arg_201_1.var_.characterEffect1076ui_story = var_204_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_7 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 and not isNil(var_204_6) then
				if arg_201_1.var_.characterEffect1076ui_story and not isNil(var_204_6) then
					arg_201_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_7)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 and not isNil(var_204_6) and arg_201_1.var_.characterEffect1076ui_story then
				arg_201_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_204_8 = 0
			local var_204_9 = 0.475

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_8 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_10 = arg_201_1:GetWordFromCfg(121491049)
				local var_204_11 = arg_201_1:FormatText(var_204_10.content)

				arg_201_1.text_.text = var_204_11

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_13 = 19 <= 0 and var_204_9 or var_204_9 * (utf8.len(var_204_11) / 19)

				if (19 <= 0 and var_204_9 or var_204_9 * (utf8.len(var_204_11) / 19)) > 0 and var_204_9 < var_204_13 then
					arg_201_1.talkMaxDuration = var_204_13

					if var_204_13 + var_204_8 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_8
					end
				end

				arg_201_1.text_.text = var_204_11
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491049", "story_v_out_121491.awb") ~= 0 then
					local var_204_14 = manager.audio:GetVoiceLength("story_v_out_121491", "121491049", "story_v_out_121491.awb") / 1000

					if var_204_14 + var_204_8 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_14 + var_204_8
					end

					if var_204_10.prefab_name ~= "" and arg_201_1.actors_[var_204_10.prefab_name] ~= nil then
						local var_204_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_10.prefab_name].transform, "story_v_out_121491", "121491049", "story_v_out_121491.awb")

						arg_201_1:RecordAudio("121491049", var_204_15)
						arg_201_1:RecordAudio("121491049", var_204_15)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_121491", "121491049", "story_v_out_121491.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_121491", "121491049", "story_v_out_121491.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_16 = math.max(var_204_9, arg_201_1.talkMaxDuration)

			if var_204_8 <= arg_201_1.time_ and arg_201_1.time_ < var_204_8 + var_204_16 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_8) / var_204_16

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_8 + var_204_16 and arg_201_1.time_ < var_204_8 + var_204_16 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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

		arg_201_1:InitPlayNodeList()
	end,
	Play121491050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 121491050
		arg_205_1.duration_ = 6.8

		local var_205_0 = {
			ja = 3.2,
			ko = 6.8,
			zh = 6.8
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play121491051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_208_0 = 0
			local var_208_1 = 0.5

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_2 = arg_205_1:GetWordFromCfg(121491050)
				local var_208_3 = arg_205_1:FormatText(var_208_2.content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 20 <= 0 and var_208_1 or var_208_1 * (utf8.len(var_208_3) / 20)

				if (20 <= 0 and var_208_1 or var_208_1 * (utf8.len(var_208_3) / 20)) > 0 and var_208_1 < var_208_5 then
					arg_205_1.talkMaxDuration = var_208_5

					if var_208_5 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491050", "story_v_out_121491.awb") ~= 0 then
					local var_208_6 = manager.audio:GetVoiceLength("story_v_out_121491", "121491050", "story_v_out_121491.awb") / 1000

					if var_208_6 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_6 + var_208_0
					end

					if var_208_2.prefab_name ~= "" and arg_205_1.actors_[var_208_2.prefab_name] ~= nil then
						local var_208_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_2.prefab_name].transform, "story_v_out_121491", "121491050", "story_v_out_121491.awb")

						arg_205_1:RecordAudio("121491050", var_208_7)
						arg_205_1:RecordAudio("121491050", var_208_7)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_121491", "121491050", "story_v_out_121491.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_121491", "121491050", "story_v_out_121491.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_8 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_8 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_8

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_8 and arg_205_1.time_ < var_208_0 + var_208_8 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play121491051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 121491051
		arg_209_1.duration_ = 2.27

		local var_209_0 = {
			ja = 2.266,
			ko = 1.666,
			zh = 1.666
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
				arg_209_0:Play121491052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1072ui_story"]) and arg_209_1.var_.characterEffect1072ui_story == nil then
				arg_209_1.var_.characterEffect1072ui_story = arg_209_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1072ui_story"]) then
				if arg_209_1.var_.characterEffect1072ui_story and not isNil(arg_209_1.actors_["1072ui_story"]) then
					arg_209_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_0)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1072ui_story"]) and arg_209_1.var_.characterEffect1072ui_story then
				arg_209_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_212_1 = arg_209_1.actors_["1076ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1076ui_story == nil then
				arg_209_1.var_.characterEffect1076ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect1076ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1076ui_story then
				arg_209_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_212_4 = 0
			local var_212_5 = 0.225

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_6 = arg_209_1:GetWordFromCfg(121491051)
				local var_212_7 = arg_209_1:FormatText(var_212_6.content)

				arg_209_1.text_.text = var_212_7

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_9 = 9 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 9)

				if (9 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 9)) > 0 and var_212_5 < var_212_9 then
					arg_209_1.talkMaxDuration = var_212_9

					if var_212_9 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_9 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_7
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491051", "story_v_out_121491.awb") ~= 0 then
					local var_212_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491051", "story_v_out_121491.awb") / 1000

					if var_212_10 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_4
					end

					if var_212_6.prefab_name ~= "" and arg_209_1.actors_[var_212_6.prefab_name] ~= nil then
						local var_212_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_6.prefab_name].transform, "story_v_out_121491", "121491051", "story_v_out_121491.awb")

						arg_209_1:RecordAudio("121491051", var_212_11)
						arg_209_1:RecordAudio("121491051", var_212_11)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_121491", "121491051", "story_v_out_121491.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_121491", "121491051", "story_v_out_121491.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_12 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_12 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_12

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_12 and arg_209_1.time_ < var_212_4 + var_212_12 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play121491052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 121491052
		arg_213_1.duration_ = 6.93

		local var_213_0 = {
			ja = 6.933,
			ko = 4.433,
			zh = 4.433
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
				arg_213_0:Play121491053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["1072ui_story"]) and arg_213_1.var_.characterEffect1072ui_story == nil then
				arg_213_1.var_.characterEffect1072ui_story = arg_213_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["1072ui_story"]) then
				if arg_213_1.var_.characterEffect1072ui_story and not isNil(arg_213_1.actors_["1072ui_story"]) then
					arg_213_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["1072ui_story"]) and arg_213_1.var_.characterEffect1072ui_story then
				arg_213_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action454")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_216_2 = arg_213_1.actors_["1076ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.characterEffect1076ui_story == nil then
				arg_213_1.var_.characterEffect1076ui_story = var_216_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_3 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_3 and not isNil(var_216_2) then
				if arg_213_1.var_.characterEffect1076ui_story and not isNil(var_216_2) then
					arg_213_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_3)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_3 and arg_213_1.time_ < 0 + var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.characterEffect1076ui_story then
				arg_213_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_216_4 = 0
			local var_216_5 = 0.475

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_6 = arg_213_1:GetWordFromCfg(121491052)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 19 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 19)

				if (19 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 19)) > 0 and var_216_5 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491052", "story_v_out_121491.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491052", "story_v_out_121491.awb") / 1000

					if var_216_10 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_4
					end

					if var_216_6.prefab_name ~= "" and arg_213_1.actors_[var_216_6.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_6.prefab_name].transform, "story_v_out_121491", "121491052", "story_v_out_121491.awb")

						arg_213_1:RecordAudio("121491052", var_216_11)
						arg_213_1:RecordAudio("121491052", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_121491", "121491052", "story_v_out_121491.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_121491", "121491052", "story_v_out_121491.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_12 and arg_213_1.time_ < var_216_4 + var_216_12 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play121491053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 121491053
		arg_217_1.duration_ = 9.8

		local var_217_0 = {
			ja = 9.8,
			ko = 9.7,
			zh = 9.7
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play121491054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_2")
			end

			local var_220_0 = 0
			local var_220_1 = 1

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_2 = arg_217_1:GetWordFromCfg(121491053)
				local var_220_3 = arg_217_1:FormatText(var_220_2.content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 40 <= 0 and var_220_1 or var_220_1 * (utf8.len(var_220_3) / 40)

				if (40 <= 0 and var_220_1 or var_220_1 * (utf8.len(var_220_3) / 40)) > 0 and var_220_1 < var_220_5 then
					arg_217_1.talkMaxDuration = var_220_5

					if var_220_5 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491053", "story_v_out_121491.awb") ~= 0 then
					local var_220_6 = manager.audio:GetVoiceLength("story_v_out_121491", "121491053", "story_v_out_121491.awb") / 1000

					if var_220_6 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_6 + var_220_0
					end

					if var_220_2.prefab_name ~= "" and arg_217_1.actors_[var_220_2.prefab_name] ~= nil then
						local var_220_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_2.prefab_name].transform, "story_v_out_121491", "121491053", "story_v_out_121491.awb")

						arg_217_1:RecordAudio("121491053", var_220_7)
						arg_217_1:RecordAudio("121491053", var_220_7)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_121491", "121491053", "story_v_out_121491.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_121491", "121491053", "story_v_out_121491.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_8 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_8 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_8

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_8 and arg_217_1.time_ < var_220_0 + var_220_8 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play121491054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 121491054
		arg_221_1.duration_ = 2.2

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play121491055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1076ui_story"]) and arg_221_1.var_.characterEffect1076ui_story == nil then
				arg_221_1.var_.characterEffect1076ui_story = arg_221_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1076ui_story"]) then
				if arg_221_1.var_.characterEffect1076ui_story and not isNil(arg_221_1.actors_["1076ui_story"]) then
					arg_221_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1076ui_story"]) and arg_221_1.var_.characterEffect1076ui_story then
				arg_221_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_224_2 = arg_221_1.actors_["1072ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.characterEffect1072ui_story == nil then
				arg_221_1.var_.characterEffect1072ui_story = var_224_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_3 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_3 and not isNil(var_224_2) then
				if arg_221_1.var_.characterEffect1072ui_story and not isNil(var_224_2) then
					arg_221_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_3)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_3 and arg_221_1.time_ < 0 + var_224_3 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.characterEffect1072ui_story then
				arg_221_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_224_4 = 0
			local var_224_5 = 0.1

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_6 = arg_221_1:GetWordFromCfg(121491054)
				local var_224_7 = arg_221_1:FormatText(var_224_6.content)

				arg_221_1.text_.text = var_224_7

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_9 = 4 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 4)

				if (4 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 4)) > 0 and var_224_5 < var_224_9 then
					arg_221_1.talkMaxDuration = var_224_9

					if var_224_9 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_9 + var_224_4
					end
				end

				arg_221_1.text_.text = var_224_7
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491054", "story_v_out_121491.awb") ~= 0 then
					local var_224_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491054", "story_v_out_121491.awb") / 1000

					if var_224_10 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_4
					end

					if var_224_6.prefab_name ~= "" and arg_221_1.actors_[var_224_6.prefab_name] ~= nil then
						local var_224_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_6.prefab_name].transform, "story_v_out_121491", "121491054", "story_v_out_121491.awb")

						arg_221_1:RecordAudio("121491054", var_224_11)
						arg_221_1:RecordAudio("121491054", var_224_11)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_121491", "121491054", "story_v_out_121491.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_121491", "121491054", "story_v_out_121491.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_12 = math.max(var_224_5, arg_221_1.talkMaxDuration)

			if var_224_4 <= arg_221_1.time_ and arg_221_1.time_ < var_224_4 + var_224_12 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_4) / var_224_12

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_4 + var_224_12 and arg_221_1.time_ < var_224_4 + var_224_12 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play121491055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 121491055
		arg_225_1.duration_ = 4.47

		local var_225_0 = {
			ja = 4.466,
			ko = 3.7,
			zh = 3.7
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
				arg_225_0:Play121491056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1072ui_story"]) and arg_225_1.var_.characterEffect1072ui_story == nil then
				arg_225_1.var_.characterEffect1072ui_story = arg_225_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1072ui_story"]) then
				if arg_225_1.var_.characterEffect1072ui_story and not isNil(arg_225_1.actors_["1072ui_story"]) then
					arg_225_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1072ui_story"]) and arg_225_1.var_.characterEffect1072ui_story then
				arg_225_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_228_2 = arg_225_1.actors_["1076ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_2) and arg_225_1.var_.characterEffect1076ui_story == nil then
				arg_225_1.var_.characterEffect1076ui_story = var_228_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_3 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_3 and not isNil(var_228_2) then
				if arg_225_1.var_.characterEffect1076ui_story and not isNil(var_228_2) then
					arg_225_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_3)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_3 and arg_225_1.time_ < 0 + var_228_3 + arg_228_0 and not isNil(var_228_2) and arg_225_1.var_.characterEffect1076ui_story then
				arg_225_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_228_4 = 0
			local var_228_5 = 0.375

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_6 = arg_225_1:GetWordFromCfg(121491055)
				local var_228_7 = arg_225_1:FormatText(var_228_6.content)

				arg_225_1.text_.text = var_228_7

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_9 = 15 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 15)

				if (15 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 15)) > 0 and var_228_5 < var_228_9 then
					arg_225_1.talkMaxDuration = var_228_9

					if var_228_9 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_9 + var_228_4
					end
				end

				arg_225_1.text_.text = var_228_7
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491055", "story_v_out_121491.awb") ~= 0 then
					local var_228_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491055", "story_v_out_121491.awb") / 1000

					if var_228_10 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_4
					end

					if var_228_6.prefab_name ~= "" and arg_225_1.actors_[var_228_6.prefab_name] ~= nil then
						local var_228_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_6.prefab_name].transform, "story_v_out_121491", "121491055", "story_v_out_121491.awb")

						arg_225_1:RecordAudio("121491055", var_228_11)
						arg_225_1:RecordAudio("121491055", var_228_11)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_121491", "121491055", "story_v_out_121491.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_121491", "121491055", "story_v_out_121491.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_12 = math.max(var_228_5, arg_225_1.talkMaxDuration)

			if var_228_4 <= arg_225_1.time_ and arg_225_1.time_ < var_228_4 + var_228_12 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_4) / var_228_12

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_4 + var_228_12 and arg_225_1.time_ < var_228_4 + var_228_12 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play121491056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 121491056
		arg_229_1.duration_ = 7.37

		local var_229_0 = {
			ja = 7.366,
			ko = 3.466,
			zh = 3.466
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
				arg_229_0:Play121491057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1072ui_story"]) and arg_229_1.var_.characterEffect1072ui_story == nil then
				arg_229_1.var_.characterEffect1072ui_story = arg_229_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1072ui_story"]) then
				if arg_229_1.var_.characterEffect1072ui_story and not isNil(arg_229_1.actors_["1072ui_story"]) then
					arg_229_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_0)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1072ui_story"]) and arg_229_1.var_.characterEffect1072ui_story then
				arg_229_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_232_1 = arg_229_1.actors_["1076ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1076ui_story == nil then
				arg_229_1.var_.characterEffect1076ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 and not isNil(var_232_1) then
				if arg_229_1.var_.characterEffect1076ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1076ui_story then
				arg_229_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_232_4 = 0
			local var_232_5 = 0.325

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_6 = arg_229_1:GetWordFromCfg(121491056)
				local var_232_7 = arg_229_1:FormatText(var_232_6.content)

				arg_229_1.text_.text = var_232_7

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_9 = 13 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 13)

				if (13 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 13)) > 0 and var_232_5 < var_232_9 then
					arg_229_1.talkMaxDuration = var_232_9

					if var_232_9 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_7
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491056", "story_v_out_121491.awb") ~= 0 then
					local var_232_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491056", "story_v_out_121491.awb") / 1000

					if var_232_10 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_4
					end

					if var_232_6.prefab_name ~= "" and arg_229_1.actors_[var_232_6.prefab_name] ~= nil then
						local var_232_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_6.prefab_name].transform, "story_v_out_121491", "121491056", "story_v_out_121491.awb")

						arg_229_1:RecordAudio("121491056", var_232_11)
						arg_229_1:RecordAudio("121491056", var_232_11)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_121491", "121491056", "story_v_out_121491.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_121491", "121491056", "story_v_out_121491.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_12 = math.max(var_232_5, arg_229_1.talkMaxDuration)

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_12 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_4) / var_232_12

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_4 + var_232_12 and arg_229_1.time_ < var_232_4 + var_232_12 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play121491057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 121491057
		arg_233_1.duration_ = 2.43

		local var_233_0 = {
			ja = 2.266,
			ko = 2.433,
			zh = 2.433
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
				arg_233_0:Play121491058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1072ui_story"]) and arg_233_1.var_.characterEffect1072ui_story == nil then
				arg_233_1.var_.characterEffect1072ui_story = arg_233_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1072ui_story"]) then
				if arg_233_1.var_.characterEffect1072ui_story and not isNil(arg_233_1.actors_["1072ui_story"]) then
					arg_233_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1072ui_story"]) and arg_233_1.var_.characterEffect1072ui_story then
				arg_233_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_236_2 = arg_233_1.actors_["1076ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.characterEffect1076ui_story == nil then
				arg_233_1.var_.characterEffect1076ui_story = var_236_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_3 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_3 and not isNil(var_236_2) then
				if arg_233_1.var_.characterEffect1076ui_story and not isNil(var_236_2) then
					arg_233_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_3)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_3 and arg_233_1.time_ < 0 + var_236_3 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.characterEffect1076ui_story then
				arg_233_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_236_4 = 0
			local var_236_5 = 0.1

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:GetWordFromCfg(121491057)
				local var_236_7 = arg_233_1:FormatText(var_236_6.content)

				arg_233_1.text_.text = var_236_7

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_9 = 4 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 4)

				if (4 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 4)) > 0 and var_236_5 < var_236_9 then
					arg_233_1.talkMaxDuration = var_236_9

					if var_236_9 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_9 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_7
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491057", "story_v_out_121491.awb") ~= 0 then
					local var_236_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491057", "story_v_out_121491.awb") / 1000

					if var_236_10 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_4
					end

					if var_236_6.prefab_name ~= "" and arg_233_1.actors_[var_236_6.prefab_name] ~= nil then
						local var_236_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_6.prefab_name].transform, "story_v_out_121491", "121491057", "story_v_out_121491.awb")

						arg_233_1:RecordAudio("121491057", var_236_11)
						arg_233_1:RecordAudio("121491057", var_236_11)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_121491", "121491057", "story_v_out_121491.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_121491", "121491057", "story_v_out_121491.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_12 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_12 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_12

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_12 and arg_233_1.time_ < var_236_4 + var_236_12 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play121491058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 121491058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play121491059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1072ui_story"]) and arg_237_1.var_.characterEffect1072ui_story == nil then
				arg_237_1.var_.characterEffect1072ui_story = arg_237_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1072ui_story"]) then
				if arg_237_1.var_.characterEffect1072ui_story and not isNil(arg_237_1.actors_["1072ui_story"]) then
					arg_237_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1072ui_story"]) and arg_237_1.var_.characterEffect1072ui_story then
				arg_237_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_240_1 = 0
			local var_240_2 = 0.95

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_3 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(121491058).content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 38 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 38)

				if (38 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 38)) > 0 and var_240_2 < var_240_5 then
					arg_237_1.talkMaxDuration = var_240_5

					if var_240_5 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_6 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_6 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_6

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_6 and arg_237_1.time_ < var_240_1 + var_240_6 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play121491059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 121491059
		arg_241_1.duration_ = 7.37

		local var_241_0 = {
			ja = 7.366,
			ko = 5.3,
			zh = 5.3
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
				arg_241_0:Play121491060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1072ui_story"]) and arg_241_1.var_.characterEffect1072ui_story == nil then
				arg_241_1.var_.characterEffect1072ui_story = arg_241_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1072ui_story"]) then
				if arg_241_1.var_.characterEffect1072ui_story and not isNil(arg_241_1.actors_["1072ui_story"]) then
					arg_241_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1072ui_story"]) and arg_241_1.var_.characterEffect1072ui_story then
				arg_241_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action463")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_244_2 = arg_241_1.actors_["1072ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.characterEffect1072ui_story == nil then
				arg_241_1.var_.characterEffect1072ui_story = var_244_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_3 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_3 and not isNil(var_244_2) then
				if arg_241_1.var_.characterEffect1072ui_story and not isNil(var_244_2) then
					arg_241_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_3 and arg_241_1.time_ < 0 + var_244_3 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.characterEffect1072ui_story then
				arg_241_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_244_5 = arg_241_1.actors_["1076ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_5) and arg_241_1.var_.characterEffect1076ui_story == nil then
				arg_241_1.var_.characterEffect1076ui_story = var_244_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_6 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_6 and not isNil(var_244_5) then
				if arg_241_1.var_.characterEffect1076ui_story and not isNil(var_244_5) then
					arg_241_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_6)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_6 and arg_241_1.time_ < 0 + var_244_6 + arg_244_0 and not isNil(var_244_5) and arg_241_1.var_.characterEffect1076ui_story then
				arg_241_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_244_7 = 0
			local var_244_8 = 0.5

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_7 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_9 = arg_241_1:GetWordFromCfg(121491059)
				local var_244_10 = arg_241_1:FormatText(var_244_9.content)

				arg_241_1.text_.text = var_244_10

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_12 = 20 <= 0 and var_244_8 or var_244_8 * (utf8.len(var_244_10) / 20)

				if (20 <= 0 and var_244_8 or var_244_8 * (utf8.len(var_244_10) / 20)) > 0 and var_244_8 < var_244_12 then
					arg_241_1.talkMaxDuration = var_244_12

					if var_244_12 + var_244_7 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_12 + var_244_7
					end
				end

				arg_241_1.text_.text = var_244_10
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491059", "story_v_out_121491.awb") ~= 0 then
					local var_244_13 = manager.audio:GetVoiceLength("story_v_out_121491", "121491059", "story_v_out_121491.awb") / 1000

					if var_244_13 + var_244_7 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_13 + var_244_7
					end

					if var_244_9.prefab_name ~= "" and arg_241_1.actors_[var_244_9.prefab_name] ~= nil then
						local var_244_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_9.prefab_name].transform, "story_v_out_121491", "121491059", "story_v_out_121491.awb")

						arg_241_1:RecordAudio("121491059", var_244_14)
						arg_241_1:RecordAudio("121491059", var_244_14)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_121491", "121491059", "story_v_out_121491.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_121491", "121491059", "story_v_out_121491.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_15 = math.max(var_244_8, arg_241_1.talkMaxDuration)

			if var_244_7 <= arg_241_1.time_ and arg_241_1.time_ < var_244_7 + var_244_15 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_7) / var_244_15

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_7 + var_244_15 and arg_241_1.time_ < var_244_7 + var_244_15 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play121491060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 121491060
		arg_245_1.duration_ = 9.5

		local var_245_0 = {
			ja = 8.4,
			ko = 9.5,
			zh = 9.5
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
				arg_245_0:Play121491061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_2")
			end

			local var_248_0 = 0
			local var_248_1 = 1.075

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_2 = arg_245_1:GetWordFromCfg(121491060)
				local var_248_3 = arg_245_1:FormatText(var_248_2.content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 43 <= 0 and var_248_1 or var_248_1 * (utf8.len(var_248_3) / 43)

				if (43 <= 0 and var_248_1 or var_248_1 * (utf8.len(var_248_3) / 43)) > 0 and var_248_1 < var_248_5 then
					arg_245_1.talkMaxDuration = var_248_5

					if var_248_5 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491060", "story_v_out_121491.awb") ~= 0 then
					local var_248_6 = manager.audio:GetVoiceLength("story_v_out_121491", "121491060", "story_v_out_121491.awb") / 1000

					if var_248_6 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_0
					end

					if var_248_2.prefab_name ~= "" and arg_245_1.actors_[var_248_2.prefab_name] ~= nil then
						local var_248_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_2.prefab_name].transform, "story_v_out_121491", "121491060", "story_v_out_121491.awb")

						arg_245_1:RecordAudio("121491060", var_248_7)
						arg_245_1:RecordAudio("121491060", var_248_7)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_121491", "121491060", "story_v_out_121491.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_121491", "121491060", "story_v_out_121491.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_8 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_8 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_8

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_8 and arg_245_1.time_ < var_248_0 + var_248_8 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play121491061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 121491061
		arg_249_1.duration_ = 8.87

		local var_249_0 = {
			ja = 8.866,
			ko = 6.7,
			zh = 6.7
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
				arg_249_0:Play121491062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0.725

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_1 = arg_249_1:GetWordFromCfg(121491061)
				local var_252_2 = arg_249_1:FormatText(var_252_1.content)

				arg_249_1.text_.text = var_252_2

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 29 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 29)

				if (29 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 29)) > 0 and var_252_0 < var_252_4 then
					arg_249_1.talkMaxDuration = var_252_4

					if var_252_4 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_4 + 0
					end
				end

				arg_249_1.text_.text = var_252_2
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491061", "story_v_out_121491.awb") ~= 0 then
					local var_252_5 = manager.audio:GetVoiceLength("story_v_out_121491", "121491061", "story_v_out_121491.awb") / 1000

					if var_252_5 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + 0
					end

					if var_252_1.prefab_name ~= "" and arg_249_1.actors_[var_252_1.prefab_name] ~= nil then
						local var_252_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_1.prefab_name].transform, "story_v_out_121491", "121491061", "story_v_out_121491.awb")

						arg_249_1:RecordAudio("121491061", var_252_6)
						arg_249_1:RecordAudio("121491061", var_252_6)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_121491", "121491061", "story_v_out_121491.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_121491", "121491061", "story_v_out_121491.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_7 and arg_249_1.time_ < 0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play121491062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 121491062
		arg_253_1.duration_ = 9.2

		local var_253_0 = {
			ja = 9.2,
			ko = 2.566,
			zh = 2.566
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
				arg_253_0:Play121491063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1076ui_story"]) and arg_253_1.var_.characterEffect1076ui_story == nil then
				arg_253_1.var_.characterEffect1076ui_story = arg_253_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1076ui_story"]) then
				if arg_253_1.var_.characterEffect1076ui_story and not isNil(arg_253_1.actors_["1076ui_story"]) then
					arg_253_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1076ui_story"]) and arg_253_1.var_.characterEffect1076ui_story then
				arg_253_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_256_2 = arg_253_1.actors_["1072ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.characterEffect1072ui_story == nil then
				arg_253_1.var_.characterEffect1072ui_story = var_256_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_3 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_3 and not isNil(var_256_2) then
				if arg_253_1.var_.characterEffect1072ui_story and not isNil(var_256_2) then
					arg_253_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_3)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_3 and arg_253_1.time_ < 0 + var_256_3 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.characterEffect1072ui_story then
				arg_253_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_256_4 = 0
			local var_256_5 = 0.3

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_6 = arg_253_1:GetWordFromCfg(121491062)
				local var_256_7 = arg_253_1:FormatText(var_256_6.content)

				arg_253_1.text_.text = var_256_7

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_9 = 12 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 12)

				if (12 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 12)) > 0 and var_256_5 < var_256_9 then
					arg_253_1.talkMaxDuration = var_256_9

					if var_256_9 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_9 + var_256_4
					end
				end

				arg_253_1.text_.text = var_256_7
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491062", "story_v_out_121491.awb") ~= 0 then
					local var_256_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491062", "story_v_out_121491.awb") / 1000

					if var_256_10 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_10 + var_256_4
					end

					if var_256_6.prefab_name ~= "" and arg_253_1.actors_[var_256_6.prefab_name] ~= nil then
						local var_256_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_6.prefab_name].transform, "story_v_out_121491", "121491062", "story_v_out_121491.awb")

						arg_253_1:RecordAudio("121491062", var_256_11)
						arg_253_1:RecordAudio("121491062", var_256_11)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_121491", "121491062", "story_v_out_121491.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_121491", "121491062", "story_v_out_121491.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_12 = math.max(var_256_5, arg_253_1.talkMaxDuration)

			if var_256_4 <= arg_253_1.time_ and arg_253_1.time_ < var_256_4 + var_256_12 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_4) / var_256_12

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_4 + var_256_12 and arg_253_1.time_ < var_256_4 + var_256_12 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play121491063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 121491063
		arg_257_1.duration_ = 6.7

		local var_257_0 = {
			ja = 6.7,
			ko = 6.266,
			zh = 6.266
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
				arg_257_0:Play121491064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["1072ui_story"]) and arg_257_1.var_.characterEffect1072ui_story == nil then
				arg_257_1.var_.characterEffect1072ui_story = arg_257_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_0 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["1072ui_story"]) then
				if arg_257_1.var_.characterEffect1072ui_story and not isNil(arg_257_1.actors_["1072ui_story"]) then
					arg_257_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["1072ui_story"]) and arg_257_1.var_.characterEffect1072ui_story then
				arg_257_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_260_2 = arg_257_1.actors_["1076ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.characterEffect1076ui_story == nil then
				arg_257_1.var_.characterEffect1076ui_story = var_260_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_3 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_3 and not isNil(var_260_2) then
				if arg_257_1.var_.characterEffect1076ui_story and not isNil(var_260_2) then
					arg_257_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_3)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_3 and arg_257_1.time_ < 0 + var_260_3 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.characterEffect1076ui_story then
				arg_257_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_260_4 = 0
			local var_260_5 = 0.7

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_6 = arg_257_1:GetWordFromCfg(121491063)
				local var_260_7 = arg_257_1:FormatText(var_260_6.content)

				arg_257_1.text_.text = var_260_7

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_9 = 28 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 28)

				if (28 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 28)) > 0 and var_260_5 < var_260_9 then
					arg_257_1.talkMaxDuration = var_260_9

					if var_260_9 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_7
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491063", "story_v_out_121491.awb") ~= 0 then
					local var_260_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491063", "story_v_out_121491.awb") / 1000

					if var_260_10 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_4
					end

					if var_260_6.prefab_name ~= "" and arg_257_1.actors_[var_260_6.prefab_name] ~= nil then
						local var_260_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_6.prefab_name].transform, "story_v_out_121491", "121491063", "story_v_out_121491.awb")

						arg_257_1:RecordAudio("121491063", var_260_11)
						arg_257_1:RecordAudio("121491063", var_260_11)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_121491", "121491063", "story_v_out_121491.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_121491", "121491063", "story_v_out_121491.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_12 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_12 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_12

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_12 and arg_257_1.time_ < var_260_4 + var_260_12 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play121491064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 121491064
		arg_261_1.duration_ = 7.5

		local var_261_0 = {
			ja = 7.5,
			ko = 6,
			zh = 6
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
				arg_261_0:Play121491065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1072ui_story"]) and arg_261_1.var_.characterEffect1072ui_story == nil then
				arg_261_1.var_.characterEffect1072ui_story = arg_261_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1072ui_story"]) then
				if arg_261_1.var_.characterEffect1072ui_story and not isNil(arg_261_1.actors_["1072ui_story"]) then
					arg_261_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1072ui_story"]) and arg_261_1.var_.characterEffect1072ui_story then
				arg_261_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_264_2 = 0
			local var_264_3 = 0.55

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_2 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_4 = arg_261_1:GetWordFromCfg(121491064)
				local var_264_5 = arg_261_1:FormatText(var_264_4.content)

				arg_261_1.text_.text = var_264_5

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_7 = 22 <= 0 and var_264_3 or var_264_3 * (utf8.len(var_264_5) / 22)

				if (22 <= 0 and var_264_3 or var_264_3 * (utf8.len(var_264_5) / 22)) > 0 and var_264_3 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_2 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_2
					end
				end

				arg_261_1.text_.text = var_264_5
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491064", "story_v_out_121491.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_out_121491", "121491064", "story_v_out_121491.awb") / 1000

					if var_264_8 + var_264_2 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_2
					end

					if var_264_4.prefab_name ~= "" and arg_261_1.actors_[var_264_4.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_4.prefab_name].transform, "story_v_out_121491", "121491064", "story_v_out_121491.awb")

						arg_261_1:RecordAudio("121491064", var_264_9)
						arg_261_1:RecordAudio("121491064", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_121491", "121491064", "story_v_out_121491.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_121491", "121491064", "story_v_out_121491.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_3, arg_261_1.talkMaxDuration)

			if var_264_2 <= arg_261_1.time_ and arg_261_1.time_ < var_264_2 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_2) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_2 + var_264_10 and arg_261_1.time_ < var_264_2 + var_264_10 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play121491065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 121491065
		arg_265_1.duration_ = 3.17

		local var_265_0 = {
			ja = 3.166,
			ko = 1.2,
			zh = 1.2
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
				arg_265_0:Play121491066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1072ui_story"]) and arg_265_1.var_.characterEffect1072ui_story == nil then
				arg_265_1.var_.characterEffect1072ui_story = arg_265_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1072ui_story"]) then
				if arg_265_1.var_.characterEffect1072ui_story and not isNil(arg_265_1.actors_["1072ui_story"]) then
					arg_265_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_0)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1072ui_story"]) and arg_265_1.var_.characterEffect1072ui_story then
				arg_265_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_268_1 = arg_265_1.actors_["1076ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1076ui_story == nil then
				arg_265_1.var_.characterEffect1076ui_story = var_268_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_2 and not isNil(var_268_1) then
				if arg_265_1.var_.characterEffect1076ui_story and not isNil(var_268_1) then
					arg_265_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_2 and arg_265_1.time_ < 0 + var_268_2 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1076ui_story then
				arg_265_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_268_4 = 0
			local var_268_5 = 0.15

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_6 = arg_265_1:GetWordFromCfg(121491065)
				local var_268_7 = arg_265_1:FormatText(var_268_6.content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 6 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 6)

				if (6 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 6)) > 0 and var_268_5 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_4
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491065", "story_v_out_121491.awb") ~= 0 then
					local var_268_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491065", "story_v_out_121491.awb") / 1000

					if var_268_10 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_4
					end

					if var_268_6.prefab_name ~= "" and arg_265_1.actors_[var_268_6.prefab_name] ~= nil then
						local var_268_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_6.prefab_name].transform, "story_v_out_121491", "121491065", "story_v_out_121491.awb")

						arg_265_1:RecordAudio("121491065", var_268_11)
						arg_265_1:RecordAudio("121491065", var_268_11)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_121491", "121491065", "story_v_out_121491.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_121491", "121491065", "story_v_out_121491.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_12 = math.max(var_268_5, arg_265_1.talkMaxDuration)

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_12 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_4) / var_268_12

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_4 + var_268_12 and arg_265_1.time_ < var_268_4 + var_268_12 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play121491066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 121491066
		arg_269_1.duration_ = 4.83

		local var_269_0 = {
			ja = 4.4,
			ko = 4.833,
			zh = 4.833
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
				arg_269_0:Play121491067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1072ui_story"]) and arg_269_1.var_.characterEffect1072ui_story == nil then
				arg_269_1.var_.characterEffect1072ui_story = arg_269_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1072ui_story"]) then
				if arg_269_1.var_.characterEffect1072ui_story and not isNil(arg_269_1.actors_["1072ui_story"]) then
					arg_269_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1072ui_story"]) and arg_269_1.var_.characterEffect1072ui_story then
				arg_269_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_272_2 = arg_269_1.actors_["1076ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.characterEffect1076ui_story == nil then
				arg_269_1.var_.characterEffect1076ui_story = var_272_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_3 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_3 and not isNil(var_272_2) then
				if arg_269_1.var_.characterEffect1076ui_story and not isNil(var_272_2) then
					arg_269_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_3)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_3 and arg_269_1.time_ < 0 + var_272_3 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.characterEffect1076ui_story then
				arg_269_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_272_4 = 0
			local var_272_5 = 0.35

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(121491066)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 14 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 14)

				if (14 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 14)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491066", "story_v_out_121491.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491066", "story_v_out_121491.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_out_121491", "121491066", "story_v_out_121491.awb")

						arg_269_1:RecordAudio("121491066", var_272_11)
						arg_269_1:RecordAudio("121491066", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_121491", "121491066", "story_v_out_121491.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_121491", "121491066", "story_v_out_121491.awb")
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

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play121491067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 121491067
		arg_273_1.duration_ = 7.37

		local var_273_0 = {
			ja = 7.366,
			ko = 3.666,
			zh = 3.666
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
				arg_273_0:Play121491068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.5

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_1 = arg_273_1:GetWordFromCfg(121491067)
				local var_276_2 = arg_273_1:FormatText(var_276_1.content)

				arg_273_1.text_.text = var_276_2

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 20 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 20)

				if (20 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 20)) > 0 and var_276_0 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end

				arg_273_1.text_.text = var_276_2
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491067", "story_v_out_121491.awb") ~= 0 then
					local var_276_5 = manager.audio:GetVoiceLength("story_v_out_121491", "121491067", "story_v_out_121491.awb") / 1000

					if var_276_5 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + 0
					end

					if var_276_1.prefab_name ~= "" and arg_273_1.actors_[var_276_1.prefab_name] ~= nil then
						local var_276_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_1.prefab_name].transform, "story_v_out_121491", "121491067", "story_v_out_121491.awb")

						arg_273_1:RecordAudio("121491067", var_276_6)
						arg_273_1:RecordAudio("121491067", var_276_6)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_121491", "121491067", "story_v_out_121491.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_121491", "121491067", "story_v_out_121491.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_7 and arg_273_1.time_ < 0 + var_276_7 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play121491068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 121491068
		arg_277_1.duration_ = 8.2

		local var_277_0 = {
			ja = 8.2,
			ko = 3.933,
			zh = 3.933
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
				arg_277_0:Play121491069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["1072ui_story"]) and arg_277_1.var_.characterEffect1072ui_story == nil then
				arg_277_1.var_.characterEffect1072ui_story = arg_277_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["1072ui_story"]) then
				if arg_277_1.var_.characterEffect1072ui_story and not isNil(arg_277_1.actors_["1072ui_story"]) then
					arg_277_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_0)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["1072ui_story"]) and arg_277_1.var_.characterEffect1072ui_story then
				arg_277_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_280_1 = arg_277_1.actors_["1076ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1076ui_story == nil then
				arg_277_1.var_.characterEffect1076ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect1076ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1076ui_story then
				arg_277_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_280_4 = 0
			local var_280_5 = 0.375

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:GetWordFromCfg(121491068)
				local var_280_7 = arg_277_1:FormatText(var_280_6.content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 15 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 15)

				if (15 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 15)) > 0 and var_280_5 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491068", "story_v_out_121491.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491068", "story_v_out_121491.awb") / 1000

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end

					if var_280_6.prefab_name ~= "" and arg_277_1.actors_[var_280_6.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_6.prefab_name].transform, "story_v_out_121491", "121491068", "story_v_out_121491.awb")

						arg_277_1:RecordAudio("121491068", var_280_11)
						arg_277_1:RecordAudio("121491068", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_121491", "121491068", "story_v_out_121491.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_121491", "121491068", "story_v_out_121491.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_12 = math.max(var_280_5, arg_277_1.talkMaxDuration)

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_12 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_4) / var_280_12

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_4 + var_280_12 and arg_277_1.time_ < var_280_4 + var_280_12 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play121491069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 121491069
		arg_281_1.duration_ = 7.27

		local var_281_0 = {
			ja = 6.466,
			ko = 7.266,
			zh = 7.266
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
				arg_281_0:Play121491070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["1072ui_story"]) and arg_281_1.var_.characterEffect1072ui_story == nil then
				arg_281_1.var_.characterEffect1072ui_story = arg_281_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_0 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["1072ui_story"]) then
				if arg_281_1.var_.characterEffect1072ui_story and not isNil(arg_281_1.actors_["1072ui_story"]) then
					arg_281_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["1072ui_story"]) and arg_281_1.var_.characterEffect1072ui_story then
				arg_281_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_284_2 = arg_281_1.actors_["1076ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.characterEffect1076ui_story == nil then
				arg_281_1.var_.characterEffect1076ui_story = var_284_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_3 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_3 and not isNil(var_284_2) then
				if arg_281_1.var_.characterEffect1076ui_story and not isNil(var_284_2) then
					arg_281_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_3)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_3 and arg_281_1.time_ < 0 + var_284_3 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.characterEffect1076ui_story then
				arg_281_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_1")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_284_4 = 0
			local var_284_5 = 0.725

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_6 = arg_281_1:GetWordFromCfg(121491069)
				local var_284_7 = arg_281_1:FormatText(var_284_6.content)

				arg_281_1.text_.text = var_284_7

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_9 = 30 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 30)

				if (30 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 30)) > 0 and var_284_5 < var_284_9 then
					arg_281_1.talkMaxDuration = var_284_9

					if var_284_9 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_4
					end
				end

				arg_281_1.text_.text = var_284_7
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491069", "story_v_out_121491.awb") ~= 0 then
					local var_284_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491069", "story_v_out_121491.awb") / 1000

					if var_284_10 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_4
					end

					if var_284_6.prefab_name ~= "" and arg_281_1.actors_[var_284_6.prefab_name] ~= nil then
						local var_284_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_6.prefab_name].transform, "story_v_out_121491", "121491069", "story_v_out_121491.awb")

						arg_281_1:RecordAudio("121491069", var_284_11)
						arg_281_1:RecordAudio("121491069", var_284_11)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_121491", "121491069", "story_v_out_121491.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_121491", "121491069", "story_v_out_121491.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_12 = math.max(var_284_5, arg_281_1.talkMaxDuration)

			if var_284_4 <= arg_281_1.time_ and arg_281_1.time_ < var_284_4 + var_284_12 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_4) / var_284_12

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_4 + var_284_12 and arg_281_1.time_ < var_284_4 + var_284_12 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play121491070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 121491070
		arg_285_1.duration_ = 12.53

		local var_285_0 = {
			ja = 12.533,
			ko = 7.233,
			zh = 7.233
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play121491071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1072ui_story"]) and arg_285_1.var_.characterEffect1072ui_story == nil then
				arg_285_1.var_.characterEffect1072ui_story = arg_285_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1072ui_story"]) then
				if arg_285_1.var_.characterEffect1072ui_story and not isNil(arg_285_1.actors_["1072ui_story"]) then
					arg_285_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1072ui_story"]) and arg_285_1.var_.characterEffect1072ui_story then
				arg_285_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_288_2 = arg_285_1.actors_["1076ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect1076ui_story == nil then
				arg_285_1.var_.characterEffect1076ui_story = var_288_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_3 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_3 and not isNil(var_288_2) then
				if arg_285_1.var_.characterEffect1076ui_story and not isNil(var_288_2) then
					arg_285_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_3)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_3 and arg_285_1.time_ < 0 + var_288_3 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect1076ui_story then
				arg_285_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_2")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_288_4 = 0
			local var_288_5 = 0.875

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:GetWordFromCfg(121491070)
				local var_288_7 = arg_285_1:FormatText(var_288_6.content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 35 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 35)

				if (35 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 35)) > 0 and var_288_5 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491070", "story_v_out_121491.awb") ~= 0 then
					local var_288_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491070", "story_v_out_121491.awb") / 1000

					if var_288_10 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_4
					end

					if var_288_6.prefab_name ~= "" and arg_285_1.actors_[var_288_6.prefab_name] ~= nil then
						local var_288_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_6.prefab_name].transform, "story_v_out_121491", "121491070", "story_v_out_121491.awb")

						arg_285_1:RecordAudio("121491070", var_288_11)
						arg_285_1:RecordAudio("121491070", var_288_11)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_121491", "121491070", "story_v_out_121491.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_121491", "121491070", "story_v_out_121491.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_12 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_12 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_12

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_12 and arg_285_1.time_ < var_288_4 + var_288_12 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play121491071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 121491071
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play121491072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1072ui_story = arg_289_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 then
				arg_289_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_289_1.time_ - 0) / var_292_0)
				arg_289_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1072ui_story"].transform.position).z)
				arg_289_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1072ui_story"].transform.localEulerAngles = arg_289_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_289_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1072ui_story"].transform.position).z)
				arg_289_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1072ui_story"].transform.localEulerAngles = arg_289_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_292_1 = arg_289_1.actors_["1072ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1072ui_story == nil then
				arg_289_1.var_.characterEffect1072ui_story = var_292_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_2 and not isNil(var_292_1) then
				if arg_289_1.var_.characterEffect1072ui_story and not isNil(var_292_1) then
					arg_289_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_2)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_2 and arg_289_1.time_ < 0 + var_292_2 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1072ui_story then
				arg_289_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_292_3 = arg_289_1.actors_["1076ui_story"].transform

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1076ui_story = var_292_3.localPosition
			end

			local var_292_4 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				var_292_3.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_289_1.time_ - 0) / var_292_4)
				var_292_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_3.position).x, (manager.ui.mainCamera.transform.position - var_292_3.position).y, (manager.ui.mainCamera.transform.position - var_292_3.position).z)
				var_292_3.localEulerAngles.z = 0
				var_292_3.localEulerAngles.x = 0
				var_292_3.localEulerAngles = var_292_3.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				var_292_3.localPosition = Vector3.New(0, 100, 0)
				var_292_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_3.position).x, (manager.ui.mainCamera.transform.position - var_292_3.position).y, (manager.ui.mainCamera.transform.position - var_292_3.position).z)
				var_292_3.localEulerAngles.z = 0
				var_292_3.localEulerAngles.x = 0
				var_292_3.localEulerAngles = var_292_3.localEulerAngles
			end

			local var_292_5 = arg_289_1.actors_["1076ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_5) and arg_289_1.var_.characterEffect1076ui_story == nil then
				arg_289_1.var_.characterEffect1076ui_story = var_292_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_6 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_6 and not isNil(var_292_5) then
				if arg_289_1.var_.characterEffect1076ui_story and not isNil(var_292_5) then
					arg_289_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_6)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_6 and arg_289_1.time_ < 0 + var_292_6 + arg_292_0 and not isNil(var_292_5) and arg_289_1.var_.characterEffect1076ui_story then
				arg_289_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_292_7 = 0
			local var_292_8 = 1.025

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_7 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_9 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(121491071).content)

				arg_289_1.text_.text = var_292_9

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_11 = 41 <= 0 and var_292_8 or var_292_8 * (utf8.len(var_292_9) / 41)

				if (41 <= 0 and var_292_8 or var_292_8 * (utf8.len(var_292_9) / 41)) > 0 and var_292_8 < var_292_11 then
					arg_289_1.talkMaxDuration = var_292_11

					if var_292_11 + var_292_7 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_11 + var_292_7
					end
				end

				arg_289_1.text_.text = var_292_9
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_12 = math.max(var_292_8, arg_289_1.talkMaxDuration)

			if var_292_7 <= arg_289_1.time_ and arg_289_1.time_ < var_292_7 + var_292_12 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_7) / var_292_12

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_7 + var_292_12 and arg_289_1.time_ < var_292_7 + var_292_12 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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

		arg_289_1:InitPlayNodeList()
	end,
	Play121491072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 121491072
		arg_293_1.duration_ = 6.27

		local var_293_0 = {
			ja = 5.6,
			ko = 6.266,
			zh = 6.266
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
				arg_293_0:Play121491073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_296_0 = 0.6

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				local var_296_1, var_296_2 = math.modf((arg_293_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_296_2 * 0.13, var_296_2 * 0.13, var_296_2 * 0.13) + arg_293_1.var_.shakeOldPos
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				manager.ui.mainCamera.transform.localPosition = arg_293_1.var_.shakeOldPos
			end

			local var_296_3 = 0

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_3 + arg_296_0 then
				arg_293_1.allBtn_.enabled = false
			end

			if arg_293_1.time_ >= var_296_3 + 0.6 and arg_293_1.time_ < var_296_3 + 0.6 + arg_296_0 then
				arg_293_1.allBtn_.enabled = true
			end

			local var_296_4 = 0
			local var_296_5 = 0.225

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_6 = arg_293_1:GetWordFromCfg(121491072)
				local var_296_7 = arg_293_1:FormatText(var_296_6.content)

				arg_293_1.text_.text = var_296_7

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_9 = 9 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_7) / 9)

				if (9 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_7) / 9)) > 0 and var_296_5 < var_296_9 then
					arg_293_1.talkMaxDuration = var_296_9

					if var_296_9 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_9 + var_296_4
					end
				end

				arg_293_1.text_.text = var_296_7
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491072", "story_v_out_121491.awb") ~= 0 then
					local var_296_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491072", "story_v_out_121491.awb") / 1000

					if var_296_10 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_4
					end

					if var_296_6.prefab_name ~= "" and arg_293_1.actors_[var_296_6.prefab_name] ~= nil then
						local var_296_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_6.prefab_name].transform, "story_v_out_121491", "121491072", "story_v_out_121491.awb")

						arg_293_1:RecordAudio("121491072", var_296_11)
						arg_293_1:RecordAudio("121491072", var_296_11)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_121491", "121491072", "story_v_out_121491.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_121491", "121491072", "story_v_out_121491.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_12 = math.max(var_296_5, arg_293_1.talkMaxDuration)

			if var_296_4 <= arg_293_1.time_ and arg_293_1.time_ < var_296_4 + var_296_12 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_4) / var_296_12

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_4 + var_296_12 and arg_293_1.time_ < var_296_4 + var_296_12 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play121491073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 121491073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play121491074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 1.2

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

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(121491073).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 48 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 48)

				if (48 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 48)) > 0 and var_300_0 < var_300_3 then
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
	Play121491074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 121491074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play121491075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.8

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_1 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(121491074).content)

				arg_301_1.text_.text = var_304_1

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_3 = 32 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 32)

				if (32 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 32)) > 0 and var_304_0 < var_304_3 then
					arg_301_1.talkMaxDuration = var_304_3

					if var_304_3 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_3 + 0
					end
				end

				arg_301_1.text_.text = var_304_1
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_4 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_4

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play121491075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 121491075
		arg_305_1.duration_ = 5.77

		local var_305_0 = {
			ja = 5.466,
			ko = 5.766,
			zh = 5.766
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
				arg_305_0:Play121491076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1072ui_story = arg_305_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_308_0 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 then
				arg_305_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_305_1.time_ - 0) / var_308_0)
				arg_305_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1072ui_story"].transform.position).z)
				arg_305_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["1072ui_story"].transform.localEulerAngles = arg_305_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 then
				arg_305_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_305_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1072ui_story"].transform.position).z)
				arg_305_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["1072ui_story"].transform.localEulerAngles = arg_305_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_308_1 = arg_305_1.actors_["1072ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1072ui_story == nil then
				arg_305_1.var_.characterEffect1072ui_story = var_308_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_2 and not isNil(var_308_1) then
				if arg_305_1.var_.characterEffect1072ui_story and not isNil(var_308_1) then
					arg_305_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 0 + var_308_2 and arg_305_1.time_ < 0 + var_308_2 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1072ui_story then
				arg_305_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_308_4 = arg_305_1.actors_["1076ui_story"].transform

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1076ui_story = var_308_4.localPosition
			end

			local var_308_5 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_5 then
				var_308_4.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_305_1.time_ - 0) / var_308_5)
				var_308_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_308_4.position).x, (manager.ui.mainCamera.transform.position - var_308_4.position).y, (manager.ui.mainCamera.transform.position - var_308_4.position).z)
				var_308_4.localEulerAngles.z = 0
				var_308_4.localEulerAngles.x = 0
				var_308_4.localEulerAngles = var_308_4.localEulerAngles
			end

			if arg_305_1.time_ >= 0 + var_308_5 and arg_305_1.time_ < 0 + var_308_5 + arg_308_0 then
				var_308_4.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_308_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_308_4.position).x, (manager.ui.mainCamera.transform.position - var_308_4.position).y, (manager.ui.mainCamera.transform.position - var_308_4.position).z)
				var_308_4.localEulerAngles.z = 0
				var_308_4.localEulerAngles.x = 0
				var_308_4.localEulerAngles = var_308_4.localEulerAngles
			end

			local var_308_6 = arg_305_1.actors_["1076ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_6) and arg_305_1.var_.characterEffect1076ui_story == nil then
				arg_305_1.var_.characterEffect1076ui_story = var_308_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_7 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_7 and not isNil(var_308_6) then
				if arg_305_1.var_.characterEffect1076ui_story and not isNil(var_308_6) then
					arg_305_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_7)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_7 and arg_305_1.time_ < 0 + var_308_7 + arg_308_0 and not isNil(var_308_6) and arg_305_1.var_.characterEffect1076ui_story then
				arg_305_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_308_8 = 0
			local var_308_9 = 0.4

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_8 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_10 = arg_305_1:GetWordFromCfg(121491075)
				local var_308_11 = arg_305_1:FormatText(var_308_10.content)

				arg_305_1.text_.text = var_308_11

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_13 = 16 <= 0 and var_308_9 or var_308_9 * (utf8.len(var_308_11) / 16)

				if (16 <= 0 and var_308_9 or var_308_9 * (utf8.len(var_308_11) / 16)) > 0 and var_308_9 < var_308_13 then
					arg_305_1.talkMaxDuration = var_308_13

					if var_308_13 + var_308_8 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_13 + var_308_8
					end
				end

				arg_305_1.text_.text = var_308_11
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491075", "story_v_out_121491.awb") ~= 0 then
					local var_308_14 = manager.audio:GetVoiceLength("story_v_out_121491", "121491075", "story_v_out_121491.awb") / 1000

					if var_308_14 + var_308_8 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_14 + var_308_8
					end

					if var_308_10.prefab_name ~= "" and arg_305_1.actors_[var_308_10.prefab_name] ~= nil then
						local var_308_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_10.prefab_name].transform, "story_v_out_121491", "121491075", "story_v_out_121491.awb")

						arg_305_1:RecordAudio("121491075", var_308_15)
						arg_305_1:RecordAudio("121491075", var_308_15)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_121491", "121491075", "story_v_out_121491.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_121491", "121491075", "story_v_out_121491.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_16 = math.max(var_308_9, arg_305_1.talkMaxDuration)

			if var_308_8 <= arg_305_1.time_ and arg_305_1.time_ < var_308_8 + var_308_16 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_8) / var_308_16

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_8 + var_308_16 and arg_305_1.time_ < var_308_8 + var_308_16 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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

		arg_305_1:InitPlayNodeList()
	end,
	Play121491076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 121491076
		arg_309_1.duration_ = 7.73

		local var_309_0 = {
			ja = 7.733,
			ko = 4.2,
			zh = 4.2
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
				arg_309_0:Play121491077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.375

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_1 = arg_309_1:GetWordFromCfg(121491076)
				local var_312_2 = arg_309_1:FormatText(var_312_1.content)

				arg_309_1.text_.text = var_312_2

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 15 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 15)

				if (15 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 15)) > 0 and var_312_0 < var_312_4 then
					arg_309_1.talkMaxDuration = var_312_4

					if var_312_4 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_4 + 0
					end
				end

				arg_309_1.text_.text = var_312_2
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491076", "story_v_out_121491.awb") ~= 0 then
					local var_312_5 = manager.audio:GetVoiceLength("story_v_out_121491", "121491076", "story_v_out_121491.awb") / 1000

					if var_312_5 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + 0
					end

					if var_312_1.prefab_name ~= "" and arg_309_1.actors_[var_312_1.prefab_name] ~= nil then
						local var_312_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_1.prefab_name].transform, "story_v_out_121491", "121491076", "story_v_out_121491.awb")

						arg_309_1:RecordAudio("121491076", var_312_6)
						arg_309_1:RecordAudio("121491076", var_312_6)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_121491", "121491076", "story_v_out_121491.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_121491", "121491076", "story_v_out_121491.awb")
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
	Play121491077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 121491077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play121491078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1072ui_story"]) and arg_313_1.var_.characterEffect1072ui_story == nil then
				arg_313_1.var_.characterEffect1072ui_story = arg_313_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1072ui_story"]) then
				if arg_313_1.var_.characterEffect1072ui_story and not isNil(arg_313_1.actors_["1072ui_story"]) then
					arg_313_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_0)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1072ui_story"]) and arg_313_1.var_.characterEffect1072ui_story then
				arg_313_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_316_1 = 0
			local var_316_2 = 0.7

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_3 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(121491077).content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 28 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 28)

				if (28 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 28)) > 0 and var_316_2 < var_316_5 then
					arg_313_1.talkMaxDuration = var_316_5

					if var_316_5 + var_316_1 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + var_316_1
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_6 = math.max(var_316_2, arg_313_1.talkMaxDuration)

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_6 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_1) / var_316_6

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_1 + var_316_6 and arg_313_1.time_ < var_316_1 + var_316_6 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play121491078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 121491078
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play121491079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1072ui_story = arg_317_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1072ui_story"].transform.position).z)
				arg_317_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1072ui_story"].transform.localEulerAngles = arg_317_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_317_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1072ui_story"].transform.position).z)
				arg_317_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1072ui_story"].transform.localEulerAngles = arg_317_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_320_1 = arg_317_1.actors_["1072ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1072ui_story == nil then
				arg_317_1.var_.characterEffect1072ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 and not isNil(var_320_1) then
				if arg_317_1.var_.characterEffect1072ui_story and not isNil(var_320_1) then
					arg_317_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_2)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1072ui_story then
				arg_317_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_320_3 = arg_317_1.actors_["1076ui_story"].transform

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1076ui_story = var_320_3.localPosition
			end

			local var_320_4 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				var_320_3.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_317_1.time_ - 0) / var_320_4)
				var_320_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_3.position).x, (manager.ui.mainCamera.transform.position - var_320_3.position).y, (manager.ui.mainCamera.transform.position - var_320_3.position).z)
				var_320_3.localEulerAngles.z = 0
				var_320_3.localEulerAngles.x = 0
				var_320_3.localEulerAngles = var_320_3.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				var_320_3.localPosition = Vector3.New(0, 100, 0)
				var_320_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_3.position).x, (manager.ui.mainCamera.transform.position - var_320_3.position).y, (manager.ui.mainCamera.transform.position - var_320_3.position).z)
				var_320_3.localEulerAngles.z = 0
				var_320_3.localEulerAngles.x = 0
				var_320_3.localEulerAngles = var_320_3.localEulerAngles
			end

			local var_320_5 = arg_317_1.actors_["1076ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_5) and arg_317_1.var_.characterEffect1076ui_story == nil then
				arg_317_1.var_.characterEffect1076ui_story = var_320_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_6 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_6 and not isNil(var_320_5) then
				if arg_317_1.var_.characterEffect1076ui_story and not isNil(var_320_5) then
					arg_317_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_6)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_6 and arg_317_1.time_ < 0 + var_320_6 + arg_320_0 and not isNil(var_320_5) and arg_317_1.var_.characterEffect1076ui_story then
				arg_317_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_320_7 = 0
			local var_320_8 = 0.95

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_7 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_9 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(121491078).content)

				arg_317_1.text_.text = var_320_9

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_11 = 38 <= 0 and var_320_8 or var_320_8 * (utf8.len(var_320_9) / 38)

				if (38 <= 0 and var_320_8 or var_320_8 * (utf8.len(var_320_9) / 38)) > 0 and var_320_8 < var_320_11 then
					arg_317_1.talkMaxDuration = var_320_11

					if var_320_11 + var_320_7 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_11 + var_320_7
					end
				end

				arg_317_1.text_.text = var_320_9
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_12 = math.max(var_320_8, arg_317_1.talkMaxDuration)

			if var_320_7 <= arg_317_1.time_ and arg_317_1.time_ < var_320_7 + var_320_12 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_7) / var_320_12

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_7 + var_320_12 and arg_317_1.time_ < var_320_7 + var_320_12 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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

		arg_317_1:InitPlayNodeList()
	end,
	Play121491079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 121491079
		arg_321_1.duration_ = 11.8

		local var_321_0 = {
			ja = 8.6,
			ko = 11.8,
			zh = 11.8
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
				arg_321_0:Play121491080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1072ui_story = arg_321_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_324_0 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 then
				arg_321_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_321_1.time_ - 0) / var_324_0)
				arg_321_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1072ui_story"].transform.position).z)
				arg_321_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1072ui_story"].transform.localEulerAngles = arg_321_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 then
				arg_321_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_321_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1072ui_story"].transform.position).z)
				arg_321_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1072ui_story"].transform.localEulerAngles = arg_321_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_324_1 = arg_321_1.actors_["1072ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1072ui_story == nil then
				arg_321_1.var_.characterEffect1072ui_story = var_324_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_2 and not isNil(var_324_1) then
				if arg_321_1.var_.characterEffect1072ui_story and not isNil(var_324_1) then
					arg_321_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_2 and arg_321_1.time_ < 0 + var_324_2 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1072ui_story then
				arg_321_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_324_4 = 0
			local var_324_5 = 0.95

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_6 = arg_321_1:GetWordFromCfg(121491079)
				local var_324_7 = arg_321_1:FormatText(var_324_6.content)

				arg_321_1.text_.text = var_324_7

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_9 = 38 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 38)

				if (38 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 38)) > 0 and var_324_5 < var_324_9 then
					arg_321_1.talkMaxDuration = var_324_9

					if var_324_9 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_9 + var_324_4
					end
				end

				arg_321_1.text_.text = var_324_7
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491079", "story_v_out_121491.awb") ~= 0 then
					local var_324_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491079", "story_v_out_121491.awb") / 1000

					if var_324_10 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_4
					end

					if var_324_6.prefab_name ~= "" and arg_321_1.actors_[var_324_6.prefab_name] ~= nil then
						local var_324_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_6.prefab_name].transform, "story_v_out_121491", "121491079", "story_v_out_121491.awb")

						arg_321_1:RecordAudio("121491079", var_324_11)
						arg_321_1:RecordAudio("121491079", var_324_11)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_121491", "121491079", "story_v_out_121491.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_121491", "121491079", "story_v_out_121491.awb")
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
				actorName = "1072ui_story",
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
	Play121491080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 121491080
		arg_325_1.duration_ = 3.23

		local var_325_0 = {
			ja = 3.233,
			ko = 2.266,
			zh = 2.266
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
				arg_325_0:Play121491081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0.225

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_1 = arg_325_1:GetWordFromCfg(121491080)
				local var_328_2 = arg_325_1:FormatText(var_328_1.content)

				arg_325_1.text_.text = var_328_2

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_4 = 9 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 9)

				if (9 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 9)) > 0 and var_328_0 < var_328_4 then
					arg_325_1.talkMaxDuration = var_328_4

					if var_328_4 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_4 + 0
					end
				end

				arg_325_1.text_.text = var_328_2
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491080", "story_v_out_121491.awb") ~= 0 then
					local var_328_5 = manager.audio:GetVoiceLength("story_v_out_121491", "121491080", "story_v_out_121491.awb") / 1000

					if var_328_5 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + 0
					end

					if var_328_1.prefab_name ~= "" and arg_325_1.actors_[var_328_1.prefab_name] ~= nil then
						local var_328_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_1.prefab_name].transform, "story_v_out_121491", "121491080", "story_v_out_121491.awb")

						arg_325_1:RecordAudio("121491080", var_328_6)
						arg_325_1:RecordAudio("121491080", var_328_6)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_121491", "121491080", "story_v_out_121491.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_121491", "121491080", "story_v_out_121491.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_7 and arg_325_1.time_ < 0 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play121491081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 121491081
		arg_329_1.duration_ = 9

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play121491082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if arg_329_1.bgs_.J12g == nil then
				local var_332_0 = Object.Instantiate(arg_329_1.paintGo_)

				var_332_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J12g")
				var_332_0.name = "J12g"
				var_332_0.transform.parent = arg_329_1.stage_.transform
				var_332_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_329_1.bgs_.J12g = var_332_0
			end

			if 2 < arg_329_1.time_ and arg_329_1.time_ <= 2 + arg_332_0 then
				local var_332_1 = arg_329_1.bgs_.J12g

				arg_329_1.bgs_.J12g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_332_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_332_2 = var_332_1:GetComponent("SpriteRenderer")

				if var_332_2 and var_332_2.sprite then
					local var_332_3 = 2 * (var_332_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_332_1.transform.localScale = Vector3.New(var_332_3 / var_332_2.sprite.bounds.size.y < var_332_3 * manager.ui.mainCameraCom_.aspect / var_332_2.sprite.bounds.size.x and var_332_3 * manager.ui.mainCameraCom_.aspect / var_332_2.sprite.bounds.size.x or var_332_3 / var_332_2.sprite.bounds.size.y, var_332_3 / var_332_2.sprite.bounds.size.y < var_332_3 * manager.ui.mainCameraCom_.aspect / var_332_2.sprite.bounds.size.x and var_332_3 * manager.ui.mainCameraCom_.aspect / var_332_2.sprite.bounds.size.x or var_332_3 / var_332_2.sprite.bounds.size.y, 0)
				end

				for iter_332_0, iter_332_1 in pairs(arg_329_1.bgs_) do
					if iter_332_0 ~= "J12g" then
						iter_332_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_332_4 = 0

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_4 + arg_332_0 then
				arg_329_1.mask_.enabled = true
				arg_329_1.mask_.raycastTarget = true

				arg_329_1:SetGaussion(false)
			end

			local var_332_5 = 2

			if var_332_4 <= arg_329_1.time_ and arg_329_1.time_ < var_332_4 + var_332_5 then
				local var_332_6 = Color.New(0, 0, 0)

				var_332_6.a = Mathf.Lerp(0, 1, (arg_329_1.time_ - var_332_4) / var_332_5)
				arg_329_1.mask_.color = var_332_6
			end

			if arg_329_1.time_ >= var_332_4 + var_332_5 and arg_329_1.time_ < var_332_4 + var_332_5 + arg_332_0 then
				local var_332_7 = Color.New(0, 0, 0)

				var_332_7.a = 1
				arg_329_1.mask_.color = var_332_7
			end

			local var_332_8 = 2

			if 2 < arg_329_1.time_ and arg_329_1.time_ <= var_332_8 + arg_332_0 then
				arg_329_1.mask_.enabled = true
				arg_329_1.mask_.raycastTarget = true

				arg_329_1:SetGaussion(false)
			end

			local var_332_9 = 2

			if var_332_8 <= arg_329_1.time_ and arg_329_1.time_ < var_332_8 + var_332_9 then
				local var_332_10 = Color.New(0, 0, 0)

				var_332_10.a = Mathf.Lerp(1, 0, (arg_329_1.time_ - var_332_8) / var_332_9)
				arg_329_1.mask_.color = var_332_10
			end

			if arg_329_1.time_ >= var_332_8 + var_332_9 and arg_329_1.time_ < var_332_8 + var_332_9 + arg_332_0 then
				local var_332_11 = Color.New(0, 0, 0)

				arg_329_1.mask_.enabled = false
				var_332_11.a = 0
				arg_329_1.mask_.color = var_332_11
			end

			local var_332_12 = arg_329_1.actors_["1072ui_story"].transform

			if 1.96599999815226 < arg_329_1.time_ and arg_329_1.time_ <= 1.96599999815226 + arg_332_0 then
				arg_329_1.var_.moveOldPos1072ui_story = var_332_12.localPosition
			end

			local var_332_13 = 0.001

			if 1.96599999815226 <= arg_329_1.time_ and arg_329_1.time_ < 1.96599999815226 + var_332_13 then
				var_332_12.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 1.96599999815226) / var_332_13)
				var_332_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_12.position).x, (manager.ui.mainCamera.transform.position - var_332_12.position).y, (manager.ui.mainCamera.transform.position - var_332_12.position).z)
				var_332_12.localEulerAngles.z = 0
				var_332_12.localEulerAngles.x = 0
				var_332_12.localEulerAngles = var_332_12.localEulerAngles
			end

			if arg_329_1.time_ >= 1.96599999815226 + var_332_13 and arg_329_1.time_ < 1.96599999815226 + var_332_13 + arg_332_0 then
				var_332_12.localPosition = Vector3.New(0, 100, 0)
				var_332_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_12.position).x, (manager.ui.mainCamera.transform.position - var_332_12.position).y, (manager.ui.mainCamera.transform.position - var_332_12.position).z)
				var_332_12.localEulerAngles.z = 0
				var_332_12.localEulerAngles.x = 0
				var_332_12.localEulerAngles = var_332_12.localEulerAngles
			end

			local var_332_14 = arg_329_1.actors_["1072ui_story"]

			if 1.96599999815226 < arg_329_1.time_ and arg_329_1.time_ <= 1.96599999815226 + arg_332_0 and not isNil(var_332_14) and arg_329_1.var_.characterEffect1072ui_story == nil then
				arg_329_1.var_.characterEffect1072ui_story = var_332_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_15 = 0.034000001847744

			if 1.96599999815226 <= arg_329_1.time_ and arg_329_1.time_ < 1.96599999815226 + var_332_15 and not isNil(var_332_14) then
				if arg_329_1.var_.characterEffect1072ui_story and not isNil(var_332_14) then
					arg_329_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 1.96599999815226) / var_332_15)
				end
			end

			if arg_329_1.time_ >= 1.96599999815226 + var_332_15 and arg_329_1.time_ < 1.96599999815226 + var_332_15 + arg_332_0 and not isNil(var_332_14) and arg_329_1.var_.characterEffect1072ui_story then
				arg_329_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_332_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_329_1.bgmTxt_.text ~= var_332_18 and arg_329_1.bgmTxt_.text ~= "" then
						if arg_329_1.bgmTxt2_.text ~= "" then
							arg_329_1.bgmTxt_.text = arg_329_1.bgmTxt2_.text
						end

						arg_329_1.bgmTxt2_.text = var_332_18

						arg_329_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_329_1.bgmTxt_.text = var_332_18
						arg_329_1.bgmTxt2_.text = var_332_18
					end

					if arg_329_1.bgmTimer then
						arg_329_1.bgmTimer:Stop()

						arg_329_1.bgmTimer = nil
					end

					if arg_329_1.settingData.show_music_name == 1 then
						arg_329_1.musicController:SetSelectedState("show")
						arg_329_1.musicAnimator_:Play("open", 0, 0)

						if arg_329_1.settingData.music_time ~= 0 then
							arg_329_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_329_1.settingData.music_time), function()
								if arg_329_1 == nil or isNil(arg_329_1.bgmTxt_) then
									return
								end

								arg_329_1.musicController:SetSelectedState("hide")
								arg_329_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.333333333333333 < arg_329_1.time_ and arg_329_1.time_ <= 0.333333333333333 + arg_332_0 then
				arg_329_1:AudioAction("play", "music", "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city.awb")

				local var_332_21 = manager.audio:GetAudioName("bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city")

				if "" ~= "" then
					if arg_329_1.bgmTxt_.text ~= var_332_21 and arg_329_1.bgmTxt_.text ~= "" then
						if arg_329_1.bgmTxt2_.text ~= "" then
							arg_329_1.bgmTxt_.text = arg_329_1.bgmTxt2_.text
						end

						arg_329_1.bgmTxt2_.text = var_332_21

						arg_329_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_329_1.bgmTxt_.text = var_332_21
						arg_329_1.bgmTxt2_.text = var_332_21
					end

					if arg_329_1.bgmTimer then
						arg_329_1.bgmTimer:Stop()

						arg_329_1.bgmTimer = nil
					end

					if arg_329_1.settingData.show_music_name == 1 then
						arg_329_1.musicController:SetSelectedState("show")
						arg_329_1.musicAnimator_:Play("open", 0, 0)

						if arg_329_1.settingData.music_time ~= 0 then
							arg_329_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_329_1.settingData.music_time), function()
								if arg_329_1 == nil or isNil(arg_329_1.bgmTxt_) then
									return
								end

								arg_329_1.musicController:SetSelectedState("hide")
								arg_329_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_329_1.frameCnt_ <= 1 then
				arg_329_1.dialog_:SetActive(false)
			end

			local var_332_22 = 4
			local var_332_23 = 1.55

			if 4 < arg_329_1.time_ and arg_329_1.time_ <= var_332_22 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0

				arg_329_1.dialog_:SetActive(true)

				arg_329_1.dialogCg_.alpha = 0

				local var_332_24 = LeanTween.value(arg_329_1.dialog_, 0, 1, 0.3)

				var_332_24:setOnUpdate(LuaHelper.FloatAction(function(arg_335_0)
					arg_329_1.dialogCg_.alpha = arg_335_0
				end))
				var_332_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_329_1.dialog_)
					var_332_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_329_1.duration_ = arg_329_1.duration_ + 0.3

				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_25 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(121491081).content)

				arg_329_1.text_.text = var_332_25

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_27 = 62 <= 0 and var_332_23 or var_332_23 * (utf8.len(var_332_25) / 62)

				if (62 <= 0 and var_332_23 or var_332_23 * (utf8.len(var_332_25) / 62)) > 0 and var_332_23 < var_332_27 then
					arg_329_1.talkMaxDuration = var_332_27
					var_332_22 = var_332_22 + 0.3

					if var_332_27 + var_332_22 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_27 + var_332_22
					end
				end

				arg_329_1.text_.text = var_332_25
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_28 = var_332_22 + 0.3
			local var_332_29 = math.max(var_332_23, arg_329_1.talkMaxDuration)

			if var_332_22 + 0.3 <= arg_329_1.time_ and arg_329_1.time_ < var_332_28 + var_332_29 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_28) / var_332_29

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_28 + var_332_29 and arg_329_1.time_ < var_332_28 + var_332_29 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play121491082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 121491082
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play121491083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 1.15

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_1 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(121491082).content)

				arg_337_1.text_.text = var_340_1

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_3 = 46 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 46)

				if (46 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 46)) > 0 and var_340_0 < var_340_3 then
					arg_337_1.talkMaxDuration = var_340_3

					if var_340_3 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_3 + 0
					end
				end

				arg_337_1.text_.text = var_340_1
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_4 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_4 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_4

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_4 and arg_337_1.time_ < 0 + var_340_4 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play121491083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 121491083
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play121491084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 1.45

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_1 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(121491083).content)

				arg_341_1.text_.text = var_344_1

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_3 = 58 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 58)

				if (58 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 58)) > 0 and var_344_0 < var_344_3 then
					arg_341_1.talkMaxDuration = var_344_3

					if var_344_3 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_3 + 0
					end
				end

				arg_341_1.text_.text = var_344_1
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_4 = math.max(var_344_0, arg_341_1.talkMaxDuration)

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_4 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - 0) / var_344_4

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= 0 + var_344_4 and arg_341_1.time_ < 0 + var_344_4 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play121491084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 121491084
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play121491085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 1.475

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_1 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(121491084).content)

				arg_345_1.text_.text = var_348_1

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_3 = 59 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_1) / 59)

				if (59 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_1) / 59)) > 0 and var_348_0 < var_348_3 then
					arg_345_1.talkMaxDuration = var_348_3

					if var_348_3 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_3 + 0
					end
				end

				arg_345_1.text_.text = var_348_1
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_4 = math.max(var_348_0, arg_345_1.talkMaxDuration)

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_4 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - 0) / var_348_4

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= 0 + var_348_4 and arg_345_1.time_ < 0 + var_348_4 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play121491085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 121491085
		arg_349_1.duration_ = 2

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play121491086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if arg_349_1.actors_["1184ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1184ui_story"))) then
				local var_352_0 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_349_1.stage_.transform)

				var_352_0.name = "1184ui_story"
				var_352_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_349_1.actors_["1184ui_story"] = var_352_0

				local var_352_1 = var_352_0:GetComponentInChildren(typeof(CharacterEffect))

				var_352_1.enabled = true

				local var_352_2 = GameObjectTools.GetOrAddComponent(var_352_0, typeof(DynamicBoneHelper))

				if var_352_2 then
					var_352_2:EnableDynamicBone(false)
				end

				arg_349_1:ShowWeapon(var_352_1.transform, false)

				arg_349_1.var_["1184ui_story" .. "Animator"] = var_352_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_349_1.var_["1184ui_story" .. "Animator"].applyRootMotion = true
				arg_349_1.var_["1184ui_story" .. "LipSync"] = var_352_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_352_3 = arg_349_1.actors_["1184ui_story"].transform

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1184ui_story = var_352_3.localPosition
			end

			local var_352_4 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_4 then
				var_352_3.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1184ui_story, Vector3.New(-0.7, -0.97, -6), (arg_349_1.time_ - 0) / var_352_4)
				var_352_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_3.position).x, (manager.ui.mainCamera.transform.position - var_352_3.position).y, (manager.ui.mainCamera.transform.position - var_352_3.position).z)
				var_352_3.localEulerAngles.z = 0
				var_352_3.localEulerAngles.x = 0
				var_352_3.localEulerAngles = var_352_3.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_4 and arg_349_1.time_ < 0 + var_352_4 + arg_352_0 then
				var_352_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_352_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_3.position).x, (manager.ui.mainCamera.transform.position - var_352_3.position).y, (manager.ui.mainCamera.transform.position - var_352_3.position).z)
				var_352_3.localEulerAngles.z = 0
				var_352_3.localEulerAngles.x = 0
				var_352_3.localEulerAngles = var_352_3.localEulerAngles
			end

			local var_352_5 = arg_349_1.actors_["1184ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_5) and arg_349_1.var_.characterEffect1184ui_story == nil then
				arg_349_1.var_.characterEffect1184ui_story = var_352_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_6 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_6 and not isNil(var_352_5) then
				if arg_349_1.var_.characterEffect1184ui_story and not isNil(var_352_5) then
					arg_349_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_6 and arg_349_1.time_ < 0 + var_352_6 + arg_352_0 and not isNil(var_352_5) and arg_349_1.var_.characterEffect1184ui_story then
				arg_349_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_352_8 = "1075ui_story"

			if arg_349_1.actors_["1075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_story"))) then
				local var_352_9 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_349_1.stage_.transform)

				var_352_9.name = var_352_8
				var_352_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_349_1.actors_[var_352_8] = var_352_9

				local var_352_10 = var_352_9:GetComponentInChildren(typeof(CharacterEffect))

				var_352_10.enabled = true

				local var_352_11 = GameObjectTools.GetOrAddComponent(var_352_9, typeof(DynamicBoneHelper))

				if var_352_11 then
					var_352_11:EnableDynamicBone(false)
				end

				arg_349_1:ShowWeapon(var_352_10.transform, false)

				arg_349_1.var_[var_352_8 .. "Animator"] = var_352_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_349_1.var_[var_352_8 .. "Animator"].applyRootMotion = true
				arg_349_1.var_[var_352_8 .. "LipSync"] = var_352_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_352_12 = arg_349_1.actors_["1075ui_story"].transform

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1075ui_story = var_352_12.localPosition
			end

			local var_352_13 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_13 then
				var_352_12.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_349_1.time_ - 0) / var_352_13)
				var_352_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_12.position).x, (manager.ui.mainCamera.transform.position - var_352_12.position).y, (manager.ui.mainCamera.transform.position - var_352_12.position).z)
				var_352_12.localEulerAngles.z = 0
				var_352_12.localEulerAngles.x = 0
				var_352_12.localEulerAngles = var_352_12.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_13 and arg_349_1.time_ < 0 + var_352_13 + arg_352_0 then
				var_352_12.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_352_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_12.position).x, (manager.ui.mainCamera.transform.position - var_352_12.position).y, (manager.ui.mainCamera.transform.position - var_352_12.position).z)
				var_352_12.localEulerAngles.z = 0
				var_352_12.localEulerAngles.x = 0
				var_352_12.localEulerAngles = var_352_12.localEulerAngles
			end

			local var_352_14 = arg_349_1.actors_["1075ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_14) and arg_349_1.var_.characterEffect1075ui_story == nil then
				arg_349_1.var_.characterEffect1075ui_story = var_352_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_15 = 0.034000001847744

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_15 and not isNil(var_352_14) then
				if arg_349_1.var_.characterEffect1075ui_story and not isNil(var_352_14) then
					arg_349_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_15)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_15 and arg_349_1.time_ < 0 + var_352_15 + arg_352_0 and not isNil(var_352_14) and arg_349_1.var_.characterEffect1075ui_story then
				arg_349_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_352_16 = 0
			local var_352_17 = 0.125

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_16 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_18 = arg_349_1:GetWordFromCfg(121491085)
				local var_352_19 = arg_349_1:FormatText(var_352_18.content)

				arg_349_1.text_.text = var_352_19

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_21 = 5 <= 0 and var_352_17 or var_352_17 * (utf8.len(var_352_19) / 5)

				if (5 <= 0 and var_352_17 or var_352_17 * (utf8.len(var_352_19) / 5)) > 0 and var_352_17 < var_352_21 then
					arg_349_1.talkMaxDuration = var_352_21

					if var_352_21 + var_352_16 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_21 + var_352_16
					end
				end

				arg_349_1.text_.text = var_352_19
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491085", "story_v_out_121491.awb") ~= 0 then
					local var_352_22 = manager.audio:GetVoiceLength("story_v_out_121491", "121491085", "story_v_out_121491.awb") / 1000

					if var_352_22 + var_352_16 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_22 + var_352_16
					end

					if var_352_18.prefab_name ~= "" and arg_349_1.actors_[var_352_18.prefab_name] ~= nil then
						local var_352_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_18.prefab_name].transform, "story_v_out_121491", "121491085", "story_v_out_121491.awb")

						arg_349_1:RecordAudio("121491085", var_352_23)
						arg_349_1:RecordAudio("121491085", var_352_23)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_121491", "121491085", "story_v_out_121491.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_121491", "121491085", "story_v_out_121491.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_24 = math.max(var_352_17, arg_349_1.talkMaxDuration)

			if var_352_16 <= arg_349_1.time_ and arg_349_1.time_ < var_352_16 + var_352_24 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_16) / var_352_24

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_16 + var_352_24 and arg_349_1.time_ < var_352_16 + var_352_24 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
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

		arg_349_1:InitPlayNodeList()
	end,
	Play121491086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 121491086
		arg_353_1.duration_ = 3.9

		local var_353_0 = {
			ja = 3.9,
			ko = 2.4,
			zh = 2.4
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
				arg_353_0:Play121491087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["1184ui_story"]) and arg_353_1.var_.characterEffect1184ui_story == nil then
				arg_353_1.var_.characterEffect1184ui_story = arg_353_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_0 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["1184ui_story"]) then
				if arg_353_1.var_.characterEffect1184ui_story and not isNil(arg_353_1.actors_["1184ui_story"]) then
					arg_353_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_0)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["1184ui_story"]) and arg_353_1.var_.characterEffect1184ui_story then
				arg_353_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_356_1 = arg_353_1.actors_["1075ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1075ui_story == nil then
				arg_353_1.var_.characterEffect1075ui_story = var_356_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_2 and not isNil(var_356_1) then
				if arg_353_1.var_.characterEffect1075ui_story and not isNil(var_356_1) then
					arg_353_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= 0 + var_356_2 and arg_353_1.time_ < 0 + var_356_2 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1075ui_story then
				arg_353_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_356_4 = 0
			local var_356_5 = 0.175

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_4 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_6 = arg_353_1:GetWordFromCfg(121491086)
				local var_356_7 = arg_353_1:FormatText(var_356_6.content)

				arg_353_1.text_.text = var_356_7

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_9 = 7 <= 0 and var_356_5 or var_356_5 * (utf8.len(var_356_7) / 7)

				if (7 <= 0 and var_356_5 or var_356_5 * (utf8.len(var_356_7) / 7)) > 0 and var_356_5 < var_356_9 then
					arg_353_1.talkMaxDuration = var_356_9

					if var_356_9 + var_356_4 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_9 + var_356_4
					end
				end

				arg_353_1.text_.text = var_356_7
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491086", "story_v_out_121491.awb") ~= 0 then
					local var_356_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491086", "story_v_out_121491.awb") / 1000

					if var_356_10 + var_356_4 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_10 + var_356_4
					end

					if var_356_6.prefab_name ~= "" and arg_353_1.actors_[var_356_6.prefab_name] ~= nil then
						local var_356_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_6.prefab_name].transform, "story_v_out_121491", "121491086", "story_v_out_121491.awb")

						arg_353_1:RecordAudio("121491086", var_356_11)
						arg_353_1:RecordAudio("121491086", var_356_11)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_121491", "121491086", "story_v_out_121491.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_121491", "121491086", "story_v_out_121491.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_12 = math.max(var_356_5, arg_353_1.talkMaxDuration)

			if var_356_4 <= arg_353_1.time_ and arg_353_1.time_ < var_356_4 + var_356_12 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_4) / var_356_12

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_4 + var_356_12 and arg_353_1.time_ < var_356_4 + var_356_12 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play121491087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 121491087
		arg_357_1.duration_ = 7.27

		local var_357_0 = {
			ja = 7.266,
			ko = 3.933,
			zh = 3.933
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
				arg_357_0:Play121491088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["1184ui_story"]) and arg_357_1.var_.characterEffect1184ui_story == nil then
				arg_357_1.var_.characterEffect1184ui_story = arg_357_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_0 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["1184ui_story"]) then
				if arg_357_1.var_.characterEffect1184ui_story and not isNil(arg_357_1.actors_["1184ui_story"]) then
					arg_357_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["1184ui_story"]) and arg_357_1.var_.characterEffect1184ui_story then
				arg_357_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_360_2 = arg_357_1.actors_["1075ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.characterEffect1075ui_story == nil then
				arg_357_1.var_.characterEffect1075ui_story = var_360_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_3 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_3 and not isNil(var_360_2) then
				if arg_357_1.var_.characterEffect1075ui_story and not isNil(var_360_2) then
					arg_357_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_357_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_357_1.time_ - 0) / var_360_3)
				end
			end

			if arg_357_1.time_ >= 0 + var_360_3 and arg_357_1.time_ < 0 + var_360_3 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.characterEffect1075ui_story then
				arg_357_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_357_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_2")
			end

			local var_360_4 = 0
			local var_360_5 = 0.425

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_6 = arg_357_1:GetWordFromCfg(121491087)
				local var_360_7 = arg_357_1:FormatText(var_360_6.content)

				arg_357_1.text_.text = var_360_7

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_9 = 17 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_7) / 17)

				if (17 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_7) / 17)) > 0 and var_360_5 < var_360_9 then
					arg_357_1.talkMaxDuration = var_360_9

					if var_360_9 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_9 + var_360_4
					end
				end

				arg_357_1.text_.text = var_360_7
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491087", "story_v_out_121491.awb") ~= 0 then
					local var_360_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491087", "story_v_out_121491.awb") / 1000

					if var_360_10 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_10 + var_360_4
					end

					if var_360_6.prefab_name ~= "" and arg_357_1.actors_[var_360_6.prefab_name] ~= nil then
						local var_360_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_6.prefab_name].transform, "story_v_out_121491", "121491087", "story_v_out_121491.awb")

						arg_357_1:RecordAudio("121491087", var_360_11)
						arg_357_1:RecordAudio("121491087", var_360_11)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_121491", "121491087", "story_v_out_121491.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_121491", "121491087", "story_v_out_121491.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_12 = math.max(var_360_5, arg_357_1.talkMaxDuration)

			if var_360_4 <= arg_357_1.time_ and arg_357_1.time_ < var_360_4 + var_360_12 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_4) / var_360_12

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_4 + var_360_12 and arg_357_1.time_ < var_360_4 + var_360_12 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play121491088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 121491088
		arg_361_1.duration_ = 10.4

		local var_361_0 = {
			ja = 10.4,
			ko = 6.466,
			zh = 6.466
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
				arg_361_0:Play121491089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1184ui_story"]) and arg_361_1.var_.characterEffect1184ui_story == nil then
				arg_361_1.var_.characterEffect1184ui_story = arg_361_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1184ui_story"]) then
				if arg_361_1.var_.characterEffect1184ui_story and not isNil(arg_361_1.actors_["1184ui_story"]) then
					arg_361_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_0)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1184ui_story"]) and arg_361_1.var_.characterEffect1184ui_story then
				arg_361_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_364_1 = arg_361_1.actors_["1075ui_story"]

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(var_364_1) and arg_361_1.var_.characterEffect1075ui_story == nil then
				arg_361_1.var_.characterEffect1075ui_story = var_364_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_2 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_2 and not isNil(var_364_1) then
				if arg_361_1.var_.characterEffect1075ui_story and not isNil(var_364_1) then
					arg_361_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= 0 + var_364_2 and arg_361_1.time_ < 0 + var_364_2 + arg_364_0 and not isNil(var_364_1) and arg_361_1.var_.characterEffect1075ui_story then
				arg_361_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_364_4 = 0
			local var_364_5 = 0.8

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_4 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_6 = arg_361_1:GetWordFromCfg(121491088)
				local var_364_7 = arg_361_1:FormatText(var_364_6.content)

				arg_361_1.text_.text = var_364_7

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_9 = 32 <= 0 and var_364_5 or var_364_5 * (utf8.len(var_364_7) / 32)

				if (32 <= 0 and var_364_5 or var_364_5 * (utf8.len(var_364_7) / 32)) > 0 and var_364_5 < var_364_9 then
					arg_361_1.talkMaxDuration = var_364_9

					if var_364_9 + var_364_4 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_9 + var_364_4
					end
				end

				arg_361_1.text_.text = var_364_7
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491088", "story_v_out_121491.awb") ~= 0 then
					local var_364_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491088", "story_v_out_121491.awb") / 1000

					if var_364_10 + var_364_4 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_10 + var_364_4
					end

					if var_364_6.prefab_name ~= "" and arg_361_1.actors_[var_364_6.prefab_name] ~= nil then
						local var_364_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_6.prefab_name].transform, "story_v_out_121491", "121491088", "story_v_out_121491.awb")

						arg_361_1:RecordAudio("121491088", var_364_11)
						arg_361_1:RecordAudio("121491088", var_364_11)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_121491", "121491088", "story_v_out_121491.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_121491", "121491088", "story_v_out_121491.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_12 = math.max(var_364_5, arg_361_1.talkMaxDuration)

			if var_364_4 <= arg_361_1.time_ and arg_361_1.time_ < var_364_4 + var_364_12 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_4) / var_364_12

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_4 + var_364_12 and arg_361_1.time_ < var_364_4 + var_364_12 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play121491089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 121491089
		arg_365_1.duration_ = 9.5

		local var_365_0 = {
			ja = 9.5,
			ko = 6,
			zh = 6
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
				arg_365_0:Play121491090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0.625

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_1 = arg_365_1:GetWordFromCfg(121491089)
				local var_368_2 = arg_365_1:FormatText(var_368_1.content)

				arg_365_1.text_.text = var_368_2

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_4 = 25 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 25)

				if (25 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 25)) > 0 and var_368_0 < var_368_4 then
					arg_365_1.talkMaxDuration = var_368_4

					if var_368_4 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_4 + 0
					end
				end

				arg_365_1.text_.text = var_368_2
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491089", "story_v_out_121491.awb") ~= 0 then
					local var_368_5 = manager.audio:GetVoiceLength("story_v_out_121491", "121491089", "story_v_out_121491.awb") / 1000

					if var_368_5 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + 0
					end

					if var_368_1.prefab_name ~= "" and arg_365_1.actors_[var_368_1.prefab_name] ~= nil then
						local var_368_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_1.prefab_name].transform, "story_v_out_121491", "121491089", "story_v_out_121491.awb")

						arg_365_1:RecordAudio("121491089", var_368_6)
						arg_365_1:RecordAudio("121491089", var_368_6)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_121491", "121491089", "story_v_out_121491.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_121491", "121491089", "story_v_out_121491.awb")
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
	Play121491090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 121491090
		arg_369_1.duration_ = 9.67

		local var_369_0 = {
			ja = 9.666,
			ko = 6.633,
			zh = 6.633
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
				arg_369_0:Play121491091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0.775

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_1 = arg_369_1:GetWordFromCfg(121491090)
				local var_372_2 = arg_369_1:FormatText(var_372_1.content)

				arg_369_1.text_.text = var_372_2

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_4 = 31 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_2) / 31)

				if (31 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_2) / 31)) > 0 and var_372_0 < var_372_4 then
					arg_369_1.talkMaxDuration = var_372_4

					if var_372_4 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_4 + 0
					end
				end

				arg_369_1.text_.text = var_372_2
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491090", "story_v_out_121491.awb") ~= 0 then
					local var_372_5 = manager.audio:GetVoiceLength("story_v_out_121491", "121491090", "story_v_out_121491.awb") / 1000

					if var_372_5 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_5 + 0
					end

					if var_372_1.prefab_name ~= "" and arg_369_1.actors_[var_372_1.prefab_name] ~= nil then
						local var_372_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_1.prefab_name].transform, "story_v_out_121491", "121491090", "story_v_out_121491.awb")

						arg_369_1:RecordAudio("121491090", var_372_6)
						arg_369_1:RecordAudio("121491090", var_372_6)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_121491", "121491090", "story_v_out_121491.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_121491", "121491090", "story_v_out_121491.awb")
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
	Play121491091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 121491091
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play121491092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["1075ui_story"]) and arg_373_1.var_.characterEffect1075ui_story == nil then
				arg_373_1.var_.characterEffect1075ui_story = arg_373_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_0 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["1075ui_story"]) then
				if arg_373_1.var_.characterEffect1075ui_story and not isNil(arg_373_1.actors_["1075ui_story"]) then
					arg_373_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_373_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_373_1.time_ - 0) / var_376_0)
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["1075ui_story"]) and arg_373_1.var_.characterEffect1075ui_story then
				arg_373_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_373_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_376_1 = 0
			local var_376_2 = 0.3

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_3 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(121491091).content)

				arg_373_1.text_.text = var_376_3

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_5 = 12 <= 0 and var_376_2 or var_376_2 * (utf8.len(var_376_3) / 12)

				if (12 <= 0 and var_376_2 or var_376_2 * (utf8.len(var_376_3) / 12)) > 0 and var_376_2 < var_376_5 then
					arg_373_1.talkMaxDuration = var_376_5

					if var_376_5 + var_376_1 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_5 + var_376_1
					end
				end

				arg_373_1.text_.text = var_376_3
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_6 = math.max(var_376_2, arg_373_1.talkMaxDuration)

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_6 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_1) / var_376_6

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_1 + var_376_6 and arg_373_1.time_ < var_376_1 + var_376_6 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play121491092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 121491092
		arg_377_1.duration_ = 3.5

		local var_377_0 = {
			ja = 3.5,
			ko = 3.2,
			zh = 3.2
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
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play121491093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["1075ui_story"]) and arg_377_1.var_.characterEffect1075ui_story == nil then
				arg_377_1.var_.characterEffect1075ui_story = arg_377_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_0 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["1075ui_story"]) then
				if arg_377_1.var_.characterEffect1075ui_story and not isNil(arg_377_1.actors_["1075ui_story"]) then
					arg_377_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["1075ui_story"]) and arg_377_1.var_.characterEffect1075ui_story then
				arg_377_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_380_2 = 0
			local var_380_3 = 0.225

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_2 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_4 = arg_377_1:GetWordFromCfg(121491092)
				local var_380_5 = arg_377_1:FormatText(var_380_4.content)

				arg_377_1.text_.text = var_380_5

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_7 = 9 <= 0 and var_380_3 or var_380_3 * (utf8.len(var_380_5) / 9)

				if (9 <= 0 and var_380_3 or var_380_3 * (utf8.len(var_380_5) / 9)) > 0 and var_380_3 < var_380_7 then
					arg_377_1.talkMaxDuration = var_380_7

					if var_380_7 + var_380_2 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_7 + var_380_2
					end
				end

				arg_377_1.text_.text = var_380_5
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491092", "story_v_out_121491.awb") ~= 0 then
					local var_380_8 = manager.audio:GetVoiceLength("story_v_out_121491", "121491092", "story_v_out_121491.awb") / 1000

					if var_380_8 + var_380_2 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_8 + var_380_2
					end

					if var_380_4.prefab_name ~= "" and arg_377_1.actors_[var_380_4.prefab_name] ~= nil then
						local var_380_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_4.prefab_name].transform, "story_v_out_121491", "121491092", "story_v_out_121491.awb")

						arg_377_1:RecordAudio("121491092", var_380_9)
						arg_377_1:RecordAudio("121491092", var_380_9)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_121491", "121491092", "story_v_out_121491.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_121491", "121491092", "story_v_out_121491.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_10 = math.max(var_380_3, arg_377_1.talkMaxDuration)

			if var_380_2 <= arg_377_1.time_ and arg_377_1.time_ < var_380_2 + var_380_10 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_2) / var_380_10

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_2 + var_380_10 and arg_377_1.time_ < var_380_2 + var_380_10 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play121491093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 121491093
		arg_381_1.duration_ = 2

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play121491094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos1184ui_story = arg_381_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_384_0 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 then
				arg_381_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_381_1.time_ - 0) / var_384_0)
				arg_381_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1184ui_story"].transform.position).z)
				arg_381_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1184ui_story"].transform.localEulerAngles = arg_381_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 then
				arg_381_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_381_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1184ui_story"].transform.position).z)
				arg_381_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1184ui_story"].transform.localEulerAngles = arg_381_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_384_1 = arg_381_1.actors_["1184ui_story"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect1184ui_story == nil then
				arg_381_1.var_.characterEffect1184ui_story = var_384_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_2 and not isNil(var_384_1) then
				if arg_381_1.var_.characterEffect1184ui_story and not isNil(var_384_1) then
					arg_381_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_381_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_381_1.time_ - 0) / var_384_2)
				end
			end

			if arg_381_1.time_ >= 0 + var_384_2 and arg_381_1.time_ < 0 + var_384_2 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect1184ui_story then
				arg_381_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_381_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_384_3 = arg_381_1.actors_["1075ui_story"].transform

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos1075ui_story = var_384_3.localPosition
			end

			local var_384_4 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_4 then
				var_384_3.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_381_1.time_ - 0) / var_384_4)
				var_384_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_384_3.position).x, (manager.ui.mainCamera.transform.position - var_384_3.position).y, (manager.ui.mainCamera.transform.position - var_384_3.position).z)
				var_384_3.localEulerAngles.z = 0
				var_384_3.localEulerAngles.x = 0
				var_384_3.localEulerAngles = var_384_3.localEulerAngles
			end

			if arg_381_1.time_ >= 0 + var_384_4 and arg_381_1.time_ < 0 + var_384_4 + arg_384_0 then
				var_384_3.localPosition = Vector3.New(0, 100, 0)
				var_384_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_384_3.position).x, (manager.ui.mainCamera.transform.position - var_384_3.position).y, (manager.ui.mainCamera.transform.position - var_384_3.position).z)
				var_384_3.localEulerAngles.z = 0
				var_384_3.localEulerAngles.x = 0
				var_384_3.localEulerAngles = var_384_3.localEulerAngles
			end

			local var_384_5 = arg_381_1.actors_["1075ui_story"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_5) and arg_381_1.var_.characterEffect1075ui_story == nil then
				arg_381_1.var_.characterEffect1075ui_story = var_384_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_6 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_6 and not isNil(var_384_5) then
				if arg_381_1.var_.characterEffect1075ui_story and not isNil(var_384_5) then
					arg_381_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_381_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_381_1.time_ - 0) / var_384_6)
				end
			end

			if arg_381_1.time_ >= 0 + var_384_6 and arg_381_1.time_ < 0 + var_384_6 + arg_384_0 and not isNil(var_384_5) and arg_381_1.var_.characterEffect1075ui_story then
				arg_381_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_381_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_384_7 = "10042ui_story"

			if arg_381_1.actors_["10042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10042ui_story"))) then
				local var_384_8 = Object.Instantiate(Asset.Load("Char/" .. "10042ui_story"), arg_381_1.stage_.transform)

				var_384_8.name = var_384_7
				var_384_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_381_1.actors_[var_384_7] = var_384_8

				local var_384_9 = var_384_8:GetComponentInChildren(typeof(CharacterEffect))

				var_384_9.enabled = true

				local var_384_10 = GameObjectTools.GetOrAddComponent(var_384_8, typeof(DynamicBoneHelper))

				if var_384_10 then
					var_384_10:EnableDynamicBone(false)
				end

				arg_381_1:ShowWeapon(var_384_9.transform, false)

				arg_381_1.var_[var_384_7 .. "Animator"] = var_384_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_381_1.var_[var_384_7 .. "Animator"].applyRootMotion = true
				arg_381_1.var_[var_384_7 .. "LipSync"] = var_384_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_384_11 = arg_381_1.actors_["10042ui_story"].transform

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos10042ui_story = var_384_11.localPosition
			end

			local var_384_12 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_12 then
				var_384_11.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos10042ui_story, Vector3.New(0, -1.12, -6.2), (arg_381_1.time_ - 0) / var_384_12)
				var_384_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_384_11.position).x, (manager.ui.mainCamera.transform.position - var_384_11.position).y, (manager.ui.mainCamera.transform.position - var_384_11.position).z)
				var_384_11.localEulerAngles.z = 0
				var_384_11.localEulerAngles.x = 0
				var_384_11.localEulerAngles = var_384_11.localEulerAngles
			end

			if arg_381_1.time_ >= 0 + var_384_12 and arg_381_1.time_ < 0 + var_384_12 + arg_384_0 then
				var_384_11.localPosition = Vector3.New(0, -1.12, -6.2)
				var_384_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_384_11.position).x, (manager.ui.mainCamera.transform.position - var_384_11.position).y, (manager.ui.mainCamera.transform.position - var_384_11.position).z)
				var_384_11.localEulerAngles.z = 0
				var_384_11.localEulerAngles.x = 0
				var_384_11.localEulerAngles = var_384_11.localEulerAngles
			end

			local var_384_13 = arg_381_1.actors_["10042ui_story"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_13) and arg_381_1.var_.characterEffect10042ui_story == nil then
				arg_381_1.var_.characterEffect10042ui_story = var_384_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_14 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_14 and not isNil(var_384_13) then
				if arg_381_1.var_.characterEffect10042ui_story and not isNil(var_384_13) then
					arg_381_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_14 and arg_381_1.time_ < 0 + var_384_14 + arg_384_0 and not isNil(var_384_13) and arg_381_1.var_.characterEffect10042ui_story then
				arg_381_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action2_1")
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_384_16 = 0
			local var_384_17 = 0.1

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_16 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_18 = arg_381_1:GetWordFromCfg(121491093)
				local var_384_19 = arg_381_1:FormatText(var_384_18.content)

				arg_381_1.text_.text = var_384_19

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_21 = 4 <= 0 and var_384_17 or var_384_17 * (utf8.len(var_384_19) / 4)

				if (4 <= 0 and var_384_17 or var_384_17 * (utf8.len(var_384_19) / 4)) > 0 and var_384_17 < var_384_21 then
					arg_381_1.talkMaxDuration = var_384_21

					if var_384_21 + var_384_16 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_21 + var_384_16
					end
				end

				arg_381_1.text_.text = var_384_19
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491093", "story_v_out_121491.awb") ~= 0 then
					local var_384_22 = manager.audio:GetVoiceLength("story_v_out_121491", "121491093", "story_v_out_121491.awb") / 1000

					if var_384_22 + var_384_16 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_22 + var_384_16
					end

					if var_384_18.prefab_name ~= "" and arg_381_1.actors_[var_384_18.prefab_name] ~= nil then
						local var_384_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_18.prefab_name].transform, "story_v_out_121491", "121491093", "story_v_out_121491.awb")

						arg_381_1:RecordAudio("121491093", var_384_23)
						arg_381_1:RecordAudio("121491093", var_384_23)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_121491", "121491093", "story_v_out_121491.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_121491", "121491093", "story_v_out_121491.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_24 = math.max(var_384_17, arg_381_1.talkMaxDuration)

			if var_384_16 <= arg_381_1.time_ and arg_381_1.time_ < var_384_16 + var_384_24 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_16) / var_384_24

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_16 + var_384_24 and arg_381_1.time_ < var_384_16 + var_384_24 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
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

		arg_381_1:InitPlayNodeList()
	end,
	Play121491094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 121491094
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play121491095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["10042ui_story"]) and arg_385_1.var_.characterEffect10042ui_story == nil then
				arg_385_1.var_.characterEffect10042ui_story = arg_385_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_0 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["10042ui_story"]) then
				if arg_385_1.var_.characterEffect10042ui_story and not isNil(arg_385_1.actors_["10042ui_story"]) then
					arg_385_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_385_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_0)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["10042ui_story"]) and arg_385_1.var_.characterEffect10042ui_story then
				arg_385_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_385_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			local var_388_1 = 0
			local var_388_2 = 1.075

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_3 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(121491094).content)

				arg_385_1.text_.text = var_388_3

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_5 = 43 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 43)

				if (43 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 43)) > 0 and var_388_2 < var_388_5 then
					arg_385_1.talkMaxDuration = var_388_5

					if var_388_5 + var_388_1 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + var_388_1
					end
				end

				arg_385_1.text_.text = var_388_3
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_6 = math.max(var_388_2, arg_385_1.talkMaxDuration)

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_6 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_1) / var_388_6

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_1 + var_388_6 and arg_385_1.time_ < var_388_1 + var_388_6 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play121491095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 121491095
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play121491096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0.7

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_1 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(121491095).content)

				arg_389_1.text_.text = var_392_1

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_3 = 28 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_1) / 28)

				if (28 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_1) / 28)) > 0 and var_392_0 < var_392_3 then
					arg_389_1.talkMaxDuration = var_392_3

					if var_392_3 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_3 + 0
					end
				end

				arg_389_1.text_.text = var_392_1
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_4 = math.max(var_392_0, arg_389_1.talkMaxDuration)

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_4 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - 0) / var_392_4

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= 0 + var_392_4 and arg_389_1.time_ < 0 + var_392_4 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play121491096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 121491096
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play121491097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0.45

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_1 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(121491096).content)

				arg_393_1.text_.text = var_396_1

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_3 = 18 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 18)

				if (18 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 18)) > 0 and var_396_0 < var_396_3 then
					arg_393_1.talkMaxDuration = var_396_3

					if var_396_3 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_3 + 0
					end
				end

				arg_393_1.text_.text = var_396_1
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_4 = math.max(var_396_0, arg_393_1.talkMaxDuration)

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_4 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - 0) / var_396_4

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= 0 + var_396_4 and arg_393_1.time_ < 0 + var_396_4 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play121491097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 121491097
		arg_397_1.duration_ = 8

		local var_397_0 = {
			ja = 4.633,
			ko = 8,
			zh = 8
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play121491098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["10042ui_story"]) and arg_397_1.var_.characterEffect10042ui_story == nil then
				arg_397_1.var_.characterEffect10042ui_story = arg_397_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_0 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["10042ui_story"]) then
				if arg_397_1.var_.characterEffect10042ui_story and not isNil(arg_397_1.actors_["10042ui_story"]) then
					arg_397_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["10042ui_story"]) and arg_397_1.var_.characterEffect10042ui_story then
				arg_397_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042actionlink/10042action423")
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_400_2 = 0
			local var_400_3 = 0.95

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_2 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_4 = arg_397_1:GetWordFromCfg(121491097)
				local var_400_5 = arg_397_1:FormatText(var_400_4.content)

				arg_397_1.text_.text = var_400_5

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_7 = 37 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_5) / 37)

				if (37 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_5) / 37)) > 0 and var_400_3 < var_400_7 then
					arg_397_1.talkMaxDuration = var_400_7

					if var_400_7 + var_400_2 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_7 + var_400_2
					end
				end

				arg_397_1.text_.text = var_400_5
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491097", "story_v_out_121491.awb") ~= 0 then
					local var_400_8 = manager.audio:GetVoiceLength("story_v_out_121491", "121491097", "story_v_out_121491.awb") / 1000

					if var_400_8 + var_400_2 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_8 + var_400_2
					end

					if var_400_4.prefab_name ~= "" and arg_397_1.actors_[var_400_4.prefab_name] ~= nil then
						local var_400_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_4.prefab_name].transform, "story_v_out_121491", "121491097", "story_v_out_121491.awb")

						arg_397_1:RecordAudio("121491097", var_400_9)
						arg_397_1:RecordAudio("121491097", var_400_9)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_121491", "121491097", "story_v_out_121491.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_121491", "121491097", "story_v_out_121491.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_10 = math.max(var_400_3, arg_397_1.talkMaxDuration)

			if var_400_2 <= arg_397_1.time_ and arg_397_1.time_ < var_400_2 + var_400_10 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_2) / var_400_10

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_2 + var_400_10 and arg_397_1.time_ < var_400_2 + var_400_10 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play121491098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 121491098
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play121491099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["10042ui_story"]) and arg_401_1.var_.characterEffect10042ui_story == nil then
				arg_401_1.var_.characterEffect10042ui_story = arg_401_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_0 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["10042ui_story"]) then
				if arg_401_1.var_.characterEffect10042ui_story and not isNil(arg_401_1.actors_["10042ui_story"]) then
					arg_401_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_401_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_401_1.time_ - 0) / var_404_0)
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["10042ui_story"]) and arg_401_1.var_.characterEffect10042ui_story then
				arg_401_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_401_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			local var_404_1 = 0
			local var_404_2 = 0.15

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_3 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(121491098).content)

				arg_401_1.text_.text = var_404_3

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_5 = 6 <= 0 and var_404_2 or var_404_2 * (utf8.len(var_404_3) / 6)

				if (6 <= 0 and var_404_2 or var_404_2 * (utf8.len(var_404_3) / 6)) > 0 and var_404_2 < var_404_5 then
					arg_401_1.talkMaxDuration = var_404_5

					if var_404_5 + var_404_1 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_5 + var_404_1
					end
				end

				arg_401_1.text_.text = var_404_3
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_6 = math.max(var_404_2, arg_401_1.talkMaxDuration)

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_6 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_1) / var_404_6

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_1 + var_404_6 and arg_401_1.time_ < var_404_1 + var_404_6 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play121491099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 121491099
		arg_405_1.duration_ = 3.53

		local var_405_0 = {
			ja = 3.533,
			ko = 2.7,
			zh = 2.7
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play121491100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0.275

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[440].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_1 = arg_405_1:GetWordFromCfg(121491099)
				local var_408_2 = arg_405_1:FormatText(var_408_1.content)

				arg_405_1.text_.text = var_408_2

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_4 = 11 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_2) / 11)

				if (11 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_2) / 11)) > 0 and var_408_0 < var_408_4 then
					arg_405_1.talkMaxDuration = var_408_4

					if var_408_4 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_4 + 0
					end
				end

				arg_405_1.text_.text = var_408_2
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491099", "story_v_out_121491.awb") ~= 0 then
					local var_408_5 = manager.audio:GetVoiceLength("story_v_out_121491", "121491099", "story_v_out_121491.awb") / 1000

					if var_408_5 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_5 + 0
					end

					if var_408_1.prefab_name ~= "" and arg_405_1.actors_[var_408_1.prefab_name] ~= nil then
						local var_408_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_1.prefab_name].transform, "story_v_out_121491", "121491099", "story_v_out_121491.awb")

						arg_405_1:RecordAudio("121491099", var_408_6)
						arg_405_1:RecordAudio("121491099", var_408_6)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_121491", "121491099", "story_v_out_121491.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_121491", "121491099", "story_v_out_121491.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_7 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_7 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_7

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_7 and arg_405_1.time_ < 0 + var_408_7 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play121491100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 121491100
		arg_409_1.duration_ = 2

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play121491101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["10042ui_story"]) and arg_409_1.var_.characterEffect10042ui_story == nil then
				arg_409_1.var_.characterEffect10042ui_story = arg_409_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_0 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["10042ui_story"]) then
				if arg_409_1.var_.characterEffect10042ui_story and not isNil(arg_409_1.actors_["10042ui_story"]) then
					arg_409_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["10042ui_story"]) and arg_409_1.var_.characterEffect10042ui_story then
				arg_409_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action3_2")
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_412_2 = 0
			local var_412_3 = 0.2

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_2 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_4 = arg_409_1:GetWordFromCfg(121491100)
				local var_412_5 = arg_409_1:FormatText(var_412_4.content)

				arg_409_1.text_.text = var_412_5

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_7 = 8 <= 0 and var_412_3 or var_412_3 * (utf8.len(var_412_5) / 8)

				if (8 <= 0 and var_412_3 or var_412_3 * (utf8.len(var_412_5) / 8)) > 0 and var_412_3 < var_412_7 then
					arg_409_1.talkMaxDuration = var_412_7

					if var_412_7 + var_412_2 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_2
					end
				end

				arg_409_1.text_.text = var_412_5
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491100", "story_v_out_121491.awb") ~= 0 then
					local var_412_8 = manager.audio:GetVoiceLength("story_v_out_121491", "121491100", "story_v_out_121491.awb") / 1000

					if var_412_8 + var_412_2 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_8 + var_412_2
					end

					if var_412_4.prefab_name ~= "" and arg_409_1.actors_[var_412_4.prefab_name] ~= nil then
						local var_412_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_4.prefab_name].transform, "story_v_out_121491", "121491100", "story_v_out_121491.awb")

						arg_409_1:RecordAudio("121491100", var_412_9)
						arg_409_1:RecordAudio("121491100", var_412_9)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_121491", "121491100", "story_v_out_121491.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_121491", "121491100", "story_v_out_121491.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_10 = math.max(var_412_3, arg_409_1.talkMaxDuration)

			if var_412_2 <= arg_409_1.time_ and arg_409_1.time_ < var_412_2 + var_412_10 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_2) / var_412_10

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_2 + var_412_10 and arg_409_1.time_ < var_412_2 + var_412_10 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play121491101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 121491101
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play121491102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(arg_413_1.actors_["10042ui_story"]) and arg_413_1.var_.characterEffect10042ui_story == nil then
				arg_413_1.var_.characterEffect10042ui_story = arg_413_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_0 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 and not isNil(arg_413_1.actors_["10042ui_story"]) then
				if arg_413_1.var_.characterEffect10042ui_story and not isNil(arg_413_1.actors_["10042ui_story"]) then
					arg_413_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_413_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_413_1.time_ - 0) / var_416_0)
				end
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 and not isNil(arg_413_1.actors_["10042ui_story"]) and arg_413_1.var_.characterEffect10042ui_story then
				arg_413_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_413_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			local var_416_1 = 0
			local var_416_2 = 1.35

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_3 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(121491101).content)

				arg_413_1.text_.text = var_416_3

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_5 = 54 <= 0 and var_416_2 or var_416_2 * (utf8.len(var_416_3) / 54)

				if (54 <= 0 and var_416_2 or var_416_2 * (utf8.len(var_416_3) / 54)) > 0 and var_416_2 < var_416_5 then
					arg_413_1.talkMaxDuration = var_416_5

					if var_416_5 + var_416_1 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_5 + var_416_1
					end
				end

				arg_413_1.text_.text = var_416_3
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_6 = math.max(var_416_2, arg_413_1.talkMaxDuration)

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_6 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_1) / var_416_6

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_1 + var_416_6 and arg_413_1.time_ < var_416_1 + var_416_6 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play121491102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 121491102
		arg_417_1.duration_ = 8.27

		local var_417_0 = {
			ja = 8.266,
			ko = 3.666,
			zh = 3.666
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play121491103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0.425

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[440].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_1 = arg_417_1:GetWordFromCfg(121491102)
				local var_420_2 = arg_417_1:FormatText(var_420_1.content)

				arg_417_1.text_.text = var_420_2

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_4 = 17 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_2) / 17)

				if (17 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_2) / 17)) > 0 and var_420_0 < var_420_4 then
					arg_417_1.talkMaxDuration = var_420_4

					if var_420_4 + 0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_4 + 0
					end
				end

				arg_417_1.text_.text = var_420_2
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491102", "story_v_out_121491.awb") ~= 0 then
					local var_420_5 = manager.audio:GetVoiceLength("story_v_out_121491", "121491102", "story_v_out_121491.awb") / 1000

					if var_420_5 + 0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_5 + 0
					end

					if var_420_1.prefab_name ~= "" and arg_417_1.actors_[var_420_1.prefab_name] ~= nil then
						local var_420_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_1.prefab_name].transform, "story_v_out_121491", "121491102", "story_v_out_121491.awb")

						arg_417_1:RecordAudio("121491102", var_420_6)
						arg_417_1:RecordAudio("121491102", var_420_6)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_121491", "121491102", "story_v_out_121491.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_121491", "121491102", "story_v_out_121491.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_7 = math.max(var_420_0, arg_417_1.talkMaxDuration)

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_7 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - 0) / var_420_7

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= 0 + var_420_7 and arg_417_1.time_ < 0 + var_420_7 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play121491103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 121491103
		arg_421_1.duration_ = 14.1

		local var_421_0 = {
			ja = 14.1,
			ko = 10.5,
			zh = 10.5
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play121491104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 1.125

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[440].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_1 = arg_421_1:GetWordFromCfg(121491103)
				local var_424_2 = arg_421_1:FormatText(var_424_1.content)

				arg_421_1.text_.text = var_424_2

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_4 = 45 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_2) / 45)

				if (45 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_2) / 45)) > 0 and var_424_0 < var_424_4 then
					arg_421_1.talkMaxDuration = var_424_4

					if var_424_4 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_4 + 0
					end
				end

				arg_421_1.text_.text = var_424_2
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491103", "story_v_out_121491.awb") ~= 0 then
					local var_424_5 = manager.audio:GetVoiceLength("story_v_out_121491", "121491103", "story_v_out_121491.awb") / 1000

					if var_424_5 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + 0
					end

					if var_424_1.prefab_name ~= "" and arg_421_1.actors_[var_424_1.prefab_name] ~= nil then
						local var_424_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_1.prefab_name].transform, "story_v_out_121491", "121491103", "story_v_out_121491.awb")

						arg_421_1:RecordAudio("121491103", var_424_6)
						arg_421_1:RecordAudio("121491103", var_424_6)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_121491", "121491103", "story_v_out_121491.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_121491", "121491103", "story_v_out_121491.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_7 = math.max(var_424_0, arg_421_1.talkMaxDuration)

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_7 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - 0) / var_424_7

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= 0 + var_424_7 and arg_421_1.time_ < 0 + var_424_7 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play121491104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 121491104
		arg_425_1.duration_ = 12.17

		local var_425_0 = {
			ja = 12.166,
			ko = 10.8,
			zh = 10.8
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play121491105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 1.1

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[440].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_1 = arg_425_1:GetWordFromCfg(121491104)
				local var_428_2 = arg_425_1:FormatText(var_428_1.content)

				arg_425_1.text_.text = var_428_2

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_4 = 44 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_2) / 44)

				if (44 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_2) / 44)) > 0 and var_428_0 < var_428_4 then
					arg_425_1.talkMaxDuration = var_428_4

					if var_428_4 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_4 + 0
					end
				end

				arg_425_1.text_.text = var_428_2
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491104", "story_v_out_121491.awb") ~= 0 then
					local var_428_5 = manager.audio:GetVoiceLength("story_v_out_121491", "121491104", "story_v_out_121491.awb") / 1000

					if var_428_5 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_5 + 0
					end

					if var_428_1.prefab_name ~= "" and arg_425_1.actors_[var_428_1.prefab_name] ~= nil then
						local var_428_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_1.prefab_name].transform, "story_v_out_121491", "121491104", "story_v_out_121491.awb")

						arg_425_1:RecordAudio("121491104", var_428_6)
						arg_425_1:RecordAudio("121491104", var_428_6)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_121491", "121491104", "story_v_out_121491.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_121491", "121491104", "story_v_out_121491.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_7 = math.max(var_428_0, arg_425_1.talkMaxDuration)

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_7 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - 0) / var_428_7

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= 0 + var_428_7 and arg_425_1.time_ < 0 + var_428_7 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play121491105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 121491105
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play121491106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 0.875

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_1 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(121491105).content)

				arg_429_1.text_.text = var_432_1

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_3 = 35 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_1) / 35)

				if (35 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_1) / 35)) > 0 and var_432_0 < var_432_3 then
					arg_429_1.talkMaxDuration = var_432_3

					if var_432_3 + 0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_3 + 0
					end
				end

				arg_429_1.text_.text = var_432_1
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_4 = math.max(var_432_0, arg_429_1.talkMaxDuration)

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_4 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - 0) / var_432_4

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= 0 + var_432_4 and arg_429_1.time_ < 0 + var_432_4 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play121491106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 121491106
		arg_433_1.duration_ = 13.53

		local var_433_0 = {
			ja = 13.533,
			ko = 5.333,
			zh = 5.333
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play121491107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0.625

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[440].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, true)
				arg_433_1.iconController_:SetSelectedState("hero")

				arg_433_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_433_1.callingController_:SetSelectedState("normal")

				arg_433_1.keyicon_.color = Color.New(1, 1, 1)
				arg_433_1.icon_.color = Color.New(1, 1, 1)

				local var_436_1 = arg_433_1:GetWordFromCfg(121491106)
				local var_436_2 = arg_433_1:FormatText(var_436_1.content)

				arg_433_1.text_.text = var_436_2

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_4 = 25 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_2) / 25)

				if (25 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_2) / 25)) > 0 and var_436_0 < var_436_4 then
					arg_433_1.talkMaxDuration = var_436_4

					if var_436_4 + 0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_4 + 0
					end
				end

				arg_433_1.text_.text = var_436_2
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491106", "story_v_out_121491.awb") ~= 0 then
					local var_436_5 = manager.audio:GetVoiceLength("story_v_out_121491", "121491106", "story_v_out_121491.awb") / 1000

					if var_436_5 + 0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_5 + 0
					end

					if var_436_1.prefab_name ~= "" and arg_433_1.actors_[var_436_1.prefab_name] ~= nil then
						local var_436_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_1.prefab_name].transform, "story_v_out_121491", "121491106", "story_v_out_121491.awb")

						arg_433_1:RecordAudio("121491106", var_436_6)
						arg_433_1:RecordAudio("121491106", var_436_6)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_121491", "121491106", "story_v_out_121491.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_121491", "121491106", "story_v_out_121491.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_7 = math.max(var_436_0, arg_433_1.talkMaxDuration)

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_7 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - 0) / var_436_7

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= 0 + var_436_7 and arg_433_1.time_ < 0 + var_436_7 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play121491107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 121491107
		arg_437_1.duration_ = 2

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play121491108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["10042ui_story"]) and arg_437_1.var_.characterEffect10042ui_story == nil then
				arg_437_1.var_.characterEffect10042ui_story = arg_437_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_0 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["10042ui_story"]) then
				if arg_437_1.var_.characterEffect10042ui_story and not isNil(arg_437_1.actors_["10042ui_story"]) then
					arg_437_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["10042ui_story"]) and arg_437_1.var_.characterEffect10042ui_story then
				arg_437_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action1_1")
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_440_2 = 0
			local var_440_3 = 0.075

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_2 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_4 = arg_437_1:GetWordFromCfg(121491107)
				local var_440_5 = arg_437_1:FormatText(var_440_4.content)

				arg_437_1.text_.text = var_440_5

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_7 = 3 <= 0 and var_440_3 or var_440_3 * (utf8.len(var_440_5) / 3)

				if (3 <= 0 and var_440_3 or var_440_3 * (utf8.len(var_440_5) / 3)) > 0 and var_440_3 < var_440_7 then
					arg_437_1.talkMaxDuration = var_440_7

					if var_440_7 + var_440_2 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_7 + var_440_2
					end
				end

				arg_437_1.text_.text = var_440_5
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491107", "story_v_out_121491.awb") ~= 0 then
					local var_440_8 = manager.audio:GetVoiceLength("story_v_out_121491", "121491107", "story_v_out_121491.awb") / 1000

					if var_440_8 + var_440_2 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_8 + var_440_2
					end

					if var_440_4.prefab_name ~= "" and arg_437_1.actors_[var_440_4.prefab_name] ~= nil then
						local var_440_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_4.prefab_name].transform, "story_v_out_121491", "121491107", "story_v_out_121491.awb")

						arg_437_1:RecordAudio("121491107", var_440_9)
						arg_437_1:RecordAudio("121491107", var_440_9)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_121491", "121491107", "story_v_out_121491.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_121491", "121491107", "story_v_out_121491.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_10 = math.max(var_440_3, arg_437_1.talkMaxDuration)

			if var_440_2 <= arg_437_1.time_ and arg_437_1.time_ < var_440_2 + var_440_10 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_2) / var_440_10

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_2 + var_440_10 and arg_437_1.time_ < var_440_2 + var_440_10 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play121491108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 121491108
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play121491109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(arg_441_1.actors_["10042ui_story"]) and arg_441_1.var_.characterEffect10042ui_story == nil then
				arg_441_1.var_.characterEffect10042ui_story = arg_441_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_0 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 and not isNil(arg_441_1.actors_["10042ui_story"]) then
				if arg_441_1.var_.characterEffect10042ui_story and not isNil(arg_441_1.actors_["10042ui_story"]) then
					arg_441_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_441_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_441_1.time_ - 0) / var_444_0)
				end
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 and not isNil(arg_441_1.actors_["10042ui_story"]) and arg_441_1.var_.characterEffect10042ui_story then
				arg_441_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_441_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			local var_444_1 = 0
			local var_444_2 = 0.525

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, false)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_3 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(121491108).content)

				arg_441_1.text_.text = var_444_3

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_5 = 21 <= 0 and var_444_2 or var_444_2 * (utf8.len(var_444_3) / 21)

				if (21 <= 0 and var_444_2 or var_444_2 * (utf8.len(var_444_3) / 21)) > 0 and var_444_2 < var_444_5 then
					arg_441_1.talkMaxDuration = var_444_5

					if var_444_5 + var_444_1 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_5 + var_444_1
					end
				end

				arg_441_1.text_.text = var_444_3
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_6 = math.max(var_444_2, arg_441_1.talkMaxDuration)

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_6 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_1) / var_444_6

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_1 + var_444_6 and arg_441_1.time_ < var_444_1 + var_444_6 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play121491109 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 121491109
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play121491110(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 1.35

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_1 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(121491109).content)

				arg_445_1.text_.text = var_448_1

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_3 = 54 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_1) / 54)

				if (54 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_1) / 54)) > 0 and var_448_0 < var_448_3 then
					arg_445_1.talkMaxDuration = var_448_3

					if var_448_3 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_3 + 0
					end
				end

				arg_445_1.text_.text = var_448_1
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_4 = math.max(var_448_0, arg_445_1.talkMaxDuration)

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_4 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - 0) / var_448_4

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= 0 + var_448_4 and arg_445_1.time_ < 0 + var_448_4 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play121491110 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 121491110
		arg_449_1.duration_ = 5.23

		local var_449_0 = {
			ja = 4.6,
			ko = 5.233,
			zh = 5.233
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play121491111(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(arg_449_1.actors_["10042ui_story"]) and arg_449_1.var_.characterEffect10042ui_story == nil then
				arg_449_1.var_.characterEffect10042ui_story = arg_449_1.actors_["10042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_0 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 and not isNil(arg_449_1.actors_["10042ui_story"]) then
				if arg_449_1.var_.characterEffect10042ui_story and not isNil(arg_449_1.actors_["10042ui_story"]) then
					arg_449_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 and not isNil(arg_449_1.actors_["10042ui_story"]) and arg_449_1.var_.characterEffect10042ui_story then
				arg_449_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action1_1")
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_452_2 = 0
			local var_452_3 = 0.525

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_2 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_4 = arg_449_1:GetWordFromCfg(121491110)
				local var_452_5 = arg_449_1:FormatText(var_452_4.content)

				arg_449_1.text_.text = var_452_5

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_7 = 20 <= 0 and var_452_3 or var_452_3 * (utf8.len(var_452_5) / 20)

				if (20 <= 0 and var_452_3 or var_452_3 * (utf8.len(var_452_5) / 20)) > 0 and var_452_3 < var_452_7 then
					arg_449_1.talkMaxDuration = var_452_7

					if var_452_7 + var_452_2 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_7 + var_452_2
					end
				end

				arg_449_1.text_.text = var_452_5
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491110", "story_v_out_121491.awb") ~= 0 then
					local var_452_8 = manager.audio:GetVoiceLength("story_v_out_121491", "121491110", "story_v_out_121491.awb") / 1000

					if var_452_8 + var_452_2 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_8 + var_452_2
					end

					if var_452_4.prefab_name ~= "" and arg_449_1.actors_[var_452_4.prefab_name] ~= nil then
						local var_452_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_4.prefab_name].transform, "story_v_out_121491", "121491110", "story_v_out_121491.awb")

						arg_449_1:RecordAudio("121491110", var_452_9)
						arg_449_1:RecordAudio("121491110", var_452_9)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_121491", "121491110", "story_v_out_121491.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_121491", "121491110", "story_v_out_121491.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_10 = math.max(var_452_3, arg_449_1.talkMaxDuration)

			if var_452_2 <= arg_449_1.time_ and arg_449_1.time_ < var_452_2 + var_452_10 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_2) / var_452_10

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_2 + var_452_10 and arg_449_1.time_ < var_452_2 + var_452_10 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play121491111 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 121491111
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play121491112(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos10042ui_story = arg_453_1.actors_["10042ui_story"].transform.localPosition
			end

			local var_456_0 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 then
				arg_453_1.actors_["10042ui_story"].transform.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos10042ui_story, Vector3.New(0, 100, 0), (arg_453_1.time_ - 0) / var_456_0)
				arg_453_1.actors_["10042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["10042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["10042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["10042ui_story"].transform.position).z)
				arg_453_1.actors_["10042ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["10042ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["10042ui_story"].transform.localEulerAngles = arg_453_1.actors_["10042ui_story"].transform.localEulerAngles
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 then
				arg_453_1.actors_["10042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_453_1.actors_["10042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["10042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["10042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["10042ui_story"].transform.position).z)
				arg_453_1.actors_["10042ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["10042ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["10042ui_story"].transform.localEulerAngles = arg_453_1.actors_["10042ui_story"].transform.localEulerAngles
			end

			local var_456_1 = arg_453_1.actors_["10042ui_story"]

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect10042ui_story == nil then
				arg_453_1.var_.characterEffect10042ui_story = var_456_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_2 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_2 and not isNil(var_456_1) then
				if arg_453_1.var_.characterEffect10042ui_story and not isNil(var_456_1) then
					arg_453_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_453_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_453_1.time_ - 0) / var_456_2)
				end
			end

			if arg_453_1.time_ >= 0 + var_456_2 and arg_453_1.time_ < 0 + var_456_2 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect10042ui_story then
				arg_453_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_453_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			local var_456_3 = 0
			local var_456_4 = 0.775

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_3 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_5 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(121491111).content)

				arg_453_1.text_.text = var_456_5

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_7 = 25 <= 0 and var_456_4 or var_456_4 * (utf8.len(var_456_5) / 25)

				if (25 <= 0 and var_456_4 or var_456_4 * (utf8.len(var_456_5) / 25)) > 0 and var_456_4 < var_456_7 then
					arg_453_1.talkMaxDuration = var_456_7

					if var_456_7 + var_456_3 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_7 + var_456_3
					end
				end

				arg_453_1.text_.text = var_456_5
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_8 = math.max(var_456_4, arg_453_1.talkMaxDuration)

			if var_456_3 <= arg_453_1.time_ and arg_453_1.time_ < var_456_3 + var_456_8 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_3) / var_456_8

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_3 + var_456_8 and arg_453_1.time_ < var_456_3 + var_456_8 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
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

		arg_453_1:InitPlayNodeList()
	end,
	Play121491112 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 121491112
		arg_457_1.duration_ = 8

		local var_457_0 = {
			ja = 8,
			ko = 7.933,
			zh = 7.933
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play121491113(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos1184ui_story = arg_457_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_460_0 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 then
				arg_457_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1184ui_story, Vector3.New(-0.7, -0.97, -6), (arg_457_1.time_ - 0) / var_460_0)
				arg_457_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1184ui_story"].transform.position).z)
				arg_457_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["1184ui_story"].transform.localEulerAngles = arg_457_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 then
				arg_457_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_457_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1184ui_story"].transform.position).z)
				arg_457_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["1184ui_story"].transform.localEulerAngles = arg_457_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_460_1 = arg_457_1.actors_["1184ui_story"]

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(var_460_1) and arg_457_1.var_.characterEffect1184ui_story == nil then
				arg_457_1.var_.characterEffect1184ui_story = var_460_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_2 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_2 and not isNil(var_460_1) then
				if arg_457_1.var_.characterEffect1184ui_story and not isNil(var_460_1) then
					arg_457_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_457_1.time_ >= 0 + var_460_2 and arg_457_1.time_ < 0 + var_460_2 + arg_460_0 and not isNil(var_460_1) and arg_457_1.var_.characterEffect1184ui_story then
				arg_457_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_460_4 = arg_457_1.actors_["1075ui_story"].transform

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos1075ui_story = var_460_4.localPosition
			end

			local var_460_5 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_5 then
				var_460_4.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_457_1.time_ - 0) / var_460_5)
				var_460_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_460_4.position).x, (manager.ui.mainCamera.transform.position - var_460_4.position).y, (manager.ui.mainCamera.transform.position - var_460_4.position).z)
				var_460_4.localEulerAngles.z = 0
				var_460_4.localEulerAngles.x = 0
				var_460_4.localEulerAngles = var_460_4.localEulerAngles
			end

			if arg_457_1.time_ >= 0 + var_460_5 and arg_457_1.time_ < 0 + var_460_5 + arg_460_0 then
				var_460_4.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_460_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_460_4.position).x, (manager.ui.mainCamera.transform.position - var_460_4.position).y, (manager.ui.mainCamera.transform.position - var_460_4.position).z)
				var_460_4.localEulerAngles.z = 0
				var_460_4.localEulerAngles.x = 0
				var_460_4.localEulerAngles = var_460_4.localEulerAngles
			end

			local var_460_6 = arg_457_1.actors_["1075ui_story"]

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(var_460_6) and arg_457_1.var_.characterEffect1075ui_story == nil then
				arg_457_1.var_.characterEffect1075ui_story = var_460_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_7 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_7 and not isNil(var_460_6) then
				if arg_457_1.var_.characterEffect1075ui_story and not isNil(var_460_6) then
					arg_457_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_457_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_457_1.time_ - 0) / var_460_7)
				end
			end

			if arg_457_1.time_ >= 0 + var_460_7 and arg_457_1.time_ < 0 + var_460_7 + arg_460_0 and not isNil(var_460_6) and arg_457_1.var_.characterEffect1075ui_story then
				arg_457_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_457_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_460_8 = 0
			local var_460_9 = 1

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_8 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_10 = arg_457_1:GetWordFromCfg(121491112)
				local var_460_11 = arg_457_1:FormatText(var_460_10.content)

				arg_457_1.text_.text = var_460_11

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_13 = 40 <= 0 and var_460_9 or var_460_9 * (utf8.len(var_460_11) / 40)

				if (40 <= 0 and var_460_9 or var_460_9 * (utf8.len(var_460_11) / 40)) > 0 and var_460_9 < var_460_13 then
					arg_457_1.talkMaxDuration = var_460_13

					if var_460_13 + var_460_8 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_13 + var_460_8
					end
				end

				arg_457_1.text_.text = var_460_11
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491112", "story_v_out_121491.awb") ~= 0 then
					local var_460_14 = manager.audio:GetVoiceLength("story_v_out_121491", "121491112", "story_v_out_121491.awb") / 1000

					if var_460_14 + var_460_8 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_14 + var_460_8
					end

					if var_460_10.prefab_name ~= "" and arg_457_1.actors_[var_460_10.prefab_name] ~= nil then
						local var_460_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_10.prefab_name].transform, "story_v_out_121491", "121491112", "story_v_out_121491.awb")

						arg_457_1:RecordAudio("121491112", var_460_15)
						arg_457_1:RecordAudio("121491112", var_460_15)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_121491", "121491112", "story_v_out_121491.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_121491", "121491112", "story_v_out_121491.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_16 = math.max(var_460_9, arg_457_1.talkMaxDuration)

			if var_460_8 <= arg_457_1.time_ and arg_457_1.time_ < var_460_8 + var_460_16 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_8) / var_460_16

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_8 + var_460_16 and arg_457_1.time_ < var_460_8 + var_460_16 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
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

		arg_457_1:InitPlayNodeList()
	end,
	Play121491113 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 121491113
		arg_461_1.duration_ = 10

		local var_461_0 = {
			ja = 9.066,
			ko = 10,
			zh = 10
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play121491114(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["1184ui_story"]) and arg_461_1.var_.characterEffect1184ui_story == nil then
				arg_461_1.var_.characterEffect1184ui_story = arg_461_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_0 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["1184ui_story"]) then
				if arg_461_1.var_.characterEffect1184ui_story and not isNil(arg_461_1.actors_["1184ui_story"]) then
					arg_461_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_461_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_461_1.time_ - 0) / var_464_0)
				end
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["1184ui_story"]) and arg_461_1.var_.characterEffect1184ui_story then
				arg_461_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_461_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_464_1 = arg_461_1.actors_["1075ui_story"]

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(var_464_1) and arg_461_1.var_.characterEffect1075ui_story == nil then
				arg_461_1.var_.characterEffect1075ui_story = var_464_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_2 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_2 and not isNil(var_464_1) then
				if arg_461_1.var_.characterEffect1075ui_story and not isNil(var_464_1) then
					arg_461_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_461_1.time_ >= 0 + var_464_2 and arg_461_1.time_ < 0 + var_464_2 + arg_464_0 and not isNil(var_464_1) and arg_461_1.var_.characterEffect1075ui_story then
				arg_461_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_464_4 = 0
			local var_464_5 = 1.075

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_4 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_6 = arg_461_1:GetWordFromCfg(121491113)
				local var_464_7 = arg_461_1:FormatText(var_464_6.content)

				arg_461_1.text_.text = var_464_7

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_9 = 43 <= 0 and var_464_5 or var_464_5 * (utf8.len(var_464_7) / 43)

				if (43 <= 0 and var_464_5 or var_464_5 * (utf8.len(var_464_7) / 43)) > 0 and var_464_5 < var_464_9 then
					arg_461_1.talkMaxDuration = var_464_9

					if var_464_9 + var_464_4 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_9 + var_464_4
					end
				end

				arg_461_1.text_.text = var_464_7
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121491", "121491113", "story_v_out_121491.awb") ~= 0 then
					local var_464_10 = manager.audio:GetVoiceLength("story_v_out_121491", "121491113", "story_v_out_121491.awb") / 1000

					if var_464_10 + var_464_4 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_10 + var_464_4
					end

					if var_464_6.prefab_name ~= "" and arg_461_1.actors_[var_464_6.prefab_name] ~= nil then
						local var_464_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_6.prefab_name].transform, "story_v_out_121491", "121491113", "story_v_out_121491.awb")

						arg_461_1:RecordAudio("121491113", var_464_11)
						arg_461_1:RecordAudio("121491113", var_464_11)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_121491", "121491113", "story_v_out_121491.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_121491", "121491113", "story_v_out_121491.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_12 = math.max(var_464_5, arg_461_1.talkMaxDuration)

			if var_464_4 <= arg_461_1.time_ and arg_461_1.time_ < var_464_4 + var_464_12 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_4) / var_464_12

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_4 + var_464_12 and arg_461_1.time_ < var_464_4 + var_464_12 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play121491114 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 121491114
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play121491115(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(arg_465_1.actors_["1075ui_story"]) and arg_465_1.var_.characterEffect1075ui_story == nil then
				arg_465_1.var_.characterEffect1075ui_story = arg_465_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_0 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 and not isNil(arg_465_1.actors_["1075ui_story"]) then
				if arg_465_1.var_.characterEffect1075ui_story and not isNil(arg_465_1.actors_["1075ui_story"]) then
					arg_465_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_465_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_465_1.time_ - 0) / var_468_0)
				end
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 and not isNil(arg_465_1.actors_["1075ui_story"]) and arg_465_1.var_.characterEffect1075ui_story then
				arg_465_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_465_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_468_1 = 0
			local var_468_2 = 0.45

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_3 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(121491114).content)

				arg_465_1.text_.text = var_468_3

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_5 = 18 <= 0 and var_468_2 or var_468_2 * (utf8.len(var_468_3) / 18)

				if (18 <= 0 and var_468_2 or var_468_2 * (utf8.len(var_468_3) / 18)) > 0 and var_468_2 < var_468_5 then
					arg_465_1.talkMaxDuration = var_468_5

					if var_468_5 + var_468_1 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_5 + var_468_1
					end
				end

				arg_465_1.text_.text = var_468_3
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_6 = math.max(var_468_2, arg_465_1.talkMaxDuration)

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_6 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_1) / var_468_6

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_1 + var_468_6 and arg_465_1.time_ < var_468_1 + var_468_6 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play121491115 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 121491115
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play121491116(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.var_.moveOldPos1184ui_story = arg_469_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_472_0 = 0.001

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 then
				arg_469_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_469_1.time_ - 0) / var_472_0)
				arg_469_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_469_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["1184ui_story"].transform.position).z)
				arg_469_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_469_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_469_1.actors_["1184ui_story"].transform.localEulerAngles = arg_469_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 then
				arg_469_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_469_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_469_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["1184ui_story"].transform.position).z)
				arg_469_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_469_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_469_1.actors_["1184ui_story"].transform.localEulerAngles = arg_469_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_472_1 = arg_469_1.actors_["1184ui_story"]

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(var_472_1) and arg_469_1.var_.characterEffect1184ui_story == nil then
				arg_469_1.var_.characterEffect1184ui_story = var_472_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_2 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_2 and not isNil(var_472_1) then
				if arg_469_1.var_.characterEffect1184ui_story and not isNil(var_472_1) then
					arg_469_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_469_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_469_1.time_ - 0) / var_472_2)
				end
			end

			if arg_469_1.time_ >= 0 + var_472_2 and arg_469_1.time_ < 0 + var_472_2 + arg_472_0 and not isNil(var_472_1) and arg_469_1.var_.characterEffect1184ui_story then
				arg_469_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_469_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_472_3 = arg_469_1.actors_["1075ui_story"].transform

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.var_.moveOldPos1075ui_story = var_472_3.localPosition
			end

			local var_472_4 = 0.001

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_4 then
				var_472_3.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_469_1.time_ - 0) / var_472_4)
				var_472_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_472_3.position).x, (manager.ui.mainCamera.transform.position - var_472_3.position).y, (manager.ui.mainCamera.transform.position - var_472_3.position).z)
				var_472_3.localEulerAngles.z = 0
				var_472_3.localEulerAngles.x = 0
				var_472_3.localEulerAngles = var_472_3.localEulerAngles
			end

			if arg_469_1.time_ >= 0 + var_472_4 and arg_469_1.time_ < 0 + var_472_4 + arg_472_0 then
				var_472_3.localPosition = Vector3.New(0, 100, 0)
				var_472_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_472_3.position).x, (manager.ui.mainCamera.transform.position - var_472_3.position).y, (manager.ui.mainCamera.transform.position - var_472_3.position).z)
				var_472_3.localEulerAngles.z = 0
				var_472_3.localEulerAngles.x = 0
				var_472_3.localEulerAngles = var_472_3.localEulerAngles
			end

			local var_472_5 = arg_469_1.actors_["1075ui_story"]

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(var_472_5) and arg_469_1.var_.characterEffect1075ui_story == nil then
				arg_469_1.var_.characterEffect1075ui_story = var_472_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_6 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_6 and not isNil(var_472_5) then
				if arg_469_1.var_.characterEffect1075ui_story and not isNil(var_472_5) then
					arg_469_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_469_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_469_1.time_ - 0) / var_472_6)
				end
			end

			if arg_469_1.time_ >= 0 + var_472_6 and arg_469_1.time_ < 0 + var_472_6 + arg_472_0 and not isNil(var_472_5) and arg_469_1.var_.characterEffect1075ui_story then
				arg_469_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_469_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_472_7 = 0
			local var_472_8 = 0.5

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_7 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_9 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(121491115).content)

				arg_469_1.text_.text = var_472_9

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_11 = 20 <= 0 and var_472_8 or var_472_8 * (utf8.len(var_472_9) / 20)

				if (20 <= 0 and var_472_8 or var_472_8 * (utf8.len(var_472_9) / 20)) > 0 and var_472_8 < var_472_11 then
					arg_469_1.talkMaxDuration = var_472_11

					if var_472_11 + var_472_7 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_11 + var_472_7
					end
				end

				arg_469_1.text_.text = var_472_9
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_12 = math.max(var_472_8, arg_469_1.talkMaxDuration)

			if var_472_7 <= arg_469_1.time_ and arg_469_1.time_ < var_472_7 + var_472_12 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_7) / var_472_12

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_7 + var_472_12 and arg_469_1.time_ < var_472_7 + var_472_12 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
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

		arg_469_1:InitPlayNodeList()
	end,
	Play121491116 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 121491116
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play121491117(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 1.475

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, false)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_1 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(121491116).content)

				arg_473_1.text_.text = var_476_1

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_3 = 59 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 59)

				if (59 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 59)) > 0 and var_476_0 < var_476_3 then
					arg_473_1.talkMaxDuration = var_476_3

					if var_476_3 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_3 + 0
					end
				end

				arg_473_1.text_.text = var_476_1
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_4 = math.max(var_476_0, arg_473_1.talkMaxDuration)

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_4 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - 0) / var_476_4

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= 0 + var_476_4 and arg_473_1.time_ < 0 + var_476_4 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play121491117 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 121491117
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
			arg_477_1.auto_ = false
		end

		function arg_477_1.playNext_(arg_479_0)
			arg_477_1.onStoryFinished_()
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0.675

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, false)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_1 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(121491117).content)

				arg_477_1.text_.text = var_480_1

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_3 = 27 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_1) / 27)

				if (27 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_1) / 27)) > 0 and var_480_0 < var_480_3 then
					arg_477_1.talkMaxDuration = var_480_3

					if var_480_3 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_3 + 0
					end
				end

				arg_477_1.text_.text = var_480_1
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_4 = math.max(var_480_0, arg_477_1.talkMaxDuration)

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_4 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - 0) / var_480_4

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= 0 + var_480_4 and arg_477_1.time_ < 0 + var_480_4 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST41",
		"TextureConfig/Background/ST42",
		"TextureConfig/Background/J12g"
	},
	voices = {
		"story_v_out_121491.awb"
	}
}
