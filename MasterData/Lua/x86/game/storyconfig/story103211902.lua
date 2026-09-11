return {
	Play321192001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321192001
		arg_1_1.duration_ = 5.1

		local var_1_0 = {
			zh = 4.333,
			ja = 5.1
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
				arg_1_0:Play321192002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L15f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L15f")
				var_4_0.name = "L15f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L15f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L15f

				arg_1_1.bgs_.L15f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L15f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2.00000000298023

			if 2.00000000298023 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "1011ui_story"

			if arg_1_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1011ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1011ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0.7, -0.71, -6)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1011ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1011ui_story == nil then
				arg_1_1.var_.characterEffect1011ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1011ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1011ui_story then
				arg_1_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 2
			local var_4_25 = 0.225

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(321192001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 9 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 9)

				if (9 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 9)) > 0 and var_4_25 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_24 = var_4_24 + 0.3

					if var_4_30 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192001", "story_v_out_321192.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_321192", "321192001", "story_v_out_321192.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_321192", "321192001", "story_v_out_321192.awb")

						arg_1_1:RecordAudio("321192001", var_4_32)
						arg_1_1:RecordAudio("321192001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_321192", "321192001", "story_v_out_321192.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_321192", "321192001", "story_v_out_321192.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_24 + 0.3
			local var_4_34 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play321192002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321192002
		arg_9_1.duration_ = 4.3

		local var_9_0 = {
			zh = 1.999999999999,
			ja = 4.3
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
				arg_9_0:Play321192003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "404001ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["404001ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["404001ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["404001ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["404001ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["404001ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos404001ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["404001ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect404001ui_story == nil then
				arg_9_1.var_.characterEffect404001ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect404001ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect404001ui_story then
				arg_9_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_12_8 = arg_9_1.actors_["1011ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.characterEffect1011ui_story == nil then
				arg_9_1.var_.characterEffect1011ui_story = var_12_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_9 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 and not isNil(var_12_8) then
				if arg_9_1.var_.characterEffect1011ui_story and not isNil(var_12_8) then
					arg_9_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_9)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.characterEffect1011ui_story then
				arg_9_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_12_10 = 0
			local var_12_11 = 0.175

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_12 = arg_9_1:GetWordFromCfg(321192002)
				local var_12_13 = arg_9_1:FormatText(var_12_12.content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 7 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 7)

				if (7 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 7)) > 0 and var_12_11 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_13
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192002", "story_v_out_321192.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_321192", "321192002", "story_v_out_321192.awb") / 1000

					if var_12_16 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_10
					end

					if var_12_12.prefab_name ~= "" and arg_9_1.actors_[var_12_12.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_12.prefab_name].transform, "story_v_out_321192", "321192002", "story_v_out_321192.awb")

						arg_9_1:RecordAudio("321192002", var_12_17)
						arg_9_1:RecordAudio("321192002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_321192", "321192002", "story_v_out_321192.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_321192", "321192002", "story_v_out_321192.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_18 = math.max(var_12_11, arg_9_1.talkMaxDuration)

			if var_12_10 <= arg_9_1.time_ and arg_9_1.time_ < var_12_10 + var_12_18 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_10) / var_12_18

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_10 + var_12_18 and arg_9_1.time_ < var_12_10 + var_12_18 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play321192003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321192003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play321192004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos404001ui_story = arg_13_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["404001ui_story"].transform.position).z)
				arg_13_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["404001ui_story"].transform.localEulerAngles = arg_13_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["404001ui_story"].transform.position).z)
				arg_13_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["404001ui_story"].transform.localEulerAngles = arg_13_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["1011ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1011ui_story = var_16_1.localPosition
			end

			local var_16_2 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 then
				var_16_1.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_13_1.time_ - 0) / var_16_2)
				var_16_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_1.position).x, (manager.ui.mainCamera.transform.position - var_16_1.position).y, (manager.ui.mainCamera.transform.position - var_16_1.position).z)
				var_16_1.localEulerAngles.z = 0
				var_16_1.localEulerAngles.x = 0
				var_16_1.localEulerAngles = var_16_1.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 then
				var_16_1.localPosition = Vector3.New(0, 100, 0)
				var_16_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_1.position).x, (manager.ui.mainCamera.transform.position - var_16_1.position).y, (manager.ui.mainCamera.transform.position - var_16_1.position).z)
				var_16_1.localEulerAngles.z = 0
				var_16_1.localEulerAngles.x = 0
				var_16_1.localEulerAngles = var_16_1.localEulerAngles
			end

			local var_16_3 = arg_13_1.actors_["404001ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_3) and arg_13_1.var_.characterEffect404001ui_story == nil then
				arg_13_1.var_.characterEffect404001ui_story = var_16_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_4 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 and not isNil(var_16_3) then
				if arg_13_1.var_.characterEffect404001ui_story and not isNil(var_16_3) then
					arg_13_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_13_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_4)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 and not isNil(var_16_3) and arg_13_1.var_.characterEffect404001ui_story then
				arg_13_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_13_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_16_5 = 0
			local var_16_6 = 1.175

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_7 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(321192003).content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 47 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_7) / 47)

				if (47 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_7) / 47)) > 0 and var_16_6 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_5
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_6, arg_13_1.talkMaxDuration)

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_5) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_5 + var_16_10 and arg_13_1.time_ < var_16_5 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play321192004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321192004
		arg_17_1.duration_ = 2.53

		local var_17_0 = {
			zh = 2.366,
			ja = 2.533
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
				arg_17_0:Play321192005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos404001ui_story = arg_17_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).z)
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles = arg_17_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_17_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["404001ui_story"].transform.position).z)
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["404001ui_story"].transform.localEulerAngles = arg_17_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["404001ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect404001ui_story == nil then
				arg_17_1.var_.characterEffect404001ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect404001ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect404001ui_story then
				arg_17_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_20_4 = 0
			local var_20_5 = 0.25

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(321192004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 10 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 10)

				if (10 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 10)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192004", "story_v_out_321192.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_321192", "321192004", "story_v_out_321192.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_321192", "321192004", "story_v_out_321192.awb")

						arg_17_1:RecordAudio("321192004", var_20_11)
						arg_17_1:RecordAudio("321192004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_321192", "321192004", "story_v_out_321192.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_321192", "321192004", "story_v_out_321192.awb")
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

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play321192005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321192005
		arg_21_1.duration_ = 9.43

		local var_21_0 = {
			zh = 5.266,
			ja = 9.433
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
				arg_21_0:Play321192006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.6

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(321192005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 24 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 24)

				if (24 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 24)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192005", "story_v_out_321192.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_321192", "321192005", "story_v_out_321192.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_321192", "321192005", "story_v_out_321192.awb")

						arg_21_1:RecordAudio("321192005", var_24_6)
						arg_21_1:RecordAudio("321192005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_321192", "321192005", "story_v_out_321192.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_321192", "321192005", "story_v_out_321192.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play321192006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321192006
		arg_25_1.duration_ = 2.47

		local var_25_0 = {
			zh = 1.999999999999,
			ja = 2.466
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
				arg_25_0:Play321192007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1011ui_story = arg_25_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1011ui_story"].transform.position).z)
				arg_25_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1011ui_story"].transform.localEulerAngles = arg_25_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_25_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1011ui_story"].transform.position).z)
				arg_25_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1011ui_story"].transform.localEulerAngles = arg_25_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1011ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1011ui_story == nil then
				arg_25_1.var_.characterEffect1011ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1011ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1011ui_story then
				arg_25_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_28_4 = arg_25_1.actors_["404001ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect404001ui_story == nil then
				arg_25_1.var_.characterEffect404001ui_story = var_28_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_5 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_5 and not isNil(var_28_4) then
				if arg_25_1.var_.characterEffect404001ui_story and not isNil(var_28_4) then
					arg_25_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_25_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_5)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_5 and arg_25_1.time_ < 0 + var_28_5 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect404001ui_story then
				arg_25_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_25_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_2")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_28_6 = 0
			local var_28_7 = 0.1

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_8 = arg_25_1:GetWordFromCfg(321192006)
				local var_28_9 = arg_25_1:FormatText(var_28_8.content)

				arg_25_1.text_.text = var_28_9

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 4 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_9) / 4)

				if (4 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_9) / 4)) > 0 and var_28_7 < var_28_11 then
					arg_25_1.talkMaxDuration = var_28_11

					if var_28_11 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_9
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192006", "story_v_out_321192.awb") ~= 0 then
					local var_28_12 = manager.audio:GetVoiceLength("story_v_out_321192", "321192006", "story_v_out_321192.awb") / 1000

					if var_28_12 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_6
					end

					if var_28_8.prefab_name ~= "" and arg_25_1.actors_[var_28_8.prefab_name] ~= nil then
						local var_28_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_8.prefab_name].transform, "story_v_out_321192", "321192006", "story_v_out_321192.awb")

						arg_25_1:RecordAudio("321192006", var_28_13)
						arg_25_1:RecordAudio("321192006", var_28_13)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_321192", "321192006", "story_v_out_321192.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_321192", "321192006", "story_v_out_321192.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_14 and arg_25_1.time_ < var_28_6 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play321192007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321192007
		arg_29_1.duration_ = 4.5

		local var_29_0 = {
			zh = 3.4,
			ja = 4.5
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
				arg_29_0:Play321192008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["404001ui_story"]) and arg_29_1.var_.characterEffect404001ui_story == nil then
				arg_29_1.var_.characterEffect404001ui_story = arg_29_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["404001ui_story"]) then
				if arg_29_1.var_.characterEffect404001ui_story and not isNil(arg_29_1.actors_["404001ui_story"]) then
					arg_29_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["404001ui_story"]) and arg_29_1.var_.characterEffect404001ui_story then
				arg_29_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_32_2 = arg_29_1.actors_["1011ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect1011ui_story == nil then
				arg_29_1.var_.characterEffect1011ui_story = var_32_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_3 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.characterEffect1011ui_story and not isNil(var_32_2) then
					arg_29_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_3)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect1011ui_story then
				arg_29_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			local var_32_4 = 0
			local var_32_5 = 0.325

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(321192007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 13 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 13)

				if (13 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 13)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192007", "story_v_out_321192.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_321192", "321192007", "story_v_out_321192.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_321192", "321192007", "story_v_out_321192.awb")

						arg_29_1:RecordAudio("321192007", var_32_11)
						arg_29_1:RecordAudio("321192007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_321192", "321192007", "story_v_out_321192.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_321192", "321192007", "story_v_out_321192.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_12 and arg_29_1.time_ < var_32_4 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play321192008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321192008
		arg_33_1.duration_ = 6.27

		local var_33_0 = {
			zh = 2.9,
			ja = 6.266
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
				arg_33_0:Play321192009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.4

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:GetWordFromCfg(321192008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 16 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 16)

				if (16 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 16)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192008", "story_v_out_321192.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_321192", "321192008", "story_v_out_321192.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_321192", "321192008", "story_v_out_321192.awb")

						arg_33_1:RecordAudio("321192008", var_36_6)
						arg_33_1:RecordAudio("321192008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_321192", "321192008", "story_v_out_321192.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_321192", "321192008", "story_v_out_321192.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play321192009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321192009
		arg_37_1.duration_ = 12.5

		local var_37_0 = {
			zh = 7.166,
			ja = 12.5
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
				arg_37_0:Play321192010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1011ui_story = arg_37_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1011ui_story"].transform.position).z)
				arg_37_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1011ui_story"].transform.localEulerAngles = arg_37_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_37_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1011ui_story"].transform.position).z)
				arg_37_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1011ui_story"].transform.localEulerAngles = arg_37_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1011ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1011ui_story == nil then
				arg_37_1.var_.characterEffect1011ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1011ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1011ui_story then
				arg_37_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_40_4 = arg_37_1.actors_["404001ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect404001ui_story == nil then
				arg_37_1.var_.characterEffect404001ui_story = var_40_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_5 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_5 and not isNil(var_40_4) then
				if arg_37_1.var_.characterEffect404001ui_story and not isNil(var_40_4) then
					arg_37_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_37_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_5)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_5 and arg_37_1.time_ < 0 + var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect404001ui_story then
				arg_37_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_37_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_40_6 = 0
			local var_40_7 = 0.75

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(321192009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 30 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 30)

				if (30 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 30)) > 0 and var_40_7 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192009", "story_v_out_321192.awb") ~= 0 then
					local var_40_12 = manager.audio:GetVoiceLength("story_v_out_321192", "321192009", "story_v_out_321192.awb") / 1000

					if var_40_12 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_6
					end

					if var_40_8.prefab_name ~= "" and arg_37_1.actors_[var_40_8.prefab_name] ~= nil then
						local var_40_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_8.prefab_name].transform, "story_v_out_321192", "321192009", "story_v_out_321192.awb")

						arg_37_1:RecordAudio("321192009", var_40_13)
						arg_37_1:RecordAudio("321192009", var_40_13)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_321192", "321192009", "story_v_out_321192.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_321192", "321192009", "story_v_out_321192.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_14 and arg_37_1.time_ < var_40_6 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play321192010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 321192010
		arg_41_1.duration_ = 2.17

		local var_41_0 = {
			zh = 1.999999999999,
			ja = 2.166
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
				arg_41_0:Play321192011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos404001ui_story = arg_41_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["404001ui_story"].transform.position).z)
				arg_41_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["404001ui_story"].transform.localEulerAngles = arg_41_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_41_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["404001ui_story"].transform.position).z)
				arg_41_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["404001ui_story"].transform.localEulerAngles = arg_41_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["404001ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect404001ui_story == nil then
				arg_41_1.var_.characterEffect404001ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect404001ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect404001ui_story then
				arg_41_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_44_4 = arg_41_1.actors_["1011ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1011ui_story == nil then
				arg_41_1.var_.characterEffect1011ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_5 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 and not isNil(var_44_4) then
				if arg_41_1.var_.characterEffect1011ui_story and not isNil(var_44_4) then
					arg_41_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_5)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1011ui_story then
				arg_41_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_44_6 = 0
			local var_44_7 = 0.125

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_8 = arg_41_1:GetWordFromCfg(321192010)
				local var_44_9 = arg_41_1:FormatText(var_44_8.content)

				arg_41_1.text_.text = var_44_9

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 5 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 5)

				if (5 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 5)) > 0 and var_44_7 < var_44_11 then
					arg_41_1.talkMaxDuration = var_44_11

					if var_44_11 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_9
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192010", "story_v_out_321192.awb") ~= 0 then
					local var_44_12 = manager.audio:GetVoiceLength("story_v_out_321192", "321192010", "story_v_out_321192.awb") / 1000

					if var_44_12 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_6
					end

					if var_44_8.prefab_name ~= "" and arg_41_1.actors_[var_44_8.prefab_name] ~= nil then
						local var_44_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_8.prefab_name].transform, "story_v_out_321192", "321192010", "story_v_out_321192.awb")

						arg_41_1:RecordAudio("321192010", var_44_13)
						arg_41_1:RecordAudio("321192010", var_44_13)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_321192", "321192010", "story_v_out_321192.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_321192", "321192010", "story_v_out_321192.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play321192011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 321192011
		arg_45_1.duration_ = 3.27

		local var_45_0 = {
			zh = 2.466,
			ja = 3.266
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
				arg_45_0:Play321192012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1011ui_story"]) and arg_45_1.var_.characterEffect1011ui_story == nil then
				arg_45_1.var_.characterEffect1011ui_story = arg_45_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1011ui_story"]) then
				if arg_45_1.var_.characterEffect1011ui_story and not isNil(arg_45_1.actors_["1011ui_story"]) then
					arg_45_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1011ui_story"]) and arg_45_1.var_.characterEffect1011ui_story then
				arg_45_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_48_2 = arg_45_1.actors_["404001ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect404001ui_story == nil then
				arg_45_1.var_.characterEffect404001ui_story = var_48_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_3 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.characterEffect404001ui_story and not isNil(var_48_2) then
					arg_45_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_45_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_3)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect404001ui_story then
				arg_45_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_45_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_2")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_48_4 = 0
			local var_48_5 = 0.2

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(321192011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 8 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 8)

				if (8 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 8)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192011", "story_v_out_321192.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_321192", "321192011", "story_v_out_321192.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_out_321192", "321192011", "story_v_out_321192.awb")

						arg_45_1:RecordAudio("321192011", var_48_11)
						arg_45_1:RecordAudio("321192011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_321192", "321192011", "story_v_out_321192.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_321192", "321192011", "story_v_out_321192.awb")
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
	Play321192012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 321192012
		arg_49_1.duration_ = 8.1

		local var_49_0 = {
			zh = 6.632999999999,
			ja = 8.099999999999
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
				arg_49_0:Play321192013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 2 < arg_49_1.time_ and arg_49_1.time_ <= 2 + arg_52_0 then
				local var_52_0 = arg_49_1.bgs_.L15f

				arg_49_1.bgs_.L15f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_52_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_52_1 = var_52_0:GetComponent("SpriteRenderer")

				if var_52_1 and var_52_1.sprite then
					local var_52_2 = 2 * (var_52_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_52_0.transform.localScale = Vector3.New(var_52_2 / var_52_1.sprite.bounds.size.y < var_52_2 * manager.ui.mainCameraCom_.aspect / var_52_1.sprite.bounds.size.x and var_52_2 * manager.ui.mainCameraCom_.aspect / var_52_1.sprite.bounds.size.x or var_52_2 / var_52_1.sprite.bounds.size.y, var_52_2 / var_52_1.sprite.bounds.size.y < var_52_2 * manager.ui.mainCameraCom_.aspect / var_52_1.sprite.bounds.size.x and var_52_2 * manager.ui.mainCameraCom_.aspect / var_52_1.sprite.bounds.size.x or var_52_2 / var_52_1.sprite.bounds.size.y, 0)
				end

				for iter_52_0, iter_52_1 in pairs(arg_49_1.bgs_) do
					if iter_52_0 ~= "L15f" then
						iter_52_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_52_3 = 3.999999999999

			if 3.999999999999 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 then
				arg_49_1.allBtn_.enabled = false
			end

			if arg_49_1.time_ >= var_52_3 + 0.3 and arg_49_1.time_ < var_52_3 + 0.3 + arg_52_0 then
				arg_49_1.allBtn_.enabled = true
			end

			local var_52_4 = 0

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_5 = 2

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_5 then
				local var_52_6 = Color.New(0, 0, 0)

				var_52_6.a = Mathf.Lerp(0, 1, (arg_49_1.time_ - var_52_4) / var_52_5)
				arg_49_1.mask_.color = var_52_6
			end

			if arg_49_1.time_ >= var_52_4 + var_52_5 and arg_49_1.time_ < var_52_4 + var_52_5 + arg_52_0 then
				local var_52_7 = Color.New(0, 0, 0)

				var_52_7.a = 1
				arg_49_1.mask_.color = var_52_7
			end

			local var_52_8 = 2

			if 2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_9 = 2

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_9 then
				local var_52_10 = Color.New(0, 0, 0)

				var_52_10.a = Mathf.Lerp(1, 0, (arg_49_1.time_ - var_52_8) / var_52_9)
				arg_49_1.mask_.color = var_52_10
			end

			if arg_49_1.time_ >= var_52_8 + var_52_9 and arg_49_1.time_ < var_52_8 + var_52_9 + arg_52_0 then
				local var_52_11 = Color.New(0, 0, 0)

				arg_49_1.mask_.enabled = false
				var_52_11.a = 0
				arg_49_1.mask_.color = var_52_11
			end

			local var_52_12 = arg_49_1.actors_["1011ui_story"].transform

			if 1.96599999815226 < arg_49_1.time_ and arg_49_1.time_ <= 1.96599999815226 + arg_52_0 then
				arg_49_1.var_.moveOldPos1011ui_story = var_52_12.localPosition
			end

			local var_52_13 = 0.001

			if 1.96599999815226 <= arg_49_1.time_ and arg_49_1.time_ < 1.96599999815226 + var_52_13 then
				var_52_12.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 1.96599999815226) / var_52_13)
				var_52_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_12.position).x, (manager.ui.mainCamera.transform.position - var_52_12.position).y, (manager.ui.mainCamera.transform.position - var_52_12.position).z)
				var_52_12.localEulerAngles.z = 0
				var_52_12.localEulerAngles.x = 0
				var_52_12.localEulerAngles = var_52_12.localEulerAngles
			end

			if arg_49_1.time_ >= 1.96599999815226 + var_52_13 and arg_49_1.time_ < 1.96599999815226 + var_52_13 + arg_52_0 then
				var_52_12.localPosition = Vector3.New(0, 100, 0)
				var_52_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_12.position).x, (manager.ui.mainCamera.transform.position - var_52_12.position).y, (manager.ui.mainCamera.transform.position - var_52_12.position).z)
				var_52_12.localEulerAngles.z = 0
				var_52_12.localEulerAngles.x = 0
				var_52_12.localEulerAngles = var_52_12.localEulerAngles
			end

			local var_52_14 = arg_49_1.actors_["404001ui_story"].transform

			if 1.96599999815226 < arg_49_1.time_ and arg_49_1.time_ <= 1.96599999815226 + arg_52_0 then
				arg_49_1.var_.moveOldPos404001ui_story = var_52_14.localPosition
			end

			local var_52_15 = 0.001

			if 1.96599999815226 <= arg_49_1.time_ and arg_49_1.time_ < 1.96599999815226 + var_52_15 then
				var_52_14.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 1.96599999815226) / var_52_15)
				var_52_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_14.position).x, (manager.ui.mainCamera.transform.position - var_52_14.position).y, (manager.ui.mainCamera.transform.position - var_52_14.position).z)
				var_52_14.localEulerAngles.z = 0
				var_52_14.localEulerAngles.x = 0
				var_52_14.localEulerAngles = var_52_14.localEulerAngles
			end

			if arg_49_1.time_ >= 1.96599999815226 + var_52_15 and arg_49_1.time_ < 1.96599999815226 + var_52_15 + arg_52_0 then
				var_52_14.localPosition = Vector3.New(0, 100, 0)
				var_52_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_14.position).x, (manager.ui.mainCamera.transform.position - var_52_14.position).y, (manager.ui.mainCamera.transform.position - var_52_14.position).z)
				var_52_14.localEulerAngles.z = 0
				var_52_14.localEulerAngles.x = 0
				var_52_14.localEulerAngles = var_52_14.localEulerAngles
			end

			local var_52_16 = arg_49_1.actors_["404001ui_story"]

			if 3.8 < arg_49_1.time_ and arg_49_1.time_ <= 3.8 + arg_52_0 and not isNil(var_52_16) and arg_49_1.var_.characterEffect404001ui_story == nil then
				arg_49_1.var_.characterEffect404001ui_story = var_52_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_17 = 0.200000002980232

			if 3.8 <= arg_49_1.time_ and arg_49_1.time_ < 3.8 + var_52_17 and not isNil(var_52_16) then
				if arg_49_1.var_.characterEffect404001ui_story and not isNil(var_52_16) then
					arg_49_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 3.8 + var_52_17 and arg_49_1.time_ < 3.8 + var_52_17 + arg_52_0 and not isNil(var_52_16) and arg_49_1.var_.characterEffect404001ui_story then
				arg_49_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 3.8 < arg_49_1.time_ and arg_49_1.time_ <= 3.8 + arg_52_0 then
				arg_49_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			if 3.8 < arg_49_1.time_ and arg_49_1.time_ <= 3.8 + arg_52_0 then
				arg_49_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_52_19 = arg_49_1.actors_["404001ui_story"].transform

			if 3.8 < arg_49_1.time_ and arg_49_1.time_ <= 3.8 + arg_52_0 then
				arg_49_1.var_.moveOldPos404001ui_story = var_52_19.localPosition
			end

			local var_52_20 = 0.001

			if 3.8 <= arg_49_1.time_ and arg_49_1.time_ < 3.8 + var_52_20 then
				var_52_19.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_49_1.time_ - 3.8) / var_52_20)
				var_52_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_19.position).x, (manager.ui.mainCamera.transform.position - var_52_19.position).y, (manager.ui.mainCamera.transform.position - var_52_19.position).z)
				var_52_19.localEulerAngles.z = 0
				var_52_19.localEulerAngles.x = 0
				var_52_19.localEulerAngles = var_52_19.localEulerAngles
			end

			if arg_49_1.time_ >= 3.8 + var_52_20 and arg_49_1.time_ < 3.8 + var_52_20 + arg_52_0 then
				var_52_19.localPosition = Vector3.New(0, -1.55, -5.5)
				var_52_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_19.position).x, (manager.ui.mainCamera.transform.position - var_52_19.position).y, (manager.ui.mainCamera.transform.position - var_52_19.position).z)
				var_52_19.localEulerAngles.z = 0
				var_52_19.localEulerAngles.x = 0
				var_52_19.localEulerAngles = var_52_19.localEulerAngles
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_21 = 3.999999999999
			local var_52_22 = 0.25

			if 3.999999999999 < arg_49_1.time_ and arg_49_1.time_ <= var_52_21 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_23 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_23:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_49_1.dialogCg_.alpha = arg_53_0
				end))
				var_52_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_24 = arg_49_1:GetWordFromCfg(321192012)
				local var_52_25 = arg_49_1:FormatText(var_52_24.content)

				arg_49_1.text_.text = var_52_25

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_27 = 10 <= 0 and var_52_22 or var_52_22 * (utf8.len(var_52_25) / 10)

				if (10 <= 0 and var_52_22 or var_52_22 * (utf8.len(var_52_25) / 10)) > 0 and var_52_22 < var_52_27 then
					arg_49_1.talkMaxDuration = var_52_27
					var_52_21 = var_52_21 + 0.3

					if var_52_27 + var_52_21 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_27 + var_52_21
					end
				end

				arg_49_1.text_.text = var_52_25
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192012", "story_v_out_321192.awb") ~= 0 then
					local var_52_28 = manager.audio:GetVoiceLength("story_v_out_321192", "321192012", "story_v_out_321192.awb") / 1000

					if var_52_28 + var_52_21 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_28 + var_52_21
					end

					if var_52_24.prefab_name ~= "" and arg_49_1.actors_[var_52_24.prefab_name] ~= nil then
						local var_52_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_24.prefab_name].transform, "story_v_out_321192", "321192012", "story_v_out_321192.awb")

						arg_49_1:RecordAudio("321192012", var_52_29)
						arg_49_1:RecordAudio("321192012", var_52_29)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_321192", "321192012", "story_v_out_321192.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_321192", "321192012", "story_v_out_321192.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_30 = var_52_21 + 0.3
			local var_52_31 = math.max(var_52_22, arg_49_1.talkMaxDuration)

			if var_52_21 + 0.3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_30 + var_52_31 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_30) / var_52_31

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_30 + var_52_31 and arg_49_1.time_ < var_52_30 + var_52_31 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play321192013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 321192013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play321192014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos404001ui_story = arg_55_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["404001ui_story"].transform.position).z)
				arg_55_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["404001ui_story"].transform.localEulerAngles = arg_55_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["404001ui_story"].transform.position).z)
				arg_55_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["404001ui_story"].transform.localEulerAngles = arg_55_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["404001ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect404001ui_story == nil then
				arg_55_1.var_.characterEffect404001ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect404001ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_55_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_2)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect404001ui_story then
				arg_55_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_55_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_55_1.time_ and arg_55_1.time_ <= 0.034000001847744 + arg_58_0 then
				arg_55_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car05", "")
			end

			local var_58_4 = 0
			local var_58_5 = 0.9

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(321192013).content)

				arg_55_1.text_.text = var_58_6

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_8 = 36 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_6) / 36)

				if (36 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_6) / 36)) > 0 and var_58_5 < var_58_8 then
					arg_55_1.talkMaxDuration = var_58_8

					if var_58_8 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_6
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_9 = math.max(var_58_5, arg_55_1.talkMaxDuration)

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_9 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_4) / var_58_9

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_4 + var_58_9 and arg_55_1.time_ < var_58_4 + var_58_9 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play321192014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 321192014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play321192015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.6

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

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(321192014).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 24 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 24)

				if (24 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 24)) > 0 and var_62_0 < var_62_3 then
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
	Play321192015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 321192015
		arg_63_1.duration_ = 1.57

		local var_63_0 = {
			zh = 1.3,
			ja = 1.566
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play321192016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.125

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[1182].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:GetWordFromCfg(321192015)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 5 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 5)

				if (5 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 5)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192015", "story_v_out_321192.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_321192", "321192015", "story_v_out_321192.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_321192", "321192015", "story_v_out_321192.awb")

						arg_63_1:RecordAudio("321192015", var_66_6)
						arg_63_1:RecordAudio("321192015", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_321192", "321192015", "story_v_out_321192.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_321192", "321192015", "story_v_out_321192.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play321192016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 321192016
		arg_67_1.duration_ = 1.9

		local var_67_0 = {
			zh = 0.999999999999,
			ja = 1.9
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
				arg_67_0:Play321192017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.075

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:GetWordFromCfg(321192016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 3 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 3)

				if (3 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 3)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192016", "story_v_out_321192.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_321192", "321192016", "story_v_out_321192.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_321192", "321192016", "story_v_out_321192.awb")

						arg_67_1:RecordAudio("321192016", var_70_6)
						arg_67_1:RecordAudio("321192016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_321192", "321192016", "story_v_out_321192.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_321192", "321192016", "story_v_out_321192.awb")
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
	Play321192017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 321192017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play321192018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1011ui_story = arg_71_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1011ui_story"].transform.position).z)
				arg_71_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1011ui_story"].transform.localEulerAngles = arg_71_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1011ui_story"].transform.position).z)
				arg_71_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1011ui_story"].transform.localEulerAngles = arg_71_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["1011ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1011ui_story == nil then
				arg_71_1.var_.characterEffect1011ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect1011ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_2)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1011ui_story then
				arg_71_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_71_1.time_ and arg_71_1.time_ <= 0.034000001847744 + arg_74_0 then
				arg_71_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_cardoor01", "")
			end

			if 0.584 < arg_71_1.time_ and arg_71_1.time_ <= 0.584 + arg_74_0 then
				arg_71_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_cardoor01", "")
			end

			local var_74_5 = 0
			local var_74_6 = 1.05

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_7 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(321192017).content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 42 <= 0 and var_74_6 or var_74_6 * (utf8.len(var_74_7) / 42)

				if (42 <= 0 and var_74_6 or var_74_6 * (utf8.len(var_74_7) / 42)) > 0 and var_74_6 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_5
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_10 = math.max(var_74_6, arg_71_1.talkMaxDuration)

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_5) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_5 + var_74_10 and arg_71_1.time_ < var_74_5 + var_74_10 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play321192018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 321192018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play321192019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0.034000001847744 < arg_75_1.time_ and arg_75_1.time_ <= 0.034000001847744 + arg_78_0 then
				arg_75_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_car02", "")
			end

			local var_78_1 = 0
			local var_78_2 = 0.775

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(321192018).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 31 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 31)

				if (31 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 31)) > 0 and var_78_2 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_6 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_6 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_6

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_6 and arg_75_1.time_ < var_78_1 + var_78_6 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play321192019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 321192019
		arg_79_1.duration_ = 6.23

		local var_79_0 = {
			zh = 4.366,
			ja = 6.233
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
				arg_79_0:Play321192020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos404001ui_story = arg_79_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["404001ui_story"].transform.position).z)
				arg_79_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["404001ui_story"].transform.localEulerAngles = arg_79_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_79_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["404001ui_story"].transform.position).z)
				arg_79_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["404001ui_story"].transform.localEulerAngles = arg_79_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["404001ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect404001ui_story == nil then
				arg_79_1.var_.characterEffect404001ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect404001ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect404001ui_story then
				arg_79_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_82_4 = 0
			local var_82_5 = 0.55

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(321192019)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 22 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 22)

				if (22 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 22)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192019", "story_v_out_321192.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_out_321192", "321192019", "story_v_out_321192.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_out_321192", "321192019", "story_v_out_321192.awb")

						arg_79_1:RecordAudio("321192019", var_82_11)
						arg_79_1:RecordAudio("321192019", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_321192", "321192019", "story_v_out_321192.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_321192", "321192019", "story_v_out_321192.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_12 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_12 and arg_79_1.time_ < var_82_4 + var_82_12 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play321192020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 321192020
		arg_83_1.duration_ = 5.5

		local var_83_0 = {
			zh = 5.5,
			ja = 5.266
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
				arg_83_0:Play321192021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1011ui_story = arg_83_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1011ui_story"].transform.position).z)
				arg_83_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1011ui_story"].transform.localEulerAngles = arg_83_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_83_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1011ui_story"].transform.position).z)
				arg_83_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1011ui_story"].transform.localEulerAngles = arg_83_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_86_1 = arg_83_1.actors_["1011ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1011ui_story == nil then
				arg_83_1.var_.characterEffect1011ui_story = var_86_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 and not isNil(var_86_1) then
				if arg_83_1.var_.characterEffect1011ui_story and not isNil(var_86_1) then
					arg_83_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1011ui_story then
				arg_83_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_86_4 = arg_83_1.actors_["404001ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_4) and arg_83_1.var_.characterEffect404001ui_story == nil then
				arg_83_1.var_.characterEffect404001ui_story = var_86_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_5 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_5 and not isNil(var_86_4) then
				if arg_83_1.var_.characterEffect404001ui_story and not isNil(var_86_4) then
					arg_83_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_83_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_5)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_5 and arg_83_1.time_ < 0 + var_86_5 + arg_86_0 and not isNil(var_86_4) and arg_83_1.var_.characterEffect404001ui_story then
				arg_83_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_83_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_86_6 = 0
			local var_86_7 = 0.55

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_8 = arg_83_1:GetWordFromCfg(321192020)
				local var_86_9 = arg_83_1:FormatText(var_86_8.content)

				arg_83_1.text_.text = var_86_9

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_11 = 22 <= 0 and var_86_7 or var_86_7 * (utf8.len(var_86_9) / 22)

				if (22 <= 0 and var_86_7 or var_86_7 * (utf8.len(var_86_9) / 22)) > 0 and var_86_7 < var_86_11 then
					arg_83_1.talkMaxDuration = var_86_11

					if var_86_11 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_11 + var_86_6
					end
				end

				arg_83_1.text_.text = var_86_9
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192020", "story_v_out_321192.awb") ~= 0 then
					local var_86_12 = manager.audio:GetVoiceLength("story_v_out_321192", "321192020", "story_v_out_321192.awb") / 1000

					if var_86_12 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_12 + var_86_6
					end

					if var_86_8.prefab_name ~= "" and arg_83_1.actors_[var_86_8.prefab_name] ~= nil then
						local var_86_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_8.prefab_name].transform, "story_v_out_321192", "321192020", "story_v_out_321192.awb")

						arg_83_1:RecordAudio("321192020", var_86_13)
						arg_83_1:RecordAudio("321192020", var_86_13)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_321192", "321192020", "story_v_out_321192.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_321192", "321192020", "story_v_out_321192.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_14 = math.max(var_86_7, arg_83_1.talkMaxDuration)

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_14 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_6) / var_86_14

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_6 + var_86_14 and arg_83_1.time_ < var_86_6 + var_86_14 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play321192021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 321192021
		arg_87_1.duration_ = 4.9

		local var_87_0 = {
			zh = 4.266,
			ja = 4.9
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play321192022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos404001ui_story = arg_87_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["404001ui_story"].transform.position).z)
				arg_87_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["404001ui_story"].transform.localEulerAngles = arg_87_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_87_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["404001ui_story"].transform.position).z)
				arg_87_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["404001ui_story"].transform.localEulerAngles = arg_87_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_90_1 = arg_87_1.actors_["404001ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect404001ui_story == nil then
				arg_87_1.var_.characterEffect404001ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect404001ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect404001ui_story then
				arg_87_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_90_4 = arg_87_1.actors_["1011ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_4) and arg_87_1.var_.characterEffect1011ui_story == nil then
				arg_87_1.var_.characterEffect1011ui_story = var_90_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_5 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_5 and not isNil(var_90_4) then
				if arg_87_1.var_.characterEffect1011ui_story and not isNil(var_90_4) then
					arg_87_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_5)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_5 and arg_87_1.time_ < 0 + var_90_5 + arg_90_0 and not isNil(var_90_4) and arg_87_1.var_.characterEffect1011ui_story then
				arg_87_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_90_6 = 0
			local var_90_7 = 0.575

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_6 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_8 = arg_87_1:GetWordFromCfg(321192021)
				local var_90_9 = arg_87_1:FormatText(var_90_8.content)

				arg_87_1.text_.text = var_90_9

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_11 = 23 <= 0 and var_90_7 or var_90_7 * (utf8.len(var_90_9) / 23)

				if (23 <= 0 and var_90_7 or var_90_7 * (utf8.len(var_90_9) / 23)) > 0 and var_90_7 < var_90_11 then
					arg_87_1.talkMaxDuration = var_90_11

					if var_90_11 + var_90_6 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_11 + var_90_6
					end
				end

				arg_87_1.text_.text = var_90_9
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192021", "story_v_out_321192.awb") ~= 0 then
					local var_90_12 = manager.audio:GetVoiceLength("story_v_out_321192", "321192021", "story_v_out_321192.awb") / 1000

					if var_90_12 + var_90_6 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_12 + var_90_6
					end

					if var_90_8.prefab_name ~= "" and arg_87_1.actors_[var_90_8.prefab_name] ~= nil then
						local var_90_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_8.prefab_name].transform, "story_v_out_321192", "321192021", "story_v_out_321192.awb")

						arg_87_1:RecordAudio("321192021", var_90_13)
						arg_87_1:RecordAudio("321192021", var_90_13)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_321192", "321192021", "story_v_out_321192.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_321192", "321192021", "story_v_out_321192.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_14 = math.max(var_90_7, arg_87_1.talkMaxDuration)

			if var_90_6 <= arg_87_1.time_ and arg_87_1.time_ < var_90_6 + var_90_14 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_6) / var_90_14

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_6 + var_90_14 and arg_87_1.time_ < var_90_6 + var_90_14 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play321192022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 321192022
		arg_91_1.duration_ = 5.7

		local var_91_0 = {
			zh = 3.4,
			ja = 5.7
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
				arg_91_0:Play321192023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["404001ui_story"]) and arg_91_1.var_.characterEffect404001ui_story == nil then
				arg_91_1.var_.characterEffect404001ui_story = arg_91_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["404001ui_story"]) then
				if arg_91_1.var_.characterEffect404001ui_story and not isNil(arg_91_1.actors_["404001ui_story"]) then
					arg_91_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_91_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_0)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["404001ui_story"]) and arg_91_1.var_.characterEffect404001ui_story then
				arg_91_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_91_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_94_1 = 0
			local var_94_2 = 0.35

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[1182].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:GetWordFromCfg(321192022)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_6 = 14 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_4) / 14)

				if (14 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_4) / 14)) > 0 and var_94_2 < var_94_6 then
					arg_91_1.talkMaxDuration = var_94_6

					if var_94_6 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_6 + var_94_1
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192022", "story_v_out_321192.awb") ~= 0 then
					local var_94_7 = manager.audio:GetVoiceLength("story_v_out_321192", "321192022", "story_v_out_321192.awb") / 1000

					if var_94_7 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_1
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_321192", "321192022", "story_v_out_321192.awb")

						arg_91_1:RecordAudio("321192022", var_94_8)
						arg_91_1:RecordAudio("321192022", var_94_8)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_321192", "321192022", "story_v_out_321192.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_321192", "321192022", "story_v_out_321192.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_9 = math.max(var_94_2, arg_91_1.talkMaxDuration)

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_9 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_1) / var_94_9

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_1 + var_94_9 and arg_91_1.time_ < var_94_1 + var_94_9 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play321192023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 321192023
		arg_95_1.duration_ = 10.07

		local var_95_0 = {
			zh = 6.3,
			ja = 10.066
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
				arg_95_0:Play321192024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1011ui_story = arg_95_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1011ui_story"].transform.position).z)
				arg_95_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1011ui_story"].transform.localEulerAngles = arg_95_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_95_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1011ui_story"].transform.position).z)
				arg_95_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1011ui_story"].transform.localEulerAngles = arg_95_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["1011ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1011ui_story == nil then
				arg_95_1.var_.characterEffect1011ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect1011ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1011ui_story then
				arg_95_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 1.56666666666667 < arg_95_1.time_ and arg_95_1.time_ <= 1.56666666666667 + arg_98_0 then
				arg_95_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action435")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_98_4 = 0

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.allBtn_.enabled = false
			end

			if arg_95_1.time_ >= var_98_4 + 3.3 and arg_95_1.time_ < var_98_4 + 3.3 + arg_98_0 then
				arg_95_1.allBtn_.enabled = true
			end

			local var_98_5 = 0
			local var_98_6 = 0.7

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_7 = arg_95_1:GetWordFromCfg(321192023)
				local var_98_8 = arg_95_1:FormatText(var_98_7.content)

				arg_95_1.text_.text = var_98_8

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_10 = 28 <= 0 and var_98_6 or var_98_6 * (utf8.len(var_98_8) / 28)

				if (28 <= 0 and var_98_6 or var_98_6 * (utf8.len(var_98_8) / 28)) > 0 and var_98_6 < var_98_10 then
					arg_95_1.talkMaxDuration = var_98_10

					if var_98_10 + var_98_5 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_5
					end
				end

				arg_95_1.text_.text = var_98_8
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192023", "story_v_out_321192.awb") ~= 0 then
					local var_98_11 = manager.audio:GetVoiceLength("story_v_out_321192", "321192023", "story_v_out_321192.awb") / 1000

					if var_98_11 + var_98_5 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_11 + var_98_5
					end

					if var_98_7.prefab_name ~= "" and arg_95_1.actors_[var_98_7.prefab_name] ~= nil then
						local var_98_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_7.prefab_name].transform, "story_v_out_321192", "321192023", "story_v_out_321192.awb")

						arg_95_1:RecordAudio("321192023", var_98_12)
						arg_95_1:RecordAudio("321192023", var_98_12)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_321192", "321192023", "story_v_out_321192.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_321192", "321192023", "story_v_out_321192.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_13 = math.max(var_98_6, arg_95_1.talkMaxDuration)

			if var_98_5 <= arg_95_1.time_ and arg_95_1.time_ < var_98_5 + var_98_13 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_5) / var_98_13

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_5 + var_98_13 and arg_95_1.time_ < var_98_5 + var_98_13 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play321192024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 321192024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play321192025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1011ui_story = arg_99_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1011ui_story"].transform.position).z)
				arg_99_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1011ui_story"].transform.localEulerAngles = arg_99_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1011ui_story"].transform.position).z)
				arg_99_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1011ui_story"].transform.localEulerAngles = arg_99_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["404001ui_story"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos404001ui_story = var_102_1.localPosition
			end

			local var_102_2 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 then
				var_102_1.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_2)
				var_102_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_1.position).x, (manager.ui.mainCamera.transform.position - var_102_1.position).y, (manager.ui.mainCamera.transform.position - var_102_1.position).z)
				var_102_1.localEulerAngles.z = 0
				var_102_1.localEulerAngles.x = 0
				var_102_1.localEulerAngles = var_102_1.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 then
				var_102_1.localPosition = Vector3.New(0, 100, 0)
				var_102_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_1.position).x, (manager.ui.mainCamera.transform.position - var_102_1.position).y, (manager.ui.mainCamera.transform.position - var_102_1.position).z)
				var_102_1.localEulerAngles.z = 0
				var_102_1.localEulerAngles.x = 0
				var_102_1.localEulerAngles = var_102_1.localEulerAngles
			end

			local var_102_3 = arg_99_1.actors_["1011ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_3) and arg_99_1.var_.characterEffect1011ui_story == nil then
				arg_99_1.var_.characterEffect1011ui_story = var_102_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_4 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 and not isNil(var_102_3) then
				if arg_99_1.var_.characterEffect1011ui_story and not isNil(var_102_3) then
					arg_99_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_4)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 and not isNil(var_102_3) and arg_99_1.var_.characterEffect1011ui_story then
				arg_99_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_99_1.time_ and arg_99_1.time_ <= 0.034000001847744 + arg_102_0 then
				arg_99_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car02", "")
			end

			local var_102_6 = 0
			local var_102_7 = 1.15

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_8 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(321192024).content)

				arg_99_1.text_.text = var_102_8

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_10 = 46 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_8) / 46)

				if (46 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_8) / 46)) > 0 and var_102_7 < var_102_10 then
					arg_99_1.talkMaxDuration = var_102_10

					if var_102_10 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_6
					end
				end

				arg_99_1.text_.text = var_102_8
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_11 = math.max(var_102_7, arg_99_1.talkMaxDuration)

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_11 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_6) / var_102_11

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_6 + var_102_11 and arg_99_1.time_ < var_102_6 + var_102_11 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play321192025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 321192025
		arg_103_1.duration_ = 2

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play321192026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1011ui_story = arg_103_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_106_0 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				arg_103_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1011ui_story"].transform.position).z)
				arg_103_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1011ui_story"].transform.localEulerAngles = arg_103_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				arg_103_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_103_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1011ui_story"].transform.position).z)
				arg_103_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1011ui_story"].transform.localEulerAngles = arg_103_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_106_1 = arg_103_1.actors_["1011ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1011ui_story == nil then
				arg_103_1.var_.characterEffect1011ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and not isNil(var_106_1) then
				if arg_103_1.var_.characterEffect1011ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1011ui_story then
				arg_103_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action5_2")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_106_4 = 0
			local var_106_5 = 0.15

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_6 = arg_103_1:GetWordFromCfg(321192025)
				local var_106_7 = arg_103_1:FormatText(var_106_6.content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 6 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 6)

				if (6 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 6)) > 0 and var_106_5 < var_106_9 then
					arg_103_1.talkMaxDuration = var_106_9

					if var_106_9 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192025", "story_v_out_321192.awb") ~= 0 then
					local var_106_10 = manager.audio:GetVoiceLength("story_v_out_321192", "321192025", "story_v_out_321192.awb") / 1000

					if var_106_10 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_4
					end

					if var_106_6.prefab_name ~= "" and arg_103_1.actors_[var_106_6.prefab_name] ~= nil then
						local var_106_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_6.prefab_name].transform, "story_v_out_321192", "321192025", "story_v_out_321192.awb")

						arg_103_1:RecordAudio("321192025", var_106_11)
						arg_103_1:RecordAudio("321192025", var_106_11)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_321192", "321192025", "story_v_out_321192.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_321192", "321192025", "story_v_out_321192.awb")
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

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play321192026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 321192026
		arg_107_1.duration_ = 5.53

		local var_107_0 = {
			zh = 4.333,
			ja = 5.533
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
				arg_107_0:Play321192027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos404001ui_story = arg_107_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["404001ui_story"].transform.position).z)
				arg_107_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["404001ui_story"].transform.localEulerAngles = arg_107_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_107_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["404001ui_story"].transform.position).z)
				arg_107_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["404001ui_story"].transform.localEulerAngles = arg_107_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_110_1 = arg_107_1.actors_["404001ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect404001ui_story == nil then
				arg_107_1.var_.characterEffect404001ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect404001ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect404001ui_story then
				arg_107_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_110_4 = arg_107_1.actors_["1011ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_4) and arg_107_1.var_.characterEffect1011ui_story == nil then
				arg_107_1.var_.characterEffect1011ui_story = var_110_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_5 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_5 and not isNil(var_110_4) then
				if arg_107_1.var_.characterEffect1011ui_story and not isNil(var_110_4) then
					arg_107_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_5)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_5 and arg_107_1.time_ < 0 + var_110_5 + arg_110_0 and not isNil(var_110_4) and arg_107_1.var_.characterEffect1011ui_story then
				arg_107_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_110_6 = 0
			local var_110_7 = 0.475

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_8 = arg_107_1:GetWordFromCfg(321192026)
				local var_110_9 = arg_107_1:FormatText(var_110_8.content)

				arg_107_1.text_.text = var_110_9

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_11 = 19 <= 0 and var_110_7 or var_110_7 * (utf8.len(var_110_9) / 19)

				if (19 <= 0 and var_110_7 or var_110_7 * (utf8.len(var_110_9) / 19)) > 0 and var_110_7 < var_110_11 then
					arg_107_1.talkMaxDuration = var_110_11

					if var_110_11 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_11 + var_110_6
					end
				end

				arg_107_1.text_.text = var_110_9
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192026", "story_v_out_321192.awb") ~= 0 then
					local var_110_12 = manager.audio:GetVoiceLength("story_v_out_321192", "321192026", "story_v_out_321192.awb") / 1000

					if var_110_12 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_12 + var_110_6
					end

					if var_110_8.prefab_name ~= "" and arg_107_1.actors_[var_110_8.prefab_name] ~= nil then
						local var_110_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_8.prefab_name].transform, "story_v_out_321192", "321192026", "story_v_out_321192.awb")

						arg_107_1:RecordAudio("321192026", var_110_13)
						arg_107_1:RecordAudio("321192026", var_110_13)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_321192", "321192026", "story_v_out_321192.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_321192", "321192026", "story_v_out_321192.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_14 = math.max(var_110_7, arg_107_1.talkMaxDuration)

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_14 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_6) / var_110_14

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_6 + var_110_14 and arg_107_1.time_ < var_110_6 + var_110_14 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play321192027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 321192027
		arg_111_1.duration_ = 2.33

		local var_111_0 = {
			zh = 1.999999999999,
			ja = 2.333
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play321192028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1011ui_story"]) and arg_111_1.var_.characterEffect1011ui_story == nil then
				arg_111_1.var_.characterEffect1011ui_story = arg_111_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1011ui_story"]) then
				if arg_111_1.var_.characterEffect1011ui_story and not isNil(arg_111_1.actors_["1011ui_story"]) then
					arg_111_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1011ui_story"]) and arg_111_1.var_.characterEffect1011ui_story then
				arg_111_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_114_2 = arg_111_1.actors_["404001ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.characterEffect404001ui_story == nil then
				arg_111_1.var_.characterEffect404001ui_story = var_114_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_3 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_3 and not isNil(var_114_2) then
				if arg_111_1.var_.characterEffect404001ui_story and not isNil(var_114_2) then
					arg_111_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_111_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_3)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_3 and arg_111_1.time_ < 0 + var_114_3 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.characterEffect404001ui_story then
				arg_111_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_111_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_114_4 = 0
			local var_114_5 = 0.225

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_6 = arg_111_1:GetWordFromCfg(321192027)
				local var_114_7 = arg_111_1:FormatText(var_114_6.content)

				arg_111_1.text_.text = var_114_7

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_9 = 9 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_7) / 9)

				if (9 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_7) / 9)) > 0 and var_114_5 < var_114_9 then
					arg_111_1.talkMaxDuration = var_114_9

					if var_114_9 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_9 + var_114_4
					end
				end

				arg_111_1.text_.text = var_114_7
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192027", "story_v_out_321192.awb") ~= 0 then
					local var_114_10 = manager.audio:GetVoiceLength("story_v_out_321192", "321192027", "story_v_out_321192.awb") / 1000

					if var_114_10 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_4
					end

					if var_114_6.prefab_name ~= "" and arg_111_1.actors_[var_114_6.prefab_name] ~= nil then
						local var_114_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_6.prefab_name].transform, "story_v_out_321192", "321192027", "story_v_out_321192.awb")

						arg_111_1:RecordAudio("321192027", var_114_11)
						arg_111_1:RecordAudio("321192027", var_114_11)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_321192", "321192027", "story_v_out_321192.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_321192", "321192027", "story_v_out_321192.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_12 = math.max(var_114_5, arg_111_1.talkMaxDuration)

			if var_114_4 <= arg_111_1.time_ and arg_111_1.time_ < var_114_4 + var_114_12 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_4) / var_114_12

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_4 + var_114_12 and arg_111_1.time_ < var_114_4 + var_114_12 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play321192028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 321192028
		arg_115_1.duration_ = 6.4

		local var_115_0 = {
			zh = 3.3,
			ja = 6.4
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
				arg_115_0:Play321192029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["404001ui_story"]) and arg_115_1.var_.characterEffect404001ui_story == nil then
				arg_115_1.var_.characterEffect404001ui_story = arg_115_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["404001ui_story"]) then
				if arg_115_1.var_.characterEffect404001ui_story and not isNil(arg_115_1.actors_["404001ui_story"]) then
					arg_115_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["404001ui_story"]) and arg_115_1.var_.characterEffect404001ui_story then
				arg_115_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_118_2 = arg_115_1.actors_["1011ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.characterEffect1011ui_story == nil then
				arg_115_1.var_.characterEffect1011ui_story = var_118_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_3 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_3 and not isNil(var_118_2) then
				if arg_115_1.var_.characterEffect1011ui_story and not isNil(var_118_2) then
					arg_115_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_3)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_3 and arg_115_1.time_ < 0 + var_118_3 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.characterEffect1011ui_story then
				arg_115_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_118_4 = 0
			local var_118_5 = 0.325

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_6 = arg_115_1:GetWordFromCfg(321192028)
				local var_118_7 = arg_115_1:FormatText(var_118_6.content)

				arg_115_1.text_.text = var_118_7

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_9 = 13 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 13)

				if (13 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 13)) > 0 and var_118_5 < var_118_9 then
					arg_115_1.talkMaxDuration = var_118_9

					if var_118_9 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_9 + var_118_4
					end
				end

				arg_115_1.text_.text = var_118_7
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192028", "story_v_out_321192.awb") ~= 0 then
					local var_118_10 = manager.audio:GetVoiceLength("story_v_out_321192", "321192028", "story_v_out_321192.awb") / 1000

					if var_118_10 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_4
					end

					if var_118_6.prefab_name ~= "" and arg_115_1.actors_[var_118_6.prefab_name] ~= nil then
						local var_118_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_6.prefab_name].transform, "story_v_out_321192", "321192028", "story_v_out_321192.awb")

						arg_115_1:RecordAudio("321192028", var_118_11)
						arg_115_1:RecordAudio("321192028", var_118_11)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_321192", "321192028", "story_v_out_321192.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_321192", "321192028", "story_v_out_321192.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_12 = math.max(var_118_5, arg_115_1.talkMaxDuration)

			if var_118_4 <= arg_115_1.time_ and arg_115_1.time_ < var_118_4 + var_118_12 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_4) / var_118_12

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_4 + var_118_12 and arg_115_1.time_ < var_118_4 + var_118_12 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play321192029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 321192029
		arg_119_1.duration_ = 13.17

		local var_119_0 = {
			zh = 9.7,
			ja = 13.166
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play321192030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["1011ui_story"]) and arg_119_1.var_.characterEffect1011ui_story == nil then
				arg_119_1.var_.characterEffect1011ui_story = arg_119_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["1011ui_story"]) then
				if arg_119_1.var_.characterEffect1011ui_story and not isNil(arg_119_1.actors_["1011ui_story"]) then
					arg_119_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["1011ui_story"]) and arg_119_1.var_.characterEffect1011ui_story then
				arg_119_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_122_2 = arg_119_1.actors_["404001ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.characterEffect404001ui_story == nil then
				arg_119_1.var_.characterEffect404001ui_story = var_122_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_3 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.characterEffect404001ui_story and not isNil(var_122_2) then
					arg_119_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_119_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_3)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.characterEffect404001ui_story then
				arg_119_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_119_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_122_4 = 0
			local var_122_5 = 1.025

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_6 = arg_119_1:GetWordFromCfg(321192029)
				local var_122_7 = arg_119_1:FormatText(var_122_6.content)

				arg_119_1.text_.text = var_122_7

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_9 = 41 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 41)

				if (41 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 41)) > 0 and var_122_5 < var_122_9 then
					arg_119_1.talkMaxDuration = var_122_9

					if var_122_9 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_4
					end
				end

				arg_119_1.text_.text = var_122_7
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192029", "story_v_out_321192.awb") ~= 0 then
					local var_122_10 = manager.audio:GetVoiceLength("story_v_out_321192", "321192029", "story_v_out_321192.awb") / 1000

					if var_122_10 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_4
					end

					if var_122_6.prefab_name ~= "" and arg_119_1.actors_[var_122_6.prefab_name] ~= nil then
						local var_122_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_6.prefab_name].transform, "story_v_out_321192", "321192029", "story_v_out_321192.awb")

						arg_119_1:RecordAudio("321192029", var_122_11)
						arg_119_1:RecordAudio("321192029", var_122_11)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_321192", "321192029", "story_v_out_321192.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_321192", "321192029", "story_v_out_321192.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_12 = math.max(var_122_5, arg_119_1.talkMaxDuration)

			if var_122_4 <= arg_119_1.time_ and arg_119_1.time_ < var_122_4 + var_122_12 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_4) / var_122_12

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_4 + var_122_12 and arg_119_1.time_ < var_122_4 + var_122_12 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play321192030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 321192030
		arg_123_1.duration_ = 4.73

		local var_123_0 = {
			zh = 3.166,
			ja = 4.733
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play321192031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["404001ui_story"]) and arg_123_1.var_.characterEffect404001ui_story == nil then
				arg_123_1.var_.characterEffect404001ui_story = arg_123_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["404001ui_story"]) then
				if arg_123_1.var_.characterEffect404001ui_story and not isNil(arg_123_1.actors_["404001ui_story"]) then
					arg_123_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["404001ui_story"]) and arg_123_1.var_.characterEffect404001ui_story then
				arg_123_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_126_2 = arg_123_1.actors_["1011ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.characterEffect1011ui_story == nil then
				arg_123_1.var_.characterEffect1011ui_story = var_126_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_3 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 and not isNil(var_126_2) then
				if arg_123_1.var_.characterEffect1011ui_story and not isNil(var_126_2) then
					arg_123_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_3)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.characterEffect1011ui_story then
				arg_123_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040actionlink/4040action457")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_126_4 = 0
			local var_126_5 = 0.45

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_6 = arg_123_1:GetWordFromCfg(321192030)
				local var_126_7 = arg_123_1:FormatText(var_126_6.content)

				arg_123_1.text_.text = var_126_7

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_9 = 18 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 18)

				if (18 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 18)) > 0 and var_126_5 < var_126_9 then
					arg_123_1.talkMaxDuration = var_126_9

					if var_126_9 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_4
					end
				end

				arg_123_1.text_.text = var_126_7
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192030", "story_v_out_321192.awb") ~= 0 then
					local var_126_10 = manager.audio:GetVoiceLength("story_v_out_321192", "321192030", "story_v_out_321192.awb") / 1000

					if var_126_10 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_4
					end

					if var_126_6.prefab_name ~= "" and arg_123_1.actors_[var_126_6.prefab_name] ~= nil then
						local var_126_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_6.prefab_name].transform, "story_v_out_321192", "321192030", "story_v_out_321192.awb")

						arg_123_1:RecordAudio("321192030", var_126_11)
						arg_123_1:RecordAudio("321192030", var_126_11)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_321192", "321192030", "story_v_out_321192.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_321192", "321192030", "story_v_out_321192.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_12 = math.max(var_126_5, arg_123_1.talkMaxDuration)

			if var_126_4 <= arg_123_1.time_ and arg_123_1.time_ < var_126_4 + var_126_12 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_4) / var_126_12

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_4 + var_126_12 and arg_123_1.time_ < var_126_4 + var_126_12 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play321192031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 321192031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play321192032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos404001ui_story = arg_127_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["404001ui_story"].transform.position).z)
				arg_127_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["404001ui_story"].transform.localEulerAngles = arg_127_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["404001ui_story"].transform.position).z)
				arg_127_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["404001ui_story"].transform.localEulerAngles = arg_127_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["1011ui_story"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1011ui_story = var_130_1.localPosition
			end

			local var_130_2 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 then
				var_130_1.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_127_1.time_ - 0) / var_130_2)
				var_130_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_1.position).x, (manager.ui.mainCamera.transform.position - var_130_1.position).y, (manager.ui.mainCamera.transform.position - var_130_1.position).z)
				var_130_1.localEulerAngles.z = 0
				var_130_1.localEulerAngles.x = 0
				var_130_1.localEulerAngles = var_130_1.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 then
				var_130_1.localPosition = Vector3.New(0, 100, 0)
				var_130_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_1.position).x, (manager.ui.mainCamera.transform.position - var_130_1.position).y, (manager.ui.mainCamera.transform.position - var_130_1.position).z)
				var_130_1.localEulerAngles.z = 0
				var_130_1.localEulerAngles.x = 0
				var_130_1.localEulerAngles = var_130_1.localEulerAngles
			end

			local var_130_3 = arg_127_1.actors_["404001ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_3) and arg_127_1.var_.characterEffect404001ui_story == nil then
				arg_127_1.var_.characterEffect404001ui_story = var_130_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_4 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 and not isNil(var_130_3) then
				if arg_127_1.var_.characterEffect404001ui_story and not isNil(var_130_3) then
					arg_127_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_127_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_4)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 and not isNil(var_130_3) and arg_127_1.var_.characterEffect404001ui_story then
				arg_127_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_127_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_127_1.time_ and arg_127_1.time_ <= 0.034000001847744 + arg_130_0 then
				arg_127_1:AudioAction("play", "effect", "se_story_side_1028", "se_story_side_1028_door", "")
			end

			local var_130_6 = 0
			local var_130_7 = 1.4

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_8 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(321192031).content)

				arg_127_1.text_.text = var_130_8

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_10 = 56 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_8) / 56)

				if (56 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_8) / 56)) > 0 and var_130_7 < var_130_10 then
					arg_127_1.talkMaxDuration = var_130_10

					if var_130_10 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_6
					end
				end

				arg_127_1.text_.text = var_130_8
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_11 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_11 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_11

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_11 and arg_127_1.time_ < var_130_6 + var_130_11 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play321192032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 321192032
		arg_131_1.duration_ = 7.17

		local var_131_0 = {
			zh = 7.166,
			ja = 5.5
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
				arg_131_0:Play321192033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["404001ui_story"]) and arg_131_1.var_.characterEffect404001ui_story == nil then
				arg_131_1.var_.characterEffect404001ui_story = arg_131_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["404001ui_story"]) then
				if arg_131_1.var_.characterEffect404001ui_story and not isNil(arg_131_1.actors_["404001ui_story"]) then
					arg_131_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["404001ui_story"]) and arg_131_1.var_.characterEffect404001ui_story then
				arg_131_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_134_2 = arg_131_1.actors_["404001ui_story"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos404001ui_story = var_134_2.localPosition
			end

			local var_134_3 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 then
				var_134_2.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_131_1.time_ - 0) / var_134_3)
				var_134_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_2.position).x, (manager.ui.mainCamera.transform.position - var_134_2.position).y, (manager.ui.mainCamera.transform.position - var_134_2.position).z)
				var_134_2.localEulerAngles.z = 0
				var_134_2.localEulerAngles.x = 0
				var_134_2.localEulerAngles = var_134_2.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 then
				var_134_2.localPosition = Vector3.New(0, -1.55, -5.5)
				var_134_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_2.position).x, (manager.ui.mainCamera.transform.position - var_134_2.position).y, (manager.ui.mainCamera.transform.position - var_134_2.position).z)
				var_134_2.localEulerAngles.z = 0
				var_134_2.localEulerAngles.x = 0
				var_134_2.localEulerAngles = var_134_2.localEulerAngles
			end

			local var_134_4 = 0
			local var_134_5 = 0.725

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(321192032)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 29 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 29)

				if (29 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 29)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192032", "story_v_out_321192.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_out_321192", "321192032", "story_v_out_321192.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_out_321192", "321192032", "story_v_out_321192.awb")

						arg_131_1:RecordAudio("321192032", var_134_11)
						arg_131_1:RecordAudio("321192032", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_321192", "321192032", "story_v_out_321192.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_321192", "321192032", "story_v_out_321192.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_12 = math.max(var_134_5, arg_131_1.talkMaxDuration)

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_12 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_4) / var_134_12

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_4 + var_134_12 and arg_131_1.time_ < var_134_4 + var_134_12 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play321192033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 321192033
		arg_135_1.duration_ = 9.3

		local var_135_0 = {
			zh = 6.2,
			ja = 9.3
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play321192034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.55

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:GetWordFromCfg(321192033)
				local var_138_2 = arg_135_1:FormatText(var_138_1.content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 22 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 22)

				if (22 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 22)) > 0 and var_138_0 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192033", "story_v_out_321192.awb") ~= 0 then
					local var_138_5 = manager.audio:GetVoiceLength("story_v_out_321192", "321192033", "story_v_out_321192.awb") / 1000

					if var_138_5 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + 0
					end

					if var_138_1.prefab_name ~= "" and arg_135_1.actors_[var_138_1.prefab_name] ~= nil then
						local var_138_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_1.prefab_name].transform, "story_v_out_321192", "321192033", "story_v_out_321192.awb")

						arg_135_1:RecordAudio("321192033", var_138_6)
						arg_135_1:RecordAudio("321192033", var_138_6)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_321192", "321192033", "story_v_out_321192.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_321192", "321192033", "story_v_out_321192.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play321192034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 321192034
		arg_139_1.duration_ = 8.03

		local var_139_0 = {
			zh = 4.9,
			ja = 8.033
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
				arg_139_0:Play321192035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action7_2")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_142_0 = 0
			local var_142_1 = 0.6

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_2 = arg_139_1:GetWordFromCfg(321192034)
				local var_142_3 = arg_139_1:FormatText(var_142_2.content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 24 <= 0 and var_142_1 or var_142_1 * (utf8.len(var_142_3) / 24)

				if (24 <= 0 and var_142_1 or var_142_1 * (utf8.len(var_142_3) / 24)) > 0 and var_142_1 < var_142_5 then
					arg_139_1.talkMaxDuration = var_142_5

					if var_142_5 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192034", "story_v_out_321192.awb") ~= 0 then
					local var_142_6 = manager.audio:GetVoiceLength("story_v_out_321192", "321192034", "story_v_out_321192.awb") / 1000

					if var_142_6 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_0
					end

					if var_142_2.prefab_name ~= "" and arg_139_1.actors_[var_142_2.prefab_name] ~= nil then
						local var_142_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_2.prefab_name].transform, "story_v_out_321192", "321192034", "story_v_out_321192.awb")

						arg_139_1:RecordAudio("321192034", var_142_7)
						arg_139_1:RecordAudio("321192034", var_142_7)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_321192", "321192034", "story_v_out_321192.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_321192", "321192034", "story_v_out_321192.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_8 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_8 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_8

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_8 and arg_139_1.time_ < var_142_0 + var_142_8 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play321192035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 321192035
		arg_143_1.duration_ = 8.63

		local var_143_0 = {
			zh = 5.466,
			ja = 8.633
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
				arg_143_0:Play321192036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1011ui_story = arg_143_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1011ui_story"].transform.position).z)
				arg_143_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1011ui_story"].transform.localEulerAngles = arg_143_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_143_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1011ui_story"].transform.position).z)
				arg_143_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1011ui_story"].transform.localEulerAngles = arg_143_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["404001ui_story"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos404001ui_story = var_146_1.localPosition
			end

			local var_146_2 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 then
				var_146_1.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_143_1.time_ - 0) / var_146_2)
				var_146_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_1.position).x, (manager.ui.mainCamera.transform.position - var_146_1.position).y, (manager.ui.mainCamera.transform.position - var_146_1.position).z)
				var_146_1.localEulerAngles.z = 0
				var_146_1.localEulerAngles.x = 0
				var_146_1.localEulerAngles = var_146_1.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 then
				var_146_1.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				var_146_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_1.position).x, (manager.ui.mainCamera.transform.position - var_146_1.position).y, (manager.ui.mainCamera.transform.position - var_146_1.position).z)
				var_146_1.localEulerAngles.z = 0
				var_146_1.localEulerAngles.x = 0
				var_146_1.localEulerAngles = var_146_1.localEulerAngles
			end

			local var_146_3 = arg_143_1.actors_["1011ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_3) and arg_143_1.var_.characterEffect1011ui_story == nil then
				arg_143_1.var_.characterEffect1011ui_story = var_146_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_4 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 and not isNil(var_146_3) then
				if arg_143_1.var_.characterEffect1011ui_story and not isNil(var_146_3) then
					arg_143_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 and not isNil(var_146_3) and arg_143_1.var_.characterEffect1011ui_story then
				arg_143_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_146_6 = arg_143_1.actors_["404001ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect404001ui_story == nil then
				arg_143_1.var_.characterEffect404001ui_story = var_146_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_7 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 and not isNil(var_146_6) then
				if arg_143_1.var_.characterEffect404001ui_story and not isNil(var_146_6) then
					arg_143_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_143_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_7)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect404001ui_story then
				arg_143_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_143_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_146_8 = 0
			local var_146_9 = 0.525

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_10 = arg_143_1:GetWordFromCfg(321192035)
				local var_146_11 = arg_143_1:FormatText(var_146_10.content)

				arg_143_1.text_.text = var_146_11

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_13 = 21 <= 0 and var_146_9 or var_146_9 * (utf8.len(var_146_11) / 21)

				if (21 <= 0 and var_146_9 or var_146_9 * (utf8.len(var_146_11) / 21)) > 0 and var_146_9 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_8
					end
				end

				arg_143_1.text_.text = var_146_11
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192035", "story_v_out_321192.awb") ~= 0 then
					local var_146_14 = manager.audio:GetVoiceLength("story_v_out_321192", "321192035", "story_v_out_321192.awb") / 1000

					if var_146_14 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_8
					end

					if var_146_10.prefab_name ~= "" and arg_143_1.actors_[var_146_10.prefab_name] ~= nil then
						local var_146_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_10.prefab_name].transform, "story_v_out_321192", "321192035", "story_v_out_321192.awb")

						arg_143_1:RecordAudio("321192035", var_146_15)
						arg_143_1:RecordAudio("321192035", var_146_15)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_321192", "321192035", "story_v_out_321192.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_321192", "321192035", "story_v_out_321192.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_16 = math.max(var_146_9, arg_143_1.talkMaxDuration)

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_16 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_8) / var_146_16

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_8 + var_146_16 and arg_143_1.time_ < var_146_8 + var_146_16 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play321192036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 321192036
		arg_147_1.duration_ = 3.37

		local var_147_0 = {
			zh = 1.999999999999,
			ja = 3.366
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
				arg_147_0:Play321192037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["404001ui_story"]) and arg_147_1.var_.characterEffect404001ui_story == nil then
				arg_147_1.var_.characterEffect404001ui_story = arg_147_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["404001ui_story"]) then
				if arg_147_1.var_.characterEffect404001ui_story and not isNil(arg_147_1.actors_["404001ui_story"]) then
					arg_147_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["404001ui_story"]) and arg_147_1.var_.characterEffect404001ui_story then
				arg_147_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_150_2 = arg_147_1.actors_["1011ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.characterEffect1011ui_story == nil then
				arg_147_1.var_.characterEffect1011ui_story = var_150_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_3 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_3 and not isNil(var_150_2) then
				if arg_147_1.var_.characterEffect1011ui_story and not isNil(var_150_2) then
					arg_147_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_3)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_3 and arg_147_1.time_ < 0 + var_150_3 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.characterEffect1011ui_story then
				arg_147_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_150_4 = 0
			local var_150_5 = 0.2

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_6 = arg_147_1:GetWordFromCfg(321192036)
				local var_150_7 = arg_147_1:FormatText(var_150_6.content)

				arg_147_1.text_.text = var_150_7

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 8 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 8)

				if (8 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 8)) > 0 and var_150_5 < var_150_9 then
					arg_147_1.talkMaxDuration = var_150_9

					if var_150_9 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_7
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192036", "story_v_out_321192.awb") ~= 0 then
					local var_150_10 = manager.audio:GetVoiceLength("story_v_out_321192", "321192036", "story_v_out_321192.awb") / 1000

					if var_150_10 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_4
					end

					if var_150_6.prefab_name ~= "" and arg_147_1.actors_[var_150_6.prefab_name] ~= nil then
						local var_150_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_6.prefab_name].transform, "story_v_out_321192", "321192036", "story_v_out_321192.awb")

						arg_147_1:RecordAudio("321192036", var_150_11)
						arg_147_1:RecordAudio("321192036", var_150_11)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_321192", "321192036", "story_v_out_321192.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_321192", "321192036", "story_v_out_321192.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_12 = math.max(var_150_5, arg_147_1.talkMaxDuration)

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_12 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_4) / var_150_12

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_4 + var_150_12 and arg_147_1.time_ < var_150_4 + var_150_12 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play321192037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 321192037
		arg_151_1.duration_ = 10.17

		local var_151_0 = {
			zh = 5.4,
			ja = 10.166
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
				arg_151_0:Play321192038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1011ui_story = arg_151_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1011ui_story"].transform.position).z)
				arg_151_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1011ui_story"].transform.localEulerAngles = arg_151_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_151_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1011ui_story"].transform.position).z)
				arg_151_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1011ui_story"].transform.localEulerAngles = arg_151_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["1011ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1011ui_story == nil then
				arg_151_1.var_.characterEffect1011ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect1011ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1011ui_story then
				arg_151_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_154_4 = arg_151_1.actors_["404001ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_4) and arg_151_1.var_.characterEffect404001ui_story == nil then
				arg_151_1.var_.characterEffect404001ui_story = var_154_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_5 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_5 and not isNil(var_154_4) then
				if arg_151_1.var_.characterEffect404001ui_story and not isNil(var_154_4) then
					arg_151_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_151_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_5)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_5 and arg_151_1.time_ < 0 + var_154_5 + arg_154_0 and not isNil(var_154_4) and arg_151_1.var_.characterEffect404001ui_story then
				arg_151_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_151_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_2")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_154_6 = 0
			local var_154_7 = 0.675

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_8 = arg_151_1:GetWordFromCfg(321192037)
				local var_154_9 = arg_151_1:FormatText(var_154_8.content)

				arg_151_1.text_.text = var_154_9

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 27 <= 0 and var_154_7 or var_154_7 * (utf8.len(var_154_9) / 27)

				if (27 <= 0 and var_154_7 or var_154_7 * (utf8.len(var_154_9) / 27)) > 0 and var_154_7 < var_154_11 then
					arg_151_1.talkMaxDuration = var_154_11

					if var_154_11 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_11 + var_154_6
					end
				end

				arg_151_1.text_.text = var_154_9
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192037", "story_v_out_321192.awb") ~= 0 then
					local var_154_12 = manager.audio:GetVoiceLength("story_v_out_321192", "321192037", "story_v_out_321192.awb") / 1000

					if var_154_12 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_12 + var_154_6
					end

					if var_154_8.prefab_name ~= "" and arg_151_1.actors_[var_154_8.prefab_name] ~= nil then
						local var_154_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_8.prefab_name].transform, "story_v_out_321192", "321192037", "story_v_out_321192.awb")

						arg_151_1:RecordAudio("321192037", var_154_13)
						arg_151_1:RecordAudio("321192037", var_154_13)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_321192", "321192037", "story_v_out_321192.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_321192", "321192037", "story_v_out_321192.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_14 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_14 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_14

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_14 and arg_151_1.time_ < var_154_6 + var_154_14 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play321192038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 321192038
		arg_155_1.duration_ = 2

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play321192039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["404001ui_story"]) and arg_155_1.var_.characterEffect404001ui_story == nil then
				arg_155_1.var_.characterEffect404001ui_story = arg_155_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["404001ui_story"]) then
				if arg_155_1.var_.characterEffect404001ui_story and not isNil(arg_155_1.actors_["404001ui_story"]) then
					arg_155_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["404001ui_story"]) and arg_155_1.var_.characterEffect404001ui_story then
				arg_155_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_158_2 = arg_155_1.actors_["1011ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.characterEffect1011ui_story == nil then
				arg_155_1.var_.characterEffect1011ui_story = var_158_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_3 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 and not isNil(var_158_2) then
				if arg_155_1.var_.characterEffect1011ui_story and not isNil(var_158_2) then
					arg_155_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_3)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.characterEffect1011ui_story then
				arg_155_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_158_4 = 0
			local var_158_5 = 0.15

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_6 = arg_155_1:GetWordFromCfg(321192038)
				local var_158_7 = arg_155_1:FormatText(var_158_6.content)

				arg_155_1.text_.text = var_158_7

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_9 = 6 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 6)

				if (6 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 6)) > 0 and var_158_5 < var_158_9 then
					arg_155_1.talkMaxDuration = var_158_9

					if var_158_9 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_9 + var_158_4
					end
				end

				arg_155_1.text_.text = var_158_7
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192038", "story_v_out_321192.awb") ~= 0 then
					local var_158_10 = manager.audio:GetVoiceLength("story_v_out_321192", "321192038", "story_v_out_321192.awb") / 1000

					if var_158_10 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_4
					end

					if var_158_6.prefab_name ~= "" and arg_155_1.actors_[var_158_6.prefab_name] ~= nil then
						local var_158_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_6.prefab_name].transform, "story_v_out_321192", "321192038", "story_v_out_321192.awb")

						arg_155_1:RecordAudio("321192038", var_158_11)
						arg_155_1:RecordAudio("321192038", var_158_11)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_321192", "321192038", "story_v_out_321192.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_321192", "321192038", "story_v_out_321192.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_12 = math.max(var_158_5, arg_155_1.talkMaxDuration)

			if var_158_4 <= arg_155_1.time_ and arg_155_1.time_ < var_158_4 + var_158_12 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_4) / var_158_12

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_4 + var_158_12 and arg_155_1.time_ < var_158_4 + var_158_12 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play321192039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 321192039
		arg_159_1.duration_ = 10.5

		local var_159_0 = {
			zh = 6.9,
			ja = 10.5
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
				arg_159_0:Play321192040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1011ui_story"]) and arg_159_1.var_.characterEffect1011ui_story == nil then
				arg_159_1.var_.characterEffect1011ui_story = arg_159_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1011ui_story"]) then
				if arg_159_1.var_.characterEffect1011ui_story and not isNil(arg_159_1.actors_["1011ui_story"]) then
					arg_159_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1011ui_story"]) and arg_159_1.var_.characterEffect1011ui_story then
				arg_159_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_162_2 = arg_159_1.actors_["404001ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.characterEffect404001ui_story == nil then
				arg_159_1.var_.characterEffect404001ui_story = var_162_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_3 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_3 and not isNil(var_162_2) then
				if arg_159_1.var_.characterEffect404001ui_story and not isNil(var_162_2) then
					arg_159_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_159_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_3)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_3 and arg_159_1.time_ < 0 + var_162_3 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.characterEffect404001ui_story then
				arg_159_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_159_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_162_4 = 0
			local var_162_5 = 0.775

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_6 = arg_159_1:GetWordFromCfg(321192039)
				local var_162_7 = arg_159_1:FormatText(var_162_6.content)

				arg_159_1.text_.text = var_162_7

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_9 = 31 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 31)

				if (31 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 31)) > 0 and var_162_5 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9

					if var_162_9 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_7
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192039", "story_v_out_321192.awb") ~= 0 then
					local var_162_10 = manager.audio:GetVoiceLength("story_v_out_321192", "321192039", "story_v_out_321192.awb") / 1000

					if var_162_10 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_4
					end

					if var_162_6.prefab_name ~= "" and arg_159_1.actors_[var_162_6.prefab_name] ~= nil then
						local var_162_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_6.prefab_name].transform, "story_v_out_321192", "321192039", "story_v_out_321192.awb")

						arg_159_1:RecordAudio("321192039", var_162_11)
						arg_159_1:RecordAudio("321192039", var_162_11)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_321192", "321192039", "story_v_out_321192.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_321192", "321192039", "story_v_out_321192.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_12 = math.max(var_162_5, arg_159_1.talkMaxDuration)

			if var_162_4 <= arg_159_1.time_ and arg_159_1.time_ < var_162_4 + var_162_12 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_4) / var_162_12

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_4 + var_162_12 and arg_159_1.time_ < var_162_4 + var_162_12 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play321192040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 321192040
		arg_163_1.duration_ = 4.83

		local var_163_0 = {
			zh = 4.833,
			ja = 4.333
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
				arg_163_0:Play321192041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos404001ui_story = arg_163_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["404001ui_story"].transform.position).z)
				arg_163_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["404001ui_story"].transform.localEulerAngles = arg_163_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_163_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["404001ui_story"].transform.position).z)
				arg_163_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["404001ui_story"].transform.localEulerAngles = arg_163_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["404001ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect404001ui_story == nil then
				arg_163_1.var_.characterEffect404001ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect404001ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect404001ui_story then
				arg_163_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_166_4 = arg_163_1.actors_["1011ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_4) and arg_163_1.var_.characterEffect1011ui_story == nil then
				arg_163_1.var_.characterEffect1011ui_story = var_166_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_5 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_5 and not isNil(var_166_4) then
				if arg_163_1.var_.characterEffect1011ui_story and not isNil(var_166_4) then
					arg_163_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_5)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_5 and arg_163_1.time_ < 0 + var_166_5 + arg_166_0 and not isNil(var_166_4) and arg_163_1.var_.characterEffect1011ui_story then
				arg_163_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_166_6 = 0
			local var_166_7 = 0.45

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_8 = arg_163_1:GetWordFromCfg(321192040)
				local var_166_9 = arg_163_1:FormatText(var_166_8.content)

				arg_163_1.text_.text = var_166_9

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 18 <= 0 and var_166_7 or var_166_7 * (utf8.len(var_166_9) / 18)

				if (18 <= 0 and var_166_7 or var_166_7 * (utf8.len(var_166_9) / 18)) > 0 and var_166_7 < var_166_11 then
					arg_163_1.talkMaxDuration = var_166_11

					if var_166_11 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_9
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192040", "story_v_out_321192.awb") ~= 0 then
					local var_166_12 = manager.audio:GetVoiceLength("story_v_out_321192", "321192040", "story_v_out_321192.awb") / 1000

					if var_166_12 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_12 + var_166_6
					end

					if var_166_8.prefab_name ~= "" and arg_163_1.actors_[var_166_8.prefab_name] ~= nil then
						local var_166_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_8.prefab_name].transform, "story_v_out_321192", "321192040", "story_v_out_321192.awb")

						arg_163_1:RecordAudio("321192040", var_166_13)
						arg_163_1:RecordAudio("321192040", var_166_13)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_321192", "321192040", "story_v_out_321192.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_321192", "321192040", "story_v_out_321192.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_14 = math.max(var_166_7, arg_163_1.talkMaxDuration)

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_14 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_6) / var_166_14

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_6 + var_166_14 and arg_163_1.time_ < var_166_6 + var_166_14 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play321192041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 321192041
		arg_167_1.duration_ = 3.67

		local var_167_0 = {
			zh = 2.733,
			ja = 3.666
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
				arg_167_0:Play321192042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1011ui_story = arg_167_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1011ui_story"].transform.position).z)
				arg_167_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1011ui_story"].transform.localEulerAngles = arg_167_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_167_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1011ui_story"].transform.position).z)
				arg_167_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1011ui_story"].transform.localEulerAngles = arg_167_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["1011ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1011ui_story == nil then
				arg_167_1.var_.characterEffect1011ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect1011ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1011ui_story then
				arg_167_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_170_4 = arg_167_1.actors_["404001ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_4) and arg_167_1.var_.characterEffect404001ui_story == nil then
				arg_167_1.var_.characterEffect404001ui_story = var_170_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_5 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_5 and not isNil(var_170_4) then
				if arg_167_1.var_.characterEffect404001ui_story and not isNil(var_170_4) then
					arg_167_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_167_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_5)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_5 and arg_167_1.time_ < 0 + var_170_5 + arg_170_0 and not isNil(var_170_4) and arg_167_1.var_.characterEffect404001ui_story then
				arg_167_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_167_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_170_6 = 0
			local var_170_7 = 0.175

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_8 = arg_167_1:GetWordFromCfg(321192041)
				local var_170_9 = arg_167_1:FormatText(var_170_8.content)

				arg_167_1.text_.text = var_170_9

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_11 = 7 <= 0 and var_170_7 or var_170_7 * (utf8.len(var_170_9) / 7)

				if (7 <= 0 and var_170_7 or var_170_7 * (utf8.len(var_170_9) / 7)) > 0 and var_170_7 < var_170_11 then
					arg_167_1.talkMaxDuration = var_170_11

					if var_170_11 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_11 + var_170_6
					end
				end

				arg_167_1.text_.text = var_170_9
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192041", "story_v_out_321192.awb") ~= 0 then
					local var_170_12 = manager.audio:GetVoiceLength("story_v_out_321192", "321192041", "story_v_out_321192.awb") / 1000

					if var_170_12 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_12 + var_170_6
					end

					if var_170_8.prefab_name ~= "" and arg_167_1.actors_[var_170_8.prefab_name] ~= nil then
						local var_170_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_8.prefab_name].transform, "story_v_out_321192", "321192041", "story_v_out_321192.awb")

						arg_167_1:RecordAudio("321192041", var_170_13)
						arg_167_1:RecordAudio("321192041", var_170_13)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_321192", "321192041", "story_v_out_321192.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_321192", "321192041", "story_v_out_321192.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_14 = math.max(var_170_7, arg_167_1.talkMaxDuration)

			if var_170_6 <= arg_167_1.time_ and arg_167_1.time_ < var_170_6 + var_170_14 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_6) / var_170_14

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_6 + var_170_14 and arg_167_1.time_ < var_170_6 + var_170_14 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play321192042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 321192042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play321192043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos404001ui_story = arg_171_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["404001ui_story"].transform.position).z)
				arg_171_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["404001ui_story"].transform.localEulerAngles = arg_171_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["404001ui_story"].transform.position).z)
				arg_171_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["404001ui_story"].transform.localEulerAngles = arg_171_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["1011ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1011ui_story = var_174_1.localPosition
			end

			local var_174_2 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 then
				var_174_1.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_2)
				var_174_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_1.position).x, (manager.ui.mainCamera.transform.position - var_174_1.position).y, (manager.ui.mainCamera.transform.position - var_174_1.position).z)
				var_174_1.localEulerAngles.z = 0
				var_174_1.localEulerAngles.x = 0
				var_174_1.localEulerAngles = var_174_1.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 then
				var_174_1.localPosition = Vector3.New(0, 100, 0)
				var_174_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_1.position).x, (manager.ui.mainCamera.transform.position - var_174_1.position).y, (manager.ui.mainCamera.transform.position - var_174_1.position).z)
				var_174_1.localEulerAngles.z = 0
				var_174_1.localEulerAngles.x = 0
				var_174_1.localEulerAngles = var_174_1.localEulerAngles
			end

			local var_174_3 = arg_171_1.actors_["1011ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_3) and arg_171_1.var_.characterEffect1011ui_story == nil then
				arg_171_1.var_.characterEffect1011ui_story = var_174_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_4 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 and not isNil(var_174_3) then
				if arg_171_1.var_.characterEffect1011ui_story and not isNil(var_174_3) then
					arg_171_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_4)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 and not isNil(var_174_3) and arg_171_1.var_.characterEffect1011ui_story then
				arg_171_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_174_5 = 0
			local var_174_6 = 1.425

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_7 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(321192042).content)

				arg_171_1.text_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 57 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_7) / 57)

				if (57 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_7) / 57)) > 0 and var_174_6 < var_174_9 then
					arg_171_1.talkMaxDuration = var_174_9

					if var_174_9 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_5
					end
				end

				arg_171_1.text_.text = var_174_7
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_6, arg_171_1.talkMaxDuration)

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_5) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_5 + var_174_10 and arg_171_1.time_ < var_174_5 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play321192043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 321192043
		arg_175_1.duration_ = 2

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play321192044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos404001ui_story = arg_175_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["404001ui_story"].transform.position).z)
				arg_175_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["404001ui_story"].transform.localEulerAngles = arg_175_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_175_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["404001ui_story"].transform.position).z)
				arg_175_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["404001ui_story"].transform.localEulerAngles = arg_175_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["404001ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect404001ui_story == nil then
				arg_175_1.var_.characterEffect404001ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect404001ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect404001ui_story then
				arg_175_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_178_4 = 0
			local var_178_5 = 0.1

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_6 = arg_175_1:GetWordFromCfg(321192043)
				local var_178_7 = arg_175_1:FormatText(var_178_6.content)

				arg_175_1.text_.text = var_178_7

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_9 = 4 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 4)

				if (4 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 4)) > 0 and var_178_5 < var_178_9 then
					arg_175_1.talkMaxDuration = var_178_9

					if var_178_9 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_9 + var_178_4
					end
				end

				arg_175_1.text_.text = var_178_7
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192043", "story_v_out_321192.awb") ~= 0 then
					local var_178_10 = manager.audio:GetVoiceLength("story_v_out_321192", "321192043", "story_v_out_321192.awb") / 1000

					if var_178_10 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_4
					end

					if var_178_6.prefab_name ~= "" and arg_175_1.actors_[var_178_6.prefab_name] ~= nil then
						local var_178_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_6.prefab_name].transform, "story_v_out_321192", "321192043", "story_v_out_321192.awb")

						arg_175_1:RecordAudio("321192043", var_178_11)
						arg_175_1:RecordAudio("321192043", var_178_11)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_321192", "321192043", "story_v_out_321192.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_321192", "321192043", "story_v_out_321192.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_12 = math.max(var_178_5, arg_175_1.talkMaxDuration)

			if var_178_4 <= arg_175_1.time_ and arg_175_1.time_ < var_178_4 + var_178_12 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_4) / var_178_12

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_4 + var_178_12 and arg_175_1.time_ < var_178_4 + var_178_12 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play321192044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 321192044
		arg_179_1.duration_ = 4.87

		local var_179_0 = {
			zh = 3.866,
			ja = 4.866
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
				arg_179_0:Play321192045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["404001ui_story"]) and arg_179_1.var_.characterEffect404001ui_story == nil then
				arg_179_1.var_.characterEffect404001ui_story = arg_179_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["404001ui_story"]) then
				if arg_179_1.var_.characterEffect404001ui_story and not isNil(arg_179_1.actors_["404001ui_story"]) then
					arg_179_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_179_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_0)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["404001ui_story"]) and arg_179_1.var_.characterEffect404001ui_story then
				arg_179_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_179_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_182_1 = 0
			local var_182_2 = 0.525

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_3 = arg_179_1:GetWordFromCfg(321192044)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_6 = 21 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_4) / 21)

				if (21 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_4) / 21)) > 0 and var_182_2 < var_182_6 then
					arg_179_1.talkMaxDuration = var_182_6

					if var_182_6 + var_182_1 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_1
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192044", "story_v_out_321192.awb") ~= 0 then
					local var_182_7 = manager.audio:GetVoiceLength("story_v_out_321192", "321192044", "story_v_out_321192.awb") / 1000

					if var_182_7 + var_182_1 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_1
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_out_321192", "321192044", "story_v_out_321192.awb")

						arg_179_1:RecordAudio("321192044", var_182_8)
						arg_179_1:RecordAudio("321192044", var_182_8)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_321192", "321192044", "story_v_out_321192.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_321192", "321192044", "story_v_out_321192.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_9 = math.max(var_182_2, arg_179_1.talkMaxDuration)

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_9 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_1) / var_182_9

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_1 + var_182_9 and arg_179_1.time_ < var_182_1 + var_182_9 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play321192045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 321192045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play321192046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos404001ui_story = arg_183_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["404001ui_story"].transform.position).z)
				arg_183_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["404001ui_story"].transform.localEulerAngles = arg_183_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["404001ui_story"].transform.position).z)
				arg_183_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["404001ui_story"].transform.localEulerAngles = arg_183_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if 0.366666666666667 < arg_183_1.time_ and arg_183_1.time_ <= 0.366666666666667 + arg_186_0 then
				arg_183_1:AudioAction("play", "effect", "se_story_140", "se_story_140_rock2", "")
			end

			local var_186_2 = 0
			local var_186_3 = 1.25

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_2 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_4 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(321192045).content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_6 = 50 <= 0 and var_186_3 or var_186_3 * (utf8.len(var_186_4) / 50)

				if (50 <= 0 and var_186_3 or var_186_3 * (utf8.len(var_186_4) / 50)) > 0 and var_186_3 < var_186_6 then
					arg_183_1.talkMaxDuration = var_186_6

					if var_186_6 + var_186_2 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_6 + var_186_2
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_3, arg_183_1.talkMaxDuration)

			if var_186_2 <= arg_183_1.time_ and arg_183_1.time_ < var_186_2 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_2) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_2 + var_186_7 and arg_183_1.time_ < var_186_2 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play321192046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 321192046
		arg_187_1.duration_ = 5.33

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play321192047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_190_0 = 0.9

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				local var_190_1, var_190_2 = math.modf((arg_187_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_190_2 * 0.13, var_190_2 * 0.13, var_190_2 * 0.13) + arg_187_1.var_.shakeOldPos
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				manager.ui.mainCamera.transform.localPosition = arg_187_1.var_.shakeOldPos
			end

			local var_190_3 = 0

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_3 + arg_190_0 then
				arg_187_1.allBtn_.enabled = false
			end

			if arg_187_1.time_ >= var_190_3 + 0.9 and arg_187_1.time_ < var_190_3 + 0.9 + arg_190_0 then
				arg_187_1.allBtn_.enabled = true
			end

			if 0.608333333333333 < arg_187_1.time_ and arg_187_1.time_ <= 0.608333333333333 + arg_190_0 then
				arg_187_1:AudioAction("play", "effect", "se_story_140", "se_story_140_rock3", "")
			end

			if arg_187_1.frameCnt_ <= 1 then
				arg_187_1.dialog_:SetActive(false)
			end

			local var_190_5 = 0.333333333333333
			local var_190_6 = 1.275

			if 0.333333333333333 < arg_187_1.time_ and arg_187_1.time_ <= var_190_5 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0

				arg_187_1.dialog_:SetActive(true)

				arg_187_1.dialogCg_.alpha = 0

				local var_190_7 = LeanTween.value(arg_187_1.dialog_, 0, 1, 0.3)

				var_190_7:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_187_1.dialogCg_.alpha = arg_191_0
				end))
				var_190_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_187_1.dialog_)
					var_190_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_187_1.duration_ = arg_187_1.duration_ + 0.3

				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_8 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(321192046).content)

				arg_187_1.text_.text = var_190_8

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_10 = 51 <= 0 and var_190_6 or var_190_6 * (utf8.len(var_190_8) / 51)

				if (51 <= 0 and var_190_6 or var_190_6 * (utf8.len(var_190_8) / 51)) > 0 and var_190_6 < var_190_10 then
					arg_187_1.talkMaxDuration = var_190_10
					var_190_5 = var_190_5 + 0.3

					if var_190_10 + var_190_5 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_5
					end
				end

				arg_187_1.text_.text = var_190_8
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_11 = var_190_5 + 0.3
			local var_190_12 = math.max(var_190_6, arg_187_1.talkMaxDuration)

			if var_190_5 + 0.3 <= arg_187_1.time_ and arg_187_1.time_ < var_190_11 + var_190_12 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_11) / var_190_12

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_11 + var_190_12 and arg_187_1.time_ < var_190_11 + var_190_12 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play321192047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 321192047
		arg_193_1.duration_ = 5.5

		local var_193_0 = {
			zh = 3.466,
			ja = 5.5
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
			arg_193_1.auto_ = false
		end

		function arg_193_1.playNext_(arg_195_0)
			arg_193_1.onStoryFinished_()
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.275

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_1 = arg_193_1:GetWordFromCfg(321192047)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 11 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 11)

				if (11 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 11)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321192", "321192047", "story_v_out_321192.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_out_321192", "321192047", "story_v_out_321192.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_out_321192", "321192047", "story_v_out_321192.awb")

						arg_193_1:RecordAudio("321192047", var_196_6)
						arg_193_1:RecordAudio("321192047", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_321192", "321192047", "story_v_out_321192.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_321192", "321192047", "story_v_out_321192.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L15f"
	},
	voices = {
		"story_v_out_321192.awb"
	}
}
