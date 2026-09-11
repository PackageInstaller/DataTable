return {
	Play322042001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322042001
		arg_1_1.duration_ = 4.1

		local var_1_0 = {
			zh = 4.1,
			ja = 3.9
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
				arg_1_0:Play322042002(arg_1_1)
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

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "1284ui_story"

			if arg_1_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1284ui_story"].transform

			if 1.88 < arg_1_1.time_ and arg_1_1.time_ <= 1.88 + arg_4_0 then
				arg_1_1.var_.moveOldPos1284ui_story = var_4_13.localPosition

				arg_1_1:ShowWeapon(arg_1_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_4_14 = 0.001

			if 1.88 <= arg_1_1.time_ and arg_1_1.time_ < 1.88 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_1_1.time_ - 1.88) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.88 + var_4_14 and arg_1_1.time_ < 1.88 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1284ui_story"]

			if 1.88 < arg_1_1.time_ and arg_1_1.time_ <= 1.88 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1284ui_story == nil then
				arg_1_1.var_.characterEffect1284ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.88 <= arg_1_1.time_ and arg_1_1.time_ < 1.88 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1284ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.88 + var_4_16 and arg_1_1.time_ < 1.88 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1284ui_story then
				arg_1_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 1.88 < arg_1_1.time_ and arg_1_1.time_ <= 1.88 + arg_4_0 then
				arg_1_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 1.88 < arg_1_1.time_ and arg_1_1.time_ <= 1.88 + arg_4_0 then
				arg_1_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
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

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 2
			local var_4_26 = 0.325

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_27 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_27:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_27:setOnUpdate(nil):setOnComplete(nil)
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

				local var_4_28 = arg_1_1:GetWordFromCfg(322042001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 13 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 13)

				if (13 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 13)) > 0 and var_4_26 < var_4_31 then
					arg_1_1.talkMaxDuration = var_4_31
					var_4_25 = var_4_25 + 0.3

					if var_4_31 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_25
					end
				end

				arg_1_1.text_.text = var_4_29
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042001", "story_v_out_322042.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_322042", "322042001", "story_v_out_322042.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_322042", "322042001", "story_v_out_322042.awb")

						arg_1_1:RecordAudio("322042001", var_4_33)
						arg_1_1:RecordAudio("322042001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322042", "322042001", "story_v_out_322042.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322042", "322042001", "story_v_out_322042.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_34 = var_4_25 + 0.3
			local var_4_35 = math.max(var_4_26, arg_1_1.talkMaxDuration)

			if var_4_25 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_34) / var_4_35

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.88,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play322042002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322042002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play322042003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "10104ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["10104ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["10104ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["10104ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["10104ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["10104ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10104ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0.99, -1.12, -5.99)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["10104ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10104ui_story == nil then
				arg_9_1.var_.characterEffect10104ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect10104ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10104ui_story then
				arg_9_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_12_8 = arg_9_1.actors_["1284ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.characterEffect1284ui_story == nil then
				arg_9_1.var_.characterEffect1284ui_story = var_12_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_9 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 and not isNil(var_12_8) then
				if arg_9_1.var_.characterEffect1284ui_story and not isNil(var_12_8) then
					arg_9_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_9)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.characterEffect1284ui_story then
				arg_9_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				if arg_9_1.var_.characterEffect10104ui_story == nil then
					arg_9_1.var_.characterEffect10104ui_story = arg_9_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_12_10 = arg_9_1.var_.characterEffect10104ui_story

				arg_9_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_12_10.interferenceEffect.enabled = true
				var_12_10.interferenceEffect.noise = 0.001
				var_12_10.interferenceEffect.simTimeScale = 1
				var_12_10.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				if arg_9_1.var_.characterEffect10104ui_story == nil then
					arg_9_1.var_.characterEffect10104ui_story = arg_9_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_9_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_12_12 = 0
			local var_12_13 = 0.05

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_14 = arg_9_1:GetWordFromCfg(322042002)
				local var_12_15 = arg_9_1:FormatText(var_12_14.content)

				arg_9_1.text_.text = var_12_15

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_17 = 2 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 2)

				if (2 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 2)) > 0 and var_12_13 < var_12_17 then
					arg_9_1.talkMaxDuration = var_12_17

					if var_12_17 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_17 + var_12_12
					end
				end

				arg_9_1.text_.text = var_12_15
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042002", "story_v_out_322042.awb") ~= 0 then
					local var_12_18 = manager.audio:GetVoiceLength("story_v_out_322042", "322042002", "story_v_out_322042.awb") / 1000

					if var_12_18 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_12
					end

					if var_12_14.prefab_name ~= "" and arg_9_1.actors_[var_12_14.prefab_name] ~= nil then
						local var_12_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_14.prefab_name].transform, "story_v_out_322042", "322042002", "story_v_out_322042.awb")

						arg_9_1:RecordAudio("322042002", var_12_19)
						arg_9_1:RecordAudio("322042002", var_12_19)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_322042", "322042002", "story_v_out_322042.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_322042", "322042002", "story_v_out_322042.awb")
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
				actorName = "10104ui_story",
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
	Play322042003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 322042003
		arg_13_1.duration_ = 5.47

		local var_13_0 = {
			zh = 3.633,
			ja = 5.466
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
				arg_13_0:Play322042004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1284ui_story"]) and arg_13_1.var_.characterEffect1284ui_story == nil then
				arg_13_1.var_.characterEffect1284ui_story = arg_13_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1284ui_story"]) then
				if arg_13_1.var_.characterEffect1284ui_story and not isNil(arg_13_1.actors_["1284ui_story"]) then
					arg_13_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1284ui_story"]) and arg_13_1.var_.characterEffect1284ui_story then
				arg_13_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_16_2 = arg_13_1.actors_["10104ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.characterEffect10104ui_story == nil then
				arg_13_1.var_.characterEffect10104ui_story = var_16_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_3 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.characterEffect10104ui_story and not isNil(var_16_2) then
					arg_13_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_3)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.characterEffect10104ui_story then
				arg_13_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_16_4 = 0
			local var_16_5 = 0.525

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(322042003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 21 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 21)

				if (21 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 21)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042003", "story_v_out_322042.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_322042", "322042003", "story_v_out_322042.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_out_322042", "322042003", "story_v_out_322042.awb")

						arg_13_1:RecordAudio("322042003", var_16_11)
						arg_13_1:RecordAudio("322042003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_322042", "322042003", "story_v_out_322042.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_322042", "322042003", "story_v_out_322042.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_12 = math.max(var_16_5, arg_13_1.talkMaxDuration)

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_12 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_4) / var_16_12

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_4 + var_16_12 and arg_13_1.time_ < var_16_4 + var_16_12 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play322042004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 322042004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play322042005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1284ui_story = arg_17_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1284ui_story"].transform.position).z)
				arg_17_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1284ui_story"].transform.localEulerAngles = arg_17_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1284ui_story"].transform.position).z)
				arg_17_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1284ui_story"].transform.localEulerAngles = arg_17_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["10104ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10104ui_story = var_20_1.localPosition
			end

			local var_20_2 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 then
				var_20_1.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_2)
				var_20_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_1.position).x, (manager.ui.mainCamera.transform.position - var_20_1.position).y, (manager.ui.mainCamera.transform.position - var_20_1.position).z)
				var_20_1.localEulerAngles.z = 0
				var_20_1.localEulerAngles.x = 0
				var_20_1.localEulerAngles = var_20_1.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 then
				var_20_1.localPosition = Vector3.New(0, 100, 0)
				var_20_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_1.position).x, (manager.ui.mainCamera.transform.position - var_20_1.position).y, (manager.ui.mainCamera.transform.position - var_20_1.position).z)
				var_20_1.localEulerAngles.z = 0
				var_20_1.localEulerAngles.x = 0
				var_20_1.localEulerAngles = var_20_1.localEulerAngles
			end

			local var_20_3 = 0
			local var_20_4 = 1.375

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_3 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_5 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(322042004).content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 55 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 55)

				if (55 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 55)) > 0 and var_20_4 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_3 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_3
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_8 = math.max(var_20_4, arg_17_1.talkMaxDuration)

			if var_20_3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_3 + var_20_8 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_3) / var_20_8

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_3 + var_20_8 and arg_17_1.time_ < var_20_3 + var_20_8 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play322042005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 322042005
		arg_21_1.duration_ = 11.67

		local var_21_0 = {
			zh = 8.633,
			ja = 11.666
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
				arg_21_0:Play322042006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1284ui_story = arg_21_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1284ui_story"].transform.position).z)
				arg_21_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1284ui_story"].transform.localEulerAngles = arg_21_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.22)
				arg_21_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1284ui_story"].transform.position).z)
				arg_21_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1284ui_story"].transform.localEulerAngles = arg_21_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1284ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1284ui_story == nil then
				arg_21_1.var_.characterEffect1284ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1284ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1284ui_story then
				arg_21_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_24_4 = 0
			local var_24_5 = 1.2

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(322042005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 48 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 48)

				if (48 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 48)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042005", "story_v_out_322042.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_322042", "322042005", "story_v_out_322042.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_322042", "322042005", "story_v_out_322042.awb")

						arg_21_1:RecordAudio("322042005", var_24_11)
						arg_21_1:RecordAudio("322042005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_322042", "322042005", "story_v_out_322042.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_322042", "322042005", "story_v_out_322042.awb")
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

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play322042006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 322042006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play322042007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_28_0 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_25_1.stage_.transform)

				var_28_0.name = "404001ui_story"
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["404001ui_story"] = var_28_0

				local var_28_1 = var_28_0:GetComponentInChildren(typeof(CharacterEffect))

				var_28_1.enabled = true

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_1.transform, false)

				arg_25_1.var_["404001ui_story" .. "Animator"] = var_28_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_["404001ui_story" .. "Animator"].applyRootMotion = true
				arg_25_1.var_["404001ui_story" .. "LipSync"] = var_28_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_3 = arg_25_1.actors_["404001ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos404001ui_story = var_28_3.localPosition
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_25_1.time_ - 0) / var_28_4)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(0.8, -1.55, -5.5)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			local var_28_5 = arg_25_1.actors_["1284ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1284ui_story = var_28_5.localPosition
			end

			local var_28_6 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 then
				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_25_1.time_ - 0) / var_28_6)
				var_28_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_5.position).x, (manager.ui.mainCamera.transform.position - var_28_5.position).y, (manager.ui.mainCamera.transform.position - var_28_5.position).z)
				var_28_5.localEulerAngles.z = 0
				var_28_5.localEulerAngles.x = 0
				var_28_5.localEulerAngles = var_28_5.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				var_28_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_5.position).x, (manager.ui.mainCamera.transform.position - var_28_5.position).y, (manager.ui.mainCamera.transform.position - var_28_5.position).z)
				var_28_5.localEulerAngles.z = 0
				var_28_5.localEulerAngles.x = 0
				var_28_5.localEulerAngles = var_28_5.localEulerAngles
			end

			local var_28_7 = arg_25_1.actors_["404001ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.characterEffect404001ui_story == nil then
				arg_25_1.var_.characterEffect404001ui_story = var_28_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_8 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_8 and not isNil(var_28_7) then
				if arg_25_1.var_.characterEffect404001ui_story and not isNil(var_28_7) then
					arg_25_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_8 and arg_25_1.time_ < 0 + var_28_8 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.characterEffect404001ui_story then
				arg_25_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_28_10 = arg_25_1.actors_["1284ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_10) and arg_25_1.var_.characterEffect1284ui_story == nil then
				arg_25_1.var_.characterEffect1284ui_story = var_28_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_11 and not isNil(var_28_10) then
				if arg_25_1.var_.characterEffect1284ui_story and not isNil(var_28_10) then
					arg_25_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_11)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_11 and arg_25_1.time_ < 0 + var_28_11 + arg_28_0 and not isNil(var_28_10) and arg_25_1.var_.characterEffect1284ui_story then
				arg_25_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				if arg_25_1.var_.characterEffect404001ui_story == nil then
					arg_25_1.var_.characterEffect404001ui_story = arg_25_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_28_12 = arg_25_1.var_.characterEffect404001ui_story

				arg_25_1.var_.characterEffect404001ui_story.imageEffect:turnOff()

				var_28_12.interferenceEffect.enabled = true
				var_28_12.interferenceEffect.noise = 0.001
				var_28_12.interferenceEffect.simTimeScale = 1
				var_28_12.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				if arg_25_1.var_.characterEffect404001ui_story == nil then
					arg_25_1.var_.characterEffect404001ui_story = arg_25_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_25_1.var_.characterEffect404001ui_story.imageEffect:turnOn(false)
			end

			local var_28_14 = 0
			local var_28_15 = 0.25

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_16 = arg_25_1:GetWordFromCfg(322042006)
				local var_28_17 = arg_25_1:FormatText(var_28_16.content)

				arg_25_1.text_.text = var_28_17

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_19 = 10 <= 0 and var_28_15 or var_28_15 * (utf8.len(var_28_17) / 10)

				if (10 <= 0 and var_28_15 or var_28_15 * (utf8.len(var_28_17) / 10)) > 0 and var_28_15 < var_28_19 then
					arg_25_1.talkMaxDuration = var_28_19

					if var_28_19 + var_28_14 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_19 + var_28_14
					end
				end

				arg_25_1.text_.text = var_28_17
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042006", "story_v_out_322042.awb") ~= 0 then
					local var_28_20 = manager.audio:GetVoiceLength("story_v_out_322042", "322042006", "story_v_out_322042.awb") / 1000

					if var_28_20 + var_28_14 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_20 + var_28_14
					end

					if var_28_16.prefab_name ~= "" and arg_25_1.actors_[var_28_16.prefab_name] ~= nil then
						local var_28_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_16.prefab_name].transform, "story_v_out_322042", "322042006", "story_v_out_322042.awb")

						arg_25_1:RecordAudio("322042006", var_28_21)
						arg_25_1:RecordAudio("322042006", var_28_21)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_322042", "322042006", "story_v_out_322042.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_322042", "322042006", "story_v_out_322042.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_22 = math.max(var_28_15, arg_25_1.talkMaxDuration)

			if var_28_14 <= arg_25_1.time_ and arg_25_1.time_ < var_28_14 + var_28_22 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_14) / var_28_22

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_14 + var_28_22 and arg_25_1.time_ < var_28_14 + var_28_22 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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
				actorName = "1284ui_story",
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
	Play322042007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 322042007
		arg_29_1.duration_ = 2

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play322042008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1284ui_story"]) and arg_29_1.var_.characterEffect1284ui_story == nil then
				arg_29_1.var_.characterEffect1284ui_story = arg_29_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1284ui_story"]) then
				if arg_29_1.var_.characterEffect1284ui_story and not isNil(arg_29_1.actors_["1284ui_story"]) then
					arg_29_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1284ui_story"]) and arg_29_1.var_.characterEffect1284ui_story then
				arg_29_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_32_2 = arg_29_1.actors_["404001ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect404001ui_story == nil then
				arg_29_1.var_.characterEffect404001ui_story = var_32_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_3 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.characterEffect404001ui_story and not isNil(var_32_2) then
					arg_29_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_29_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_3)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect404001ui_story then
				arg_29_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_29_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_32_4 = 0
			local var_32_5 = 0.075

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(322042007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 3 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 3)

				if (3 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 3)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042007", "story_v_out_322042.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_322042", "322042007", "story_v_out_322042.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_322042", "322042007", "story_v_out_322042.awb")

						arg_29_1:RecordAudio("322042007", var_32_11)
						arg_29_1:RecordAudio("322042007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_322042", "322042007", "story_v_out_322042.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_322042", "322042007", "story_v_out_322042.awb")
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
	Play322042008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 322042008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play322042009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["404001ui_story"]) and arg_33_1.var_.characterEffect404001ui_story == nil then
				arg_33_1.var_.characterEffect404001ui_story = arg_33_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["404001ui_story"]) then
				if arg_33_1.var_.characterEffect404001ui_story and not isNil(arg_33_1.actors_["404001ui_story"]) then
					arg_33_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["404001ui_story"]) and arg_33_1.var_.characterEffect404001ui_story then
				arg_33_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_36_2 = arg_33_1.actors_["1284ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect1284ui_story == nil then
				arg_33_1.var_.characterEffect1284ui_story = var_36_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_3 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.characterEffect1284ui_story and not isNil(var_36_2) then
					arg_33_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_3)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect1284ui_story then
				arg_33_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				if arg_33_1.var_.characterEffect404001ui_story == nil then
					arg_33_1.var_.characterEffect404001ui_story = arg_33_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_36_4 = arg_33_1.var_.characterEffect404001ui_story

				arg_33_1.var_.characterEffect404001ui_story.imageEffect:turnOff()

				var_36_4.interferenceEffect.enabled = true
				var_36_4.interferenceEffect.noise = 0.001
				var_36_4.interferenceEffect.simTimeScale = 1
				var_36_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				if arg_33_1.var_.characterEffect404001ui_story == nil then
					arg_33_1.var_.characterEffect404001ui_story = arg_33_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_33_1.var_.characterEffect404001ui_story.imageEffect:turnOn(false)
			end

			local var_36_6 = 0
			local var_36_7 = 0.325

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
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

				local var_36_8 = arg_33_1:GetWordFromCfg(322042008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 13 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 13)

				if (13 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 13)) > 0 and var_36_7 < var_36_11 then
					arg_33_1.talkMaxDuration = var_36_11

					if var_36_11 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042008", "story_v_out_322042.awb") ~= 0 then
					local var_36_12 = manager.audio:GetVoiceLength("story_v_out_322042", "322042008", "story_v_out_322042.awb") / 1000

					if var_36_12 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_6
					end

					if var_36_8.prefab_name ~= "" and arg_33_1.actors_[var_36_8.prefab_name] ~= nil then
						local var_36_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_8.prefab_name].transform, "story_v_out_322042", "322042008", "story_v_out_322042.awb")

						arg_33_1:RecordAudio("322042008", var_36_13)
						arg_33_1:RecordAudio("322042008", var_36_13)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_322042", "322042008", "story_v_out_322042.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_322042", "322042008", "story_v_out_322042.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_14 and arg_33_1.time_ < var_36_6 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play322042009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 322042009
		arg_37_1.duration_ = 4.03

		local var_37_0 = {
			zh = 2.7,
			ja = 4.033
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
				arg_37_0:Play322042010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1284ui_story"]) and arg_37_1.var_.characterEffect1284ui_story == nil then
				arg_37_1.var_.characterEffect1284ui_story = arg_37_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1284ui_story"]) then
				if arg_37_1.var_.characterEffect1284ui_story and not isNil(arg_37_1.actors_["1284ui_story"]) then
					arg_37_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1284ui_story"]) and arg_37_1.var_.characterEffect1284ui_story then
				arg_37_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_40_2 = arg_37_1.actors_["404001ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.characterEffect404001ui_story == nil then
				arg_37_1.var_.characterEffect404001ui_story = var_40_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_3 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.characterEffect404001ui_story and not isNil(var_40_2) then
					arg_37_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_37_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_3)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.characterEffect404001ui_story then
				arg_37_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_37_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action4_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_40_4 = 0
			local var_40_5 = 0.375

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(322042009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 15 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 15)

				if (15 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 15)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042009", "story_v_out_322042.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_322042", "322042009", "story_v_out_322042.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_322042", "322042009", "story_v_out_322042.awb")

						arg_37_1:RecordAudio("322042009", var_40_11)
						arg_37_1:RecordAudio("322042009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_322042", "322042009", "story_v_out_322042.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_322042", "322042009", "story_v_out_322042.awb")
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
	Play322042010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 322042010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play322042011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["404001ui_story"]) and arg_41_1.var_.characterEffect404001ui_story == nil then
				arg_41_1.var_.characterEffect404001ui_story = arg_41_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["404001ui_story"]) then
				if arg_41_1.var_.characterEffect404001ui_story and not isNil(arg_41_1.actors_["404001ui_story"]) then
					arg_41_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["404001ui_story"]) and arg_41_1.var_.characterEffect404001ui_story then
				arg_41_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_44_2 = arg_41_1.actors_["1284ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1284ui_story == nil then
				arg_41_1.var_.characterEffect1284ui_story = var_44_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_3 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.characterEffect1284ui_story and not isNil(var_44_2) then
					arg_41_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_3)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1284ui_story then
				arg_41_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				if arg_41_1.var_.characterEffect404001ui_story == nil then
					arg_41_1.var_.characterEffect404001ui_story = arg_41_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_44_4 = arg_41_1.var_.characterEffect404001ui_story

				arg_41_1.var_.characterEffect404001ui_story.imageEffect:turnOff()

				var_44_4.interferenceEffect.enabled = true
				var_44_4.interferenceEffect.noise = 0.001
				var_44_4.interferenceEffect.simTimeScale = 1
				var_44_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				if arg_41_1.var_.characterEffect404001ui_story == nil then
					arg_41_1.var_.characterEffect404001ui_story = arg_41_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_41_1.var_.characterEffect404001ui_story.imageEffect:turnOn(false)
			end

			local var_44_6 = 0
			local var_44_7 = 0.35

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

				local var_44_8 = arg_41_1:GetWordFromCfg(322042010)
				local var_44_9 = arg_41_1:FormatText(var_44_8.content)

				arg_41_1.text_.text = var_44_9

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 14 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 14)

				if (14 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 14)) > 0 and var_44_7 < var_44_11 then
					arg_41_1.talkMaxDuration = var_44_11

					if var_44_11 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_9
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042010", "story_v_out_322042.awb") ~= 0 then
					local var_44_12 = manager.audio:GetVoiceLength("story_v_out_322042", "322042010", "story_v_out_322042.awb") / 1000

					if var_44_12 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_6
					end

					if var_44_8.prefab_name ~= "" and arg_41_1.actors_[var_44_8.prefab_name] ~= nil then
						local var_44_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_8.prefab_name].transform, "story_v_out_322042", "322042010", "story_v_out_322042.awb")

						arg_41_1:RecordAudio("322042010", var_44_13)
						arg_41_1:RecordAudio("322042010", var_44_13)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_322042", "322042010", "story_v_out_322042.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_322042", "322042010", "story_v_out_322042.awb")
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

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play322042011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322042011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play322042012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10104ui_story = arg_45_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10104ui_story"].transform.position).z)
				arg_45_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["10104ui_story"].transform.localEulerAngles = arg_45_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.99, -1.12, -5.99)
				arg_45_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10104ui_story"].transform.position).z)
				arg_45_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["10104ui_story"].transform.localEulerAngles = arg_45_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["404001ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos404001ui_story = var_48_1.localPosition
			end

			local var_48_2 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 then
				var_48_1.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_2)
				var_48_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_1.position).x, (manager.ui.mainCamera.transform.position - var_48_1.position).y, (manager.ui.mainCamera.transform.position - var_48_1.position).z)
				var_48_1.localEulerAngles.z = 0
				var_48_1.localEulerAngles.x = 0
				var_48_1.localEulerAngles = var_48_1.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 then
				var_48_1.localPosition = Vector3.New(0, 100, 0)
				var_48_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_1.position).x, (manager.ui.mainCamera.transform.position - var_48_1.position).y, (manager.ui.mainCamera.transform.position - var_48_1.position).z)
				var_48_1.localEulerAngles.z = 0
				var_48_1.localEulerAngles.x = 0
				var_48_1.localEulerAngles = var_48_1.localEulerAngles
			end

			local var_48_3 = arg_45_1.actors_["10104ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_3) and arg_45_1.var_.characterEffect10104ui_story == nil then
				arg_45_1.var_.characterEffect10104ui_story = var_48_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_4 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 and not isNil(var_48_3) then
				if arg_45_1.var_.characterEffect10104ui_story and not isNil(var_48_3) then
					arg_45_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 and not isNil(var_48_3) and arg_45_1.var_.characterEffect10104ui_story then
				arg_45_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_48_6 = arg_45_1.actors_["404001ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect404001ui_story == nil then
				arg_45_1.var_.characterEffect404001ui_story = var_48_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_7 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 and not isNil(var_48_6) then
				if arg_45_1.var_.characterEffect404001ui_story and not isNil(var_48_6) then
					arg_45_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_45_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_7)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect404001ui_story then
				arg_45_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_45_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				if arg_45_1.var_.characterEffect10104ui_story == nil then
					arg_45_1.var_.characterEffect10104ui_story = arg_45_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_48_8 = arg_45_1.var_.characterEffect10104ui_story

				arg_45_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_48_8.interferenceEffect.enabled = true
				var_48_8.interferenceEffect.noise = 0.001
				var_48_8.interferenceEffect.simTimeScale = 1
				var_48_8.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				if arg_45_1.var_.characterEffect10104ui_story == nil then
					arg_45_1.var_.characterEffect10104ui_story = arg_45_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_45_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_48_10 = 0
			local var_48_11 = 0.375

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_12 = arg_45_1:GetWordFromCfg(322042011)
				local var_48_13 = arg_45_1:FormatText(var_48_12.content)

				arg_45_1.text_.text = var_48_13

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_15 = 15 <= 0 and var_48_11 or var_48_11 * (utf8.len(var_48_13) / 15)

				if (15 <= 0 and var_48_11 or var_48_11 * (utf8.len(var_48_13) / 15)) > 0 and var_48_11 < var_48_15 then
					arg_45_1.talkMaxDuration = var_48_15

					if var_48_15 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_15 + var_48_10
					end
				end

				arg_45_1.text_.text = var_48_13
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042011", "story_v_out_322042.awb") ~= 0 then
					local var_48_16 = manager.audio:GetVoiceLength("story_v_out_322042", "322042011", "story_v_out_322042.awb") / 1000

					if var_48_16 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_16 + var_48_10
					end

					if var_48_12.prefab_name ~= "" and arg_45_1.actors_[var_48_12.prefab_name] ~= nil then
						local var_48_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_12.prefab_name].transform, "story_v_out_322042", "322042011", "story_v_out_322042.awb")

						arg_45_1:RecordAudio("322042011", var_48_17)
						arg_45_1:RecordAudio("322042011", var_48_17)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_322042", "322042011", "story_v_out_322042.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_322042", "322042011", "story_v_out_322042.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_18 = math.max(var_48_11, arg_45_1.talkMaxDuration)

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_18 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_10) / var_48_18

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_10 + var_48_18 and arg_45_1.time_ < var_48_10 + var_48_18 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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

		arg_45_1:InitPlayNodeList()
	end,
	Play322042012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322042012
		arg_49_1.duration_ = 5.47

		local var_49_0 = {
			zh = 5.466,
			ja = 5.2
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
				arg_49_0:Play322042013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				if arg_49_1.var_.characterEffect10104ui_story == nil then
					arg_49_1.var_.characterEffect10104ui_story = arg_49_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_52_0 = arg_49_1.var_.characterEffect10104ui_story

				arg_49_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_52_0.interferenceEffect.enabled = true
				var_52_0.interferenceEffect.noise = 0.001
				var_52_0.interferenceEffect.simTimeScale = 1
				var_52_0.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				if arg_49_1.var_.characterEffect10104ui_story == nil then
					arg_49_1.var_.characterEffect10104ui_story = arg_49_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_49_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_52_2 = 0
			local var_52_3 = 0.775

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(322042012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 31 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 31)

				if (31 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 31)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042012", "story_v_out_322042.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_322042", "322042012", "story_v_out_322042.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_out_322042", "322042012", "story_v_out_322042.awb")

						arg_49_1:RecordAudio("322042012", var_52_9)
						arg_49_1:RecordAudio("322042012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_322042", "322042012", "story_v_out_322042.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_322042", "322042012", "story_v_out_322042.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_10 and arg_49_1.time_ < var_52_2 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play322042013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 322042013
		arg_53_1.duration_ = 2.3

		local var_53_0 = {
			zh = 2.1,
			ja = 2.3
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
				arg_53_0:Play322042014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1284ui_story"]) and arg_53_1.var_.characterEffect1284ui_story == nil then
				arg_53_1.var_.characterEffect1284ui_story = arg_53_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1284ui_story"]) then
				if arg_53_1.var_.characterEffect1284ui_story and not isNil(arg_53_1.actors_["1284ui_story"]) then
					arg_53_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1284ui_story"]) and arg_53_1.var_.characterEffect1284ui_story then
				arg_53_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_56_2 = arg_53_1.actors_["10104ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect10104ui_story == nil then
				arg_53_1.var_.characterEffect10104ui_story = var_56_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_3 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.characterEffect10104ui_story and not isNil(var_56_2) then
					arg_53_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_3)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect10104ui_story then
				arg_53_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action4_2")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_56_4 = 0
			local var_56_5 = 0.25

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(322042013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 10 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 10)

				if (10 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 10)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042013", "story_v_out_322042.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_322042", "322042013", "story_v_out_322042.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_322042", "322042013", "story_v_out_322042.awb")

						arg_53_1:RecordAudio("322042013", var_56_11)
						arg_53_1:RecordAudio("322042013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_322042", "322042013", "story_v_out_322042.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_322042", "322042013", "story_v_out_322042.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_12 and arg_53_1.time_ < var_56_4 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play322042014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 322042014
		arg_57_1.duration_ = 7

		local var_57_0 = {
			zh = 4.999999999999,
			ja = 7
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
				arg_57_0:Play322042015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10104ui_story"]) and arg_57_1.var_.characterEffect10104ui_story == nil then
				arg_57_1.var_.characterEffect10104ui_story = arg_57_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10104ui_story"]) then
				if arg_57_1.var_.characterEffect10104ui_story and not isNil(arg_57_1.actors_["10104ui_story"]) then
					arg_57_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10104ui_story"]) and arg_57_1.var_.characterEffect10104ui_story then
				arg_57_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_60_2 = arg_57_1.actors_["1284ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1284ui_story == nil then
				arg_57_1.var_.characterEffect1284ui_story = var_60_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_3 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.characterEffect1284ui_story and not isNil(var_60_2) then
					arg_57_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_3)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1284ui_story then
				arg_57_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_2")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				if arg_57_1.var_.characterEffect10104ui_story == nil then
					arg_57_1.var_.characterEffect10104ui_story = arg_57_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_60_4 = arg_57_1.var_.characterEffect10104ui_story

				arg_57_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_60_4.interferenceEffect.enabled = true
				var_60_4.interferenceEffect.noise = 0.001
				var_60_4.interferenceEffect.simTimeScale = 1
				var_60_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				if arg_57_1.var_.characterEffect10104ui_story == nil then
					arg_57_1.var_.characterEffect10104ui_story = arg_57_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_57_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_60_6 = 0
			local var_60_7 = 0.625

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(322042014)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 25 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 25)

				if (25 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 25)) > 0 and var_60_7 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042014", "story_v_out_322042.awb") ~= 0 then
					local var_60_12 = manager.audio:GetVoiceLength("story_v_out_322042", "322042014", "story_v_out_322042.awb") / 1000

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end

					if var_60_8.prefab_name ~= "" and arg_57_1.actors_[var_60_8.prefab_name] ~= nil then
						local var_60_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_8.prefab_name].transform, "story_v_out_322042", "322042014", "story_v_out_322042.awb")

						arg_57_1:RecordAudio("322042014", var_60_13)
						arg_57_1:RecordAudio("322042014", var_60_13)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_322042", "322042014", "story_v_out_322042.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_322042", "322042014", "story_v_out_322042.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_14 and arg_57_1.time_ < var_60_6 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play322042015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 322042015
		arg_61_1.duration_ = 10.83

		local var_61_0 = {
			zh = 6.266,
			ja = 10.833
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
				arg_61_0:Play322042016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action4_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				if arg_61_1.var_.characterEffect10104ui_story == nil then
					arg_61_1.var_.characterEffect10104ui_story = arg_61_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_64_0 = arg_61_1.var_.characterEffect10104ui_story

				arg_61_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_64_0.interferenceEffect.enabled = true
				var_64_0.interferenceEffect.noise = 0.001
				var_64_0.interferenceEffect.simTimeScale = 1
				var_64_0.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				if arg_61_1.var_.characterEffect10104ui_story == nil then
					arg_61_1.var_.characterEffect10104ui_story = arg_61_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_61_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_64_2 = 0
			local var_64_3 = 0.825

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:GetWordFromCfg(322042015)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 33 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 33)

				if (33 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 33)) > 0 and var_64_3 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042015", "story_v_out_322042.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_322042", "322042015", "story_v_out_322042.awb") / 1000

					if var_64_8 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_2
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_out_322042", "322042015", "story_v_out_322042.awb")

						arg_61_1:RecordAudio("322042015", var_64_9)
						arg_61_1:RecordAudio("322042015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_322042", "322042015", "story_v_out_322042.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_322042", "322042015", "story_v_out_322042.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_10 and arg_61_1.time_ < var_64_2 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play322042016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 322042016
		arg_65_1.duration_ = 9

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play322042017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if arg_65_1.bgs_.L15h == nil then
				local var_68_0 = Object.Instantiate(arg_65_1.paintGo_)

				var_68_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L15h")
				var_68_0.name = "L15h"
				var_68_0.transform.parent = arg_65_1.stage_.transform
				var_68_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.bgs_.L15h = var_68_0
			end

			if 2 < arg_65_1.time_ and arg_65_1.time_ <= 2 + arg_68_0 then
				local var_68_1 = arg_65_1.bgs_.L15h

				arg_65_1.bgs_.L15h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_68_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_2 = var_68_1:GetComponent("SpriteRenderer")

				if var_68_2 and var_68_2.sprite then
					local var_68_3 = 2 * (var_68_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_68_1.transform.localScale = Vector3.New(var_68_3 / var_68_2.sprite.bounds.size.y < var_68_3 * manager.ui.mainCameraCom_.aspect / var_68_2.sprite.bounds.size.x and var_68_3 * manager.ui.mainCameraCom_.aspect / var_68_2.sprite.bounds.size.x or var_68_3 / var_68_2.sprite.bounds.size.y, var_68_3 / var_68_2.sprite.bounds.size.y < var_68_3 * manager.ui.mainCameraCom_.aspect / var_68_2.sprite.bounds.size.x and var_68_3 * manager.ui.mainCameraCom_.aspect / var_68_2.sprite.bounds.size.x or var_68_3 / var_68_2.sprite.bounds.size.y, 0)
				end

				for iter_68_0, iter_68_1 in pairs(arg_65_1.bgs_) do
					if iter_68_0 ~= "L15h" then
						iter_68_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_68_4 = 3.999999999999

			if 3.999999999999 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.allBtn_.enabled = false
			end

			if arg_65_1.time_ >= var_68_4 + 0.3 and arg_65_1.time_ < var_68_4 + 0.3 + arg_68_0 then
				arg_65_1.allBtn_.enabled = true
			end

			local var_68_5 = 0

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_6 = 2

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_6 then
				local var_68_7 = Color.New(0, 0, 0)

				var_68_7.a = Mathf.Lerp(0, 1, (arg_65_1.time_ - var_68_5) / var_68_6)
				arg_65_1.mask_.color = var_68_7
			end

			if arg_65_1.time_ >= var_68_5 + var_68_6 and arg_65_1.time_ < var_68_5 + var_68_6 + arg_68_0 then
				local var_68_8 = Color.New(0, 0, 0)

				var_68_8.a = 1
				arg_65_1.mask_.color = var_68_8
			end

			local var_68_9 = 2

			if 2 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_10 = 2

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_10 then
				local var_68_11 = Color.New(0, 0, 0)

				var_68_11.a = Mathf.Lerp(1, 0, (arg_65_1.time_ - var_68_9) / var_68_10)
				arg_65_1.mask_.color = var_68_11
			end

			if arg_65_1.time_ >= var_68_9 + var_68_10 and arg_65_1.time_ < var_68_9 + var_68_10 + arg_68_0 then
				local var_68_12 = Color.New(0, 0, 0)

				arg_65_1.mask_.enabled = false
				var_68_12.a = 0
				arg_65_1.mask_.color = var_68_12
			end

			local var_68_13 = arg_65_1.actors_["1284ui_story"].transform

			if 1.96599999815226 < arg_65_1.time_ and arg_65_1.time_ <= 1.96599999815226 + arg_68_0 then
				arg_65_1.var_.moveOldPos1284ui_story = var_68_13.localPosition
			end

			local var_68_14 = 0.001

			if 1.96599999815226 <= arg_65_1.time_ and arg_65_1.time_ < 1.96599999815226 + var_68_14 then
				var_68_13.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 1.96599999815226) / var_68_14)
				var_68_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_13.position).x, (manager.ui.mainCamera.transform.position - var_68_13.position).y, (manager.ui.mainCamera.transform.position - var_68_13.position).z)
				var_68_13.localEulerAngles.z = 0
				var_68_13.localEulerAngles.x = 0
				var_68_13.localEulerAngles = var_68_13.localEulerAngles
			end

			if arg_65_1.time_ >= 1.96599999815226 + var_68_14 and arg_65_1.time_ < 1.96599999815226 + var_68_14 + arg_68_0 then
				var_68_13.localPosition = Vector3.New(0, 100, 0)
				var_68_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_13.position).x, (manager.ui.mainCamera.transform.position - var_68_13.position).y, (manager.ui.mainCamera.transform.position - var_68_13.position).z)
				var_68_13.localEulerAngles.z = 0
				var_68_13.localEulerAngles.x = 0
				var_68_13.localEulerAngles = var_68_13.localEulerAngles
			end

			local var_68_15 = arg_65_1.actors_["10104ui_story"].transform

			if 1.96599999815226 < arg_65_1.time_ and arg_65_1.time_ <= 1.96599999815226 + arg_68_0 then
				arg_65_1.var_.moveOldPos10104ui_story = var_68_15.localPosition
			end

			local var_68_16 = 0.001

			if 1.96599999815226 <= arg_65_1.time_ and arg_65_1.time_ < 1.96599999815226 + var_68_16 then
				var_68_15.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 1.96599999815226) / var_68_16)
				var_68_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_15.position).x, (manager.ui.mainCamera.transform.position - var_68_15.position).y, (manager.ui.mainCamera.transform.position - var_68_15.position).z)
				var_68_15.localEulerAngles.z = 0
				var_68_15.localEulerAngles.x = 0
				var_68_15.localEulerAngles = var_68_15.localEulerAngles
			end

			if arg_65_1.time_ >= 1.96599999815226 + var_68_16 and arg_65_1.time_ < 1.96599999815226 + var_68_16 + arg_68_0 then
				var_68_15.localPosition = Vector3.New(0, 100, 0)
				var_68_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_15.position).x, (manager.ui.mainCamera.transform.position - var_68_15.position).y, (manager.ui.mainCamera.transform.position - var_68_15.position).z)
				var_68_15.localEulerAngles.z = 0
				var_68_15.localEulerAngles.x = 0
				var_68_15.localEulerAngles = var_68_15.localEulerAngles
			end

			local var_68_17 = arg_65_1.actors_["10104ui_story"]

			if 1.96599999815226 < arg_65_1.time_ and arg_65_1.time_ <= 1.96599999815226 + arg_68_0 and not isNil(var_68_17) and arg_65_1.var_.characterEffect10104ui_story == nil then
				arg_65_1.var_.characterEffect10104ui_story = var_68_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_18 = 0.034000001847744

			if 1.96599999815226 <= arg_65_1.time_ and arg_65_1.time_ < 1.96599999815226 + var_68_18 and not isNil(var_68_17) then
				if arg_65_1.var_.characterEffect10104ui_story and not isNil(var_68_17) then
					arg_65_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 1.96599999815226) / var_68_18)
				end
			end

			if arg_65_1.time_ >= 1.96599999815226 + var_68_18 and arg_65_1.time_ < 1.96599999815226 + var_68_18 + arg_68_0 and not isNil(var_68_17) and arg_65_1.var_.characterEffect10104ui_story then
				arg_65_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_19 = 3.999999999999
			local var_68_20 = 0.6

			if 3.999999999999 < arg_65_1.time_ and arg_65_1.time_ <= var_68_19 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_21 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_21:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_22 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(322042016).content)

				arg_65_1.text_.text = var_68_22

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_24 = 24 <= 0 and var_68_20 or var_68_20 * (utf8.len(var_68_22) / 24)

				if (24 <= 0 and var_68_20 or var_68_20 * (utf8.len(var_68_22) / 24)) > 0 and var_68_20 < var_68_24 then
					arg_65_1.talkMaxDuration = var_68_24
					var_68_19 = var_68_19 + 0.3

					if var_68_24 + var_68_19 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_24 + var_68_19
					end
				end

				arg_65_1.text_.text = var_68_22
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_25 = var_68_19 + 0.3
			local var_68_26 = math.max(var_68_20, arg_65_1.talkMaxDuration)

			if var_68_19 + 0.3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_25 + var_68_26 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_25) / var_68_26

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_25 + var_68_26 and arg_65_1.time_ < var_68_25 + var_68_26 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play322042017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 322042017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play322042018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0.766666666666667 < arg_71_1.time_ and arg_71_1.time_ <= 0.766666666666667 + arg_74_0 then
				arg_71_1:AudioAction("play", "effect", "se_story_140", "se_story_140_explosion05", "")
			end

			local var_74_1 = manager.ui.mainCamera.transform

			if 0.766666666666667 < arg_71_1.time_ and arg_71_1.time_ <= 0.766666666666667 + arg_74_0 then
				arg_71_1.var_.shakeOldPos = var_74_1.localPosition
			end

			local var_74_2 = 0.833333333333333

			if 0.766666666666667 <= arg_71_1.time_ and arg_71_1.time_ < 0.766666666666667 + var_74_2 then
				local var_74_3, var_74_4 = math.modf((arg_71_1.time_ - 0.766666666666667) / 0.066)

				var_74_1.localPosition = Vector3.New(var_74_4 * 0.13, var_74_4 * 0.13, var_74_4 * 0.13) + arg_71_1.var_.shakeOldPos
			end

			if arg_71_1.time_ >= 0.766666666666667 + var_74_2 and arg_71_1.time_ < 0.766666666666667 + var_74_2 + arg_74_0 then
				var_74_1.localPosition = arg_71_1.var_.shakeOldPos
			end

			local var_74_5 = 0
			local var_74_6 = 1.025

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

				local var_74_7 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(322042017).content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 41 <= 0 and var_74_6 or var_74_6 * (utf8.len(var_74_7) / 41)

				if (41 <= 0 and var_74_6 or var_74_6 * (utf8.len(var_74_7) / 41)) > 0 and var_74_6 < var_74_9 then
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

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play322042018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 322042018
		arg_75_1.duration_ = 2

		local var_75_0 = {
			zh = 1.999999999999,
			ja = 2
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
				arg_75_0:Play322042019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if arg_75_1.actors_["1156ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1156ui_story"))) then
				local var_78_0 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_75_1.stage_.transform)

				var_78_0.name = "1156ui_story"
				var_78_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.actors_["1156ui_story"] = var_78_0

				local var_78_1 = var_78_0:GetComponentInChildren(typeof(CharacterEffect))

				var_78_1.enabled = true

				local var_78_2 = GameObjectTools.GetOrAddComponent(var_78_0, typeof(DynamicBoneHelper))

				if var_78_2 then
					var_78_2:EnableDynamicBone(false)
				end

				arg_75_1:ShowWeapon(var_78_1.transform, false)

				arg_75_1.var_["1156ui_story" .. "Animator"] = var_78_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_75_1.var_["1156ui_story" .. "Animator"].applyRootMotion = true
				arg_75_1.var_["1156ui_story" .. "LipSync"] = var_78_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_78_3 = arg_75_1.actors_["1156ui_story"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1156ui_story = var_78_3.localPosition
			end

			local var_78_4 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				var_78_3.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1156ui_story, Vector3.New(-0.9, -1.1, -6.18), (arg_75_1.time_ - 0) / var_78_4)
				var_78_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_3.position).x, (manager.ui.mainCamera.transform.position - var_78_3.position).y, (manager.ui.mainCamera.transform.position - var_78_3.position).z)
				var_78_3.localEulerAngles.z = 0
				var_78_3.localEulerAngles.x = 0
				var_78_3.localEulerAngles = var_78_3.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				var_78_3.localPosition = Vector3.New(-0.9, -1.1, -6.18)
				var_78_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_3.position).x, (manager.ui.mainCamera.transform.position - var_78_3.position).y, (manager.ui.mainCamera.transform.position - var_78_3.position).z)
				var_78_3.localEulerAngles.z = 0
				var_78_3.localEulerAngles.x = 0
				var_78_3.localEulerAngles = var_78_3.localEulerAngles
			end

			local var_78_5 = arg_75_1.actors_["1156ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.characterEffect1156ui_story == nil then
				arg_75_1.var_.characterEffect1156ui_story = var_78_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_6 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_6 and not isNil(var_78_5) then
				if arg_75_1.var_.characterEffect1156ui_story and not isNil(var_78_5) then
					arg_75_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_6 and arg_75_1.time_ < 0 + var_78_6 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.characterEffect1156ui_story then
				arg_75_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_78_8 = 0
			local var_78_9 = 0.125

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 then
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

				local var_78_10 = arg_75_1:GetWordFromCfg(322042018)
				local var_78_11 = arg_75_1:FormatText(var_78_10.content)

				arg_75_1.text_.text = var_78_11

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_13 = 5 <= 0 and var_78_9 or var_78_9 * (utf8.len(var_78_11) / 5)

				if (5 <= 0 and var_78_9 or var_78_9 * (utf8.len(var_78_11) / 5)) > 0 and var_78_9 < var_78_13 then
					arg_75_1.talkMaxDuration = var_78_13

					if var_78_13 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_8
					end
				end

				arg_75_1.text_.text = var_78_11
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042018", "story_v_out_322042.awb") ~= 0 then
					local var_78_14 = manager.audio:GetVoiceLength("story_v_out_322042", "322042018", "story_v_out_322042.awb") / 1000

					if var_78_14 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_14 + var_78_8
					end

					if var_78_10.prefab_name ~= "" and arg_75_1.actors_[var_78_10.prefab_name] ~= nil then
						local var_78_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_10.prefab_name].transform, "story_v_out_322042", "322042018", "story_v_out_322042.awb")

						arg_75_1:RecordAudio("322042018", var_78_15)
						arg_75_1:RecordAudio("322042018", var_78_15)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_322042", "322042018", "story_v_out_322042.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_322042", "322042018", "story_v_out_322042.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_16 = math.max(var_78_9, arg_75_1.talkMaxDuration)

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_16 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_8) / var_78_16

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_8 + var_78_16 and arg_75_1.time_ < var_78_8 + var_78_16 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
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

		arg_75_1:InitPlayNodeList()
	end,
	Play322042019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 322042019
		arg_79_1.duration_ = 2

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play322042020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1284ui_story = arg_79_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1284ui_story"].transform.position).z)
				arg_79_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1284ui_story"].transform.localEulerAngles = arg_79_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
				arg_79_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1284ui_story"].transform.position).z)
				arg_79_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1284ui_story"].transform.localEulerAngles = arg_79_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["1284ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1284ui_story == nil then
				arg_79_1.var_.characterEffect1284ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect1284ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1284ui_story then
				arg_79_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_82_4 = arg_79_1.actors_["1156ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_4) and arg_79_1.var_.characterEffect1156ui_story == nil then
				arg_79_1.var_.characterEffect1156ui_story = var_82_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_5 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_5 and not isNil(var_82_4) then
				if arg_79_1.var_.characterEffect1156ui_story and not isNil(var_82_4) then
					arg_79_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_5)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_5 and arg_79_1.time_ < 0 + var_82_5 + arg_82_0 and not isNil(var_82_4) and arg_79_1.var_.characterEffect1156ui_story then
				arg_79_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_82_6 = 0
			local var_82_7 = 0.2

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_8 = arg_79_1:GetWordFromCfg(322042019)
				local var_82_9 = arg_79_1:FormatText(var_82_8.content)

				arg_79_1.text_.text = var_82_9

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_11 = 8 <= 0 and var_82_7 or var_82_7 * (utf8.len(var_82_9) / 8)

				if (8 <= 0 and var_82_7 or var_82_7 * (utf8.len(var_82_9) / 8)) > 0 and var_82_7 < var_82_11 then
					arg_79_1.talkMaxDuration = var_82_11

					if var_82_11 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_11 + var_82_6
					end
				end

				arg_79_1.text_.text = var_82_9
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042019", "story_v_out_322042.awb") ~= 0 then
					local var_82_12 = manager.audio:GetVoiceLength("story_v_out_322042", "322042019", "story_v_out_322042.awb") / 1000

					if var_82_12 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_12 + var_82_6
					end

					if var_82_8.prefab_name ~= "" and arg_79_1.actors_[var_82_8.prefab_name] ~= nil then
						local var_82_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_8.prefab_name].transform, "story_v_out_322042", "322042019", "story_v_out_322042.awb")

						arg_79_1:RecordAudio("322042019", var_82_13)
						arg_79_1:RecordAudio("322042019", var_82_13)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_322042", "322042019", "story_v_out_322042.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_322042", "322042019", "story_v_out_322042.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_14 = math.max(var_82_7, arg_79_1.talkMaxDuration)

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_14 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_6) / var_82_14

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_6 + var_82_14 and arg_79_1.time_ < var_82_6 + var_82_14 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322042020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 322042020
		arg_83_1.duration_ = 6

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play322042021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_9000

			if 1 < arg_83_1.time_ and arg_83_1.time_ <= 1 + arg_86_0 then
				arg_83_1.var_.moveOldPos1284ui_story = arg_83_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 1 <= arg_83_1.time_ and arg_83_1.time_ < 1 + var_86_0 then
				arg_83_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_83_1.time_ - 1) / var_86_0)
				arg_83_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1284ui_story"].transform.position).z)
				arg_83_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1284ui_story"].transform.localEulerAngles = arg_83_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 1 + var_86_0 and arg_83_1.time_ < 1 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1284ui_story"].transform.position).z)
				arg_83_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1284ui_story"].transform.localEulerAngles = arg_83_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_86_1 = arg_83_1.actors_["1156ui_story"].transform

			if 1 < arg_83_1.time_ and arg_83_1.time_ <= 1 + arg_86_0 then
				arg_83_1.var_.moveOldPos1156ui_story = var_86_1.localPosition
			end

			local var_86_2 = 0.001

			if 1 <= arg_83_1.time_ and arg_83_1.time_ < 1 + var_86_2 then
				var_86_1.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_83_1.time_ - 1) / var_86_2)
				var_86_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_1.position).x, (manager.ui.mainCamera.transform.position - var_86_1.position).y, (manager.ui.mainCamera.transform.position - var_86_1.position).z)
				var_86_1.localEulerAngles.z = 0
				var_86_1.localEulerAngles.x = 0
				var_86_1.localEulerAngles = var_86_1.localEulerAngles
			end

			if arg_83_1.time_ >= 1 + var_86_2 and arg_83_1.time_ < 1 + var_86_2 + arg_86_0 then
				var_86_1.localPosition = Vector3.New(0, 100, 0)
				var_86_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_1.position).x, (manager.ui.mainCamera.transform.position - var_86_1.position).y, (manager.ui.mainCamera.transform.position - var_86_1.position).z)
				var_86_1.localEulerAngles.z = 0
				var_86_1.localEulerAngles.x = 0
				var_86_1.localEulerAngles = var_86_1.localEulerAngles
			end

			if 1 < arg_83_1.time_ and arg_83_1.time_ <= 1 + arg_86_0 then
				local var_86_3 = arg_83_1.var_.effect2023

				if not arg_83_1.var_.effect2023 then
					var_86_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_burning_1"), manager.ui.mainCamera.transform)
					var_86_3.name = "2023"
					arg_83_1.var_.effect2023 = var_86_3
				else
					var_86_3.transform:SetParent(var_86_9000)
				end

				var_86_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_86_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1 < arg_83_1.time_ and arg_83_1.time_ <= 1 + arg_86_0 then
				arg_83_1:AudioAction("play", "effect", "se_story_145", "se_story_145_fire04_loop", "")
			end

			local var_86_6 = 0

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_7 = 1

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_7 then
				local var_86_8 = Color.New(0, 0, 0)

				var_86_8.a = Mathf.Lerp(0, 1, (arg_83_1.time_ - var_86_6) / var_86_7)
				arg_83_1.mask_.color = var_86_8
			end

			if arg_83_1.time_ >= var_86_6 + var_86_7 and arg_83_1.time_ < var_86_6 + var_86_7 + arg_86_0 then
				local var_86_9 = Color.New(0, 0, 0)

				var_86_9.a = 1
				arg_83_1.mask_.color = var_86_9
			end

			local var_86_10 = 1

			if 1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_11 = 1

			if var_86_10 <= arg_83_1.time_ and arg_83_1.time_ < var_86_10 + var_86_11 then
				local var_86_12 = Color.New(0, 0, 0)

				var_86_12.a = Mathf.Lerp(1, 0, (arg_83_1.time_ - var_86_10) / var_86_11)
				arg_83_1.mask_.color = var_86_12
			end

			if arg_83_1.time_ >= var_86_10 + var_86_11 and arg_83_1.time_ < var_86_10 + var_86_11 + arg_86_0 then
				local var_86_13 = Color.New(0, 0, 0)

				arg_83_1.mask_.enabled = false
				var_86_13.a = 0
				arg_83_1.mask_.color = var_86_13
			end

			if arg_83_1.frameCnt_ <= 1 then
				arg_83_1.dialog_:SetActive(false)
			end

			local var_86_14 = 1
			local var_86_15 = 1.275

			if 1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_14 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				arg_83_1.dialog_:SetActive(true)

				arg_83_1.dialogCg_.alpha = 0

				local var_86_16 = LeanTween.value(arg_83_1.dialog_, 0, 1, 0.3)

				var_86_16:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_83_1.dialogCg_.alpha = arg_87_0
				end))
				var_86_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_83_1.dialog_)
					var_86_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_83_1.duration_ = arg_83_1.duration_ + 0.3

				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_17 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(322042020).content)

				arg_83_1.text_.text = var_86_17

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_19 = 51 <= 0 and var_86_15 or var_86_15 * (utf8.len(var_86_17) / 51)

				if (51 <= 0 and var_86_15 or var_86_15 * (utf8.len(var_86_17) / 51)) > 0 and var_86_15 < var_86_19 then
					arg_83_1.talkMaxDuration = var_86_19
					var_86_14 = var_86_14 + 0.3

					if var_86_19 + var_86_14 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_19 + var_86_14
					end
				end

				arg_83_1.text_.text = var_86_17
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_20 = var_86_14 + 0.3
			local var_86_21 = math.max(var_86_15, arg_83_1.talkMaxDuration)

			if var_86_14 + 0.3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_20 + var_86_21 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_20) / var_86_21

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_20 + var_86_21 and arg_83_1.time_ < var_86_20 + var_86_21 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play322042021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 322042021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play322042022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1.275

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(322042021).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 51 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 51)

				if (51 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 51)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play322042022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 322042022
		arg_93_1.duration_ = 3.4

		local var_93_0 = {
			zh = 2.7,
			ja = 3.4
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
				arg_93_0:Play322042023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if arg_93_1.actors_["10150ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10150ui_story"))) then
				local var_96_0 = Object.Instantiate(Asset.Load("Char/" .. "10150ui_story"), arg_93_1.stage_.transform)

				var_96_0.name = "10150ui_story"
				var_96_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_["10150ui_story"] = var_96_0

				local var_96_1 = var_96_0:GetComponentInChildren(typeof(CharacterEffect))

				var_96_1.enabled = true

				local var_96_2 = GameObjectTools.GetOrAddComponent(var_96_0, typeof(DynamicBoneHelper))

				if var_96_2 then
					var_96_2:EnableDynamicBone(false)
				end

				arg_93_1:ShowWeapon(var_96_1.transform, false)

				arg_93_1.var_["10150ui_story" .. "Animator"] = var_96_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_93_1.var_["10150ui_story" .. "Animator"].applyRootMotion = true
				arg_93_1.var_["10150ui_story" .. "LipSync"] = var_96_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_96_3 = arg_93_1.actors_["10150ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10150ui_story = var_96_3.localPosition

				local var_96_4 = GameObjectTools.GetOrAddComponent(var_96_3.gameObject, typeof(DynamicBoneHelper))

				if var_96_4 then
					var_96_4:EnableDynamicBone(false)
				end
			end

			local var_96_5 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_5 then
				var_96_3.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10150ui_story, Vector3.New(0, -1.73, -5.5), (arg_93_1.time_ - 0) / var_96_5)
				var_96_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_3.position).x, (manager.ui.mainCamera.transform.position - var_96_3.position).y, (manager.ui.mainCamera.transform.position - var_96_3.position).z)
				var_96_3.localEulerAngles.z = 0
				var_96_3.localEulerAngles.x = 0
				var_96_3.localEulerAngles = var_96_3.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_5 and arg_93_1.time_ < 0 + var_96_5 + arg_96_0 then
				var_96_3.localPosition = Vector3.New(0, -1.73, -5.5)
				var_96_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_3.position).x, (manager.ui.mainCamera.transform.position - var_96_3.position).y, (manager.ui.mainCamera.transform.position - var_96_3.position).z)
				var_96_3.localEulerAngles.z = 0
				var_96_3.localEulerAngles.x = 0
				var_96_3.localEulerAngles = var_96_3.localEulerAngles

				local var_96_6 = GameObjectTools.GetOrAddComponent(var_96_3.gameObject, typeof(DynamicBoneHelper))

				if var_96_6 then
					var_96_6:EnableDynamicBone(true)
				end
			end

			local var_96_7 = arg_93_1.actors_["10150ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.characterEffect10150ui_story == nil then
				arg_93_1.var_.characterEffect10150ui_story = var_96_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_8 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_8 and not isNil(var_96_7) then
				if arg_93_1.var_.characterEffect10150ui_story and not isNil(var_96_7) then
					arg_93_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_8 and arg_93_1.time_ < 0 + var_96_8 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.characterEffect10150ui_story then
				arg_93_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action5_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_96_10 = 0
			local var_96_11 = 0.175

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_12 = arg_93_1:GetWordFromCfg(322042022)
				local var_96_13 = arg_93_1:FormatText(var_96_12.content)

				arg_93_1.text_.text = var_96_13

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_15 = 7 <= 0 and var_96_11 or var_96_11 * (utf8.len(var_96_13) / 7)

				if (7 <= 0 and var_96_11 or var_96_11 * (utf8.len(var_96_13) / 7)) > 0 and var_96_11 < var_96_15 then
					arg_93_1.talkMaxDuration = var_96_15

					if var_96_15 + var_96_10 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_15 + var_96_10
					end
				end

				arg_93_1.text_.text = var_96_13
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042022", "story_v_out_322042.awb") ~= 0 then
					local var_96_16 = manager.audio:GetVoiceLength("story_v_out_322042", "322042022", "story_v_out_322042.awb") / 1000

					if var_96_16 + var_96_10 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_16 + var_96_10
					end

					if var_96_12.prefab_name ~= "" and arg_93_1.actors_[var_96_12.prefab_name] ~= nil then
						local var_96_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_12.prefab_name].transform, "story_v_out_322042", "322042022", "story_v_out_322042.awb")

						arg_93_1:RecordAudio("322042022", var_96_17)
						arg_93_1:RecordAudio("322042022", var_96_17)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_322042", "322042022", "story_v_out_322042.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_322042", "322042022", "story_v_out_322042.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_18 = math.max(var_96_11, arg_93_1.talkMaxDuration)

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_18 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_10) / var_96_18

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_10 + var_96_18 and arg_93_1.time_ < var_96_10 + var_96_18 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play322042023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 322042023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play322042024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10150ui_story = arg_97_1.actors_["10150ui_story"].transform.localPosition

				local var_100_0 = GameObjectTools.GetOrAddComponent(arg_97_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_100_0 then
					var_100_0:EnableDynamicBone(false)
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10150ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_1)
				arg_97_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10150ui_story"].transform.position).z)
				arg_97_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10150ui_story"].transform.localEulerAngles = arg_97_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10150ui_story"].transform.position).z)
				arg_97_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10150ui_story"].transform.localEulerAngles = arg_97_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_100_2 = GameObjectTools.GetOrAddComponent(arg_97_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_100_2 then
					var_100_2:EnableDynamicBone(true)
				end
			end

			if 0.200000002980232 < arg_97_1.time_ and arg_97_1.time_ <= 0.200000002980232 + arg_100_0 then
				arg_97_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_fireanergy2", "")
			end

			local var_100_4 = 0
			local var_100_5 = 1.675

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(322042023).content)

				arg_97_1.text_.text = var_100_6

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_8 = 67 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_6) / 67)

				if (67 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_6) / 67)) > 0 and var_100_5 < var_100_8 then
					arg_97_1.talkMaxDuration = var_100_8

					if var_100_8 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_6
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_9 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_9 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_9

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_9 and arg_97_1.time_ < var_100_4 + var_100_9 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play322042024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 322042024
		arg_101_1.duration_ = 5.77

		local var_101_0 = {
			zh = 5.5,
			ja = 5.766
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
				arg_101_0:Play322042025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 2 < arg_101_1.time_ and arg_101_1.time_ <= 2 + arg_104_0 then
				arg_101_1.var_.moveOldPos1284ui_story = arg_101_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 2 <= arg_101_1.time_ and arg_101_1.time_ < 2 + var_104_0 then
				arg_101_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_101_1.time_ - 2) / var_104_0)
				arg_101_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1284ui_story"].transform.position).z)
				arg_101_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1284ui_story"].transform.localEulerAngles = arg_101_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 2 + var_104_0 and arg_101_1.time_ < 2 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				arg_101_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1284ui_story"].transform.position).z)
				arg_101_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1284ui_story"].transform.localEulerAngles = arg_101_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1284ui_story"]

			if 2 < arg_101_1.time_ and arg_101_1.time_ <= 2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1284ui_story == nil then
				arg_101_1.var_.characterEffect1284ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 2 <= arg_101_1.time_ and arg_101_1.time_ < 2 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1284ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 2 + var_104_2 and arg_101_1.time_ < 2 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1284ui_story then
				arg_101_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 2 < arg_101_1.time_ and arg_101_1.time_ <= 2 + arg_104_0 then
				arg_101_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action4_1")
			end

			if 2 < arg_101_1.time_ and arg_101_1.time_ <= 2 + arg_104_0 then
				arg_101_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.983333333333333 < arg_101_1.time_ and arg_101_1.time_ <= 0.983333333333333 + arg_104_0 then
				if arg_101_1.var_.effect2023 then
					Object.Destroy(arg_101_1.var_.effect2023)

					arg_101_1.var_.effect2023 = nil
				end
			end

			local var_104_5 = 0

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = false

				arg_101_1:SetGaussion(false)
			end

			local var_104_6 = 1

			if var_104_5 <= arg_101_1.time_ and arg_101_1.time_ < var_104_5 + var_104_6 then
				local var_104_7 = Color.New(0, 0, 0)

				var_104_7.a = Mathf.Lerp(0, 1, (arg_101_1.time_ - var_104_5) / var_104_6)
				arg_101_1.mask_.color = var_104_7
			end

			if arg_101_1.time_ >= var_104_5 + var_104_6 and arg_101_1.time_ < var_104_5 + var_104_6 + arg_104_0 then
				local var_104_8 = Color.New(0, 0, 0)

				var_104_8.a = 1
				arg_101_1.mask_.color = var_104_8
			end

			local var_104_9 = 1

			if 1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_9 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = false

				arg_101_1:SetGaussion(false)
			end

			local var_104_10 = 1

			if var_104_9 <= arg_101_1.time_ and arg_101_1.time_ < var_104_9 + var_104_10 then
				local var_104_11 = Color.New(0, 0, 0)

				var_104_11.a = Mathf.Lerp(1, 0, (arg_101_1.time_ - var_104_9) / var_104_10)
				arg_101_1.mask_.color = var_104_11
			end

			if arg_101_1.time_ >= var_104_9 + var_104_10 and arg_101_1.time_ < var_104_9 + var_104_10 + arg_104_0 then
				local var_104_12 = Color.New(0, 0, 0)

				arg_101_1.mask_.enabled = false
				var_104_12.a = 0
				arg_101_1.mask_.color = var_104_12
			end

			if 1.38777878078145e-17 < arg_101_1.time_ and arg_101_1.time_ <= 1.38777878078145e-17 + arg_104_0 then
				arg_101_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_fire04_loop", "")
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_14 = 2
			local var_104_15 = 0.475

			if 2 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_16 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_16:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_17 = arg_101_1:GetWordFromCfg(322042024)
				local var_104_18 = arg_101_1:FormatText(var_104_17.content)

				arg_101_1.text_.text = var_104_18

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_20 = 19 <= 0 and var_104_15 or var_104_15 * (utf8.len(var_104_18) / 19)

				if (19 <= 0 and var_104_15 or var_104_15 * (utf8.len(var_104_18) / 19)) > 0 and var_104_15 < var_104_20 then
					arg_101_1.talkMaxDuration = var_104_20
					var_104_14 = var_104_14 + 0.3

					if var_104_20 + var_104_14 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_20 + var_104_14
					end
				end

				arg_101_1.text_.text = var_104_18
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042024", "story_v_out_322042.awb") ~= 0 then
					local var_104_21 = manager.audio:GetVoiceLength("story_v_out_322042", "322042024", "story_v_out_322042.awb") / 1000

					if var_104_21 + var_104_14 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_21 + var_104_14
					end

					if var_104_17.prefab_name ~= "" and arg_101_1.actors_[var_104_17.prefab_name] ~= nil then
						local var_104_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_17.prefab_name].transform, "story_v_out_322042", "322042024", "story_v_out_322042.awb")

						arg_101_1:RecordAudio("322042024", var_104_22)
						arg_101_1:RecordAudio("322042024", var_104_22)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_322042", "322042024", "story_v_out_322042.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_322042", "322042024", "story_v_out_322042.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_23 = var_104_14 + 0.3
			local var_104_24 = math.max(var_104_15, arg_101_1.talkMaxDuration)

			if var_104_14 + 0.3 <= arg_101_1.time_ and arg_101_1.time_ < var_104_23 + var_104_24 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_23) / var_104_24

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_23 + var_104_24 and arg_101_1.time_ < var_104_23 + var_104_24 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play322042025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 322042025
		arg_107_1.duration_ = 3.07

		local var_107_0 = {
			zh = 2.5,
			ja = 3.066
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
				arg_107_0:Play322042026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10150ui_story = arg_107_1.actors_["10150ui_story"].transform.localPosition

				local var_110_0 = GameObjectTools.GetOrAddComponent(arg_107_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_110_0 then
					var_110_0:EnableDynamicBone(false)
				end
			end

			local var_110_1 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_1 then
				arg_107_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10150ui_story, Vector3.New(0.9, -1.73, -5.5), (arg_107_1.time_ - 0) / var_110_1)
				arg_107_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10150ui_story"].transform.position).z)
				arg_107_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["10150ui_story"].transform.localEulerAngles = arg_107_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_1 and arg_107_1.time_ < 0 + var_110_1 + arg_110_0 then
				arg_107_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(0.9, -1.73, -5.5)
				arg_107_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10150ui_story"].transform.position).z)
				arg_107_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["10150ui_story"].transform.localEulerAngles = arg_107_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_110_2 = GameObjectTools.GetOrAddComponent(arg_107_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_110_2 then
					var_110_2:EnableDynamicBone(true)
				end
			end

			local var_110_3 = arg_107_1.actors_["10150ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_3) and arg_107_1.var_.characterEffect10150ui_story == nil then
				arg_107_1.var_.characterEffect10150ui_story = var_110_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_4 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 and not isNil(var_110_3) then
				if arg_107_1.var_.characterEffect10150ui_story and not isNil(var_110_3) then
					arg_107_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 and not isNil(var_110_3) and arg_107_1.var_.characterEffect10150ui_story then
				arg_107_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_110_6 = arg_107_1.actors_["1284ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_6) and arg_107_1.var_.characterEffect1284ui_story == nil then
				arg_107_1.var_.characterEffect1284ui_story = var_110_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_7 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_7 and not isNil(var_110_6) then
				if arg_107_1.var_.characterEffect1284ui_story and not isNil(var_110_6) then
					arg_107_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_7)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_7 and arg_107_1.time_ < 0 + var_110_7 + arg_110_0 and not isNil(var_110_6) and arg_107_1.var_.characterEffect1284ui_story then
				arg_107_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action5_2")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_110_8 = 0
			local var_110_9 = 0.125

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_8 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_10 = arg_107_1:GetWordFromCfg(322042025)
				local var_110_11 = arg_107_1:FormatText(var_110_10.content)

				arg_107_1.text_.text = var_110_11

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_13 = 5 <= 0 and var_110_9 or var_110_9 * (utf8.len(var_110_11) / 5)

				if (5 <= 0 and var_110_9 or var_110_9 * (utf8.len(var_110_11) / 5)) > 0 and var_110_9 < var_110_13 then
					arg_107_1.talkMaxDuration = var_110_13

					if var_110_13 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_8
					end
				end

				arg_107_1.text_.text = var_110_11
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042025", "story_v_out_322042.awb") ~= 0 then
					local var_110_14 = manager.audio:GetVoiceLength("story_v_out_322042", "322042025", "story_v_out_322042.awb") / 1000

					if var_110_14 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_14 + var_110_8
					end

					if var_110_10.prefab_name ~= "" and arg_107_1.actors_[var_110_10.prefab_name] ~= nil then
						local var_110_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_10.prefab_name].transform, "story_v_out_322042", "322042025", "story_v_out_322042.awb")

						arg_107_1:RecordAudio("322042025", var_110_15)
						arg_107_1:RecordAudio("322042025", var_110_15)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_322042", "322042025", "story_v_out_322042.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_322042", "322042025", "story_v_out_322042.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_16 = math.max(var_110_9, arg_107_1.talkMaxDuration)

			if var_110_8 <= arg_107_1.time_ and arg_107_1.time_ < var_110_8 + var_110_16 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_8) / var_110_16

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_8 + var_110_16 and arg_107_1.time_ < var_110_8 + var_110_16 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322042026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 322042026
		arg_111_1.duration_ = 4.73

		local var_111_0 = {
			zh = 2.7,
			ja = 4.733
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
				arg_111_0:Play322042027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1284ui_story"]) and arg_111_1.var_.characterEffect1284ui_story == nil then
				arg_111_1.var_.characterEffect1284ui_story = arg_111_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1284ui_story"]) then
				if arg_111_1.var_.characterEffect1284ui_story and not isNil(arg_111_1.actors_["1284ui_story"]) then
					arg_111_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1284ui_story"]) and arg_111_1.var_.characterEffect1284ui_story then
				arg_111_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_114_2 = arg_111_1.actors_["10150ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.characterEffect10150ui_story == nil then
				arg_111_1.var_.characterEffect10150ui_story = var_114_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_3 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_3 and not isNil(var_114_2) then
				if arg_111_1.var_.characterEffect10150ui_story and not isNil(var_114_2) then
					arg_111_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_111_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_3)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_3 and arg_111_1.time_ < 0 + var_114_3 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.characterEffect10150ui_story then
				arg_111_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_111_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			local var_114_4 = 0
			local var_114_5 = 0.3

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_6 = arg_111_1:GetWordFromCfg(322042026)
				local var_114_7 = arg_111_1:FormatText(var_114_6.content)

				arg_111_1.text_.text = var_114_7

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_9 = 12 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_7) / 12)

				if (12 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_7) / 12)) > 0 and var_114_5 < var_114_9 then
					arg_111_1.talkMaxDuration = var_114_9

					if var_114_9 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_9 + var_114_4
					end
				end

				arg_111_1.text_.text = var_114_7
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042026", "story_v_out_322042.awb") ~= 0 then
					local var_114_10 = manager.audio:GetVoiceLength("story_v_out_322042", "322042026", "story_v_out_322042.awb") / 1000

					if var_114_10 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_4
					end

					if var_114_6.prefab_name ~= "" and arg_111_1.actors_[var_114_6.prefab_name] ~= nil then
						local var_114_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_6.prefab_name].transform, "story_v_out_322042", "322042026", "story_v_out_322042.awb")

						arg_111_1:RecordAudio("322042026", var_114_11)
						arg_111_1:RecordAudio("322042026", var_114_11)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_322042", "322042026", "story_v_out_322042.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_322042", "322042026", "story_v_out_322042.awb")
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
	Play322042027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 322042027
		arg_115_1.duration_ = 4.27

		local var_115_0 = {
			zh = 3.666,
			ja = 4.266
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
				arg_115_0:Play322042028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["10150ui_story"]) and arg_115_1.var_.characterEffect10150ui_story == nil then
				arg_115_1.var_.characterEffect10150ui_story = arg_115_1.actors_["10150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["10150ui_story"]) then
				if arg_115_1.var_.characterEffect10150ui_story and not isNil(arg_115_1.actors_["10150ui_story"]) then
					arg_115_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["10150ui_story"]) and arg_115_1.var_.characterEffect10150ui_story then
				arg_115_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_118_2 = arg_115_1.actors_["1284ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.characterEffect1284ui_story == nil then
				arg_115_1.var_.characterEffect1284ui_story = var_118_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_3 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_3 and not isNil(var_118_2) then
				if arg_115_1.var_.characterEffect1284ui_story and not isNil(var_118_2) then
					arg_115_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_3)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_3 and arg_115_1.time_ < 0 + var_118_3 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.characterEffect1284ui_story then
				arg_115_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_118_4 = 0
			local var_118_5 = 0.325

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_6 = arg_115_1:GetWordFromCfg(322042027)
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

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042027", "story_v_out_322042.awb") ~= 0 then
					local var_118_10 = manager.audio:GetVoiceLength("story_v_out_322042", "322042027", "story_v_out_322042.awb") / 1000

					if var_118_10 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_4
					end

					if var_118_6.prefab_name ~= "" and arg_115_1.actors_[var_118_6.prefab_name] ~= nil then
						local var_118_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_6.prefab_name].transform, "story_v_out_322042", "322042027", "story_v_out_322042.awb")

						arg_115_1:RecordAudio("322042027", var_118_11)
						arg_115_1:RecordAudio("322042027", var_118_11)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_322042", "322042027", "story_v_out_322042.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_322042", "322042027", "story_v_out_322042.awb")
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
	Play322042028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 322042028
		arg_119_1.duration_ = 3.87

		local var_119_0 = {
			zh = 3,
			ja = 3.866
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
				arg_119_0:Play322042029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1156ui_story = arg_119_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1156ui_story, Vector3.New(0.9, -1.1, -6.18), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1156ui_story"].transform.position).z)
				arg_119_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1156ui_story"].transform.localEulerAngles = arg_119_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0.9, -1.1, -6.18)
				arg_119_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1156ui_story"].transform.position).z)
				arg_119_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1156ui_story"].transform.localEulerAngles = arg_119_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["10150ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10150ui_story = var_122_1.localPosition

				local var_122_2 = GameObjectTools.GetOrAddComponent(var_122_1.gameObject, typeof(DynamicBoneHelper))

				if var_122_2 then
					var_122_2:EnableDynamicBone(false)
				end
			end

			local var_122_3 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 then
				var_122_1.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10150ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 0) / var_122_3)
				var_122_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_1.position).x, (manager.ui.mainCamera.transform.position - var_122_1.position).y, (manager.ui.mainCamera.transform.position - var_122_1.position).z)
				var_122_1.localEulerAngles.z = 0
				var_122_1.localEulerAngles.x = 0
				var_122_1.localEulerAngles = var_122_1.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 then
				var_122_1.localPosition = Vector3.New(0, 100, 0)
				var_122_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_1.position).x, (manager.ui.mainCamera.transform.position - var_122_1.position).y, (manager.ui.mainCamera.transform.position - var_122_1.position).z)
				var_122_1.localEulerAngles.z = 0
				var_122_1.localEulerAngles.x = 0
				var_122_1.localEulerAngles = var_122_1.localEulerAngles

				local var_122_4 = GameObjectTools.GetOrAddComponent(var_122_1.gameObject, typeof(DynamicBoneHelper))

				if var_122_4 then
					var_122_4:EnableDynamicBone(true)
				end
			end

			local var_122_5 = arg_119_1.actors_["1156ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.characterEffect1156ui_story == nil then
				arg_119_1.var_.characterEffect1156ui_story = var_122_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_6 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_6 and not isNil(var_122_5) then
				if arg_119_1.var_.characterEffect1156ui_story and not isNil(var_122_5) then
					arg_119_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_6 and arg_119_1.time_ < 0 + var_122_6 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.characterEffect1156ui_story then
				arg_119_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_122_8 = arg_119_1.actors_["10150ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_8) and arg_119_1.var_.characterEffect10150ui_story == nil then
				arg_119_1.var_.characterEffect10150ui_story = var_122_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_9 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_9 and not isNil(var_122_8) then
				if arg_119_1.var_.characterEffect10150ui_story and not isNil(var_122_8) then
					arg_119_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_9)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_9 and arg_119_1.time_ < 0 + var_122_9 + arg_122_0 and not isNil(var_122_8) and arg_119_1.var_.characterEffect10150ui_story then
				arg_119_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_122_10 = 0
			local var_122_11 = 0.325

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_12 = arg_119_1:GetWordFromCfg(322042028)
				local var_122_13 = arg_119_1:FormatText(var_122_12.content)

				arg_119_1.text_.text = var_122_13

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_15 = 13 <= 0 and var_122_11 or var_122_11 * (utf8.len(var_122_13) / 13)

				if (13 <= 0 and var_122_11 or var_122_11 * (utf8.len(var_122_13) / 13)) > 0 and var_122_11 < var_122_15 then
					arg_119_1.talkMaxDuration = var_122_15

					if var_122_15 + var_122_10 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_15 + var_122_10
					end
				end

				arg_119_1.text_.text = var_122_13
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042028", "story_v_out_322042.awb") ~= 0 then
					local var_122_16 = manager.audio:GetVoiceLength("story_v_out_322042", "322042028", "story_v_out_322042.awb") / 1000

					if var_122_16 + var_122_10 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_16 + var_122_10
					end

					if var_122_12.prefab_name ~= "" and arg_119_1.actors_[var_122_12.prefab_name] ~= nil then
						local var_122_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_12.prefab_name].transform, "story_v_out_322042", "322042028", "story_v_out_322042.awb")

						arg_119_1:RecordAudio("322042028", var_122_17)
						arg_119_1:RecordAudio("322042028", var_122_17)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_322042", "322042028", "story_v_out_322042.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_322042", "322042028", "story_v_out_322042.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_18 = math.max(var_122_11, arg_119_1.talkMaxDuration)

			if var_122_10 <= arg_119_1.time_ and arg_119_1.time_ < var_122_10 + var_122_18 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_10) / var_122_18

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_10 + var_122_18 and arg_119_1.time_ < var_122_10 + var_122_18 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322042029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 322042029
		arg_123_1.duration_ = 9.87

		local var_123_0 = {
			zh = 9.7,
			ja = 9.866
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
				arg_123_0:Play322042030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1284ui_story"]) and arg_123_1.var_.characterEffect1284ui_story == nil then
				arg_123_1.var_.characterEffect1284ui_story = arg_123_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1284ui_story"]) then
				if arg_123_1.var_.characterEffect1284ui_story and not isNil(arg_123_1.actors_["1284ui_story"]) then
					arg_123_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1284ui_story"]) and arg_123_1.var_.characterEffect1284ui_story then
				arg_123_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_126_2 = arg_123_1.actors_["1156ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.characterEffect1156ui_story == nil then
				arg_123_1.var_.characterEffect1156ui_story = var_126_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_3 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 and not isNil(var_126_2) then
				if arg_123_1.var_.characterEffect1156ui_story and not isNil(var_126_2) then
					arg_123_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_3)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.characterEffect1156ui_story then
				arg_123_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action4_2")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_126_4 = 0
			local var_126_5 = 1.275

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_6 = arg_123_1:GetWordFromCfg(322042029)
				local var_126_7 = arg_123_1:FormatText(var_126_6.content)

				arg_123_1.text_.text = var_126_7

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_9 = 51 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 51)

				if (51 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 51)) > 0 and var_126_5 < var_126_9 then
					arg_123_1.talkMaxDuration = var_126_9

					if var_126_9 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_4
					end
				end

				arg_123_1.text_.text = var_126_7
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042029", "story_v_out_322042.awb") ~= 0 then
					local var_126_10 = manager.audio:GetVoiceLength("story_v_out_322042", "322042029", "story_v_out_322042.awb") / 1000

					if var_126_10 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_4
					end

					if var_126_6.prefab_name ~= "" and arg_123_1.actors_[var_126_6.prefab_name] ~= nil then
						local var_126_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_6.prefab_name].transform, "story_v_out_322042", "322042029", "story_v_out_322042.awb")

						arg_123_1:RecordAudio("322042029", var_126_11)
						arg_123_1:RecordAudio("322042029", var_126_11)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_322042", "322042029", "story_v_out_322042.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_322042", "322042029", "story_v_out_322042.awb")
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
	Play322042030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 322042030
		arg_127_1.duration_ = 5.37

		local var_127_0 = {
			zh = 3.4,
			ja = 5.366
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
				arg_127_0:Play322042031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1156ui_story"]) and arg_127_1.var_.characterEffect1156ui_story == nil then
				arg_127_1.var_.characterEffect1156ui_story = arg_127_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1156ui_story"]) then
				if arg_127_1.var_.characterEffect1156ui_story and not isNil(arg_127_1.actors_["1156ui_story"]) then
					arg_127_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1156ui_story"]) and arg_127_1.var_.characterEffect1156ui_story then
				arg_127_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_130_2 = arg_127_1.actors_["1284ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.characterEffect1284ui_story == nil then
				arg_127_1.var_.characterEffect1284ui_story = var_130_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_3 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_3 and not isNil(var_130_2) then
				if arg_127_1.var_.characterEffect1284ui_story and not isNil(var_130_2) then
					arg_127_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_3)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_3 and arg_127_1.time_ < 0 + var_130_3 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.characterEffect1284ui_story then
				arg_127_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action6_1")
			end

			local var_130_4 = 0
			local var_130_5 = 0.475

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_6 = arg_127_1:GetWordFromCfg(322042030)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 19 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 19)

				if (19 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 19)) > 0 and var_130_5 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042030", "story_v_out_322042.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_out_322042", "322042030", "story_v_out_322042.awb") / 1000

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end

					if var_130_6.prefab_name ~= "" and arg_127_1.actors_[var_130_6.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_6.prefab_name].transform, "story_v_out_322042", "322042030", "story_v_out_322042.awb")

						arg_127_1:RecordAudio("322042030", var_130_11)
						arg_127_1:RecordAudio("322042030", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_322042", "322042030", "story_v_out_322042.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_322042", "322042030", "story_v_out_322042.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_12 = math.max(var_130_5, arg_127_1.talkMaxDuration)

			if var_130_4 <= arg_127_1.time_ and arg_127_1.time_ < var_130_4 + var_130_12 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_4) / var_130_12

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_4 + var_130_12 and arg_127_1.time_ < var_130_4 + var_130_12 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play322042031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 322042031
		arg_131_1.duration_ = 4.67

		local var_131_0 = {
			zh = 3.766,
			ja = 4.666
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
				arg_131_0:Play322042032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1156ui_story"]) and arg_131_1.var_.characterEffect1156ui_story == nil then
				arg_131_1.var_.characterEffect1156ui_story = arg_131_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1156ui_story"]) then
				if arg_131_1.var_.characterEffect1156ui_story and not isNil(arg_131_1.actors_["1156ui_story"]) then
					arg_131_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_0)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1156ui_story"]) and arg_131_1.var_.characterEffect1156ui_story then
				arg_131_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_134_1 = 0
			local var_134_2 = 0.5

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_131_1.callingController_:SetSelectedState("calling")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:GetWordFromCfg(322042031)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_6 = 20 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_4) / 20)

				if (20 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_4) / 20)) > 0 and var_134_2 < var_134_6 then
					arg_131_1.talkMaxDuration = var_134_6

					if var_134_6 + var_134_1 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_1
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042031", "story_v_out_322042.awb") ~= 0 then
					local var_134_7 = manager.audio:GetVoiceLength("story_v_out_322042", "322042031", "story_v_out_322042.awb") / 1000

					if var_134_7 + var_134_1 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_1
					end

					if var_134_3.prefab_name ~= "" and arg_131_1.actors_[var_134_3.prefab_name] ~= nil then
						local var_134_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_3.prefab_name].transform, "story_v_out_322042", "322042031", "story_v_out_322042.awb")

						arg_131_1:RecordAudio("322042031", var_134_8)
						arg_131_1:RecordAudio("322042031", var_134_8)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_322042", "322042031", "story_v_out_322042.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_322042", "322042031", "story_v_out_322042.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_9 = math.max(var_134_2, arg_131_1.talkMaxDuration)

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_9 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_1) / var_134_9

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_1 + var_134_9 and arg_131_1.time_ < var_134_1 + var_134_9 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play322042032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 322042032
		arg_135_1.duration_ = 1.4

		local var_135_0 = {
			zh = 0.999999999999,
			ja = 1.4
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
				arg_135_0:Play322042033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1284ui_story"]) and arg_135_1.var_.characterEffect1284ui_story == nil then
				arg_135_1.var_.characterEffect1284ui_story = arg_135_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1284ui_story"]) then
				if arg_135_1.var_.characterEffect1284ui_story and not isNil(arg_135_1.actors_["1284ui_story"]) then
					arg_135_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1284ui_story"]) and arg_135_1.var_.characterEffect1284ui_story then
				arg_135_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_138_2 = 0
			local var_138_3 = 0.075

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_4 = arg_135_1:GetWordFromCfg(322042032)
				local var_138_5 = arg_135_1:FormatText(var_138_4.content)

				arg_135_1.text_.text = var_138_5

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_7 = 3 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_5) / 3)

				if (3 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_5) / 3)) > 0 and var_138_3 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_2
					end
				end

				arg_135_1.text_.text = var_138_5
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042032", "story_v_out_322042.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_322042", "322042032", "story_v_out_322042.awb") / 1000

					if var_138_8 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_2
					end

					if var_138_4.prefab_name ~= "" and arg_135_1.actors_[var_138_4.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_4.prefab_name].transform, "story_v_out_322042", "322042032", "story_v_out_322042.awb")

						arg_135_1:RecordAudio("322042032", var_138_9)
						arg_135_1:RecordAudio("322042032", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_322042", "322042032", "story_v_out_322042.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_322042", "322042032", "story_v_out_322042.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_3, arg_135_1.talkMaxDuration)

			if var_138_2 <= arg_135_1.time_ and arg_135_1.time_ < var_138_2 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_2) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_2 + var_138_10 and arg_135_1.time_ < var_138_2 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play322042033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 322042033
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play322042034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1284ui_story = arg_139_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1284ui_story"].transform.position).z)
				arg_139_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1284ui_story"].transform.localEulerAngles = arg_139_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1284ui_story"].transform.position).z)
				arg_139_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1284ui_story"].transform.localEulerAngles = arg_139_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["1156ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1156ui_story = var_142_1.localPosition
			end

			local var_142_2 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 then
				var_142_1.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_2)
				var_142_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_1.position).x, (manager.ui.mainCamera.transform.position - var_142_1.position).y, (manager.ui.mainCamera.transform.position - var_142_1.position).z)
				var_142_1.localEulerAngles.z = 0
				var_142_1.localEulerAngles.x = 0
				var_142_1.localEulerAngles = var_142_1.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 then
				var_142_1.localPosition = Vector3.New(0, 100, 0)
				var_142_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_1.position).x, (manager.ui.mainCamera.transform.position - var_142_1.position).y, (manager.ui.mainCamera.transform.position - var_142_1.position).z)
				var_142_1.localEulerAngles.z = 0
				var_142_1.localEulerAngles.x = 0
				var_142_1.localEulerAngles = var_142_1.localEulerAngles
			end

			local var_142_3 = 0
			local var_142_4 = 1.275

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_3 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_5 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(322042033).content)

				arg_139_1.text_.text = var_142_5

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_7 = 51 <= 0 and var_142_4 or var_142_4 * (utf8.len(var_142_5) / 51)

				if (51 <= 0 and var_142_4 or var_142_4 * (utf8.len(var_142_5) / 51)) > 0 and var_142_4 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_3 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_3
					end
				end

				arg_139_1.text_.text = var_142_5
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_8 = math.max(var_142_4, arg_139_1.talkMaxDuration)

			if var_142_3 <= arg_139_1.time_ and arg_139_1.time_ < var_142_3 + var_142_8 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_3) / var_142_8

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_3 + var_142_8 and arg_139_1.time_ < var_142_3 + var_142_8 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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

		arg_139_1:InitPlayNodeList()
	end,
	Play322042034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 322042034
		arg_143_1.duration_ = 5.36

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play322042035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_9001
			local var_146_9000

			if 0.1 < arg_143_1.time_ and arg_143_1.time_ <= 0.1 + arg_146_0 then
				arg_143_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_rush", "")
			end

			if 1.83333333333333 < arg_143_1.time_ and arg_143_1.time_ <= 1.83333333333333 + arg_146_0 then
				arg_143_1:AudioAction("play", "effect", "se_story_145", "se_story_145_explosion02", "")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				local var_146_2 = arg_143_1.var_.effect2034

				if not arg_143_1.var_.effect2034 then
					var_146_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), manager.ui.mainCamera.transform)
					var_146_2.name = "2034"
					arg_143_1.var_.effect2034 = var_146_2
				else
					var_146_2.transform:SetParent(var_146_9001)
				end

				var_146_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_146_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_146_4 = manager.ui.mainCamera.transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.shakeOldPos = var_146_4.localPosition
			end

			local var_146_5 = 0.533333333333333

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_5 then
				local var_146_6, var_146_7 = math.modf((arg_143_1.time_ - 0) / 0.066)

				var_146_4.localPosition = Vector3.New(var_146_7 * 0.13, var_146_7 * 0.13, var_146_7 * 0.13) + arg_143_1.var_.shakeOldPos
			end

			if arg_143_1.time_ >= 0 + var_146_5 and arg_143_1.time_ < 0 + var_146_5 + arg_146_0 then
				var_146_4.localPosition = arg_143_1.var_.shakeOldPos
			end

			if 1.83333333333333 < arg_143_1.time_ and arg_143_1.time_ <= 1.83333333333333 + arg_146_0 then
				local var_146_8 = arg_143_1.var_.effect20342

				if not arg_143_1.var_.effect20342 then
					var_146_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), manager.ui.mainCamera.transform)
					var_146_8.name = "20342"
					arg_143_1.var_.effect20342 = var_146_8
				else
					var_146_8.transform:SetParent(var_146_9000)
				end

				var_146_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_146_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.1 < arg_143_1.time_ and arg_143_1.time_ <= 0.1 + arg_146_0 then
				arg_143_1:AudioAction("play", "effect", "se_story_10", "se_story_10_sword02", "")
			end

			if arg_143_1.frameCnt_ <= 1 then
				arg_143_1.dialog_:SetActive(false)
			end

			local var_146_11 = 0.358333333333333
			local var_146_12 = 1.475

			if 0.358333333333333 < arg_143_1.time_ and arg_143_1.time_ <= var_146_11 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0

				arg_143_1.dialog_:SetActive(true)

				arg_143_1.dialogCg_.alpha = 0

				local var_146_13 = LeanTween.value(arg_143_1.dialog_, 0, 1, 0.3)

				var_146_13:setOnUpdate(LuaHelper.FloatAction(function(arg_147_0)
					arg_143_1.dialogCg_.alpha = arg_147_0
				end))
				var_146_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_143_1.dialog_)
					var_146_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_143_1.duration_ = arg_143_1.duration_ + 0.3

				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_14 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(322042034).content)

				arg_143_1.text_.text = var_146_14

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_16 = 59 <= 0 and var_146_12 or var_146_12 * (utf8.len(var_146_14) / 59)

				if (59 <= 0 and var_146_12 or var_146_12 * (utf8.len(var_146_14) / 59)) > 0 and var_146_12 < var_146_16 then
					arg_143_1.talkMaxDuration = var_146_16
					var_146_11 = var_146_11 + 0.3

					if var_146_16 + var_146_11 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_16 + var_146_11
					end
				end

				arg_143_1.text_.text = var_146_14
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_17 = var_146_11 + 0.3
			local var_146_18 = math.max(var_146_12, arg_143_1.talkMaxDuration)

			if var_146_11 + 0.3 <= arg_143_1.time_ and arg_143_1.time_ < var_146_17 + var_146_18 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_17) / var_146_18

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_17 + var_146_18 and arg_143_1.time_ < var_146_17 + var_146_18 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play322042035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 322042035
		arg_149_1.duration_ = 2.13

		local var_149_0 = {
			zh = 2.133,
			ja = 1.466
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
				arg_149_0:Play322042036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos10150ui_story = arg_149_1.actors_["10150ui_story"].transform.localPosition

				local var_152_0 = GameObjectTools.GetOrAddComponent(arg_149_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_152_0 then
					var_152_0:EnableDynamicBone(false)
				end
			end

			local var_152_1 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_1 then
				arg_149_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10150ui_story, Vector3.New(0, -1.73, -5.5), (arg_149_1.time_ - 0) / var_152_1)
				arg_149_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["10150ui_story"].transform.position).z)
				arg_149_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["10150ui_story"].transform.localEulerAngles = arg_149_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_1 and arg_149_1.time_ < 0 + var_152_1 + arg_152_0 then
				arg_149_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(0, -1.73, -5.5)
				arg_149_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["10150ui_story"].transform.position).z)
				arg_149_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["10150ui_story"].transform.localEulerAngles = arg_149_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_152_2 = GameObjectTools.GetOrAddComponent(arg_149_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_152_2 then
					var_152_2:EnableDynamicBone(true)
				end
			end

			local var_152_3 = arg_149_1.actors_["10150ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_3) and arg_149_1.var_.characterEffect10150ui_story == nil then
				arg_149_1.var_.characterEffect10150ui_story = var_152_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_4 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 and not isNil(var_152_3) then
				if arg_149_1.var_.characterEffect10150ui_story and not isNil(var_152_3) then
					arg_149_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 and not isNil(var_152_3) and arg_149_1.var_.characterEffect10150ui_story then
				arg_149_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_152_6 = 0
			local var_152_7 = 0.05

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_8 = arg_149_1:GetWordFromCfg(322042035)
				local var_152_9 = arg_149_1:FormatText(var_152_8.content)

				arg_149_1.text_.text = var_152_9

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 2 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 2)

				if (2 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 2)) > 0 and var_152_7 < var_152_11 then
					arg_149_1.talkMaxDuration = var_152_11

					if var_152_11 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_9
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042035", "story_v_out_322042.awb") ~= 0 then
					local var_152_12 = manager.audio:GetVoiceLength("story_v_out_322042", "322042035", "story_v_out_322042.awb") / 1000

					if var_152_12 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_12 + var_152_6
					end

					if var_152_8.prefab_name ~= "" and arg_149_1.actors_[var_152_8.prefab_name] ~= nil then
						local var_152_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_8.prefab_name].transform, "story_v_out_322042", "322042035", "story_v_out_322042.awb")

						arg_149_1:RecordAudio("322042035", var_152_13)
						arg_149_1:RecordAudio("322042035", var_152_13)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_322042", "322042035", "story_v_out_322042.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_322042", "322042035", "story_v_out_322042.awb")
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
				actorName = "10150ui_story",
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
	Play322042036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 322042036
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play322042037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10150ui_story = arg_153_1.actors_["10150ui_story"].transform.localPosition

				local var_156_0 = GameObjectTools.GetOrAddComponent(arg_153_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_156_0 then
					var_156_0:EnableDynamicBone(false)
				end
			end

			local var_156_1 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_1 then
				arg_153_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10150ui_story, Vector3.New(0, 100, 0), (arg_153_1.time_ - 0) / var_156_1)
				arg_153_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10150ui_story"].transform.position).z)
				arg_153_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["10150ui_story"].transform.localEulerAngles = arg_153_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_1 and arg_153_1.time_ < 0 + var_156_1 + arg_156_0 then
				arg_153_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_153_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10150ui_story"].transform.position).z)
				arg_153_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["10150ui_story"].transform.localEulerAngles = arg_153_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_156_2 = GameObjectTools.GetOrAddComponent(arg_153_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_156_2 then
					var_156_2:EnableDynamicBone(true)
				end
			end

			if 0.433333333333333 < arg_153_1.time_ and arg_153_1.time_ <= 0.433333333333333 + arg_156_0 then
				arg_153_1:AudioAction("play", "effect", "se_story_141", "se_story_141_sword_aim", "")
			end

			local var_156_4 = 0
			local var_156_5 = 0.825

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(322042036).content)

				arg_153_1.text_.text = var_156_6

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_8 = 33 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_6) / 33)

				if (33 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_6) / 33)) > 0 and var_156_5 < var_156_8 then
					arg_153_1.talkMaxDuration = var_156_8

					if var_156_8 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_6
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_9 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_9 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_9

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_9 and arg_153_1.time_ < var_156_4 + var_156_9 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322042037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 322042037
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play322042038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 1.5

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(322042037).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 60 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 60)

				if (60 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 60)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play322042038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 322042038
		arg_161_1.duration_ = 4.73

		local var_161_0 = {
			zh = 4.533,
			ja = 4.733
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
				arg_161_0:Play322042039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10150ui_story = arg_161_1.actors_["10150ui_story"].transform.localPosition

				local var_164_0 = GameObjectTools.GetOrAddComponent(arg_161_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_164_0 then
					var_164_0:EnableDynamicBone(false)
				end
			end

			local var_164_1 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_1 then
				arg_161_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10150ui_story, Vector3.New(-0.9, -1.73, -5.5), (arg_161_1.time_ - 0) / var_164_1)
				arg_161_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10150ui_story"].transform.position).z)
				arg_161_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["10150ui_story"].transform.localEulerAngles = arg_161_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_1 and arg_161_1.time_ < 0 + var_164_1 + arg_164_0 then
				arg_161_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(-0.9, -1.73, -5.5)
				arg_161_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10150ui_story"].transform.position).z)
				arg_161_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["10150ui_story"].transform.localEulerAngles = arg_161_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_164_2 = GameObjectTools.GetOrAddComponent(arg_161_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_164_2 then
					var_164_2:EnableDynamicBone(true)
				end
			end

			local var_164_3 = arg_161_1.actors_["10150ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_3) and arg_161_1.var_.characterEffect10150ui_story == nil then
				arg_161_1.var_.characterEffect10150ui_story = var_164_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_4 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 and not isNil(var_164_3) then
				if arg_161_1.var_.characterEffect10150ui_story and not isNil(var_164_3) then
					arg_161_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 and not isNil(var_164_3) and arg_161_1.var_.characterEffect10150ui_story then
				arg_161_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action4_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_164_6 = 0
			local var_164_7 = 0.325

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_8 = arg_161_1:GetWordFromCfg(322042038)
				local var_164_9 = arg_161_1:FormatText(var_164_8.content)

				arg_161_1.text_.text = var_164_9

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_11 = 13 <= 0 and var_164_7 or var_164_7 * (utf8.len(var_164_9) / 13)

				if (13 <= 0 and var_164_7 or var_164_7 * (utf8.len(var_164_9) / 13)) > 0 and var_164_7 < var_164_11 then
					arg_161_1.talkMaxDuration = var_164_11

					if var_164_11 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_11 + var_164_6
					end
				end

				arg_161_1.text_.text = var_164_9
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042038", "story_v_out_322042.awb") ~= 0 then
					local var_164_12 = manager.audio:GetVoiceLength("story_v_out_322042", "322042038", "story_v_out_322042.awb") / 1000

					if var_164_12 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_12 + var_164_6
					end

					if var_164_8.prefab_name ~= "" and arg_161_1.actors_[var_164_8.prefab_name] ~= nil then
						local var_164_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_8.prefab_name].transform, "story_v_out_322042", "322042038", "story_v_out_322042.awb")

						arg_161_1:RecordAudio("322042038", var_164_13)
						arg_161_1:RecordAudio("322042038", var_164_13)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_322042", "322042038", "story_v_out_322042.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_322042", "322042038", "story_v_out_322042.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_14 = math.max(var_164_7, arg_161_1.talkMaxDuration)

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_14 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_6) / var_164_14

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_6 + var_164_14 and arg_161_1.time_ < var_164_6 + var_164_14 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play322042039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 322042039
		arg_165_1.duration_ = 4.6

		local var_165_0 = {
			zh = 3.7,
			ja = 4.6
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
				arg_165_0:Play322042040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1156ui_story = arg_165_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1156ui_story, Vector3.New(0.9, -1.1, -6.18), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1156ui_story"].transform.position).z)
				arg_165_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1156ui_story"].transform.localEulerAngles = arg_165_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0.9, -1.1, -6.18)
				arg_165_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1156ui_story"].transform.position).z)
				arg_165_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1156ui_story"].transform.localEulerAngles = arg_165_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1156ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1156ui_story == nil then
				arg_165_1.var_.characterEffect1156ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1156ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1156ui_story then
				arg_165_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_168_4 = arg_165_1.actors_["10150ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect10150ui_story == nil then
				arg_165_1.var_.characterEffect10150ui_story = var_168_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_5 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_5 and not isNil(var_168_4) then
				if arg_165_1.var_.characterEffect10150ui_story and not isNil(var_168_4) then
					arg_165_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_5)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_5 and arg_165_1.time_ < 0 + var_168_5 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect10150ui_story then
				arg_165_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action2_1")
			end

			local var_168_6 = 0
			local var_168_7 = 0.475

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:GetWordFromCfg(322042039)
				local var_168_9 = arg_165_1:FormatText(var_168_8.content)

				arg_165_1.text_.text = var_168_9

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_11 = 19 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_9) / 19)

				if (19 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_9) / 19)) > 0 and var_168_7 < var_168_11 then
					arg_165_1.talkMaxDuration = var_168_11

					if var_168_11 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_11 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_9
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042039", "story_v_out_322042.awb") ~= 0 then
					local var_168_12 = manager.audio:GetVoiceLength("story_v_out_322042", "322042039", "story_v_out_322042.awb") / 1000

					if var_168_12 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_12 + var_168_6
					end

					if var_168_8.prefab_name ~= "" and arg_165_1.actors_[var_168_8.prefab_name] ~= nil then
						local var_168_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_8.prefab_name].transform, "story_v_out_322042", "322042039", "story_v_out_322042.awb")

						arg_165_1:RecordAudio("322042039", var_168_13)
						arg_165_1:RecordAudio("322042039", var_168_13)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_322042", "322042039", "story_v_out_322042.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_322042", "322042039", "story_v_out_322042.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_14 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_14 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_14

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_14 and arg_165_1.time_ < var_168_6 + var_168_14 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
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

		arg_165_1:InitPlayNodeList()
	end,
	Play322042040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 322042040
		arg_169_1.duration_ = 7.97

		local var_169_0 = {
			zh = 5,
			ja = 7.966
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
				arg_169_0:Play322042041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10150ui_story = arg_169_1.actors_["10150ui_story"].transform.localPosition

				local var_172_0 = GameObjectTools.GetOrAddComponent(arg_169_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_172_0 then
					var_172_0:EnableDynamicBone(false)
				end
			end

			local var_172_1 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_1 then
				arg_169_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10150ui_story, Vector3.New(-0.9, -1.73, -5.5), (arg_169_1.time_ - 0) / var_172_1)
				arg_169_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10150ui_story"].transform.position).z)
				arg_169_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10150ui_story"].transform.localEulerAngles = arg_169_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_1 and arg_169_1.time_ < 0 + var_172_1 + arg_172_0 then
				arg_169_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(-0.9, -1.73, -5.5)
				arg_169_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10150ui_story"].transform.position).z)
				arg_169_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10150ui_story"].transform.localEulerAngles = arg_169_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_172_2 = GameObjectTools.GetOrAddComponent(arg_169_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_172_2 then
					var_172_2:EnableDynamicBone(true)
				end
			end

			local var_172_3 = arg_169_1.actors_["10150ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_3) and arg_169_1.var_.characterEffect10150ui_story == nil then
				arg_169_1.var_.characterEffect10150ui_story = var_172_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_4 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 and not isNil(var_172_3) then
				if arg_169_1.var_.characterEffect10150ui_story and not isNil(var_172_3) then
					arg_169_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 and not isNil(var_172_3) and arg_169_1.var_.characterEffect10150ui_story then
				arg_169_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_172_6 = arg_169_1.actors_["1156ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_6) and arg_169_1.var_.characterEffect1156ui_story == nil then
				arg_169_1.var_.characterEffect1156ui_story = var_172_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_7 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 and not isNil(var_172_6) then
				if arg_169_1.var_.characterEffect1156ui_story and not isNil(var_172_6) then
					arg_169_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_7)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 and not isNil(var_172_6) and arg_169_1.var_.characterEffect1156ui_story then
				arg_169_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action4_2")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_172_8 = 0
			local var_172_9 = 0.5

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_10 = arg_169_1:GetWordFromCfg(322042040)
				local var_172_11 = arg_169_1:FormatText(var_172_10.content)

				arg_169_1.text_.text = var_172_11

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_13 = 20 <= 0 and var_172_9 or var_172_9 * (utf8.len(var_172_11) / 20)

				if (20 <= 0 and var_172_9 or var_172_9 * (utf8.len(var_172_11) / 20)) > 0 and var_172_9 < var_172_13 then
					arg_169_1.talkMaxDuration = var_172_13

					if var_172_13 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_13 + var_172_8
					end
				end

				arg_169_1.text_.text = var_172_11
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042040", "story_v_out_322042.awb") ~= 0 then
					local var_172_14 = manager.audio:GetVoiceLength("story_v_out_322042", "322042040", "story_v_out_322042.awb") / 1000

					if var_172_14 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_14 + var_172_8
					end

					if var_172_10.prefab_name ~= "" and arg_169_1.actors_[var_172_10.prefab_name] ~= nil then
						local var_172_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_10.prefab_name].transform, "story_v_out_322042", "322042040", "story_v_out_322042.awb")

						arg_169_1:RecordAudio("322042040", var_172_15)
						arg_169_1:RecordAudio("322042040", var_172_15)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_322042", "322042040", "story_v_out_322042.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_322042", "322042040", "story_v_out_322042.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_16 = math.max(var_172_9, arg_169_1.talkMaxDuration)

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_16 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_8) / var_172_16

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_8 + var_172_16 and arg_169_1.time_ < var_172_8 + var_172_16 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play322042041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 322042041
		arg_173_1.duration_ = 7.17

		local var_173_0 = {
			zh = 4.233,
			ja = 7.166
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
				arg_173_0:Play322042042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1284ui_story = arg_173_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1284ui_story"].transform.position).z)
				arg_173_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1284ui_story"].transform.localEulerAngles = arg_173_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
				arg_173_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1284ui_story"].transform.position).z)
				arg_173_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1284ui_story"].transform.localEulerAngles = arg_173_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1156ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1156ui_story = var_176_1.localPosition
			end

			local var_176_2 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 then
				var_176_1.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_173_1.time_ - 0) / var_176_2)
				var_176_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_1.position).x, (manager.ui.mainCamera.transform.position - var_176_1.position).y, (manager.ui.mainCamera.transform.position - var_176_1.position).z)
				var_176_1.localEulerAngles.z = 0
				var_176_1.localEulerAngles.x = 0
				var_176_1.localEulerAngles = var_176_1.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 then
				var_176_1.localPosition = Vector3.New(0, 100, 0)
				var_176_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_1.position).x, (manager.ui.mainCamera.transform.position - var_176_1.position).y, (manager.ui.mainCamera.transform.position - var_176_1.position).z)
				var_176_1.localEulerAngles.z = 0
				var_176_1.localEulerAngles.x = 0
				var_176_1.localEulerAngles = var_176_1.localEulerAngles
			end

			local var_176_3 = arg_173_1.actors_["1284ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_3) and arg_173_1.var_.characterEffect1284ui_story == nil then
				arg_173_1.var_.characterEffect1284ui_story = var_176_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_4 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 and not isNil(var_176_3) then
				if arg_173_1.var_.characterEffect1284ui_story and not isNil(var_176_3) then
					arg_173_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 and not isNil(var_176_3) and arg_173_1.var_.characterEffect1284ui_story then
				arg_173_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_176_6 = arg_173_1.actors_["10150ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect10150ui_story == nil then
				arg_173_1.var_.characterEffect10150ui_story = var_176_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_7 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 and not isNil(var_176_6) then
				if arg_173_1.var_.characterEffect10150ui_story and not isNil(var_176_6) then
					arg_173_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_7)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect10150ui_story then
				arg_173_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_176_8 = 0
			local var_176_9 = 0.625

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_10 = arg_173_1:GetWordFromCfg(322042041)
				local var_176_11 = arg_173_1:FormatText(var_176_10.content)

				arg_173_1.text_.text = var_176_11

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_13 = 25 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 25)

				if (25 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 25)) > 0 and var_176_9 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_8
					end
				end

				arg_173_1.text_.text = var_176_11
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042041", "story_v_out_322042.awb") ~= 0 then
					local var_176_14 = manager.audio:GetVoiceLength("story_v_out_322042", "322042041", "story_v_out_322042.awb") / 1000

					if var_176_14 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_8
					end

					if var_176_10.prefab_name ~= "" and arg_173_1.actors_[var_176_10.prefab_name] ~= nil then
						local var_176_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_10.prefab_name].transform, "story_v_out_322042", "322042041", "story_v_out_322042.awb")

						arg_173_1:RecordAudio("322042041", var_176_15)
						arg_173_1:RecordAudio("322042041", var_176_15)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_322042", "322042041", "story_v_out_322042.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_322042", "322042041", "story_v_out_322042.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_16 = math.max(var_176_9, arg_173_1.talkMaxDuration)

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_16 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_8) / var_176_16

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_8 + var_176_16 and arg_173_1.time_ < var_176_8 + var_176_16 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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

		arg_173_1:InitPlayNodeList()
	end,
	Play322042042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 322042042
		arg_177_1.duration_ = 2

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play322042043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["10150ui_story"]) and arg_177_1.var_.characterEffect10150ui_story == nil then
				arg_177_1.var_.characterEffect10150ui_story = arg_177_1.actors_["10150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["10150ui_story"]) then
				if arg_177_1.var_.characterEffect10150ui_story and not isNil(arg_177_1.actors_["10150ui_story"]) then
					arg_177_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["10150ui_story"]) and arg_177_1.var_.characterEffect10150ui_story then
				arg_177_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_180_2 = arg_177_1.actors_["1284ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect1284ui_story == nil then
				arg_177_1.var_.characterEffect1284ui_story = var_180_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_3 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.characterEffect1284ui_story and not isNil(var_180_2) then
					arg_177_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_3)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect1284ui_story then
				arg_177_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action5_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_180_4 = 0
			local var_180_5 = 0.1

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(322042042)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 4 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 4)

				if (4 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 4)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042042", "story_v_out_322042.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_322042", "322042042", "story_v_out_322042.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_out_322042", "322042042", "story_v_out_322042.awb")

						arg_177_1:RecordAudio("322042042", var_180_11)
						arg_177_1:RecordAudio("322042042", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_322042", "322042042", "story_v_out_322042.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_322042", "322042042", "story_v_out_322042.awb")
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
	Play322042043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 322042043
		arg_181_1.duration_ = 7.43

		local var_181_0 = {
			zh = 2.966,
			ja = 7.433
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
				arg_181_0:Play322042044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1284ui_story"]) and arg_181_1.var_.characterEffect1284ui_story == nil then
				arg_181_1.var_.characterEffect1284ui_story = arg_181_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1284ui_story"]) then
				if arg_181_1.var_.characterEffect1284ui_story and not isNil(arg_181_1.actors_["1284ui_story"]) then
					arg_181_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1284ui_story"]) and arg_181_1.var_.characterEffect1284ui_story then
				arg_181_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_184_2 = arg_181_1.actors_["10150ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.characterEffect10150ui_story == nil then
				arg_181_1.var_.characterEffect10150ui_story = var_184_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_3 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.characterEffect10150ui_story and not isNil(var_184_2) then
					arg_181_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_181_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_3)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.characterEffect10150ui_story then
				arg_181_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_181_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			local var_184_4 = 0
			local var_184_5 = 0.425

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_6 = arg_181_1:GetWordFromCfg(322042043)
				local var_184_7 = arg_181_1:FormatText(var_184_6.content)

				arg_181_1.text_.text = var_184_7

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_9 = 17 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 17)

				if (17 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 17)) > 0 and var_184_5 < var_184_9 then
					arg_181_1.talkMaxDuration = var_184_9

					if var_184_9 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_4
					end
				end

				arg_181_1.text_.text = var_184_7
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042043", "story_v_out_322042.awb") ~= 0 then
					local var_184_10 = manager.audio:GetVoiceLength("story_v_out_322042", "322042043", "story_v_out_322042.awb") / 1000

					if var_184_10 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_4
					end

					if var_184_6.prefab_name ~= "" and arg_181_1.actors_[var_184_6.prefab_name] ~= nil then
						local var_184_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_6.prefab_name].transform, "story_v_out_322042", "322042043", "story_v_out_322042.awb")

						arg_181_1:RecordAudio("322042043", var_184_11)
						arg_181_1:RecordAudio("322042043", var_184_11)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_322042", "322042043", "story_v_out_322042.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_322042", "322042043", "story_v_out_322042.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_12 = math.max(var_184_5, arg_181_1.talkMaxDuration)

			if var_184_4 <= arg_181_1.time_ and arg_181_1.time_ < var_184_4 + var_184_12 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_4) / var_184_12

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_4 + var_184_12 and arg_181_1.time_ < var_184_4 + var_184_12 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play322042044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 322042044
		arg_185_1.duration_ = 13.2

		local var_185_0 = {
			zh = 8.5,
			ja = 13.2
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
				arg_185_0:Play322042045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10150ui_story = arg_185_1.actors_["10150ui_story"].transform.localPosition

				local var_188_0 = GameObjectTools.GetOrAddComponent(arg_185_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_188_0 then
					var_188_0:EnableDynamicBone(false)
				end
			end

			local var_188_1 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				arg_185_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10150ui_story, Vector3.New(-0.9, -1.73, -5.5), (arg_185_1.time_ - 0) / var_188_1)
				arg_185_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10150ui_story"].transform.position).z)
				arg_185_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["10150ui_story"].transform.localEulerAngles = arg_185_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 then
				arg_185_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(-0.9, -1.73, -5.5)
				arg_185_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10150ui_story"].transform.position).z)
				arg_185_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["10150ui_story"].transform.localEulerAngles = arg_185_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_188_2 = GameObjectTools.GetOrAddComponent(arg_185_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_188_2 then
					var_188_2:EnableDynamicBone(true)
				end
			end

			local var_188_3 = arg_185_1.actors_["10150ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_3) and arg_185_1.var_.characterEffect10150ui_story == nil then
				arg_185_1.var_.characterEffect10150ui_story = var_188_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_4 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 and not isNil(var_188_3) then
				if arg_185_1.var_.characterEffect10150ui_story and not isNil(var_188_3) then
					arg_185_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 and not isNil(var_188_3) and arg_185_1.var_.characterEffect10150ui_story then
				arg_185_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_188_6 = arg_185_1.actors_["1284ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect1284ui_story == nil then
				arg_185_1.var_.characterEffect1284ui_story = var_188_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_7 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 and not isNil(var_188_6) then
				if arg_185_1.var_.characterEffect1284ui_story and not isNil(var_188_6) then
					arg_185_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_7)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect1284ui_story then
				arg_185_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action5_2")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_188_8 = 0
			local var_188_9 = 0.875

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_10 = arg_185_1:GetWordFromCfg(322042044)
				local var_188_11 = arg_185_1:FormatText(var_188_10.content)

				arg_185_1.text_.text = var_188_11

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 35 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 35)

				if (35 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 35)) > 0 and var_188_9 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_11
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042044", "story_v_out_322042.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_out_322042", "322042044", "story_v_out_322042.awb") / 1000

					if var_188_14 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_8
					end

					if var_188_10.prefab_name ~= "" and arg_185_1.actors_[var_188_10.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_10.prefab_name].transform, "story_v_out_322042", "322042044", "story_v_out_322042.awb")

						arg_185_1:RecordAudio("322042044", var_188_15)
						arg_185_1:RecordAudio("322042044", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_322042", "322042044", "story_v_out_322042.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_322042", "322042044", "story_v_out_322042.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_9, arg_185_1.talkMaxDuration)

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_8) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_8 + var_188_16 and arg_185_1.time_ < var_188_8 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play322042045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 322042045
		arg_189_1.duration_ = 5.67

		local var_189_0 = {
			zh = 5.433,
			ja = 5.666
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
				arg_189_0:Play322042046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_192_0 = 0
			local var_192_1 = 0.575

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_2 = arg_189_1:GetWordFromCfg(322042045)
				local var_192_3 = arg_189_1:FormatText(var_192_2.content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 23 <= 0 and var_192_1 or var_192_1 * (utf8.len(var_192_3) / 23)

				if (23 <= 0 and var_192_1 or var_192_1 * (utf8.len(var_192_3) / 23)) > 0 and var_192_1 < var_192_5 then
					arg_189_1.talkMaxDuration = var_192_5

					if var_192_5 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042045", "story_v_out_322042.awb") ~= 0 then
					local var_192_6 = manager.audio:GetVoiceLength("story_v_out_322042", "322042045", "story_v_out_322042.awb") / 1000

					if var_192_6 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_0
					end

					if var_192_2.prefab_name ~= "" and arg_189_1.actors_[var_192_2.prefab_name] ~= nil then
						local var_192_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_2.prefab_name].transform, "story_v_out_322042", "322042045", "story_v_out_322042.awb")

						arg_189_1:RecordAudio("322042045", var_192_7)
						arg_189_1:RecordAudio("322042045", var_192_7)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_322042", "322042045", "story_v_out_322042.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_322042", "322042045", "story_v_out_322042.awb")
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
	Play322042046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 322042046
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play322042047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["10150ui_story"]) and arg_193_1.var_.characterEffect10150ui_story == nil then
				arg_193_1.var_.characterEffect10150ui_story = arg_193_1.actors_["10150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["10150ui_story"]) then
				if arg_193_1.var_.characterEffect10150ui_story and not isNil(arg_193_1.actors_["10150ui_story"]) then
					arg_193_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_193_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_0)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["10150ui_story"]) and arg_193_1.var_.characterEffect10150ui_story then
				arg_193_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_193_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			local var_196_1 = 0
			local var_196_2 = 1.475

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(322042046).content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 59 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 59)

				if (59 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 59)) > 0 and var_196_2 < var_196_5 then
					arg_193_1.talkMaxDuration = var_196_5

					if var_196_5 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + var_196_1
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_6 = math.max(var_196_2, arg_193_1.talkMaxDuration)

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_6 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_1) / var_196_6

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_1 + var_196_6 and arg_193_1.time_ < var_196_1 + var_196_6 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play322042047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 322042047
		arg_197_1.duration_ = 10.67

		local var_197_0 = {
			zh = 9.333,
			ja = 10.666
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
				arg_197_0:Play322042048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1284ui_story"]) and arg_197_1.var_.characterEffect1284ui_story == nil then
				arg_197_1.var_.characterEffect1284ui_story = arg_197_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1284ui_story"]) then
				if arg_197_1.var_.characterEffect1284ui_story and not isNil(arg_197_1.actors_["1284ui_story"]) then
					arg_197_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1284ui_story"]) and arg_197_1.var_.characterEffect1284ui_story then
				arg_197_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_2")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_200_2 = 0
			local var_200_3 = 1.3

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_2 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_4 = arg_197_1:GetWordFromCfg(322042047)
				local var_200_5 = arg_197_1:FormatText(var_200_4.content)

				arg_197_1.text_.text = var_200_5

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_7 = 52 <= 0 and var_200_3 or var_200_3 * (utf8.len(var_200_5) / 52)

				if (52 <= 0 and var_200_3 or var_200_3 * (utf8.len(var_200_5) / 52)) > 0 and var_200_3 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_2 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_2
					end
				end

				arg_197_1.text_.text = var_200_5
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042047", "story_v_out_322042.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_322042", "322042047", "story_v_out_322042.awb") / 1000

					if var_200_8 + var_200_2 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_2
					end

					if var_200_4.prefab_name ~= "" and arg_197_1.actors_[var_200_4.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_4.prefab_name].transform, "story_v_out_322042", "322042047", "story_v_out_322042.awb")

						arg_197_1:RecordAudio("322042047", var_200_9)
						arg_197_1:RecordAudio("322042047", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_322042", "322042047", "story_v_out_322042.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_322042", "322042047", "story_v_out_322042.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_3, arg_197_1.talkMaxDuration)

			if var_200_2 <= arg_197_1.time_ and arg_197_1.time_ < var_200_2 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_2) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_2 + var_200_10 and arg_197_1.time_ < var_200_2 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play322042048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 322042048
		arg_201_1.duration_ = 7.07

		local var_201_0 = {
			zh = 6.5,
			ja = 7.066
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
				arg_201_0:Play322042049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["10150ui_story"]) and arg_201_1.var_.characterEffect10150ui_story == nil then
				arg_201_1.var_.characterEffect10150ui_story = arg_201_1.actors_["10150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["10150ui_story"]) then
				if arg_201_1.var_.characterEffect10150ui_story and not isNil(arg_201_1.actors_["10150ui_story"]) then
					arg_201_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["10150ui_story"]) and arg_201_1.var_.characterEffect10150ui_story then
				arg_201_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_204_2 = arg_201_1.actors_["1284ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.characterEffect1284ui_story == nil then
				arg_201_1.var_.characterEffect1284ui_story = var_204_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_3 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_3 and not isNil(var_204_2) then
				if arg_201_1.var_.characterEffect1284ui_story and not isNil(var_204_2) then
					arg_201_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_3)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_3 and arg_201_1.time_ < 0 + var_204_3 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.characterEffect1284ui_story then
				arg_201_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action2_1")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_204_4 = 0
			local var_204_5 = 0.45

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_6 = arg_201_1:GetWordFromCfg(322042048)
				local var_204_7 = arg_201_1:FormatText(var_204_6.content)

				arg_201_1.text_.text = var_204_7

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_9 = 18 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 18)

				if (18 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 18)) > 0 and var_204_5 < var_204_9 then
					arg_201_1.talkMaxDuration = var_204_9

					if var_204_9 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_9 + var_204_4
					end
				end

				arg_201_1.text_.text = var_204_7
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042048", "story_v_out_322042.awb") ~= 0 then
					local var_204_10 = manager.audio:GetVoiceLength("story_v_out_322042", "322042048", "story_v_out_322042.awb") / 1000

					if var_204_10 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_4
					end

					if var_204_6.prefab_name ~= "" and arg_201_1.actors_[var_204_6.prefab_name] ~= nil then
						local var_204_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_6.prefab_name].transform, "story_v_out_322042", "322042048", "story_v_out_322042.awb")

						arg_201_1:RecordAudio("322042048", var_204_11)
						arg_201_1:RecordAudio("322042048", var_204_11)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_322042", "322042048", "story_v_out_322042.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_322042", "322042048", "story_v_out_322042.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_12 = math.max(var_204_5, arg_201_1.talkMaxDuration)

			if var_204_4 <= arg_201_1.time_ and arg_201_1.time_ < var_204_4 + var_204_12 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_4) / var_204_12

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_4 + var_204_12 and arg_201_1.time_ < var_204_4 + var_204_12 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play322042049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 322042049
		arg_205_1.duration_ = 9.83

		local var_205_0 = {
			zh = 7.5,
			ja = 9.833
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
				arg_205_0:Play322042050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1284ui_story"]) and arg_205_1.var_.characterEffect1284ui_story == nil then
				arg_205_1.var_.characterEffect1284ui_story = arg_205_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1284ui_story"]) then
				if arg_205_1.var_.characterEffect1284ui_story and not isNil(arg_205_1.actors_["1284ui_story"]) then
					arg_205_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1284ui_story"]) and arg_205_1.var_.characterEffect1284ui_story then
				arg_205_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_208_2 = arg_205_1.actors_["10150ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.characterEffect10150ui_story == nil then
				arg_205_1.var_.characterEffect10150ui_story = var_208_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_3 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_3 and not isNil(var_208_2) then
				if arg_205_1.var_.characterEffect10150ui_story and not isNil(var_208_2) then
					arg_205_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_205_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_3)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.characterEffect10150ui_story then
				arg_205_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_205_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action6_1")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_208_4 = 0
			local var_208_5 = 1.075

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_6 = arg_205_1:GetWordFromCfg(322042049)
				local var_208_7 = arg_205_1:FormatText(var_208_6.content)

				arg_205_1.text_.text = var_208_7

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_9 = 43 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_7) / 43)

				if (43 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_7) / 43)) > 0 and var_208_5 < var_208_9 then
					arg_205_1.talkMaxDuration = var_208_9

					if var_208_9 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_9 + var_208_4
					end
				end

				arg_205_1.text_.text = var_208_7
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042049", "story_v_out_322042.awb") ~= 0 then
					local var_208_10 = manager.audio:GetVoiceLength("story_v_out_322042", "322042049", "story_v_out_322042.awb") / 1000

					if var_208_10 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_10 + var_208_4
					end

					if var_208_6.prefab_name ~= "" and arg_205_1.actors_[var_208_6.prefab_name] ~= nil then
						local var_208_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_6.prefab_name].transform, "story_v_out_322042", "322042049", "story_v_out_322042.awb")

						arg_205_1:RecordAudio("322042049", var_208_11)
						arg_205_1:RecordAudio("322042049", var_208_11)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_322042", "322042049", "story_v_out_322042.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_322042", "322042049", "story_v_out_322042.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_12 = math.max(var_208_5, arg_205_1.talkMaxDuration)

			if var_208_4 <= arg_205_1.time_ and arg_205_1.time_ < var_208_4 + var_208_12 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_4) / var_208_12

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_4 + var_208_12 and arg_205_1.time_ < var_208_4 + var_208_12 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play322042050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 322042050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play322042051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1284ui_story = arg_209_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1284ui_story"].transform.position).z)
				arg_209_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1284ui_story"].transform.localEulerAngles = arg_209_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1284ui_story"].transform.position).z)
				arg_209_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1284ui_story"].transform.localEulerAngles = arg_209_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["10150ui_story"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos10150ui_story = var_212_1.localPosition

				local var_212_2 = GameObjectTools.GetOrAddComponent(var_212_1.gameObject, typeof(DynamicBoneHelper))

				if var_212_2 then
					var_212_2:EnableDynamicBone(false)
				end
			end

			local var_212_3 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_3 then
				var_212_1.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10150ui_story, Vector3.New(0, 100, 0), (arg_209_1.time_ - 0) / var_212_3)
				var_212_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_1.position).x, (manager.ui.mainCamera.transform.position - var_212_1.position).y, (manager.ui.mainCamera.transform.position - var_212_1.position).z)
				var_212_1.localEulerAngles.z = 0
				var_212_1.localEulerAngles.x = 0
				var_212_1.localEulerAngles = var_212_1.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_3 and arg_209_1.time_ < 0 + var_212_3 + arg_212_0 then
				var_212_1.localPosition = Vector3.New(0, 100, 0)
				var_212_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_1.position).x, (manager.ui.mainCamera.transform.position - var_212_1.position).y, (manager.ui.mainCamera.transform.position - var_212_1.position).z)
				var_212_1.localEulerAngles.z = 0
				var_212_1.localEulerAngles.x = 0
				var_212_1.localEulerAngles = var_212_1.localEulerAngles

				local var_212_4 = GameObjectTools.GetOrAddComponent(var_212_1.gameObject, typeof(DynamicBoneHelper))

				if var_212_4 then
					var_212_4:EnableDynamicBone(true)
				end
			end

			local var_212_5 = 0
			local var_212_6 = 1.075

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_7 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(322042050).content)

				arg_209_1.text_.text = var_212_7

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_9 = 43 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_7) / 43)

				if (43 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_7) / 43)) > 0 and var_212_6 < var_212_9 then
					arg_209_1.talkMaxDuration = var_212_9

					if var_212_9 + var_212_5 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_9 + var_212_5
					end
				end

				arg_209_1.text_.text = var_212_7
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_10 = math.max(var_212_6, arg_209_1.talkMaxDuration)

			if var_212_5 <= arg_209_1.time_ and arg_209_1.time_ < var_212_5 + var_212_10 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_5) / var_212_10

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_5 + var_212_10 and arg_209_1.time_ < var_212_5 + var_212_10 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play322042051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 322042051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play322042052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_9000

			if 0.433333333333333 < arg_213_1.time_ and arg_213_1.time_ <= 0.433333333333333 + arg_216_0 then
				arg_213_1:AudioAction("play", "effect", "se_story_140", "se_story_140_microphone", "")
			end

			if 0.433333333333333 < arg_213_1.time_ and arg_213_1.time_ <= 0.433333333333333 + arg_216_0 then
				local var_216_1 = arg_213_1.var_.effect2051

				if not arg_213_1.var_.effect2051 then
					var_216_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_216_1.name = "2051"
					arg_213_1.var_.effect2051 = var_216_1
				else
					var_216_1.transform:SetParent(var_216_9000)
				end

				var_216_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_216_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.73333333333333 < arg_213_1.time_ and arg_213_1.time_ <= 1.73333333333333 + arg_216_0 then
				if arg_213_1.var_.effect2051 then
					Object.Destroy(arg_213_1.var_.effect2051)

					arg_213_1.var_.effect2051 = nil
				end
			end

			local var_216_4 = 0
			local var_216_5 = 1.25

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_6 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(322042051).content)

				arg_213_1.text_.text = var_216_6

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_8 = 50 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_6) / 50)

				if (50 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_6) / 50)) > 0 and var_216_5 < var_216_8 then
					arg_213_1.talkMaxDuration = var_216_8

					if var_216_8 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_6
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_9 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_9 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_9

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_9 and arg_213_1.time_ < var_216_4 + var_216_9 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play322042052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 322042052
		arg_217_1.duration_ = 2

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play322042053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1156ui_story = arg_217_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1156ui_story"].transform.position).z)
				arg_217_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1156ui_story"].transform.localEulerAngles = arg_217_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.18)
				arg_217_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1156ui_story"].transform.position).z)
				arg_217_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1156ui_story"].transform.localEulerAngles = arg_217_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_220_1 = arg_217_1.actors_["1156ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1156ui_story == nil then
				arg_217_1.var_.characterEffect1156ui_story = var_220_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 and not isNil(var_220_1) then
				if arg_217_1.var_.characterEffect1156ui_story and not isNil(var_220_1) then
					arg_217_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1156ui_story then
				arg_217_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_220_4 = 0
			local var_220_5 = 0.25

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_4 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_6 = arg_217_1:GetWordFromCfg(322042052)
				local var_220_7 = arg_217_1:FormatText(var_220_6.content)

				arg_217_1.text_.text = var_220_7

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_9 = 10 <= 0 and var_220_5 or var_220_5 * (utf8.len(var_220_7) / 10)

				if (10 <= 0 and var_220_5 or var_220_5 * (utf8.len(var_220_7) / 10)) > 0 and var_220_5 < var_220_9 then
					arg_217_1.talkMaxDuration = var_220_9

					if var_220_9 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_9 + var_220_4
					end
				end

				arg_217_1.text_.text = var_220_7
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042052", "story_v_out_322042.awb") ~= 0 then
					local var_220_10 = manager.audio:GetVoiceLength("story_v_out_322042", "322042052", "story_v_out_322042.awb") / 1000

					if var_220_10 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_10 + var_220_4
					end

					if var_220_6.prefab_name ~= "" and arg_217_1.actors_[var_220_6.prefab_name] ~= nil then
						local var_220_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_6.prefab_name].transform, "story_v_out_322042", "322042052", "story_v_out_322042.awb")

						arg_217_1:RecordAudio("322042052", var_220_11)
						arg_217_1:RecordAudio("322042052", var_220_11)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_322042", "322042052", "story_v_out_322042.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_322042", "322042052", "story_v_out_322042.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_12 = math.max(var_220_5, arg_217_1.talkMaxDuration)

			if var_220_4 <= arg_217_1.time_ and arg_217_1.time_ < var_220_4 + var_220_12 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_4) / var_220_12

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_4 + var_220_12 and arg_217_1.time_ < var_220_4 + var_220_12 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
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

		arg_217_1:InitPlayNodeList()
	end,
	Play322042053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 322042053
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play322042054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_9000

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1156ui_story = arg_221_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1156ui_story"].transform.position).z)
				arg_221_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1156ui_story"].transform.localEulerAngles = arg_221_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_221_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1156ui_story"].transform.position).z)
				arg_221_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1156ui_story"].transform.localEulerAngles = arg_221_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if 0.433333333333333 < arg_221_1.time_ and arg_221_1.time_ <= 0.433333333333333 + arg_224_0 then
				arg_221_1:AudioAction("play", "effect", "se_story_145", "se_story_145_rock", "")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				local var_224_2 = arg_221_1.var_.effect2043

				if not arg_221_1.var_.effect2043 then
					var_224_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_fogbank_black_in"), manager.ui.mainCamera.transform)
					var_224_2.name = "2043"
					arg_221_1.var_.effect2043 = var_224_2
				else
					var_224_2.transform:SetParent(var_224_9000)
				end

				var_224_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_224_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_224_4 = 0
			local var_224_5 = 1.675

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_6 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(322042053).content)

				arg_221_1.text_.text = var_224_6

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_8 = 67 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_6) / 67)

				if (67 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_6) / 67)) > 0 and var_224_5 < var_224_8 then
					arg_221_1.talkMaxDuration = var_224_8

					if var_224_8 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_4
					end
				end

				arg_221_1.text_.text = var_224_6
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_9 = math.max(var_224_5, arg_221_1.talkMaxDuration)

			if var_224_4 <= arg_221_1.time_ and arg_221_1.time_ < var_224_4 + var_224_9 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_4) / var_224_9

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_4 + var_224_9 and arg_221_1.time_ < var_224_4 + var_224_9 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
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

		arg_221_1:InitPlayNodeList()
	end,
	Play322042054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 322042054
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play322042055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 1.475

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_1 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(322042054).content)

				arg_225_1.text_.text = var_228_1

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_3 = 59 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 59)

				if (59 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 59)) > 0 and var_228_0 < var_228_3 then
					arg_225_1.talkMaxDuration = var_228_3

					if var_228_3 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_3 + 0
					end
				end

				arg_225_1.text_.text = var_228_1
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_4 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_4

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play322042055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 322042055
		arg_229_1.duration_ = 3.1

		local var_229_0 = {
			zh = 2.99966666666667,
			ja = 3.09966666666667
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
				arg_229_0:Play322042056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0.166666666666667 < arg_229_1.time_ and arg_229_1.time_ <= 0.166666666666667 + arg_232_0 then
				arg_229_1.var_.moveOldPos1284ui_story = arg_229_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0.166666666666667 <= arg_229_1.time_ and arg_229_1.time_ < 0.166666666666667 + var_232_0 then
				arg_229_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_229_1.time_ - 0.166666666666667) / var_232_0)
				arg_229_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1284ui_story"].transform.position).z)
				arg_229_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1284ui_story"].transform.localEulerAngles = arg_229_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0.166666666666667 + var_232_0 and arg_229_1.time_ < 0.166666666666667 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				arg_229_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1284ui_story"].transform.position).z)
				arg_229_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1284ui_story"].transform.localEulerAngles = arg_229_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_232_1 = arg_229_1.actors_["1284ui_story"]

			if 0.166666666666667 < arg_229_1.time_ and arg_229_1.time_ <= 0.166666666666667 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1284ui_story == nil then
				arg_229_1.var_.characterEffect1284ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if 0.166666666666667 <= arg_229_1.time_ and arg_229_1.time_ < 0.166666666666667 + var_232_2 and not isNil(var_232_1) then
				if arg_229_1.var_.characterEffect1284ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0.166666666666667 + var_232_2 and arg_229_1.time_ < 0.166666666666667 + var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1284ui_story then
				arg_229_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0.166666666666667 < arg_229_1.time_ and arg_229_1.time_ <= 0.166666666666667 + arg_232_0 then
				arg_229_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0.166666666666667 < arg_229_1.time_ and arg_229_1.time_ <= 0.166666666666667 + arg_232_0 then
				arg_229_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				if arg_229_1.var_.effect2043 then
					Object.Destroy(arg_229_1.var_.effect2043)

					arg_229_1.var_.effect2043 = nil
				end
			end

			local var_232_5 = 0

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = false

				arg_229_1:SetGaussion(false)
			end

			local var_232_6 = 0.166666666666667

			if var_232_5 <= arg_229_1.time_ and arg_229_1.time_ < var_232_5 + var_232_6 then
				local var_232_7 = Color.New(0, 0, 0)

				var_232_7.a = Mathf.Lerp(0, 1, (arg_229_1.time_ - var_232_5) / var_232_6)
				arg_229_1.mask_.color = var_232_7
			end

			if arg_229_1.time_ >= var_232_5 + var_232_6 and arg_229_1.time_ < var_232_5 + var_232_6 + arg_232_0 then
				local var_232_8 = Color.New(0, 0, 0)

				var_232_8.a = 1
				arg_229_1.mask_.color = var_232_8
			end

			local var_232_9 = 0.166666666666667

			if 0.166666666666667 < arg_229_1.time_ and arg_229_1.time_ <= var_232_9 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = false

				arg_229_1:SetGaussion(false)
			end

			local var_232_10 = 0.166666666666667

			if var_232_9 <= arg_229_1.time_ and arg_229_1.time_ < var_232_9 + var_232_10 then
				local var_232_11 = Color.New(0, 0, 0)

				var_232_11.a = Mathf.Lerp(1, 0, (arg_229_1.time_ - var_232_9) / var_232_10)
				arg_229_1.mask_.color = var_232_11
			end

			if arg_229_1.time_ >= var_232_9 + var_232_10 and arg_229_1.time_ < var_232_9 + var_232_10 + arg_232_0 then
				local var_232_12 = Color.New(0, 0, 0)

				arg_229_1.mask_.enabled = false
				var_232_12.a = 0
				arg_229_1.mask_.color = var_232_12
			end

			if arg_229_1.frameCnt_ <= 1 then
				arg_229_1.dialog_:SetActive(false)
			end

			local var_232_13 = 0.166666666666667
			local var_232_14 = 0.325

			if 0.166666666666667 < arg_229_1.time_ and arg_229_1.time_ <= var_232_13 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				arg_229_1.dialog_:SetActive(true)

				arg_229_1.dialogCg_.alpha = 0

				local var_232_15 = LeanTween.value(arg_229_1.dialog_, 0, 1, 0.3)

				var_232_15:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_229_1.dialogCg_.alpha = arg_233_0
				end))
				var_232_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_229_1.dialog_)
					var_232_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_229_1.duration_ = arg_229_1.duration_ + 0.3

				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_16 = arg_229_1:GetWordFromCfg(322042055)
				local var_232_17 = arg_229_1:FormatText(var_232_16.content)

				arg_229_1.text_.text = var_232_17

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_19 = 13 <= 0 and var_232_14 or var_232_14 * (utf8.len(var_232_17) / 13)

				if (13 <= 0 and var_232_14 or var_232_14 * (utf8.len(var_232_17) / 13)) > 0 and var_232_14 < var_232_19 then
					arg_229_1.talkMaxDuration = var_232_19
					var_232_13 = var_232_13 + 0.3

					if var_232_19 + var_232_13 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_19 + var_232_13
					end
				end

				arg_229_1.text_.text = var_232_17
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042055", "story_v_out_322042.awb") ~= 0 then
					local var_232_20 = manager.audio:GetVoiceLength("story_v_out_322042", "322042055", "story_v_out_322042.awb") / 1000

					if var_232_20 + var_232_13 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_20 + var_232_13
					end

					if var_232_16.prefab_name ~= "" and arg_229_1.actors_[var_232_16.prefab_name] ~= nil then
						local var_232_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_16.prefab_name].transform, "story_v_out_322042", "322042055", "story_v_out_322042.awb")

						arg_229_1:RecordAudio("322042055", var_232_21)
						arg_229_1:RecordAudio("322042055", var_232_21)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_322042", "322042055", "story_v_out_322042.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_322042", "322042055", "story_v_out_322042.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_22 = var_232_13 + 0.3
			local var_232_23 = math.max(var_232_14, arg_229_1.talkMaxDuration)

			if var_232_13 + 0.3 <= arg_229_1.time_ and arg_229_1.time_ < var_232_22 + var_232_23 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_22) / var_232_23

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_22 + var_232_23 and arg_229_1.time_ < var_232_22 + var_232_23 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play322042056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 322042056
		arg_235_1.duration_ = 7.9

		local var_235_0 = {
			zh = 4.833,
			ja = 7.9
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play322042057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos10104ui_story = arg_235_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_238_0 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 then
				arg_235_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_235_1.time_ - 0) / var_238_0)
				arg_235_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["10104ui_story"].transform.position).z)
				arg_235_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["10104ui_story"].transform.localEulerAngles = arg_235_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 then
				arg_235_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.99, -1.12, -5.99)
				arg_235_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["10104ui_story"].transform.position).z)
				arg_235_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["10104ui_story"].transform.localEulerAngles = arg_235_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_238_1 = arg_235_1.actors_["10104ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect10104ui_story == nil then
				arg_235_1.var_.characterEffect10104ui_story = var_238_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_2 and not isNil(var_238_1) then
				if arg_235_1.var_.characterEffect10104ui_story and not isNil(var_238_1) then
					arg_235_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_2 and arg_235_1.time_ < 0 + var_238_2 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect10104ui_story then
				arg_235_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_238_4 = arg_235_1.actors_["1284ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_4) and arg_235_1.var_.characterEffect1284ui_story == nil then
				arg_235_1.var_.characterEffect1284ui_story = var_238_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_5 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_5 and not isNil(var_238_4) then
				if arg_235_1.var_.characterEffect1284ui_story and not isNil(var_238_4) then
					arg_235_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_5)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_5 and arg_235_1.time_ < 0 + var_238_5 + arg_238_0 and not isNil(var_238_4) and arg_235_1.var_.characterEffect1284ui_story then
				arg_235_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_238_6 = 0
			local var_238_7 = 0.5

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_6 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_8 = arg_235_1:GetWordFromCfg(322042056)
				local var_238_9 = arg_235_1:FormatText(var_238_8.content)

				arg_235_1.text_.text = var_238_9

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_11 = 20 <= 0 and var_238_7 or var_238_7 * (utf8.len(var_238_9) / 20)

				if (20 <= 0 and var_238_7 or var_238_7 * (utf8.len(var_238_9) / 20)) > 0 and var_238_7 < var_238_11 then
					arg_235_1.talkMaxDuration = var_238_11

					if var_238_11 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_11 + var_238_6
					end
				end

				arg_235_1.text_.text = var_238_9
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042056", "story_v_out_322042.awb") ~= 0 then
					local var_238_12 = manager.audio:GetVoiceLength("story_v_out_322042", "322042056", "story_v_out_322042.awb") / 1000

					if var_238_12 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_12 + var_238_6
					end

					if var_238_8.prefab_name ~= "" and arg_235_1.actors_[var_238_8.prefab_name] ~= nil then
						local var_238_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_8.prefab_name].transform, "story_v_out_322042", "322042056", "story_v_out_322042.awb")

						arg_235_1:RecordAudio("322042056", var_238_13)
						arg_235_1:RecordAudio("322042056", var_238_13)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_322042", "322042056", "story_v_out_322042.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_322042", "322042056", "story_v_out_322042.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_14 = math.max(var_238_7, arg_235_1.talkMaxDuration)

			if var_238_6 <= arg_235_1.time_ and arg_235_1.time_ < var_238_6 + var_238_14 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_6) / var_238_14

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_6 + var_238_14 and arg_235_1.time_ < var_238_6 + var_238_14 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play322042057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 322042057
		arg_239_1.duration_ = 2.73

		local var_239_0 = {
			zh = 2.066,
			ja = 2.733
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play322042058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1156ui_story = arg_239_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1156ui_story"].transform.position).z)
				arg_239_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1156ui_story"].transform.localEulerAngles = arg_239_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.18)
				arg_239_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1156ui_story"].transform.position).z)
				arg_239_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1156ui_story"].transform.localEulerAngles = arg_239_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_242_1 = arg_239_1.actors_["10104ui_story"].transform

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos10104ui_story = var_242_1.localPosition
			end

			local var_242_2 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 then
				var_242_1.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_239_1.time_ - 0) / var_242_2)
				var_242_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_242_1.position).x, (manager.ui.mainCamera.transform.position - var_242_1.position).y, (manager.ui.mainCamera.transform.position - var_242_1.position).z)
				var_242_1.localEulerAngles.z = 0
				var_242_1.localEulerAngles.x = 0
				var_242_1.localEulerAngles = var_242_1.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 then
				var_242_1.localPosition = Vector3.New(0, 100, 0)
				var_242_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_242_1.position).x, (manager.ui.mainCamera.transform.position - var_242_1.position).y, (manager.ui.mainCamera.transform.position - var_242_1.position).z)
				var_242_1.localEulerAngles.z = 0
				var_242_1.localEulerAngles.x = 0
				var_242_1.localEulerAngles = var_242_1.localEulerAngles
			end

			local var_242_3 = arg_239_1.actors_["1284ui_story"].transform

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1284ui_story = var_242_3.localPosition
			end

			local var_242_4 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 then
				var_242_3.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_239_1.time_ - 0) / var_242_4)
				var_242_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_242_3.position).x, (manager.ui.mainCamera.transform.position - var_242_3.position).y, (manager.ui.mainCamera.transform.position - var_242_3.position).z)
				var_242_3.localEulerAngles.z = 0
				var_242_3.localEulerAngles.x = 0
				var_242_3.localEulerAngles = var_242_3.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 then
				var_242_3.localPosition = Vector3.New(0, 100, 0)
				var_242_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_242_3.position).x, (manager.ui.mainCamera.transform.position - var_242_3.position).y, (manager.ui.mainCamera.transform.position - var_242_3.position).z)
				var_242_3.localEulerAngles.z = 0
				var_242_3.localEulerAngles.x = 0
				var_242_3.localEulerAngles = var_242_3.localEulerAngles
			end

			local var_242_5 = arg_239_1.actors_["1156ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_5) and arg_239_1.var_.characterEffect1156ui_story == nil then
				arg_239_1.var_.characterEffect1156ui_story = var_242_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_6 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_6 and not isNil(var_242_5) then
				if arg_239_1.var_.characterEffect1156ui_story and not isNil(var_242_5) then
					arg_239_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_6 and arg_239_1.time_ < 0 + var_242_6 + arg_242_0 and not isNil(var_242_5) and arg_239_1.var_.characterEffect1156ui_story then
				arg_239_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_242_8 = arg_239_1.actors_["10104ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_8) and arg_239_1.var_.characterEffect10104ui_story == nil then
				arg_239_1.var_.characterEffect10104ui_story = var_242_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_9 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_9 and not isNil(var_242_8) then
				if arg_239_1.var_.characterEffect10104ui_story and not isNil(var_242_8) then
					arg_239_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_239_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_9)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_9 and arg_239_1.time_ < 0 + var_242_9 + arg_242_0 and not isNil(var_242_8) and arg_239_1.var_.characterEffect10104ui_story then
				arg_239_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_239_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action8_1")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_242_10 = 0
			local var_242_11 = 0.275

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_12 = arg_239_1:GetWordFromCfg(322042057)
				local var_242_13 = arg_239_1:FormatText(var_242_12.content)

				arg_239_1.text_.text = var_242_13

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_15 = 11 <= 0 and var_242_11 or var_242_11 * (utf8.len(var_242_13) / 11)

				if (11 <= 0 and var_242_11 or var_242_11 * (utf8.len(var_242_13) / 11)) > 0 and var_242_11 < var_242_15 then
					arg_239_1.talkMaxDuration = var_242_15

					if var_242_15 + var_242_10 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_15 + var_242_10
					end
				end

				arg_239_1.text_.text = var_242_13
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042057", "story_v_out_322042.awb") ~= 0 then
					local var_242_16 = manager.audio:GetVoiceLength("story_v_out_322042", "322042057", "story_v_out_322042.awb") / 1000

					if var_242_16 + var_242_10 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_16 + var_242_10
					end

					if var_242_12.prefab_name ~= "" and arg_239_1.actors_[var_242_12.prefab_name] ~= nil then
						local var_242_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_12.prefab_name].transform, "story_v_out_322042", "322042057", "story_v_out_322042.awb")

						arg_239_1:RecordAudio("322042057", var_242_17)
						arg_239_1:RecordAudio("322042057", var_242_17)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_322042", "322042057", "story_v_out_322042.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_322042", "322042057", "story_v_out_322042.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_18 = math.max(var_242_11, arg_239_1.talkMaxDuration)

			if var_242_10 <= arg_239_1.time_ and arg_239_1.time_ < var_242_10 + var_242_18 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_10) / var_242_18

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_10 + var_242_18 and arg_239_1.time_ < var_242_10 + var_242_18 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play322042058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 322042058
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play322042059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0.3 < arg_243_1.time_ and arg_243_1.time_ <= 0.3 + arg_246_0 then
				arg_243_1:AudioAction("play", "effect", "se_story_145", "se_story_145_fire01", "")
			end

			local var_246_1 = arg_243_1.actors_["1156ui_story"].transform

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1156ui_story = var_246_1.localPosition
			end

			local var_246_2 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_2 then
				var_246_1.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_243_1.time_ - 0) / var_246_2)
				var_246_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_1.position).x, (manager.ui.mainCamera.transform.position - var_246_1.position).y, (manager.ui.mainCamera.transform.position - var_246_1.position).z)
				var_246_1.localEulerAngles.z = 0
				var_246_1.localEulerAngles.x = 0
				var_246_1.localEulerAngles = var_246_1.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_2 and arg_243_1.time_ < 0 + var_246_2 + arg_246_0 then
				var_246_1.localPosition = Vector3.New(0, 100, 0)
				var_246_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_1.position).x, (manager.ui.mainCamera.transform.position - var_246_1.position).y, (manager.ui.mainCamera.transform.position - var_246_1.position).z)
				var_246_1.localEulerAngles.z = 0
				var_246_1.localEulerAngles.x = 0
				var_246_1.localEulerAngles = var_246_1.localEulerAngles
			end

			local var_246_3 = 0
			local var_246_4 = 1.45

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_3 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_5 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(322042058).content)

				arg_243_1.text_.text = var_246_5

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_7 = 58 <= 0 and var_246_4 or var_246_4 * (utf8.len(var_246_5) / 58)

				if (58 <= 0 and var_246_4 or var_246_4 * (utf8.len(var_246_5) / 58)) > 0 and var_246_4 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_3 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_3
					end
				end

				arg_243_1.text_.text = var_246_5
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_8 = math.max(var_246_4, arg_243_1.talkMaxDuration)

			if var_246_3 <= arg_243_1.time_ and arg_243_1.time_ < var_246_3 + var_246_8 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_3) / var_246_8

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_3 + var_246_8 and arg_243_1.time_ < var_246_3 + var_246_8 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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

		arg_243_1:InitPlayNodeList()
	end,
	Play322042059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 322042059
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play322042060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 1.1

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_1 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(322042059).content)

				arg_247_1.text_.text = var_250_1

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_3 = 44 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 44)

				if (44 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 44)) > 0 and var_250_0 < var_250_3 then
					arg_247_1.talkMaxDuration = var_250_3

					if var_250_3 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_3 + 0
					end
				end

				arg_247_1.text_.text = var_250_1
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_4 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_4 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_4

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_4 and arg_247_1.time_ < 0 + var_250_4 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play322042060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 322042060
		arg_251_1.duration_ = 5.1

		local var_251_0 = {
			zh = 4.866,
			ja = 5.1
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play322042061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.475

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10150")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_1 = arg_251_1:GetWordFromCfg(322042060)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 19 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 19)

				if (19 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 19)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042060", "story_v_out_322042.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_322042", "322042060", "story_v_out_322042.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_322042", "322042060", "story_v_out_322042.awb")

						arg_251_1:RecordAudio("322042060", var_254_6)
						arg_251_1:RecordAudio("322042060", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_322042", "322042060", "story_v_out_322042.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_322042", "322042060", "story_v_out_322042.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_7 and arg_251_1.time_ < 0 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play322042061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 322042061
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play322042062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_9000

			if 0.225 < arg_255_1.time_ and arg_255_1.time_ <= 0.225 + arg_258_0 then
				arg_255_1:AudioAction("play", "effect", "se_story_145", "se_story_145_firework", "")
			end

			local var_258_1 = manager.ui.mainCamera.transform

			if 0.225 < arg_255_1.time_ and arg_255_1.time_ <= 0.225 + arg_258_0 then
				arg_255_1.var_.shakeOldPos = var_258_1.localPosition
			end

			local var_258_2 = 0.508333333333333

			if 0.225 <= arg_255_1.time_ and arg_255_1.time_ < 0.225 + var_258_2 then
				local var_258_3, var_258_4 = math.modf((arg_255_1.time_ - 0.225) / 0.132)

				var_258_1.localPosition = Vector3.New(var_258_4 * 0.13, var_258_4 * 0.13, var_258_4 * 0.13) + arg_255_1.var_.shakeOldPos
			end

			if arg_255_1.time_ >= 0.225 + var_258_2 and arg_255_1.time_ < 0.225 + var_258_2 + arg_258_0 then
				var_258_1.localPosition = arg_255_1.var_.shakeOldPos
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				local var_258_5 = arg_255_1.var_.effect2062

				if not arg_255_1.var_.effect2062 then
					var_258_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redtwister_keep"), manager.ui.mainCamera.transform)
					var_258_5.name = "2062"
					arg_255_1.var_.effect2062 = var_258_5
				else
					var_258_5.transform:SetParent(var_258_9000)
				end

				var_258_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_258_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_258_7 = 0
			local var_258_8 = 1.225

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_7 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_9 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(322042061).content)

				arg_255_1.text_.text = var_258_9

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_11 = 49 <= 0 and var_258_8 or var_258_8 * (utf8.len(var_258_9) / 49)

				if (49 <= 0 and var_258_8 or var_258_8 * (utf8.len(var_258_9) / 49)) > 0 and var_258_8 < var_258_11 then
					arg_255_1.talkMaxDuration = var_258_11

					if var_258_11 + var_258_7 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_11 + var_258_7
					end
				end

				arg_255_1.text_.text = var_258_9
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_12 = math.max(var_258_8, arg_255_1.talkMaxDuration)

			if var_258_7 <= arg_255_1.time_ and arg_255_1.time_ < var_258_7 + var_258_12 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_7) / var_258_12

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_7 + var_258_12 and arg_255_1.time_ < var_258_7 + var_258_12 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play322042062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 322042062
		arg_259_1.duration_ = 6.33

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play322042063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_9000

			if 0.333333333333333 < arg_259_1.time_ and arg_259_1.time_ <= 0.333333333333333 + arg_262_0 then
				arg_259_1:AudioAction("play", "effect", "se_story_145", "se_story_145_fall", "")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:AudioAction("play", "effect", "se_story_123_02", "se_story_123_02_fire", "")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				local var_262_2 = arg_259_1.var_.effect2062

				if not arg_259_1.var_.effect2062 then
					var_262_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redtwister_out"), manager.ui.mainCamera.transform)
					var_262_2.name = "2062"
					arg_259_1.var_.effect2062 = var_262_2
				else
					var_262_2.transform:SetParent(var_262_9000)
				end

				var_262_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_262_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_262_4 = manager.ui.mainCamera.transform

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.shakeOldPos = var_262_4.localPosition
			end

			local var_262_5 = 0.866666666666667

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_5 then
				local var_262_6, var_262_7 = math.modf((arg_259_1.time_ - 0) / 0.066)

				var_262_4.localPosition = Vector3.New(var_262_7 * 0.13, var_262_7 * 0.13, var_262_7 * 0.13) + arg_259_1.var_.shakeOldPos
			end

			if arg_259_1.time_ >= 0 + var_262_5 and arg_259_1.time_ < 0 + var_262_5 + arg_262_0 then
				var_262_4.localPosition = arg_259_1.var_.shakeOldPos
			end

			if arg_259_1.frameCnt_ <= 1 then
				arg_259_1.dialog_:SetActive(false)
			end

			local var_262_8 = 1.33333333333333
			local var_262_9 = 1.15

			if 1.33333333333333 < arg_259_1.time_ and arg_259_1.time_ <= var_262_8 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0

				arg_259_1.dialog_:SetActive(true)

				arg_259_1.dialogCg_.alpha = 0

				local var_262_10 = LeanTween.value(arg_259_1.dialog_, 0, 1, 0.3)

				var_262_10:setOnUpdate(LuaHelper.FloatAction(function(arg_263_0)
					arg_259_1.dialogCg_.alpha = arg_263_0
				end))
				var_262_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_259_1.dialog_)
					var_262_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_259_1.duration_ = arg_259_1.duration_ + 0.3

				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_11 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(322042062).content)

				arg_259_1.text_.text = var_262_11

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_13 = 46 <= 0 and var_262_9 or var_262_9 * (utf8.len(var_262_11) / 46)

				if (46 <= 0 and var_262_9 or var_262_9 * (utf8.len(var_262_11) / 46)) > 0 and var_262_9 < var_262_13 then
					arg_259_1.talkMaxDuration = var_262_13
					var_262_8 = var_262_8 + 0.3

					if var_262_13 + var_262_8 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_13 + var_262_8
					end
				end

				arg_259_1.text_.text = var_262_11
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_14 = var_262_8 + 0.3
			local var_262_15 = math.max(var_262_9, arg_259_1.talkMaxDuration)

			if var_262_8 + 0.3 <= arg_259_1.time_ and arg_259_1.time_ < var_262_14 + var_262_15 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_14) / var_262_15

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_14 + var_262_15 and arg_259_1.time_ < var_262_14 + var_262_15 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play322042063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 322042063
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play322042064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_9000

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				if arg_265_1.var_.effect2062 then
					Object.Destroy(arg_265_1.var_.effect2062)

					arg_265_1.var_.effect2062 = nil
				end
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				local var_268_1 = arg_265_1.var_.effect2063

				if not arg_265_1.var_.effect2063 then
					var_268_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redtwister_out"), manager.ui.mainCamera.transform)
					var_268_1.name = "2063"
					arg_265_1.var_.effect2063 = var_268_1
				else
					var_268_1.transform:SetParent(var_268_9000)
				end

				var_268_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_268_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:AudioAction("play", "effect", "se_story_145", "se_story_145_fire01", "")
			end

			local var_268_4 = 0
			local var_268_5 = 1.25

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_6 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(322042063).content)

				arg_265_1.text_.text = var_268_6

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_8 = 50 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_6) / 50)

				if (50 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_6) / 50)) > 0 and var_268_5 < var_268_8 then
					arg_265_1.talkMaxDuration = var_268_8

					if var_268_8 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_4
					end
				end

				arg_265_1.text_.text = var_268_6
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_9 = math.max(var_268_5, arg_265_1.talkMaxDuration)

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_9 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_4) / var_268_9

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_4 + var_268_9 and arg_265_1.time_ < var_268_4 + var_268_9 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play322042064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 322042064
		arg_269_1.duration_ = 3.9

		local var_269_0 = {
			zh = 2.666,
			ja = 3.9
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
				arg_269_0:Play322042065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1156ui_story = arg_269_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1156ui_story, Vector3.New(-0.9, -1.1, -6.18), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1156ui_story"].transform.position).z)
				arg_269_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1156ui_story"].transform.localEulerAngles = arg_269_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(-0.9, -1.1, -6.18)
				arg_269_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1156ui_story"].transform.position).z)
				arg_269_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1156ui_story"].transform.localEulerAngles = arg_269_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["1156ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1156ui_story == nil then
				arg_269_1.var_.characterEffect1156ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect1156ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1156ui_story then
				arg_269_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action2_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_272_4 = 0
			local var_272_5 = 0.275

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(322042064)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 11 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 11)

				if (11 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 11)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042064", "story_v_out_322042.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_out_322042", "322042064", "story_v_out_322042.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_out_322042", "322042064", "story_v_out_322042.awb")

						arg_269_1:RecordAudio("322042064", var_272_11)
						arg_269_1:RecordAudio("322042064", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_322042", "322042064", "story_v_out_322042.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_322042", "322042064", "story_v_out_322042.awb")
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
				actorName = "1156ui_story",
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
	Play322042065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 322042065
		arg_273_1.duration_ = 7.97

		local var_273_0 = {
			zh = 7.1,
			ja = 7.966
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
				arg_273_0:Play322042066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1284ui_story = arg_273_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1284ui_story"].transform.position).z)
				arg_273_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1284ui_story"].transform.localEulerAngles = arg_273_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
				arg_273_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1284ui_story"].transform.position).z)
				arg_273_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1284ui_story"].transform.localEulerAngles = arg_273_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_276_1 = arg_273_1.actors_["1284ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1284ui_story == nil then
				arg_273_1.var_.characterEffect1284ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 and not isNil(var_276_1) then
				if arg_273_1.var_.characterEffect1284ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1284ui_story then
				arg_273_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_276_4 = arg_273_1.actors_["1156ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_4) and arg_273_1.var_.characterEffect1156ui_story == nil then
				arg_273_1.var_.characterEffect1156ui_story = var_276_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_5 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_5 and not isNil(var_276_4) then
				if arg_273_1.var_.characterEffect1156ui_story and not isNil(var_276_4) then
					arg_273_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_5)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_5 and arg_273_1.time_ < 0 + var_276_5 + arg_276_0 and not isNil(var_276_4) and arg_273_1.var_.characterEffect1156ui_story then
				arg_273_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_276_6 = 0
			local var_276_7 = 0.925

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_8 = arg_273_1:GetWordFromCfg(322042065)
				local var_276_9 = arg_273_1:FormatText(var_276_8.content)

				arg_273_1.text_.text = var_276_9

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_11 = 37 <= 0 and var_276_7 or var_276_7 * (utf8.len(var_276_9) / 37)

				if (37 <= 0 and var_276_7 or var_276_7 * (utf8.len(var_276_9) / 37)) > 0 and var_276_7 < var_276_11 then
					arg_273_1.talkMaxDuration = var_276_11

					if var_276_11 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_11 + var_276_6
					end
				end

				arg_273_1.text_.text = var_276_9
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042065", "story_v_out_322042.awb") ~= 0 then
					local var_276_12 = manager.audio:GetVoiceLength("story_v_out_322042", "322042065", "story_v_out_322042.awb") / 1000

					if var_276_12 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_12 + var_276_6
					end

					if var_276_8.prefab_name ~= "" and arg_273_1.actors_[var_276_8.prefab_name] ~= nil then
						local var_276_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_8.prefab_name].transform, "story_v_out_322042", "322042065", "story_v_out_322042.awb")

						arg_273_1:RecordAudio("322042065", var_276_13)
						arg_273_1:RecordAudio("322042065", var_276_13)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_322042", "322042065", "story_v_out_322042.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_322042", "322042065", "story_v_out_322042.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_14 = math.max(var_276_7, arg_273_1.talkMaxDuration)

			if var_276_6 <= arg_273_1.time_ and arg_273_1.time_ < var_276_6 + var_276_14 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_6) / var_276_14

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_6 + var_276_14 and arg_273_1.time_ < var_276_6 + var_276_14 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play322042066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 322042066
		arg_277_1.duration_ = 2

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play322042067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos10104ui_story = arg_277_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10104ui_story, Vector3.New(-0.88, -1.12, -5.99), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10104ui_story"].transform.position).z)
				arg_277_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["10104ui_story"].transform.localEulerAngles = arg_277_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(-0.88, -1.12, -5.99)
				arg_277_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10104ui_story"].transform.position).z)
				arg_277_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["10104ui_story"].transform.localEulerAngles = arg_277_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_280_1 = arg_277_1.actors_["1156ui_story"].transform

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1156ui_story = var_280_1.localPosition
			end

			local var_280_2 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 then
				var_280_1.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_277_1.time_ - 0) / var_280_2)
				var_280_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_280_1.position).x, (manager.ui.mainCamera.transform.position - var_280_1.position).y, (manager.ui.mainCamera.transform.position - var_280_1.position).z)
				var_280_1.localEulerAngles.z = 0
				var_280_1.localEulerAngles.x = 0
				var_280_1.localEulerAngles = var_280_1.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 then
				var_280_1.localPosition = Vector3.New(0, 100, 0)
				var_280_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_280_1.position).x, (manager.ui.mainCamera.transform.position - var_280_1.position).y, (manager.ui.mainCamera.transform.position - var_280_1.position).z)
				var_280_1.localEulerAngles.z = 0
				var_280_1.localEulerAngles.x = 0
				var_280_1.localEulerAngles = var_280_1.localEulerAngles
			end

			local var_280_3 = arg_277_1.actors_["10104ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_3) and arg_277_1.var_.characterEffect10104ui_story == nil then
				arg_277_1.var_.characterEffect10104ui_story = var_280_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_4 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_4 and not isNil(var_280_3) then
				if arg_277_1.var_.characterEffect10104ui_story and not isNil(var_280_3) then
					arg_277_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_4 and arg_277_1.time_ < 0 + var_280_4 + arg_280_0 and not isNil(var_280_3) and arg_277_1.var_.characterEffect10104ui_story then
				arg_277_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_280_6 = arg_277_1.actors_["1284ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_6) and arg_277_1.var_.characterEffect1284ui_story == nil then
				arg_277_1.var_.characterEffect1284ui_story = var_280_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_7 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 and not isNil(var_280_6) then
				if arg_277_1.var_.characterEffect1284ui_story and not isNil(var_280_6) then
					arg_277_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_7)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 and not isNil(var_280_6) and arg_277_1.var_.characterEffect1284ui_story then
				arg_277_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action7_1")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_280_8 = 0
			local var_280_9 = 0.1

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_10 = arg_277_1:GetWordFromCfg(322042066)
				local var_280_11 = arg_277_1:FormatText(var_280_10.content)

				arg_277_1.text_.text = var_280_11

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_13 = 4 <= 0 and var_280_9 or var_280_9 * (utf8.len(var_280_11) / 4)

				if (4 <= 0 and var_280_9 or var_280_9 * (utf8.len(var_280_11) / 4)) > 0 and var_280_9 < var_280_13 then
					arg_277_1.talkMaxDuration = var_280_13

					if var_280_13 + var_280_8 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_13 + var_280_8
					end
				end

				arg_277_1.text_.text = var_280_11
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042066", "story_v_out_322042.awb") ~= 0 then
					local var_280_14 = manager.audio:GetVoiceLength("story_v_out_322042", "322042066", "story_v_out_322042.awb") / 1000

					if var_280_14 + var_280_8 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_14 + var_280_8
					end

					if var_280_10.prefab_name ~= "" and arg_277_1.actors_[var_280_10.prefab_name] ~= nil then
						local var_280_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_10.prefab_name].transform, "story_v_out_322042", "322042066", "story_v_out_322042.awb")

						arg_277_1:RecordAudio("322042066", var_280_15)
						arg_277_1:RecordAudio("322042066", var_280_15)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_322042", "322042066", "story_v_out_322042.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_322042", "322042066", "story_v_out_322042.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_16 = math.max(var_280_9, arg_277_1.talkMaxDuration)

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_16 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_8) / var_280_16

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_8 + var_280_16 and arg_277_1.time_ < var_280_8 + var_280_16 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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

		arg_277_1:InitPlayNodeList()
	end,
	Play322042067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 322042067
		arg_281_1.duration_ = 2

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play322042068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["1284ui_story"]) and arg_281_1.var_.characterEffect1284ui_story == nil then
				arg_281_1.var_.characterEffect1284ui_story = arg_281_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_0 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["1284ui_story"]) then
				if arg_281_1.var_.characterEffect1284ui_story and not isNil(arg_281_1.actors_["1284ui_story"]) then
					arg_281_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["1284ui_story"]) and arg_281_1.var_.characterEffect1284ui_story then
				arg_281_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_284_2 = arg_281_1.actors_["10104ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.characterEffect10104ui_story == nil then
				arg_281_1.var_.characterEffect10104ui_story = var_284_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_3 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_3 and not isNil(var_284_2) then
				if arg_281_1.var_.characterEffect10104ui_story and not isNil(var_284_2) then
					arg_281_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_281_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_3)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_3 and arg_281_1.time_ < 0 + var_284_3 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.characterEffect10104ui_story then
				arg_281_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_281_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action8_1")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_284_4 = 0
			local var_284_5 = 0.05

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_6 = arg_281_1:GetWordFromCfg(322042067)
				local var_284_7 = arg_281_1:FormatText(var_284_6.content)

				arg_281_1.text_.text = var_284_7

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_9 = 2 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 2)

				if (2 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 2)) > 0 and var_284_5 < var_284_9 then
					arg_281_1.talkMaxDuration = var_284_9

					if var_284_9 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_4
					end
				end

				arg_281_1.text_.text = var_284_7
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042067", "story_v_out_322042.awb") ~= 0 then
					local var_284_10 = manager.audio:GetVoiceLength("story_v_out_322042", "322042067", "story_v_out_322042.awb") / 1000

					if var_284_10 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_4
					end

					if var_284_6.prefab_name ~= "" and arg_281_1.actors_[var_284_6.prefab_name] ~= nil then
						local var_284_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_6.prefab_name].transform, "story_v_out_322042", "322042067", "story_v_out_322042.awb")

						arg_281_1:RecordAudio("322042067", var_284_11)
						arg_281_1:RecordAudio("322042067", var_284_11)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_322042", "322042067", "story_v_out_322042.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_322042", "322042067", "story_v_out_322042.awb")
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
	Play322042068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 322042068
		arg_285_1.duration_ = 5.57

		local var_285_0 = {
			zh = 4.066,
			ja = 5.566
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
				arg_285_0:Play322042069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["10104ui_story"]) and arg_285_1.var_.characterEffect10104ui_story == nil then
				arg_285_1.var_.characterEffect10104ui_story = arg_285_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["10104ui_story"]) then
				if arg_285_1.var_.characterEffect10104ui_story and not isNil(arg_285_1.actors_["10104ui_story"]) then
					arg_285_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["10104ui_story"]) and arg_285_1.var_.characterEffect10104ui_story then
				arg_285_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_288_2 = arg_285_1.actors_["1284ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect1284ui_story == nil then
				arg_285_1.var_.characterEffect1284ui_story = var_288_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_3 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_3 and not isNil(var_288_2) then
				if arg_285_1.var_.characterEffect1284ui_story and not isNil(var_288_2) then
					arg_285_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_3)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_3 and arg_285_1.time_ < 0 + var_288_3 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect1284ui_story then
				arg_285_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action7_2")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_288_4 = 0
			local var_288_5 = 0.625

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:GetWordFromCfg(322042068)
				local var_288_7 = arg_285_1:FormatText(var_288_6.content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 25 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 25)

				if (25 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 25)) > 0 and var_288_5 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042068", "story_v_out_322042.awb") ~= 0 then
					local var_288_10 = manager.audio:GetVoiceLength("story_v_out_322042", "322042068", "story_v_out_322042.awb") / 1000

					if var_288_10 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_4
					end

					if var_288_6.prefab_name ~= "" and arg_285_1.actors_[var_288_6.prefab_name] ~= nil then
						local var_288_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_6.prefab_name].transform, "story_v_out_322042", "322042068", "story_v_out_322042.awb")

						arg_285_1:RecordAudio("322042068", var_288_11)
						arg_285_1:RecordAudio("322042068", var_288_11)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_322042", "322042068", "story_v_out_322042.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_322042", "322042068", "story_v_out_322042.awb")
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
	Play322042069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 322042069
		arg_289_1.duration_ = 7

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play322042070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_9000

			if 1 < arg_289_1.time_ and arg_289_1.time_ <= 1 + arg_292_0 then
				arg_289_1.var_.moveOldPos10104ui_story = arg_289_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 1 <= arg_289_1.time_ and arg_289_1.time_ < 1 + var_292_0 then
				arg_289_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_289_1.time_ - 1) / var_292_0)
				arg_289_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10104ui_story"].transform.position).z)
				arg_289_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["10104ui_story"].transform.localEulerAngles = arg_289_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 1 + var_292_0 and arg_289_1.time_ < 1 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_289_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10104ui_story"].transform.position).z)
				arg_289_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["10104ui_story"].transform.localEulerAngles = arg_289_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_292_1 = arg_289_1.actors_["1284ui_story"].transform

			if 1 < arg_289_1.time_ and arg_289_1.time_ <= 1 + arg_292_0 then
				arg_289_1.var_.moveOldPos1284ui_story = var_292_1.localPosition
			end

			local var_292_2 = 0.001

			if 1 <= arg_289_1.time_ and arg_289_1.time_ < 1 + var_292_2 then
				var_292_1.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_289_1.time_ - 1) / var_292_2)
				var_292_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_1.position).x, (manager.ui.mainCamera.transform.position - var_292_1.position).y, (manager.ui.mainCamera.transform.position - var_292_1.position).z)
				var_292_1.localEulerAngles.z = 0
				var_292_1.localEulerAngles.x = 0
				var_292_1.localEulerAngles = var_292_1.localEulerAngles
			end

			if arg_289_1.time_ >= 1 + var_292_2 and arg_289_1.time_ < 1 + var_292_2 + arg_292_0 then
				var_292_1.localPosition = Vector3.New(0, 100, 0)
				var_292_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_1.position).x, (manager.ui.mainCamera.transform.position - var_292_1.position).y, (manager.ui.mainCamera.transform.position - var_292_1.position).z)
				var_292_1.localEulerAngles.z = 0
				var_292_1.localEulerAngles.x = 0
				var_292_1.localEulerAngles = var_292_1.localEulerAngles
			end

			if 2.03400000184774 < arg_289_1.time_ and arg_289_1.time_ <= 2.03400000184774 + arg_292_0 then
				arg_289_1:AudioAction("play", "effect", "se_story_145", "se_story_145_fire02", "")
			end

			if 1.03400000184774 < arg_289_1.time_ and arg_289_1.time_ <= 1.03400000184774 + arg_292_0 then
				local var_292_4 = arg_289_1.var_.effect2069

				if not arg_289_1.var_.effect2069 then
					var_292_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_burning"), manager.ui.mainCamera.transform)
					var_292_4.name = "2069"
					arg_289_1.var_.effect2069 = var_292_4
				else
					var_292_4.transform:SetParent(var_292_9000)
				end

				var_292_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_292_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_292_6 = 0

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_6 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_7 = 1

			if var_292_6 <= arg_289_1.time_ and arg_289_1.time_ < var_292_6 + var_292_7 then
				local var_292_8 = Color.New(0, 0, 0)

				var_292_8.a = Mathf.Lerp(0, 1, (arg_289_1.time_ - var_292_6) / var_292_7)
				arg_289_1.mask_.color = var_292_8
			end

			if arg_289_1.time_ >= var_292_6 + var_292_7 and arg_289_1.time_ < var_292_6 + var_292_7 + arg_292_0 then
				local var_292_9 = Color.New(0, 0, 0)

				var_292_9.a = 1
				arg_289_1.mask_.color = var_292_9
			end

			local var_292_10 = 1

			if 1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_11 = 1

			if var_292_10 <= arg_289_1.time_ and arg_289_1.time_ < var_292_10 + var_292_11 then
				local var_292_12 = Color.New(0, 0, 0)

				var_292_12.a = Mathf.Lerp(1, 0, (arg_289_1.time_ - var_292_10) / var_292_11)
				arg_289_1.mask_.color = var_292_12
			end

			if arg_289_1.time_ >= var_292_10 + var_292_11 and arg_289_1.time_ < var_292_10 + var_292_11 + arg_292_0 then
				local var_292_13 = Color.New(0, 0, 0)

				arg_289_1.mask_.enabled = false
				var_292_13.a = 0
				arg_289_1.mask_.color = var_292_13
			end

			local var_292_14 = "L10b"

			if arg_289_1.bgs_.L10b == nil then
				local var_292_15 = Object.Instantiate(arg_289_1.paintGo_)

				var_292_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_292_14)
				var_292_15.name = var_292_14
				var_292_15.transform.parent = arg_289_1.stage_.transform
				var_292_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_289_1.bgs_[var_292_14] = var_292_15
			end

			local var_292_16 = arg_289_1.bgs_.L10b.transform

			if 1 < arg_289_1.time_ and arg_289_1.time_ <= 1 + arg_292_0 then
				arg_289_1.var_.moveOldPosL10b = var_292_16.localPosition
			end

			local var_292_17 = 1

			if 1 <= arg_289_1.time_ and arg_289_1.time_ < 1 + var_292_17 then
				var_292_16.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPosL10b, Vector3.New(0, 0.5, 7), (arg_289_1.time_ - 1) / var_292_17)
			end

			if arg_289_1.time_ >= 1 + var_292_17 and arg_289_1.time_ < 1 + var_292_17 + arg_292_0 then
				var_292_16.localPosition = Vector3.New(0, 0.5, 7)
			end

			if 0.6 < arg_289_1.time_ and arg_289_1.time_ <= 0.6 + arg_292_0 then
				arg_289_1:AudioAction("play", "effect", "se_story_145", "se_story_145_fire04_loop", "")
			end

			if arg_289_1.frameCnt_ <= 1 then
				arg_289_1.dialog_:SetActive(false)
			end

			local var_292_19 = 2
			local var_292_20 = 1.8

			if 2 < arg_289_1.time_ and arg_289_1.time_ <= var_292_19 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0

				arg_289_1.dialog_:SetActive(true)

				arg_289_1.dialogCg_.alpha = 0

				local var_292_21 = LeanTween.value(arg_289_1.dialog_, 0, 1, 0.3)

				var_292_21:setOnUpdate(LuaHelper.FloatAction(function(arg_293_0)
					arg_289_1.dialogCg_.alpha = arg_293_0
				end))
				var_292_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_289_1.dialog_)
					var_292_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_289_1.duration_ = arg_289_1.duration_ + 0.3

				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_22 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(322042069).content)

				arg_289_1.text_.text = var_292_22

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_24 = 72 <= 0 and var_292_20 or var_292_20 * (utf8.len(var_292_22) / 72)

				if (72 <= 0 and var_292_20 or var_292_20 * (utf8.len(var_292_22) / 72)) > 0 and var_292_20 < var_292_24 then
					arg_289_1.talkMaxDuration = var_292_24
					var_292_19 = var_292_19 + 0.3

					if var_292_24 + var_292_19 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_24 + var_292_19
					end
				end

				arg_289_1.text_.text = var_292_22
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_25 = var_292_19 + 0.3
			local var_292_26 = math.max(var_292_20, arg_289_1.talkMaxDuration)

			if var_292_19 + 0.3 <= arg_289_1.time_ and arg_289_1.time_ < var_292_25 + var_292_26 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_25) / var_292_26

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_25 + var_292_26 and arg_289_1.time_ < var_292_25 + var_292_26 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "L10b",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 8),
					endPos = Vector3.New(0, 0.5, 7),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play322042070 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 322042070
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
			arg_295_1.auto_ = false
		end

		function arg_295_1.playNext_(arg_297_0)
			arg_295_1.onStoryFinished_()
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 1.275

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_1 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(322042070).content)

				arg_295_1.text_.text = var_298_1

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_3 = 51 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 51)

				if (51 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 51)) > 0 and var_298_0 < var_298_3 then
					arg_295_1.talkMaxDuration = var_298_3

					if var_298_3 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_3 + 0
					end
				end

				arg_295_1.text_.text = var_298_1
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_4 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_4 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_4

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_4 and arg_295_1.time_ < 0 + var_298_4 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L15f",
		"TextureConfig/Background/L15h"
	},
	voices = {
		"story_v_out_322042.awb"
	}
}
