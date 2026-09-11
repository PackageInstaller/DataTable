return {
	Play412071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 412071001
		arg_1_1.duration_ = 4.57

		local var_1_0 = {
			zh = 4.56600000298023,
			ja = 3.899999999999
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
				arg_1_0:Play412071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST85b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST85b")
				var_4_0.name = "ST85b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST85b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST85b

				arg_1_1.bgs_.ST85b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST85b" then
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

			local var_4_9 = "1097ui_story"

			if arg_1_1.actors_["1097ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1097ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1097ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1097ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1097ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1097ui_story == nil then
				arg_1_1.var_.characterEffect1097ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1097ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1097ui_story then
				arg_1_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
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

			if 0.266666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.266666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream")

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

			local var_4_24 = 2.00000000298023
			local var_4_25 = 0.25

			if 2.00000000298023 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(412071001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 10 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 10)

				if (10 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 10)) > 0 and var_4_25 < var_4_30 then
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

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071001", "story_v_out_412071.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_412071", "412071001", "story_v_out_412071.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_412071", "412071001", "story_v_out_412071.awb")

						arg_1_1:RecordAudio("412071001", var_4_32)
						arg_1_1:RecordAudio("412071001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_412071", "412071001", "story_v_out_412071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_412071", "412071001", "story_v_out_412071.awb")
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
				actorName = "1097ui_story",
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
	Play412071002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 412071002
		arg_9_1.duration_ = 2.2

		local var_9_0 = {
			zh = 1.999999999999,
			ja = 2.2
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
				arg_9_0:Play412071003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10078ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "10078ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "10078ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["10078ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["10078ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["10078ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["10078ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["10078ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10078ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10078ui_story, Vector3.New(0.7, -0.5, -6.3), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["10078ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10078ui_story == nil then
				arg_9_1.var_.characterEffect10078ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect10078ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10078ui_story then
				arg_9_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_8 = arg_9_1.actors_["1097ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.characterEffect1097ui_story == nil then
				arg_9_1.var_.characterEffect1097ui_story = var_12_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_9 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 and not isNil(var_12_8) then
				if arg_9_1.var_.characterEffect1097ui_story and not isNil(var_12_8) then
					arg_9_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_9)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.characterEffect1097ui_story then
				arg_9_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_12_10 = 0
			local var_12_11 = 0.05

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_12 = arg_9_1:GetWordFromCfg(412071002)
				local var_12_13 = arg_9_1:FormatText(var_12_12.content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 2 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 2)

				if (2 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 2)) > 0 and var_12_11 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_13
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071002", "story_v_out_412071.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_412071", "412071002", "story_v_out_412071.awb") / 1000

					if var_12_16 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_10
					end

					if var_12_12.prefab_name ~= "" and arg_9_1.actors_[var_12_12.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_12.prefab_name].transform, "story_v_out_412071", "412071002", "story_v_out_412071.awb")

						arg_9_1:RecordAudio("412071002", var_12_17)
						arg_9_1:RecordAudio("412071002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_412071", "412071002", "story_v_out_412071.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_412071", "412071002", "story_v_out_412071.awb")
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
				actorName = "10078ui_story",
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
	Play412071003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 412071003
		arg_13_1.duration_ = 10.63

		local var_13_0 = {
			zh = 7.9,
			ja = 10.633
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
				arg_13_0:Play412071004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1097ui_story"]) and arg_13_1.var_.characterEffect1097ui_story == nil then
				arg_13_1.var_.characterEffect1097ui_story = arg_13_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1097ui_story"]) then
				if arg_13_1.var_.characterEffect1097ui_story and not isNil(arg_13_1.actors_["1097ui_story"]) then
					arg_13_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1097ui_story"]) and arg_13_1.var_.characterEffect1097ui_story then
				arg_13_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_2 = arg_13_1.actors_["10078ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.characterEffect10078ui_story == nil then
				arg_13_1.var_.characterEffect10078ui_story = var_16_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_3 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.characterEffect10078ui_story and not isNil(var_16_2) then
					arg_13_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_3)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.characterEffect10078ui_story then
				arg_13_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_16_4 = 0
			local var_16_5 = 0.675

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(412071003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 27 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 27)

				if (27 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 27)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071003", "story_v_out_412071.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_412071", "412071003", "story_v_out_412071.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_out_412071", "412071003", "story_v_out_412071.awb")

						arg_13_1:RecordAudio("412071003", var_16_11)
						arg_13_1:RecordAudio("412071003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_412071", "412071003", "story_v_out_412071.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_412071", "412071003", "story_v_out_412071.awb")
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
	Play412071004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 412071004
		arg_17_1.duration_ = 7.17

		local var_17_0 = {
			zh = 7.1,
			ja = 7.166
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
				arg_17_0:Play412071005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10078ui_story"]) and arg_17_1.var_.characterEffect10078ui_story == nil then
				arg_17_1.var_.characterEffect10078ui_story = arg_17_1.actors_["10078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10078ui_story"]) then
				if arg_17_1.var_.characterEffect10078ui_story and not isNil(arg_17_1.actors_["10078ui_story"]) then
					arg_17_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10078ui_story"]) and arg_17_1.var_.characterEffect10078ui_story then
				arg_17_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_2 = arg_17_1.actors_["1097ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.characterEffect1097ui_story == nil then
				arg_17_1.var_.characterEffect1097ui_story = var_20_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_3 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.characterEffect1097ui_story and not isNil(var_20_2) then
					arg_17_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_3)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.characterEffect1097ui_story then
				arg_17_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_20_4 = 0
			local var_20_5 = 0.55

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(412071004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 22 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 22)

				if (22 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 22)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071004", "story_v_out_412071.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_412071", "412071004", "story_v_out_412071.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_412071", "412071004", "story_v_out_412071.awb")

						arg_17_1:RecordAudio("412071004", var_20_11)
						arg_17_1:RecordAudio("412071004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_412071", "412071004", "story_v_out_412071.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_412071", "412071004", "story_v_out_412071.awb")
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
	Play412071005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 412071005
		arg_21_1.duration_ = 7.3

		local var_21_0 = {
			zh = 7.3,
			ja = 5.533
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
				arg_21_0:Play412071006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.5

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(412071005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 20 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 20)

				if (20 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 20)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071005", "story_v_out_412071.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_412071", "412071005", "story_v_out_412071.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_412071", "412071005", "story_v_out_412071.awb")

						arg_21_1:RecordAudio("412071005", var_24_6)
						arg_21_1:RecordAudio("412071005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_412071", "412071005", "story_v_out_412071.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_412071", "412071005", "story_v_out_412071.awb")
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
	Play412071006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 412071006
		arg_25_1.duration_ = 8.5

		local var_25_0 = {
			zh = 6.333,
			ja = 8.5
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
				arg_25_0:Play412071007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1097ui_story"]) and arg_25_1.var_.characterEffect1097ui_story == nil then
				arg_25_1.var_.characterEffect1097ui_story = arg_25_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1097ui_story"]) then
				if arg_25_1.var_.characterEffect1097ui_story and not isNil(arg_25_1.actors_["1097ui_story"]) then
					arg_25_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1097ui_story"]) and arg_25_1.var_.characterEffect1097ui_story then
				arg_25_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_2 = arg_25_1.actors_["10078ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect10078ui_story == nil then
				arg_25_1.var_.characterEffect10078ui_story = var_28_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_3 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.characterEffect10078ui_story and not isNil(var_28_2) then
					arg_25_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_3)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect10078ui_story then
				arg_25_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_28_4 = 0
			local var_28_5 = 0.575

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(412071006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 23 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 23)

				if (23 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 23)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071006", "story_v_out_412071.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_412071", "412071006", "story_v_out_412071.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_412071", "412071006", "story_v_out_412071.awb")

						arg_25_1:RecordAudio("412071006", var_28_11)
						arg_25_1:RecordAudio("412071006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_412071", "412071006", "story_v_out_412071.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_412071", "412071006", "story_v_out_412071.awb")
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
	Play412071007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 412071007
		arg_29_1.duration_ = 6.9

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play412071008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.bgs_.STwhite == nil then
				local var_32_0 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_32_0.name = "STwhite"
				var_32_0.transform.parent = arg_29_1.stage_.transform
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_.STwhite = var_32_0
			end

			if 1 < arg_29_1.time_ and arg_29_1.time_ <= 1 + arg_32_0 then
				local var_32_1 = arg_29_1.bgs_.STwhite

				arg_29_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_32_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_2 = var_32_1:GetComponent("SpriteRenderer")

				if var_32_2 and var_32_2.sprite then
					local var_32_3 = 2 * (var_32_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_32_1.transform.localScale = Vector3.New(var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "STwhite" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_4 = arg_29_1.actors_["1097ui_story"].transform

			if 0.965999998152256 < arg_29_1.time_ and arg_29_1.time_ <= 0.965999998152256 + arg_32_0 then
				arg_29_1.var_.moveOldPos1097ui_story = var_32_4.localPosition
			end

			local var_32_5 = 0.001

			if 0.965999998152256 <= arg_29_1.time_ and arg_29_1.time_ < 0.965999998152256 + var_32_5 then
				var_32_4.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0.965999998152256) / var_32_5)
				var_32_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_4.position).x, (manager.ui.mainCamera.transform.position - var_32_4.position).y, (manager.ui.mainCamera.transform.position - var_32_4.position).z)
				var_32_4.localEulerAngles.z = 0
				var_32_4.localEulerAngles.x = 0
				var_32_4.localEulerAngles = var_32_4.localEulerAngles
			end

			if arg_29_1.time_ >= 0.965999998152256 + var_32_5 and arg_29_1.time_ < 0.965999998152256 + var_32_5 + arg_32_0 then
				var_32_4.localPosition = Vector3.New(0, 100, 0)
				var_32_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_4.position).x, (manager.ui.mainCamera.transform.position - var_32_4.position).y, (manager.ui.mainCamera.transform.position - var_32_4.position).z)
				var_32_4.localEulerAngles.z = 0
				var_32_4.localEulerAngles.x = 0
				var_32_4.localEulerAngles = var_32_4.localEulerAngles
			end

			local var_32_6 = arg_29_1.actors_["1097ui_story"]

			if 0.965999998152256 < arg_29_1.time_ and arg_29_1.time_ <= 0.965999998152256 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect1097ui_story == nil then
				arg_29_1.var_.characterEffect1097ui_story = var_32_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_7 = 0.034000001847744

			if 0.965999998152256 <= arg_29_1.time_ and arg_29_1.time_ < 0.965999998152256 + var_32_7 and not isNil(var_32_6) then
				if arg_29_1.var_.characterEffect1097ui_story and not isNil(var_32_6) then
					arg_29_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0.965999998152256) / var_32_7)
				end
			end

			if arg_29_1.time_ >= 0.965999998152256 + var_32_7 and arg_29_1.time_ < 0.965999998152256 + var_32_7 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect1097ui_story then
				arg_29_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_32_8 = arg_29_1.actors_["10078ui_story"].transform

			if 0.965999998152256 < arg_29_1.time_ and arg_29_1.time_ <= 0.965999998152256 + arg_32_0 then
				arg_29_1.var_.moveOldPos10078ui_story = var_32_8.localPosition
			end

			local var_32_9 = 0.001

			if 0.965999998152256 <= arg_29_1.time_ and arg_29_1.time_ < 0.965999998152256 + var_32_9 then
				var_32_8.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0.965999998152256) / var_32_9)
				var_32_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_8.position).x, (manager.ui.mainCamera.transform.position - var_32_8.position).y, (manager.ui.mainCamera.transform.position - var_32_8.position).z)
				var_32_8.localEulerAngles.z = 0
				var_32_8.localEulerAngles.x = 0
				var_32_8.localEulerAngles = var_32_8.localEulerAngles
			end

			if arg_29_1.time_ >= 0.965999998152256 + var_32_9 and arg_29_1.time_ < 0.965999998152256 + var_32_9 + arg_32_0 then
				var_32_8.localPosition = Vector3.New(0, 100, 0)
				var_32_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_8.position).x, (manager.ui.mainCamera.transform.position - var_32_8.position).y, (manager.ui.mainCamera.transform.position - var_32_8.position).z)
				var_32_8.localEulerAngles.z = 0
				var_32_8.localEulerAngles.x = 0
				var_32_8.localEulerAngles = var_32_8.localEulerAngles
			end

			local var_32_10 = arg_29_1.actors_["10078ui_story"]

			if 0.965999998152256 < arg_29_1.time_ and arg_29_1.time_ <= 0.965999998152256 + arg_32_0 and not isNil(var_32_10) and arg_29_1.var_.characterEffect10078ui_story == nil then
				arg_29_1.var_.characterEffect10078ui_story = var_32_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.034000001847744

			if 0.965999998152256 <= arg_29_1.time_ and arg_29_1.time_ < 0.965999998152256 + var_32_11 and not isNil(var_32_10) then
				if arg_29_1.var_.characterEffect10078ui_story and not isNil(var_32_10) then
					arg_29_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0.965999998152256) / var_32_11)
				end
			end

			if arg_29_1.time_ >= 0.965999998152256 + var_32_11 and arg_29_1.time_ < 0.965999998152256 + var_32_11 + arg_32_0 and not isNil(var_32_10) and arg_29_1.var_.characterEffect10078ui_story then
				arg_29_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_32_12 = 0

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_13 = 1

			if var_32_12 <= arg_29_1.time_ and arg_29_1.time_ < var_32_12 + var_32_13 then
				local var_32_14 = Color.New(1, 1, 1)

				var_32_14.a = Mathf.Lerp(0, 1, (arg_29_1.time_ - var_32_12) / var_32_13)
				arg_29_1.mask_.color = var_32_14
			end

			if arg_29_1.time_ >= var_32_12 + var_32_13 and arg_29_1.time_ < var_32_12 + var_32_13 + arg_32_0 then
				local var_32_15 = Color.New(1, 1, 1)

				var_32_15.a = 1
				arg_29_1.mask_.color = var_32_15
			end

			local var_32_16 = 1

			if 1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_17 = 1

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_17 then
				local var_32_18 = Color.New(1, 1, 1)

				var_32_18.a = Mathf.Lerp(1, 0, (arg_29_1.time_ - var_32_16) / var_32_17)
				arg_29_1.mask_.color = var_32_18
			end

			if arg_29_1.time_ >= var_32_16 + var_32_17 and arg_29_1.time_ < var_32_16 + var_32_17 + arg_32_0 then
				local var_32_19 = Color.New(1, 1, 1)

				arg_29_1.mask_.enabled = false
				var_32_19.a = 0
				arg_29_1.mask_.color = var_32_19
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_20 = 1.9
			local var_32_21 = 1.025

			if 1.9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_20 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_22 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_22:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_23 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(412071007).content)

				arg_29_1.text_.text = var_32_23

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_25 = 40 <= 0 and var_32_21 or var_32_21 * (utf8.len(var_32_23) / 40)

				if (40 <= 0 and var_32_21 or var_32_21 * (utf8.len(var_32_23) / 40)) > 0 and var_32_21 < var_32_25 then
					arg_29_1.talkMaxDuration = var_32_25
					var_32_20 = var_32_20 + 0.3

					if var_32_25 + var_32_20 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_25 + var_32_20
					end
				end

				arg_29_1.text_.text = var_32_23
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_26 = var_32_20 + 0.3
			local var_32_27 = math.max(var_32_21, arg_29_1.talkMaxDuration)

			if var_32_20 + 0.3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_26 + var_32_27 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_26) / var_32_27

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_26 + var_32_27 and arg_29_1.time_ < var_32_26 + var_32_27 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152256,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152256,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play412071008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 412071008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play412071009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.375

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_1 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(412071008).content)

				arg_35_1.text_.text = var_38_1

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_3 = 15 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 15)

				if (15 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 15)) > 0 and var_38_0 < var_38_3 then
					arg_35_1.talkMaxDuration = var_38_3

					if var_38_3 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_3 + 0
					end
				end

				arg_35_1.text_.text = var_38_1
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_4 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_4

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play412071009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 412071009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play412071010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.65

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(412071009).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 26 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 26)

				if (26 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 26)) > 0 and var_42_0 < var_42_3 then
					arg_39_1.talkMaxDuration = var_42_3

					if var_42_3 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_3 + 0
					end
				end

				arg_39_1.text_.text = var_42_1
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_4 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_4

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play412071010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 412071010
		arg_43_1.duration_ = 4

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play412071011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 2 < arg_43_1.time_ and arg_43_1.time_ <= 2 + arg_46_0 then
				arg_43_1.var_.moveOldPos1097ui_story = arg_43_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 2 <= arg_43_1.time_ and arg_43_1.time_ < 2 + var_46_0 then
				arg_43_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_43_1.time_ - 2) / var_46_0)
				arg_43_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1097ui_story"].transform.position).z)
				arg_43_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1097ui_story"].transform.localEulerAngles = arg_43_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 2 + var_46_0 and arg_43_1.time_ < 2 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_43_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1097ui_story"].transform.position).z)
				arg_43_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1097ui_story"].transform.localEulerAngles = arg_43_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["1097ui_story"]

			if 2 < arg_43_1.time_ and arg_43_1.time_ <= 2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1097ui_story == nil then
				arg_43_1.var_.characterEffect1097ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if 2 <= arg_43_1.time_ and arg_43_1.time_ < 2 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect1097ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 2 + var_46_2 and arg_43_1.time_ < 2 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1097ui_story then
				arg_43_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 2 < arg_43_1.time_ and arg_43_1.time_ <= 2 + arg_46_0 then
				arg_43_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 2 < arg_43_1.time_ and arg_43_1.time_ <= 2 + arg_46_0 then
				arg_43_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				local var_46_4 = arg_43_1.bgs_.ST85b

				arg_43_1.bgs_.ST85b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_46_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_46_5 = var_46_4:GetComponent("SpriteRenderer")

				if var_46_5 and var_46_5.sprite then
					local var_46_6 = 2 * (var_46_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_46_4.transform.localScale = Vector3.New(var_46_6 / var_46_5.sprite.bounds.size.y < var_46_6 * manager.ui.mainCameraCom_.aspect / var_46_5.sprite.bounds.size.x and var_46_6 * manager.ui.mainCameraCom_.aspect / var_46_5.sprite.bounds.size.x or var_46_6 / var_46_5.sprite.bounds.size.y, var_46_6 / var_46_5.sprite.bounds.size.y < var_46_6 * manager.ui.mainCameraCom_.aspect / var_46_5.sprite.bounds.size.x and var_46_6 * manager.ui.mainCameraCom_.aspect / var_46_5.sprite.bounds.size.x or var_46_6 / var_46_5.sprite.bounds.size.y, 0)
				end

				for iter_46_0, iter_46_1 in pairs(arg_43_1.bgs_) do
					if iter_46_0 ~= "ST85b" then
						iter_46_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_46_7 = 0

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_7 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_8 = 2

			if var_46_7 <= arg_43_1.time_ and arg_43_1.time_ < var_46_7 + var_46_8 then
				local var_46_9 = Color.New(1, 1, 1)

				var_46_9.a = Mathf.Lerp(1, 0, (arg_43_1.time_ - var_46_7) / var_46_8)
				arg_43_1.mask_.color = var_46_9
			end

			if arg_43_1.time_ >= var_46_7 + var_46_8 and arg_43_1.time_ < var_46_7 + var_46_8 + arg_46_0 then
				local var_46_10 = Color.New(1, 1, 1)

				arg_43_1.mask_.enabled = false
				var_46_10.a = 0
				arg_43_1.mask_.color = var_46_10
			end

			if arg_43_1.frameCnt_ <= 1 then
				arg_43_1.dialog_:SetActive(false)
			end

			local var_46_11 = 2
			local var_46_12 = 0.125

			if 2 < arg_43_1.time_ and arg_43_1.time_ <= var_46_11 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_13 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_13:setOnUpdate(LuaHelper.FloatAction(function(arg_47_0)
					arg_43_1.dialogCg_.alpha = arg_47_0
				end))
				var_46_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_14 = arg_43_1:GetWordFromCfg(412071010)
				local var_46_15 = arg_43_1:FormatText(var_46_14.content)

				arg_43_1.text_.text = var_46_15

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_17 = 5 <= 0 and var_46_12 or var_46_12 * (utf8.len(var_46_15) / 5)

				if (5 <= 0 and var_46_12 or var_46_12 * (utf8.len(var_46_15) / 5)) > 0 and var_46_12 < var_46_17 then
					arg_43_1.talkMaxDuration = var_46_17
					var_46_11 = var_46_11 + 0.3

					if var_46_17 + var_46_11 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_17 + var_46_11
					end
				end

				arg_43_1.text_.text = var_46_15
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071010", "story_v_out_412071.awb") ~= 0 then
					local var_46_18 = manager.audio:GetVoiceLength("story_v_out_412071", "412071010", "story_v_out_412071.awb") / 1000

					if var_46_18 + var_46_11 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_18 + var_46_11
					end

					if var_46_14.prefab_name ~= "" and arg_43_1.actors_[var_46_14.prefab_name] ~= nil then
						local var_46_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_14.prefab_name].transform, "story_v_out_412071", "412071010", "story_v_out_412071.awb")

						arg_43_1:RecordAudio("412071010", var_46_19)
						arg_43_1:RecordAudio("412071010", var_46_19)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_412071", "412071010", "story_v_out_412071.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_412071", "412071010", "story_v_out_412071.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_20 = var_46_11 + 0.3
			local var_46_21 = math.max(var_46_12, arg_43_1.talkMaxDuration)

			if var_46_11 + 0.3 <= arg_43_1.time_ and arg_43_1.time_ < var_46_20 + var_46_21 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_20) / var_46_21

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_20 + var_46_21 and arg_43_1.time_ < var_46_20 + var_46_21 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play412071011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 412071011
		arg_49_1.duration_ = 7.77

		local var_49_0 = {
			zh = 7.766,
			ja = 6.8
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
				arg_49_0:Play412071012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10078ui_story = arg_49_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10078ui_story, Vector3.New(0.7, -0.5, -6.3), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10078ui_story"].transform.position).z)
				arg_49_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10078ui_story"].transform.localEulerAngles = arg_49_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0.7, -0.5, -6.3)
				arg_49_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10078ui_story"].transform.position).z)
				arg_49_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10078ui_story"].transform.localEulerAngles = arg_49_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["10078ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10078ui_story == nil then
				arg_49_1.var_.characterEffect10078ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect10078ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10078ui_story then
				arg_49_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_4 = arg_49_1.actors_["1097ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1097ui_story == nil then
				arg_49_1.var_.characterEffect1097ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_5 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_5 and not isNil(var_52_4) then
				if arg_49_1.var_.characterEffect1097ui_story and not isNil(var_52_4) then
					arg_49_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_5)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_5 and arg_49_1.time_ < 0 + var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1097ui_story then
				arg_49_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_52_6 = 0
			local var_52_7 = 0.6

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(412071011)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 24 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 24)

				if (24 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 24)) > 0 and var_52_7 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071011", "story_v_out_412071.awb") ~= 0 then
					local var_52_12 = manager.audio:GetVoiceLength("story_v_out_412071", "412071011", "story_v_out_412071.awb") / 1000

					if var_52_12 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_6
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_out_412071", "412071011", "story_v_out_412071.awb")

						arg_49_1:RecordAudio("412071011", var_52_13)
						arg_49_1:RecordAudio("412071011", var_52_13)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_412071", "412071011", "story_v_out_412071.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_412071", "412071011", "story_v_out_412071.awb")
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
				actorName = "10078ui_story",
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
	Play412071012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 412071012
		arg_53_1.duration_ = 12.43

		local var_53_0 = {
			zh = 8.433,
			ja = 12.433
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
				arg_53_0:Play412071013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_56_0 = 0
			local var_56_1 = 0.575

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_2 = arg_53_1:GetWordFromCfg(412071012)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 23 <= 0 and var_56_1 or var_56_1 * (utf8.len(var_56_3) / 23)

				if (23 <= 0 and var_56_1 or var_56_1 * (utf8.len(var_56_3) / 23)) > 0 and var_56_1 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071012", "story_v_out_412071.awb") ~= 0 then
					local var_56_6 = manager.audio:GetVoiceLength("story_v_out_412071", "412071012", "story_v_out_412071.awb") / 1000

					if var_56_6 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_0
					end

					if var_56_2.prefab_name ~= "" and arg_53_1.actors_[var_56_2.prefab_name] ~= nil then
						local var_56_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_2.prefab_name].transform, "story_v_out_412071", "412071012", "story_v_out_412071.awb")

						arg_53_1:RecordAudio("412071012", var_56_7)
						arg_53_1:RecordAudio("412071012", var_56_7)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_412071", "412071012", "story_v_out_412071.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_412071", "412071012", "story_v_out_412071.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_8 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_8 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_8

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_8 and arg_53_1.time_ < var_56_0 + var_56_8 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play412071013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 412071013
		arg_57_1.duration_ = 6.9

		local var_57_0 = {
			zh = 6.9,
			ja = 6.766
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
				arg_57_0:Play412071014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1097ui_story = arg_57_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).z)
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles = arg_57_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_57_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).z)
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles = arg_57_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1097ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1097ui_story == nil then
				arg_57_1.var_.characterEffect1097ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1097ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1097ui_story then
				arg_57_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_4 = arg_57_1.actors_["10078ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect10078ui_story == nil then
				arg_57_1.var_.characterEffect10078ui_story = var_60_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_5 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_5 and not isNil(var_60_4) then
				if arg_57_1.var_.characterEffect10078ui_story and not isNil(var_60_4) then
					arg_57_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_57_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_5)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_5 and arg_57_1.time_ < 0 + var_60_5 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect10078ui_story then
				arg_57_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_57_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_60_6 = 0
			local var_60_7 = 0.675

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(412071013)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 27 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 27)

				if (27 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 27)) > 0 and var_60_7 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071013", "story_v_out_412071.awb") ~= 0 then
					local var_60_12 = manager.audio:GetVoiceLength("story_v_out_412071", "412071013", "story_v_out_412071.awb") / 1000

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end

					if var_60_8.prefab_name ~= "" and arg_57_1.actors_[var_60_8.prefab_name] ~= nil then
						local var_60_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_8.prefab_name].transform, "story_v_out_412071", "412071013", "story_v_out_412071.awb")

						arg_57_1:RecordAudio("412071013", var_60_13)
						arg_57_1:RecordAudio("412071013", var_60_13)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_412071", "412071013", "story_v_out_412071.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_412071", "412071013", "story_v_out_412071.awb")
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

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play412071014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 412071014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play412071015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1097ui_story = arg_61_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1097ui_story"].transform.position).z)
				arg_61_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1097ui_story"].transform.localEulerAngles = arg_61_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1097ui_story"].transform.position).z)
				arg_61_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1097ui_story"].transform.localEulerAngles = arg_61_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1097ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1097ui_story == nil then
				arg_61_1.var_.characterEffect1097ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1097ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_2)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1097ui_story then
				arg_61_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_64_3 = arg_61_1.actors_["10078ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10078ui_story = var_64_3.localPosition
			end

			local var_64_4 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				var_64_3.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_4)
				var_64_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_3.position).x, (manager.ui.mainCamera.transform.position - var_64_3.position).y, (manager.ui.mainCamera.transform.position - var_64_3.position).z)
				var_64_3.localEulerAngles.z = 0
				var_64_3.localEulerAngles.x = 0
				var_64_3.localEulerAngles = var_64_3.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				var_64_3.localPosition = Vector3.New(0, 100, 0)
				var_64_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_3.position).x, (manager.ui.mainCamera.transform.position - var_64_3.position).y, (manager.ui.mainCamera.transform.position - var_64_3.position).z)
				var_64_3.localEulerAngles.z = 0
				var_64_3.localEulerAngles.x = 0
				var_64_3.localEulerAngles = var_64_3.localEulerAngles
			end

			local var_64_5 = arg_61_1.actors_["10078ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect10078ui_story == nil then
				arg_61_1.var_.characterEffect10078ui_story = var_64_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_6 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_6 and not isNil(var_64_5) then
				if arg_61_1.var_.characterEffect10078ui_story and not isNil(var_64_5) then
					arg_61_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_6)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_6 and arg_61_1.time_ < 0 + var_64_6 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect10078ui_story then
				arg_61_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_64_7 = 0
			local var_64_8 = 1.025

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_7 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_9 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(412071014).content)

				arg_61_1.text_.text = var_64_9

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 41 <= 0 and var_64_8 or var_64_8 * (utf8.len(var_64_9) / 41)

				if (41 <= 0 and var_64_8 or var_64_8 * (utf8.len(var_64_9) / 41)) > 0 and var_64_8 < var_64_11 then
					arg_61_1.talkMaxDuration = var_64_11

					if var_64_11 + var_64_7 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_7
					end
				end

				arg_61_1.text_.text = var_64_9
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_8, arg_61_1.talkMaxDuration)

			if var_64_7 <= arg_61_1.time_ and arg_61_1.time_ < var_64_7 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_7) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_7 + var_64_12 and arg_61_1.time_ < var_64_7 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play412071015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 412071015
		arg_65_1.duration_ = 4.67

		local var_65_0 = {
			zh = 1.999999999999,
			ja = 4.666
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
				arg_65_0:Play412071016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1097ui_story = arg_65_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1097ui_story"].transform.position).z)
				arg_65_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1097ui_story"].transform.localEulerAngles = arg_65_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_65_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1097ui_story"].transform.position).z)
				arg_65_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1097ui_story"].transform.localEulerAngles = arg_65_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1097ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1097ui_story == nil then
				arg_65_1.var_.characterEffect1097ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1097ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1097ui_story then
				arg_65_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_68_4 = 0
			local var_68_5 = 0.2

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(412071015)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 8 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 8)

				if (8 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 8)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071015", "story_v_out_412071.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_412071", "412071015", "story_v_out_412071.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_412071", "412071015", "story_v_out_412071.awb")

						arg_65_1:RecordAudio("412071015", var_68_11)
						arg_65_1:RecordAudio("412071015", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_412071", "412071015", "story_v_out_412071.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_412071", "412071015", "story_v_out_412071.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play412071016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 412071016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play412071017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1097ui_story = arg_69_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1097ui_story"].transform.position).z)
				arg_69_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1097ui_story"].transform.localEulerAngles = arg_69_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1097ui_story"].transform.position).z)
				arg_69_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1097ui_story"].transform.localEulerAngles = arg_69_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1097ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1097ui_story == nil then
				arg_69_1.var_.characterEffect1097ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1097ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_2)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1097ui_story then
				arg_69_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_72_3 = 0
			local var_72_4 = 1.475

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_3 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_5 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(412071016).content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 59 <= 0 and var_72_4 or var_72_4 * (utf8.len(var_72_5) / 59)

				if (59 <= 0 and var_72_4 or var_72_4 * (utf8.len(var_72_5) / 59)) > 0 and var_72_4 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_3 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_3
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_8 = math.max(var_72_4, arg_69_1.talkMaxDuration)

			if var_72_3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_3 + var_72_8 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_3) / var_72_8

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_3 + var_72_8 and arg_69_1.time_ < var_72_3 + var_72_8 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play412071017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 412071017
		arg_73_1.duration_ = 4.9

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play412071018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10078ui_story = arg_73_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10078ui_story"].transform.position).z)
				arg_73_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["10078ui_story"].transform.localEulerAngles = arg_73_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_73_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10078ui_story"].transform.position).z)
				arg_73_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["10078ui_story"].transform.localEulerAngles = arg_73_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["10078ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect10078ui_story == nil then
				arg_73_1.var_.characterEffect10078ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect10078ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect10078ui_story then
				arg_73_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_4 = 0
			local var_76_5 = 0.3

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(412071017)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 12 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 12)

				if (12 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 12)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071017", "story_v_out_412071.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_412071", "412071017", "story_v_out_412071.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_412071", "412071017", "story_v_out_412071.awb")

						arg_73_1:RecordAudio("412071017", var_76_11)
						arg_73_1:RecordAudio("412071017", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_412071", "412071017", "story_v_out_412071.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_412071", "412071017", "story_v_out_412071.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_12 and arg_73_1.time_ < var_76_4 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412071018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 412071018
		arg_77_1.duration_ = 5.57

		local var_77_0 = {
			zh = 5.566,
			ja = 3.866
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
				arg_77_0:Play412071019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if arg_77_1.actors_["10083ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10083ui_story"))) then
				local var_80_0 = Object.Instantiate(Asset.Load("Char/" .. "10083ui_story"), arg_77_1.stage_.transform)

				var_80_0.name = "10083ui_story"
				var_80_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_["10083ui_story"] = var_80_0

				local var_80_1 = var_80_0:GetComponentInChildren(typeof(CharacterEffect))

				var_80_1.enabled = true

				local var_80_2 = GameObjectTools.GetOrAddComponent(var_80_0, typeof(DynamicBoneHelper))

				if var_80_2 then
					var_80_2:EnableDynamicBone(false)
				end

				arg_77_1:ShowWeapon(var_80_1.transform, false)

				arg_77_1.var_["10083ui_story" .. "Animator"] = var_80_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_77_1.var_["10083ui_story" .. "Animator"].applyRootMotion = true
				arg_77_1.var_["10083ui_story" .. "LipSync"] = var_80_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_80_3 = arg_77_1.actors_["10083ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10083ui_story = var_80_3.localPosition
			end

			local var_80_4 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				var_80_3.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_77_1.time_ - 0) / var_80_4)
				var_80_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_3.position).x, (manager.ui.mainCamera.transform.position - var_80_3.position).y, (manager.ui.mainCamera.transform.position - var_80_3.position).z)
				var_80_3.localEulerAngles.z = 0
				var_80_3.localEulerAngles.x = 0
				var_80_3.localEulerAngles = var_80_3.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				var_80_3.localPosition = Vector3.New(0, -2.6, -2.8)
				var_80_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_3.position).x, (manager.ui.mainCamera.transform.position - var_80_3.position).y, (manager.ui.mainCamera.transform.position - var_80_3.position).z)
				var_80_3.localEulerAngles.z = 0
				var_80_3.localEulerAngles.x = 0
				var_80_3.localEulerAngles = var_80_3.localEulerAngles
			end

			local var_80_5 = arg_77_1.actors_["10083ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.characterEffect10083ui_story == nil then
				arg_77_1.var_.characterEffect10083ui_story = var_80_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_6 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_6 and not isNil(var_80_5) then
				if arg_77_1.var_.characterEffect10083ui_story and not isNil(var_80_5) then
					arg_77_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_6 and arg_77_1.time_ < 0 + var_80_6 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.characterEffect10083ui_story then
				arg_77_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action5_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_8 = arg_77_1.actors_["10078ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10078ui_story = var_80_8.localPosition
			end

			local var_80_9 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_9 then
				var_80_8.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_9)
				var_80_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_8.position).x, (manager.ui.mainCamera.transform.position - var_80_8.position).y, (manager.ui.mainCamera.transform.position - var_80_8.position).z)
				var_80_8.localEulerAngles.z = 0
				var_80_8.localEulerAngles.x = 0
				var_80_8.localEulerAngles = var_80_8.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_9 and arg_77_1.time_ < 0 + var_80_9 + arg_80_0 then
				var_80_8.localPosition = Vector3.New(0, 100, 0)
				var_80_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_8.position).x, (manager.ui.mainCamera.transform.position - var_80_8.position).y, (manager.ui.mainCamera.transform.position - var_80_8.position).z)
				var_80_8.localEulerAngles.z = 0
				var_80_8.localEulerAngles.x = 0
				var_80_8.localEulerAngles = var_80_8.localEulerAngles
			end

			local var_80_10 = arg_77_1.actors_["10078ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_10) and arg_77_1.var_.characterEffect10078ui_story == nil then
				arg_77_1.var_.characterEffect10078ui_story = var_80_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_11 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_11 and not isNil(var_80_10) then
				if arg_77_1.var_.characterEffect10078ui_story and not isNil(var_80_10) then
					arg_77_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_11)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_11 and arg_77_1.time_ < 0 + var_80_11 + arg_80_0 and not isNil(var_80_10) and arg_77_1.var_.characterEffect10078ui_story then
				arg_77_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_80_12 = 0
			local var_80_13 = 0.65

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_12 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_14 = arg_77_1:GetWordFromCfg(412071018)
				local var_80_15 = arg_77_1:FormatText(var_80_14.content)

				arg_77_1.text_.text = var_80_15

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_17 = 26 <= 0 and var_80_13 or var_80_13 * (utf8.len(var_80_15) / 26)

				if (26 <= 0 and var_80_13 or var_80_13 * (utf8.len(var_80_15) / 26)) > 0 and var_80_13 < var_80_17 then
					arg_77_1.talkMaxDuration = var_80_17

					if var_80_17 + var_80_12 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_17 + var_80_12
					end
				end

				arg_77_1.text_.text = var_80_15
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071018", "story_v_out_412071.awb") ~= 0 then
					local var_80_18 = manager.audio:GetVoiceLength("story_v_out_412071", "412071018", "story_v_out_412071.awb") / 1000

					if var_80_18 + var_80_12 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_18 + var_80_12
					end

					if var_80_14.prefab_name ~= "" and arg_77_1.actors_[var_80_14.prefab_name] ~= nil then
						local var_80_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_14.prefab_name].transform, "story_v_out_412071", "412071018", "story_v_out_412071.awb")

						arg_77_1:RecordAudio("412071018", var_80_19)
						arg_77_1:RecordAudio("412071018", var_80_19)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_412071", "412071018", "story_v_out_412071.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_412071", "412071018", "story_v_out_412071.awb")
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
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412071019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 412071019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play412071020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10083ui_story = arg_81_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10083ui_story"].transform.position).z)
				arg_81_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["10083ui_story"].transform.localEulerAngles = arg_81_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10083ui_story"].transform.position).z)
				arg_81_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["10083ui_story"].transform.localEulerAngles = arg_81_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["10083ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect10083ui_story == nil then
				arg_81_1.var_.characterEffect10083ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect10083ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_2)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect10083ui_story then
				arg_81_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_84_3 = 0
			local var_84_4 = 1.15

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_3 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_5 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(412071019).content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 46 <= 0 and var_84_4 or var_84_4 * (utf8.len(var_84_5) / 46)

				if (46 <= 0 and var_84_4 or var_84_4 * (utf8.len(var_84_5) / 46)) > 0 and var_84_4 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_3 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_3
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_8 = math.max(var_84_4, arg_81_1.talkMaxDuration)

			if var_84_3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_3 + var_84_8 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_3) / var_84_8

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_3 + var_84_8 and arg_81_1.time_ < var_84_3 + var_84_8 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play412071020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 412071020
		arg_85_1.duration_ = 3

		local var_85_0 = {
			zh = 2.6,
			ja = 3
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
				arg_85_0:Play412071021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1097ui_story = arg_85_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1097ui_story"].transform.position).z)
				arg_85_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1097ui_story"].transform.localEulerAngles = arg_85_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_85_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1097ui_story"].transform.position).z)
				arg_85_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1097ui_story"].transform.localEulerAngles = arg_85_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1097ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1097ui_story == nil then
				arg_85_1.var_.characterEffect1097ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1097ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1097ui_story then
				arg_85_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_4 = 0
			local var_88_5 = 0.225

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(412071020)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 9 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 9)

				if (9 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 9)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071020", "story_v_out_412071.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_412071", "412071020", "story_v_out_412071.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_412071", "412071020", "story_v_out_412071.awb")

						arg_85_1:RecordAudio("412071020", var_88_11)
						arg_85_1:RecordAudio("412071020", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_412071", "412071020", "story_v_out_412071.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_412071", "412071020", "story_v_out_412071.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_12 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_12 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_12

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_12 and arg_85_1.time_ < var_88_4 + var_88_12 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play412071021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 412071021
		arg_89_1.duration_ = 9.27

		local var_89_0 = {
			zh = 8.8,
			ja = 9.266
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
				arg_89_0:Play412071022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10083ui_story = arg_89_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10083ui_story"].transform.position).z)
				arg_89_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["10083ui_story"].transform.localEulerAngles = arg_89_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, -2.6, -2.8)
				arg_89_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10083ui_story"].transform.position).z)
				arg_89_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["10083ui_story"].transform.localEulerAngles = arg_89_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["10083ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect10083ui_story == nil then
				arg_89_1.var_.characterEffect10083ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect10083ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect10083ui_story then
				arg_89_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action1_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_4 = arg_89_1.actors_["1097ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1097ui_story = var_92_4.localPosition
			end

			local var_92_5 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_5 then
				var_92_4.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_5)
				var_92_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_4.position).x, (manager.ui.mainCamera.transform.position - var_92_4.position).y, (manager.ui.mainCamera.transform.position - var_92_4.position).z)
				var_92_4.localEulerAngles.z = 0
				var_92_4.localEulerAngles.x = 0
				var_92_4.localEulerAngles = var_92_4.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_5 and arg_89_1.time_ < 0 + var_92_5 + arg_92_0 then
				var_92_4.localPosition = Vector3.New(0, 100, 0)
				var_92_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_4.position).x, (manager.ui.mainCamera.transform.position - var_92_4.position).y, (manager.ui.mainCamera.transform.position - var_92_4.position).z)
				var_92_4.localEulerAngles.z = 0
				var_92_4.localEulerAngles.x = 0
				var_92_4.localEulerAngles = var_92_4.localEulerAngles
			end

			local var_92_6 = arg_89_1.actors_["1097ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_6) and arg_89_1.var_.characterEffect1097ui_story == nil then
				arg_89_1.var_.characterEffect1097ui_story = var_92_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_7 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 and not isNil(var_92_6) then
				if arg_89_1.var_.characterEffect1097ui_story and not isNil(var_92_6) then
					arg_89_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_7)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 and not isNil(var_92_6) and arg_89_1.var_.characterEffect1097ui_story then
				arg_89_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_92_8 = 0
			local var_92_9 = 1.075

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_10 = arg_89_1:GetWordFromCfg(412071021)
				local var_92_11 = arg_89_1:FormatText(var_92_10.content)

				arg_89_1.text_.text = var_92_11

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_13 = 43 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 43)

				if (43 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 43)) > 0 and var_92_9 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_8
					end
				end

				arg_89_1.text_.text = var_92_11
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071021", "story_v_out_412071.awb") ~= 0 then
					local var_92_14 = manager.audio:GetVoiceLength("story_v_out_412071", "412071021", "story_v_out_412071.awb") / 1000

					if var_92_14 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_8
					end

					if var_92_10.prefab_name ~= "" and arg_89_1.actors_[var_92_10.prefab_name] ~= nil then
						local var_92_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_10.prefab_name].transform, "story_v_out_412071", "412071021", "story_v_out_412071.awb")

						arg_89_1:RecordAudio("412071021", var_92_15)
						arg_89_1:RecordAudio("412071021", var_92_15)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_412071", "412071021", "story_v_out_412071.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_412071", "412071021", "story_v_out_412071.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_16 = math.max(var_92_9, arg_89_1.talkMaxDuration)

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_16 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_8) / var_92_16

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_8 + var_92_16 and arg_89_1.time_ < var_92_8 + var_92_16 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play412071022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 412071022
		arg_93_1.duration_ = 5.83

		local var_93_0 = {
			zh = 4.1,
			ja = 5.833
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
				arg_93_0:Play412071023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10078ui_story = arg_93_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10078ui_story"].transform.position).z)
				arg_93_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10078ui_story"].transform.localEulerAngles = arg_93_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_93_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10078ui_story"].transform.position).z)
				arg_93_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10078ui_story"].transform.localEulerAngles = arg_93_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["10078ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10078ui_story == nil then
				arg_93_1.var_.characterEffect10078ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect10078ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10078ui_story then
				arg_93_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action5_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_4 = arg_93_1.actors_["10083ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10083ui_story = var_96_4.localPosition
			end

			local var_96_5 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_5 then
				var_96_4.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_5)
				var_96_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_4.position).x, (manager.ui.mainCamera.transform.position - var_96_4.position).y, (manager.ui.mainCamera.transform.position - var_96_4.position).z)
				var_96_4.localEulerAngles.z = 0
				var_96_4.localEulerAngles.x = 0
				var_96_4.localEulerAngles = var_96_4.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_5 and arg_93_1.time_ < 0 + var_96_5 + arg_96_0 then
				var_96_4.localPosition = Vector3.New(0, 100, 0)
				var_96_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_4.position).x, (manager.ui.mainCamera.transform.position - var_96_4.position).y, (manager.ui.mainCamera.transform.position - var_96_4.position).z)
				var_96_4.localEulerAngles.z = 0
				var_96_4.localEulerAngles.x = 0
				var_96_4.localEulerAngles = var_96_4.localEulerAngles
			end

			local var_96_6 = arg_93_1.actors_["10083ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect10083ui_story == nil then
				arg_93_1.var_.characterEffect10083ui_story = var_96_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_7 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 and not isNil(var_96_6) then
				if arg_93_1.var_.characterEffect10083ui_story and not isNil(var_96_6) then
					arg_93_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_7)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect10083ui_story then
				arg_93_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_96_8 = 0
			local var_96_9 = 0.275

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_10 = arg_93_1:GetWordFromCfg(412071022)
				local var_96_11 = arg_93_1:FormatText(var_96_10.content)

				arg_93_1.text_.text = var_96_11

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_13 = 11 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_11) / 11)

				if (11 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_11) / 11)) > 0 and var_96_9 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_8
					end
				end

				arg_93_1.text_.text = var_96_11
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071022", "story_v_out_412071.awb") ~= 0 then
					local var_96_14 = manager.audio:GetVoiceLength("story_v_out_412071", "412071022", "story_v_out_412071.awb") / 1000

					if var_96_14 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_8
					end

					if var_96_10.prefab_name ~= "" and arg_93_1.actors_[var_96_10.prefab_name] ~= nil then
						local var_96_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_10.prefab_name].transform, "story_v_out_412071", "412071022", "story_v_out_412071.awb")

						arg_93_1:RecordAudio("412071022", var_96_15)
						arg_93_1:RecordAudio("412071022", var_96_15)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_412071", "412071022", "story_v_out_412071.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_412071", "412071022", "story_v_out_412071.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_16 = math.max(var_96_9, arg_93_1.talkMaxDuration)

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_16 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_8) / var_96_16

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_8 + var_96_16 and arg_93_1.time_ < var_96_8 + var_96_16 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
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
	Play412071023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 412071023
		arg_97_1.duration_ = 10.4

		local var_97_0 = {
			zh = 7.1,
			ja = 10.4
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
				arg_97_0:Play412071024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10083ui_story = arg_97_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10083ui_story"].transform.position).z)
				arg_97_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10083ui_story"].transform.localEulerAngles = arg_97_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, -2.6, -2.8)
				arg_97_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10083ui_story"].transform.position).z)
				arg_97_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10083ui_story"].transform.localEulerAngles = arg_97_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["10083ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10083ui_story == nil then
				arg_97_1.var_.characterEffect10083ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect10083ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10083ui_story then
				arg_97_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action1_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_4 = arg_97_1.actors_["10078ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10078ui_story = var_100_4.localPosition
			end

			local var_100_5 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_5 then
				var_100_4.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_5)
				var_100_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_4.position).x, (manager.ui.mainCamera.transform.position - var_100_4.position).y, (manager.ui.mainCamera.transform.position - var_100_4.position).z)
				var_100_4.localEulerAngles.z = 0
				var_100_4.localEulerAngles.x = 0
				var_100_4.localEulerAngles = var_100_4.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_5 and arg_97_1.time_ < 0 + var_100_5 + arg_100_0 then
				var_100_4.localPosition = Vector3.New(0, 100, 0)
				var_100_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_4.position).x, (manager.ui.mainCamera.transform.position - var_100_4.position).y, (manager.ui.mainCamera.transform.position - var_100_4.position).z)
				var_100_4.localEulerAngles.z = 0
				var_100_4.localEulerAngles.x = 0
				var_100_4.localEulerAngles = var_100_4.localEulerAngles
			end

			local var_100_6 = arg_97_1.actors_["10078ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect10078ui_story == nil then
				arg_97_1.var_.characterEffect10078ui_story = var_100_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_7 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 and not isNil(var_100_6) then
				if arg_97_1.var_.characterEffect10078ui_story and not isNil(var_100_6) then
					arg_97_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_7)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect10078ui_story then
				arg_97_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_100_8 = 0
			local var_100_9 = 0.825

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_10 = arg_97_1:GetWordFromCfg(412071023)
				local var_100_11 = arg_97_1:FormatText(var_100_10.content)

				arg_97_1.text_.text = var_100_11

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 33 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 33)

				if (33 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 33)) > 0 and var_100_9 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_11
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071023", "story_v_out_412071.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_out_412071", "412071023", "story_v_out_412071.awb") / 1000

					if var_100_14 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_8
					end

					if var_100_10.prefab_name ~= "" and arg_97_1.actors_[var_100_10.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_10.prefab_name].transform, "story_v_out_412071", "412071023", "story_v_out_412071.awb")

						arg_97_1:RecordAudio("412071023", var_100_15)
						arg_97_1:RecordAudio("412071023", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_412071", "412071023", "story_v_out_412071.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_412071", "412071023", "story_v_out_412071.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_9, arg_97_1.talkMaxDuration)

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_8) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_8 + var_100_16 and arg_97_1.time_ < var_100_8 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412071024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 412071024
		arg_101_1.duration_ = 4.87

		local var_101_0 = {
			zh = 4.866,
			ja = 3.233
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
				arg_101_0:Play412071025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1097ui_story = arg_101_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1097ui_story"].transform.position).z)
				arg_101_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1097ui_story"].transform.localEulerAngles = arg_101_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_101_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1097ui_story"].transform.position).z)
				arg_101_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1097ui_story"].transform.localEulerAngles = arg_101_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1097ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1097ui_story == nil then
				arg_101_1.var_.characterEffect1097ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1097ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1097ui_story then
				arg_101_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_4 = arg_101_1.actors_["10083ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10083ui_story = var_104_4.localPosition
			end

			local var_104_5 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_5 then
				var_104_4.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_5)
				var_104_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_4.position).x, (manager.ui.mainCamera.transform.position - var_104_4.position).y, (manager.ui.mainCamera.transform.position - var_104_4.position).z)
				var_104_4.localEulerAngles.z = 0
				var_104_4.localEulerAngles.x = 0
				var_104_4.localEulerAngles = var_104_4.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_5 and arg_101_1.time_ < 0 + var_104_5 + arg_104_0 then
				var_104_4.localPosition = Vector3.New(0, 100, 0)
				var_104_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_4.position).x, (manager.ui.mainCamera.transform.position - var_104_4.position).y, (manager.ui.mainCamera.transform.position - var_104_4.position).z)
				var_104_4.localEulerAngles.z = 0
				var_104_4.localEulerAngles.x = 0
				var_104_4.localEulerAngles = var_104_4.localEulerAngles
			end

			local var_104_6 = arg_101_1.actors_["10083ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect10083ui_story == nil then
				arg_101_1.var_.characterEffect10083ui_story = var_104_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_7 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 and not isNil(var_104_6) then
				if arg_101_1.var_.characterEffect10083ui_story and not isNil(var_104_6) then
					arg_101_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_7)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect10083ui_story then
				arg_101_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_104_8 = 0
			local var_104_9 = 0.55

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(412071024)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 22 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 22)

				if (22 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 22)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071024", "story_v_out_412071.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_412071", "412071024", "story_v_out_412071.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_412071", "412071024", "story_v_out_412071.awb")

						arg_101_1:RecordAudio("412071024", var_104_15)
						arg_101_1:RecordAudio("412071024", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_412071", "412071024", "story_v_out_412071.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_412071", "412071024", "story_v_out_412071.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_16 and arg_101_1.time_ < var_104_8 + var_104_16 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play412071025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 412071025
		arg_105_1.duration_ = 7.23

		local var_105_0 = {
			zh = 5.9,
			ja = 7.233
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play412071026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10078ui_story = arg_105_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10078ui_story"].transform.position).z)
				arg_105_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10078ui_story"].transform.localEulerAngles = arg_105_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_105_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10078ui_story"].transform.position).z)
				arg_105_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10078ui_story"].transform.localEulerAngles = arg_105_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["10078ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect10078ui_story == nil then
				arg_105_1.var_.characterEffect10078ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect10078ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect10078ui_story then
				arg_105_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_108_4 = arg_105_1.actors_["1097ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1097ui_story = var_108_4.localPosition
			end

			local var_108_5 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_5 then
				var_108_4.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_5)
				var_108_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_4.position).x, (manager.ui.mainCamera.transform.position - var_108_4.position).y, (manager.ui.mainCamera.transform.position - var_108_4.position).z)
				var_108_4.localEulerAngles.z = 0
				var_108_4.localEulerAngles.x = 0
				var_108_4.localEulerAngles = var_108_4.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_5 and arg_105_1.time_ < 0 + var_108_5 + arg_108_0 then
				var_108_4.localPosition = Vector3.New(0, 100, 0)
				var_108_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_4.position).x, (manager.ui.mainCamera.transform.position - var_108_4.position).y, (manager.ui.mainCamera.transform.position - var_108_4.position).z)
				var_108_4.localEulerAngles.z = 0
				var_108_4.localEulerAngles.x = 0
				var_108_4.localEulerAngles = var_108_4.localEulerAngles
			end

			local var_108_6 = arg_105_1.actors_["1097ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect1097ui_story == nil then
				arg_105_1.var_.characterEffect1097ui_story = var_108_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_7 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 and not isNil(var_108_6) then
				if arg_105_1.var_.characterEffect1097ui_story and not isNil(var_108_6) then
					arg_105_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_7)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect1097ui_story then
				arg_105_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_108_8 = 0
			local var_108_9 = 0.425

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:GetWordFromCfg(412071025)
				local var_108_11 = arg_105_1:FormatText(var_108_10.content)

				arg_105_1.text_.text = var_108_11

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 17 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 17)

				if (17 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 17)) > 0 and var_108_9 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_11
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071025", "story_v_out_412071.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_out_412071", "412071025", "story_v_out_412071.awb") / 1000

					if var_108_14 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_8
					end

					if var_108_10.prefab_name ~= "" and arg_105_1.actors_[var_108_10.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_10.prefab_name].transform, "story_v_out_412071", "412071025", "story_v_out_412071.awb")

						arg_105_1:RecordAudio("412071025", var_108_15)
						arg_105_1:RecordAudio("412071025", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_412071", "412071025", "story_v_out_412071.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_412071", "412071025", "story_v_out_412071.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_16 and arg_105_1.time_ < var_108_8 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play412071026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 412071026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play412071027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10078ui_story = arg_109_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10078ui_story"].transform.position).z)
				arg_109_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10078ui_story"].transform.localEulerAngles = arg_109_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10078ui_story"].transform.position).z)
				arg_109_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10078ui_story"].transform.localEulerAngles = arg_109_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["10078ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect10078ui_story == nil then
				arg_109_1.var_.characterEffect10078ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect10078ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_2)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect10078ui_story then
				arg_109_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_112_3 = 0
			local var_112_4 = 0.5

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_5 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(412071026).content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 20 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 20)

				if (20 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 20)) > 0 and var_112_4 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_3
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_4, arg_109_1.talkMaxDuration)

			if var_112_3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_3 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_3) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_3 + var_112_8 and arg_109_1.time_ < var_112_3 + var_112_8 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play412071027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 412071027
		arg_113_1.duration_ = 7

		local var_113_0 = {
			zh = 7,
			ja = 3.266
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play412071028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10078ui_story = arg_113_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10078ui_story"].transform.position).z)
				arg_113_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10078ui_story"].transform.localEulerAngles = arg_113_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_113_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10078ui_story"].transform.position).z)
				arg_113_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10078ui_story"].transform.localEulerAngles = arg_113_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["10078ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10078ui_story == nil then
				arg_113_1.var_.characterEffect10078ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect10078ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10078ui_story then
				arg_113_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_116_4 = 0
			local var_116_5 = 0.6

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(412071027)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 24 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 24)

				if (24 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 24)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071027", "story_v_out_412071.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_412071", "412071027", "story_v_out_412071.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_out_412071", "412071027", "story_v_out_412071.awb")

						arg_113_1:RecordAudio("412071027", var_116_11)
						arg_113_1:RecordAudio("412071027", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_412071", "412071027", "story_v_out_412071.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_412071", "412071027", "story_v_out_412071.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_12 and arg_113_1.time_ < var_116_4 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play412071028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 412071028
		arg_117_1.duration_ = 7.5

		local var_117_0 = {
			zh = 6.533,
			ja = 7.5
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play412071029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.55

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:GetWordFromCfg(412071028)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 22 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 22)

				if (22 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 22)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071028", "story_v_out_412071.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_412071", "412071028", "story_v_out_412071.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_412071", "412071028", "story_v_out_412071.awb")

						arg_117_1:RecordAudio("412071028", var_120_6)
						arg_117_1:RecordAudio("412071028", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_412071", "412071028", "story_v_out_412071.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_412071", "412071028", "story_v_out_412071.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play412071029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 412071029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play412071030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10078ui_story = arg_121_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10078ui_story"].transform.position).z)
				arg_121_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10078ui_story"].transform.localEulerAngles = arg_121_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10078ui_story"].transform.position).z)
				arg_121_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10078ui_story"].transform.localEulerAngles = arg_121_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["10078ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10078ui_story == nil then
				arg_121_1.var_.characterEffect10078ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect10078ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_2)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10078ui_story then
				arg_121_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_124_3 = manager.ui.mainCamera.transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.shakeOldPos = var_124_3.localPosition
			end

			local var_124_4 = 0.6

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				local var_124_5, var_124_6 = math.modf((arg_121_1.time_ - 0) / 0.066)

				var_124_3.localPosition = Vector3.New(var_124_6 * 0.13, var_124_6 * 0.13, var_124_6 * 0.13) + arg_121_1.var_.shakeOldPos
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_3.localPosition = arg_121_1.var_.shakeOldPos
			end

			local var_124_7 = 0

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_7 + arg_124_0 then
				arg_121_1.allBtn_.enabled = false
			end

			if arg_121_1.time_ >= var_124_7 + 0.6 and arg_121_1.time_ < var_124_7 + 0.6 + arg_124_0 then
				arg_121_1.allBtn_.enabled = true
			end

			local var_124_8 = 0
			local var_124_9 = 0.75

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_10 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(412071029).content)

				arg_121_1.text_.text = var_124_10

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_12 = 30 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_10) / 30)

				if (30 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_10) / 30)) > 0 and var_124_9 < var_124_12 then
					arg_121_1.talkMaxDuration = var_124_12

					if var_124_12 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_12 + var_124_8
					end
				end

				arg_121_1.text_.text = var_124_10
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_13 = math.max(var_124_9, arg_121_1.talkMaxDuration)

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_13 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_8) / var_124_13

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_8 + var_124_13 and arg_121_1.time_ < var_124_8 + var_124_13 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play412071030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 412071030
		arg_125_1.duration_ = 5.87

		local var_125_0 = {
			zh = 5.866,
			ja = 4.633
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
				arg_125_0:Play412071031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10083ui_story = arg_125_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10083ui_story"].transform.position).z)
				arg_125_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["10083ui_story"].transform.localEulerAngles = arg_125_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, -2.6, -2.8)
				arg_125_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10083ui_story"].transform.position).z)
				arg_125_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["10083ui_story"].transform.localEulerAngles = arg_125_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["10083ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect10083ui_story == nil then
				arg_125_1.var_.characterEffect10083ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect10083ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect10083ui_story then
				arg_125_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action4_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_4 = 0
			local var_128_5 = 0.625

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(412071030)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 25 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 25)

				if (25 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 25)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071030", "story_v_out_412071.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_out_412071", "412071030", "story_v_out_412071.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_out_412071", "412071030", "story_v_out_412071.awb")

						arg_125_1:RecordAudio("412071030", var_128_11)
						arg_125_1:RecordAudio("412071030", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_412071", "412071030", "story_v_out_412071.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_412071", "412071030", "story_v_out_412071.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_12 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_12 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_12

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_12 and arg_125_1.time_ < var_128_4 + var_128_12 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
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
	Play412071031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 412071031
		arg_129_1.duration_ = 4.93

		local var_129_0 = {
			zh = 3.933,
			ja = 4.933
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
				arg_129_0:Play412071032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1097ui_story = arg_129_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1097ui_story"].transform.position).z)
				arg_129_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1097ui_story"].transform.localEulerAngles = arg_129_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_129_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1097ui_story"].transform.position).z)
				arg_129_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1097ui_story"].transform.localEulerAngles = arg_129_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1097ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1097ui_story == nil then
				arg_129_1.var_.characterEffect1097ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1097ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1097ui_story then
				arg_129_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_132_4 = arg_129_1.actors_["10083ui_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10083ui_story = var_132_4.localPosition
			end

			local var_132_5 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_5 then
				var_132_4.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 0) / var_132_5)
				var_132_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_4.position).x, (manager.ui.mainCamera.transform.position - var_132_4.position).y, (manager.ui.mainCamera.transform.position - var_132_4.position).z)
				var_132_4.localEulerAngles.z = 0
				var_132_4.localEulerAngles.x = 0
				var_132_4.localEulerAngles = var_132_4.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_5 and arg_129_1.time_ < 0 + var_132_5 + arg_132_0 then
				var_132_4.localPosition = Vector3.New(0, 100, 0)
				var_132_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_4.position).x, (manager.ui.mainCamera.transform.position - var_132_4.position).y, (manager.ui.mainCamera.transform.position - var_132_4.position).z)
				var_132_4.localEulerAngles.z = 0
				var_132_4.localEulerAngles.x = 0
				var_132_4.localEulerAngles = var_132_4.localEulerAngles
			end

			local var_132_6 = arg_129_1.actors_["10083ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_6) and arg_129_1.var_.characterEffect10083ui_story == nil then
				arg_129_1.var_.characterEffect10083ui_story = var_132_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_7 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 and not isNil(var_132_6) then
				if arg_129_1.var_.characterEffect10083ui_story and not isNil(var_132_6) then
					arg_129_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_7)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 and not isNil(var_132_6) and arg_129_1.var_.characterEffect10083ui_story then
				arg_129_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_132_8 = 0
			local var_132_9 = 0.45

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0

				arg_129_1.dialog_:SetActive(true)

				arg_129_1.dialogCg_.alpha = 0

				local var_132_10 = LeanTween.value(arg_129_1.dialog_, 0, 1, 0.3)

				var_132_10:setOnUpdate(LuaHelper.FloatAction(function(arg_133_0)
					arg_129_1.dialogCg_.alpha = arg_133_0
				end))
				var_132_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_129_1.dialog_)
					var_132_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_129_1.duration_ = arg_129_1.duration_ + 0.3

				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_11 = arg_129_1:GetWordFromCfg(412071031)
				local var_132_12 = arg_129_1:FormatText(var_132_11.content)

				arg_129_1.text_.text = var_132_12

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_14 = 18 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_12) / 18)

				if (18 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_12) / 18)) > 0 and var_132_9 < var_132_14 then
					arg_129_1.talkMaxDuration = var_132_14
					var_132_8 = var_132_8 + 0.3

					if var_132_14 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_14 + var_132_8
					end
				end

				arg_129_1.text_.text = var_132_12
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071031", "story_v_out_412071.awb") ~= 0 then
					local var_132_15 = manager.audio:GetVoiceLength("story_v_out_412071", "412071031", "story_v_out_412071.awb") / 1000

					if var_132_15 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_15 + var_132_8
					end

					if var_132_11.prefab_name ~= "" and arg_129_1.actors_[var_132_11.prefab_name] ~= nil then
						local var_132_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_11.prefab_name].transform, "story_v_out_412071", "412071031", "story_v_out_412071.awb")

						arg_129_1:RecordAudio("412071031", var_132_16)
						arg_129_1:RecordAudio("412071031", var_132_16)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_412071", "412071031", "story_v_out_412071.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_412071", "412071031", "story_v_out_412071.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_17 = var_132_8 + 0.3
			local var_132_18 = math.max(var_132_9, arg_129_1.talkMaxDuration)

			if var_132_8 + 0.3 <= arg_129_1.time_ and arg_129_1.time_ < var_132_17 + var_132_18 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_17) / var_132_18

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_17 + var_132_18 and arg_129_1.time_ < var_132_17 + var_132_18 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play412071032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 412071032
		arg_135_1.duration_ = 12.37

		local var_135_0 = {
			zh = 10.433,
			ja = 12.366
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
				arg_135_0:Play412071033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 2.7 < arg_135_1.time_ and arg_135_1.time_ <= 2.7 + arg_138_0 then
				local var_138_0 = arg_135_1.bgs_.ST85b

				arg_135_1.bgs_.ST85b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_138_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_138_1 = var_138_0:GetComponent("SpriteRenderer")

				if var_138_1 and var_138_1.sprite then
					local var_138_2 = 2 * (var_138_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_138_0.transform.localScale = Vector3.New(var_138_2 / var_138_1.sprite.bounds.size.y < var_138_2 * manager.ui.mainCameraCom_.aspect / var_138_1.sprite.bounds.size.x and var_138_2 * manager.ui.mainCameraCom_.aspect / var_138_1.sprite.bounds.size.x or var_138_2 / var_138_1.sprite.bounds.size.y, var_138_2 / var_138_1.sprite.bounds.size.y < var_138_2 * manager.ui.mainCameraCom_.aspect / var_138_1.sprite.bounds.size.x and var_138_2 * manager.ui.mainCameraCom_.aspect / var_138_1.sprite.bounds.size.x or var_138_2 / var_138_1.sprite.bounds.size.y, 0)
				end

				for iter_138_0, iter_138_1 in pairs(arg_135_1.bgs_) do
					if iter_138_0 ~= "ST85b" then
						iter_138_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_138_3 = 4.7

			if 4.7 < arg_135_1.time_ and arg_135_1.time_ <= var_138_3 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			if arg_135_1.time_ >= var_138_3 + 0.3 and arg_135_1.time_ < var_138_3 + 0.3 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end

			local var_138_4 = 0.7

			if 0.7 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_5 = 2

			if var_138_4 <= arg_135_1.time_ and arg_135_1.time_ < var_138_4 + var_138_5 then
				local var_138_6 = Color.New(0, 0, 0)

				var_138_6.a = Mathf.Lerp(0, 1, (arg_135_1.time_ - var_138_4) / var_138_5)
				arg_135_1.mask_.color = var_138_6
			end

			if arg_135_1.time_ >= var_138_4 + var_138_5 and arg_135_1.time_ < var_138_4 + var_138_5 + arg_138_0 then
				local var_138_7 = Color.New(0, 0, 0)

				var_138_7.a = 1
				arg_135_1.mask_.color = var_138_7
			end

			local var_138_8 = 2.7

			if 2.7 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_9 = 2

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_9 then
				local var_138_10 = Color.New(0, 0, 0)

				var_138_10.a = Mathf.Lerp(1, 0, (arg_135_1.time_ - var_138_8) / var_138_9)
				arg_135_1.mask_.color = var_138_10
			end

			if arg_135_1.time_ >= var_138_8 + var_138_9 and arg_135_1.time_ < var_138_8 + var_138_9 + arg_138_0 then
				local var_138_11 = Color.New(0, 0, 0)

				arg_135_1.mask_.enabled = false
				var_138_11.a = 0
				arg_135_1.mask_.color = var_138_11
			end

			local var_138_12 = arg_135_1.actors_["1097ui_story"].transform

			if 2.666 < arg_135_1.time_ and arg_135_1.time_ <= 2.666 + arg_138_0 then
				arg_135_1.var_.moveOldPos1097ui_story = var_138_12.localPosition
			end

			local var_138_13 = 0.001

			if 2.666 <= arg_135_1.time_ and arg_135_1.time_ < 2.666 + var_138_13 then
				var_138_12.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_135_1.time_ - 2.666) / var_138_13)
				var_138_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_12.position).x, (manager.ui.mainCamera.transform.position - var_138_12.position).y, (manager.ui.mainCamera.transform.position - var_138_12.position).z)
				var_138_12.localEulerAngles.z = 0
				var_138_12.localEulerAngles.x = 0
				var_138_12.localEulerAngles = var_138_12.localEulerAngles
			end

			if arg_135_1.time_ >= 2.666 + var_138_13 and arg_135_1.time_ < 2.666 + var_138_13 + arg_138_0 then
				var_138_12.localPosition = Vector3.New(0, 100, 0)
				var_138_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_12.position).x, (manager.ui.mainCamera.transform.position - var_138_12.position).y, (manager.ui.mainCamera.transform.position - var_138_12.position).z)
				var_138_12.localEulerAngles.z = 0
				var_138_12.localEulerAngles.x = 0
				var_138_12.localEulerAngles = var_138_12.localEulerAngles
			end

			local var_138_14 = arg_135_1.actors_["1097ui_story"].transform

			if 4.5 < arg_135_1.time_ and arg_135_1.time_ <= 4.5 + arg_138_0 then
				arg_135_1.var_.moveOldPos1097ui_story = var_138_14.localPosition
			end

			local var_138_15 = 0.001

			if 4.5 <= arg_135_1.time_ and arg_135_1.time_ < 4.5 + var_138_15 then
				var_138_14.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_135_1.time_ - 4.5) / var_138_15)
				var_138_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_14.position).x, (manager.ui.mainCamera.transform.position - var_138_14.position).y, (manager.ui.mainCamera.transform.position - var_138_14.position).z)
				var_138_14.localEulerAngles.z = 0
				var_138_14.localEulerAngles.x = 0
				var_138_14.localEulerAngles = var_138_14.localEulerAngles
			end

			if arg_135_1.time_ >= 4.5 + var_138_15 and arg_135_1.time_ < 4.5 + var_138_15 + arg_138_0 then
				var_138_14.localPosition = Vector3.New(0, -0.54, -6.3)
				var_138_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_14.position).x, (manager.ui.mainCamera.transform.position - var_138_14.position).y, (manager.ui.mainCamera.transform.position - var_138_14.position).z)
				var_138_14.localEulerAngles.z = 0
				var_138_14.localEulerAngles.x = 0
				var_138_14.localEulerAngles = var_138_14.localEulerAngles
			end

			if 4.5 < arg_135_1.time_ and arg_135_1.time_ <= 4.5 + arg_138_0 then
				arg_135_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if arg_135_1.frameCnt_ <= 1 then
				arg_135_1.dialog_:SetActive(false)
			end

			local var_138_16 = 4.7
			local var_138_17 = 0.7

			if 4.7 < arg_135_1.time_ and arg_135_1.time_ <= var_138_16 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				arg_135_1.dialog_:SetActive(true)

				arg_135_1.dialogCg_.alpha = 0

				local var_138_18 = LeanTween.value(arg_135_1.dialog_, 0, 1, 0.3)

				var_138_18:setOnUpdate(LuaHelper.FloatAction(function(arg_139_0)
					arg_135_1.dialogCg_.alpha = arg_139_0
				end))
				var_138_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_135_1.dialog_)
					var_138_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_135_1.duration_ = arg_135_1.duration_ + 0.3

				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_19 = arg_135_1:GetWordFromCfg(412071032)
				local var_138_20 = arg_135_1:FormatText(var_138_19.content)

				arg_135_1.text_.text = var_138_20

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_22 = 28 <= 0 and var_138_17 or var_138_17 * (utf8.len(var_138_20) / 28)

				if (28 <= 0 and var_138_17 or var_138_17 * (utf8.len(var_138_20) / 28)) > 0 and var_138_17 < var_138_22 then
					arg_135_1.talkMaxDuration = var_138_22
					var_138_16 = var_138_16 + 0.3

					if var_138_22 + var_138_16 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_22 + var_138_16
					end
				end

				arg_135_1.text_.text = var_138_20
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071032", "story_v_out_412071.awb") ~= 0 then
					local var_138_23 = manager.audio:GetVoiceLength("story_v_out_412071", "412071032", "story_v_out_412071.awb") / 1000

					if var_138_23 + var_138_16 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_23 + var_138_16
					end

					if var_138_19.prefab_name ~= "" and arg_135_1.actors_[var_138_19.prefab_name] ~= nil then
						local var_138_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_19.prefab_name].transform, "story_v_out_412071", "412071032", "story_v_out_412071.awb")

						arg_135_1:RecordAudio("412071032", var_138_24)
						arg_135_1:RecordAudio("412071032", var_138_24)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_412071", "412071032", "story_v_out_412071.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_412071", "412071032", "story_v_out_412071.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_25 = var_138_16 + 0.3
			local var_138_26 = math.max(var_138_17, arg_135_1.talkMaxDuration)

			if var_138_16 + 0.3 <= arg_135_1.time_ and arg_135_1.time_ < var_138_25 + var_138_26 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_25) / var_138_26

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_25 + var_138_26 and arg_135_1.time_ < var_138_25 + var_138_26 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.666,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play412071033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 412071033
		arg_141_1.duration_ = 4.07

		local var_141_0 = {
			zh = 4.066,
			ja = 2.5
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
				arg_141_0:Play412071034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10078ui_story = arg_141_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10078ui_story"].transform.position).z)
				arg_141_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10078ui_story"].transform.localEulerAngles = arg_141_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_141_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10078ui_story"].transform.position).z)
				arg_141_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10078ui_story"].transform.localEulerAngles = arg_141_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["10078ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect10078ui_story == nil then
				arg_141_1.var_.characterEffect10078ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect10078ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect10078ui_story then
				arg_141_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_144_4 = arg_141_1.actors_["1097ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1097ui_story = var_144_4.localPosition
			end

			local var_144_5 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_5 then
				var_144_4.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_141_1.time_ - 0) / var_144_5)
				var_144_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_4.position).x, (manager.ui.mainCamera.transform.position - var_144_4.position).y, (manager.ui.mainCamera.transform.position - var_144_4.position).z)
				var_144_4.localEulerAngles.z = 0
				var_144_4.localEulerAngles.x = 0
				var_144_4.localEulerAngles = var_144_4.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_5 and arg_141_1.time_ < 0 + var_144_5 + arg_144_0 then
				var_144_4.localPosition = Vector3.New(0, 100, 0)
				var_144_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_4.position).x, (manager.ui.mainCamera.transform.position - var_144_4.position).y, (manager.ui.mainCamera.transform.position - var_144_4.position).z)
				var_144_4.localEulerAngles.z = 0
				var_144_4.localEulerAngles.x = 0
				var_144_4.localEulerAngles = var_144_4.localEulerAngles
			end

			local var_144_6 = arg_141_1.actors_["1097ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect1097ui_story == nil then
				arg_141_1.var_.characterEffect1097ui_story = var_144_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_7 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 and not isNil(var_144_6) then
				if arg_141_1.var_.characterEffect1097ui_story and not isNil(var_144_6) then
					arg_141_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_7)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect1097ui_story then
				arg_141_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_144_8 = 0
			local var_144_9 = 0.25

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_10 = arg_141_1:GetWordFromCfg(412071033)
				local var_144_11 = arg_141_1:FormatText(var_144_10.content)

				arg_141_1.text_.text = var_144_11

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_13 = 10 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_11) / 10)

				if (10 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_11) / 10)) > 0 and var_144_9 < var_144_13 then
					arg_141_1.talkMaxDuration = var_144_13

					if var_144_13 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_8
					end
				end

				arg_141_1.text_.text = var_144_11
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071033", "story_v_out_412071.awb") ~= 0 then
					local var_144_14 = manager.audio:GetVoiceLength("story_v_out_412071", "412071033", "story_v_out_412071.awb") / 1000

					if var_144_14 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_8
					end

					if var_144_10.prefab_name ~= "" and arg_141_1.actors_[var_144_10.prefab_name] ~= nil then
						local var_144_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_10.prefab_name].transform, "story_v_out_412071", "412071033", "story_v_out_412071.awb")

						arg_141_1:RecordAudio("412071033", var_144_15)
						arg_141_1:RecordAudio("412071033", var_144_15)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_412071", "412071033", "story_v_out_412071.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_412071", "412071033", "story_v_out_412071.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_16 = math.max(var_144_9, arg_141_1.talkMaxDuration)

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_16 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_8) / var_144_16

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_8 + var_144_16 and arg_141_1.time_ < var_144_8 + var_144_16 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412071034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 412071034
		arg_145_1.duration_ = 10.77

		local var_145_0 = {
			zh = 7.566,
			ja = 10.766
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
				arg_145_0:Play412071035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.525

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:GetWordFromCfg(412071034)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 21 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 21)

				if (21 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 21)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071034", "story_v_out_412071.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_412071", "412071034", "story_v_out_412071.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_412071", "412071034", "story_v_out_412071.awb")

						arg_145_1:RecordAudio("412071034", var_148_6)
						arg_145_1:RecordAudio("412071034", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_412071", "412071034", "story_v_out_412071.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_412071", "412071034", "story_v_out_412071.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play412071035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 412071035
		arg_149_1.duration_ = 7.5

		local var_149_0 = {
			zh = 5.866,
			ja = 7.5
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
				arg_149_0:Play412071036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1097ui_story = arg_149_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1097ui_story"].transform.position).z)
				arg_149_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1097ui_story"].transform.localEulerAngles = arg_149_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0.7, -0.54, -6.3)
				arg_149_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1097ui_story"].transform.position).z)
				arg_149_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1097ui_story"].transform.localEulerAngles = arg_149_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["1097ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1097ui_story == nil then
				arg_149_1.var_.characterEffect1097ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1097ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1097ui_story then
				arg_149_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_152_4 = arg_149_1.actors_["10078ui_story"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos10078ui_story = var_152_4.localPosition
			end

			local var_152_5 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_5 then
				var_152_4.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10078ui_story, Vector3.New(-0.7, -0.5, -6.3), (arg_149_1.time_ - 0) / var_152_5)
				var_152_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_4.position).x, (manager.ui.mainCamera.transform.position - var_152_4.position).y, (manager.ui.mainCamera.transform.position - var_152_4.position).z)
				var_152_4.localEulerAngles.z = 0
				var_152_4.localEulerAngles.x = 0
				var_152_4.localEulerAngles = var_152_4.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_5 and arg_149_1.time_ < 0 + var_152_5 + arg_152_0 then
				var_152_4.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_152_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_4.position).x, (manager.ui.mainCamera.transform.position - var_152_4.position).y, (manager.ui.mainCamera.transform.position - var_152_4.position).z)
				var_152_4.localEulerAngles.z = 0
				var_152_4.localEulerAngles.x = 0
				var_152_4.localEulerAngles = var_152_4.localEulerAngles
			end

			local var_152_6 = arg_149_1.actors_["10078ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_6) and arg_149_1.var_.characterEffect10078ui_story == nil then
				arg_149_1.var_.characterEffect10078ui_story = var_152_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_7 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 and not isNil(var_152_6) then
				if arg_149_1.var_.characterEffect10078ui_story and not isNil(var_152_6) then
					arg_149_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_7)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 and not isNil(var_152_6) and arg_149_1.var_.characterEffect10078ui_story then
				arg_149_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_152_8 = 0
			local var_152_9 = 0.575

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_10 = arg_149_1:GetWordFromCfg(412071035)
				local var_152_11 = arg_149_1:FormatText(var_152_10.content)

				arg_149_1.text_.text = var_152_11

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_13 = 23 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 23)

				if (23 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 23)) > 0 and var_152_9 < var_152_13 then
					arg_149_1.talkMaxDuration = var_152_13

					if var_152_13 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_11
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071035", "story_v_out_412071.awb") ~= 0 then
					local var_152_14 = manager.audio:GetVoiceLength("story_v_out_412071", "412071035", "story_v_out_412071.awb") / 1000

					if var_152_14 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_14 + var_152_8
					end

					if var_152_10.prefab_name ~= "" and arg_149_1.actors_[var_152_10.prefab_name] ~= nil then
						local var_152_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_10.prefab_name].transform, "story_v_out_412071", "412071035", "story_v_out_412071.awb")

						arg_149_1:RecordAudio("412071035", var_152_15)
						arg_149_1:RecordAudio("412071035", var_152_15)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_412071", "412071035", "story_v_out_412071.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_412071", "412071035", "story_v_out_412071.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_16 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_16 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_16

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_16 and arg_149_1.time_ < var_152_8 + var_152_16 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412071036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 412071036
		arg_153_1.duration_ = 5.37

		local var_153_0 = {
			zh = 3.8,
			ja = 5.366
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
				arg_153_0:Play412071037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["10078ui_story"]) and arg_153_1.var_.characterEffect10078ui_story == nil then
				arg_153_1.var_.characterEffect10078ui_story = arg_153_1.actors_["10078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["10078ui_story"]) then
				if arg_153_1.var_.characterEffect10078ui_story and not isNil(arg_153_1.actors_["10078ui_story"]) then
					arg_153_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["10078ui_story"]) and arg_153_1.var_.characterEffect10078ui_story then
				arg_153_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_156_2 = arg_153_1.actors_["1097ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect1097ui_story == nil then
				arg_153_1.var_.characterEffect1097ui_story = var_156_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_3 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.characterEffect1097ui_story and not isNil(var_156_2) then
					arg_153_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_3)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect1097ui_story then
				arg_153_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_156_4 = 0
			local var_156_5 = 0.25

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(412071036)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 10 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 10)

				if (10 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 10)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071036", "story_v_out_412071.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_out_412071", "412071036", "story_v_out_412071.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_out_412071", "412071036", "story_v_out_412071.awb")

						arg_153_1:RecordAudio("412071036", var_156_11)
						arg_153_1:RecordAudio("412071036", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_412071", "412071036", "story_v_out_412071.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_412071", "412071036", "story_v_out_412071.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play412071037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 412071037
		arg_157_1.duration_ = 12.67

		local var_157_0 = {
			zh = 5.6,
			ja = 12.666
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
				arg_157_0:Play412071038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1097ui_story"]) and arg_157_1.var_.characterEffect1097ui_story == nil then
				arg_157_1.var_.characterEffect1097ui_story = arg_157_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1097ui_story"]) then
				if arg_157_1.var_.characterEffect1097ui_story and not isNil(arg_157_1.actors_["1097ui_story"]) then
					arg_157_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1097ui_story"]) and arg_157_1.var_.characterEffect1097ui_story then
				arg_157_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_160_2 = arg_157_1.actors_["10078ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect10078ui_story == nil then
				arg_157_1.var_.characterEffect10078ui_story = var_160_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_3 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_3 and not isNil(var_160_2) then
				if arg_157_1.var_.characterEffect10078ui_story and not isNil(var_160_2) then
					arg_157_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_157_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_3)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_3 and arg_157_1.time_ < 0 + var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect10078ui_story then
				arg_157_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_157_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_160_4 = 0
			local var_160_5 = 0.6

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(412071037)
				local var_160_7 = arg_157_1:FormatText(var_160_6.content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_9 = 24 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 24)

				if (24 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 24)) > 0 and var_160_5 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071037", "story_v_out_412071.awb") ~= 0 then
					local var_160_10 = manager.audio:GetVoiceLength("story_v_out_412071", "412071037", "story_v_out_412071.awb") / 1000

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end

					if var_160_6.prefab_name ~= "" and arg_157_1.actors_[var_160_6.prefab_name] ~= nil then
						local var_160_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_6.prefab_name].transform, "story_v_out_412071", "412071037", "story_v_out_412071.awb")

						arg_157_1:RecordAudio("412071037", var_160_11)
						arg_157_1:RecordAudio("412071037", var_160_11)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_412071", "412071037", "story_v_out_412071.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_412071", "412071037", "story_v_out_412071.awb")
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
	Play412071038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 412071038
		arg_161_1.duration_ = 10

		local var_161_0 = {
			zh = 10,
			ja = 8.233
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
				arg_161_0:Play412071039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.975

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(412071038)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 39 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 39)

				if (39 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 39)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071038", "story_v_out_412071.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_412071", "412071038", "story_v_out_412071.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_412071", "412071038", "story_v_out_412071.awb")

						arg_161_1:RecordAudio("412071038", var_164_6)
						arg_161_1:RecordAudio("412071038", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_412071", "412071038", "story_v_out_412071.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_412071", "412071038", "story_v_out_412071.awb")
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
	Play412071039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 412071039
		arg_165_1.duration_ = 3.1

		local var_165_0 = {
			zh = 3.1,
			ja = 2.833
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
				arg_165_0:Play412071040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["10078ui_story"]) and arg_165_1.var_.characterEffect10078ui_story == nil then
				arg_165_1.var_.characterEffect10078ui_story = arg_165_1.actors_["10078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["10078ui_story"]) then
				if arg_165_1.var_.characterEffect10078ui_story and not isNil(arg_165_1.actors_["10078ui_story"]) then
					arg_165_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["10078ui_story"]) and arg_165_1.var_.characterEffect10078ui_story then
				arg_165_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action5_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_168_2 = arg_165_1.actors_["10078ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.characterEffect10078ui_story == nil then
				arg_165_1.var_.characterEffect10078ui_story = var_168_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_3 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_3 and not isNil(var_168_2) then
				if arg_165_1.var_.characterEffect10078ui_story and not isNil(var_168_2) then
					arg_165_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_3 and arg_165_1.time_ < 0 + var_168_3 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.characterEffect10078ui_story then
				arg_165_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_168_5 = 0
			local var_168_6 = 0.225

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_7 = arg_165_1:GetWordFromCfg(412071039)
				local var_168_8 = arg_165_1:FormatText(var_168_7.content)

				arg_165_1.text_.text = var_168_8

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 9 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_8) / 9)

				if (9 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_8) / 9)) > 0 and var_168_6 < var_168_10 then
					arg_165_1.talkMaxDuration = var_168_10

					if var_168_10 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_5
					end
				end

				arg_165_1.text_.text = var_168_8
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071039", "story_v_out_412071.awb") ~= 0 then
					local var_168_11 = manager.audio:GetVoiceLength("story_v_out_412071", "412071039", "story_v_out_412071.awb") / 1000

					if var_168_11 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_11 + var_168_5
					end

					if var_168_7.prefab_name ~= "" and arg_165_1.actors_[var_168_7.prefab_name] ~= nil then
						local var_168_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_7.prefab_name].transform, "story_v_out_412071", "412071039", "story_v_out_412071.awb")

						arg_165_1:RecordAudio("412071039", var_168_12)
						arg_165_1:RecordAudio("412071039", var_168_12)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_412071", "412071039", "story_v_out_412071.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_412071", "412071039", "story_v_out_412071.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_13 = math.max(var_168_6, arg_165_1.talkMaxDuration)

			if var_168_5 <= arg_165_1.time_ and arg_165_1.time_ < var_168_5 + var_168_13 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_5) / var_168_13

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_5 + var_168_13 and arg_165_1.time_ < var_168_5 + var_168_13 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play412071040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 412071040
		arg_169_1.duration_ = 17.33

		local var_169_0 = {
			zh = 6.9,
			ja = 17.333
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
				arg_169_0:Play412071041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1097ui_story = arg_169_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1097ui_story"].transform.position).z)
				arg_169_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1097ui_story"].transform.localEulerAngles = arg_169_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0.7, -0.54, -6.3)
				arg_169_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1097ui_story"].transform.position).z)
				arg_169_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1097ui_story"].transform.localEulerAngles = arg_169_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["1097ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1097ui_story == nil then
				arg_169_1.var_.characterEffect1097ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect1097ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1097ui_story then
				arg_169_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_172_4 = arg_169_1.actors_["10078ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_4) and arg_169_1.var_.characterEffect10078ui_story == nil then
				arg_169_1.var_.characterEffect10078ui_story = var_172_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_5 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_5 and not isNil(var_172_4) then
				if arg_169_1.var_.characterEffect10078ui_story and not isNil(var_172_4) then
					arg_169_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_169_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_5)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_5 and arg_169_1.time_ < 0 + var_172_5 + arg_172_0 and not isNil(var_172_4) and arg_169_1.var_.characterEffect10078ui_story then
				arg_169_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_169_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_172_6 = 0
			local var_172_7 = 0.75

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_8 = arg_169_1:GetWordFromCfg(412071040)
				local var_172_9 = arg_169_1:FormatText(var_172_8.content)

				arg_169_1.text_.text = var_172_9

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 30 <= 0 and var_172_7 or var_172_7 * (utf8.len(var_172_9) / 30)

				if (30 <= 0 and var_172_7 or var_172_7 * (utf8.len(var_172_9) / 30)) > 0 and var_172_7 < var_172_11 then
					arg_169_1.talkMaxDuration = var_172_11

					if var_172_11 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_11 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_9
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071040", "story_v_out_412071.awb") ~= 0 then
					local var_172_12 = manager.audio:GetVoiceLength("story_v_out_412071", "412071040", "story_v_out_412071.awb") / 1000

					if var_172_12 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_12 + var_172_6
					end

					if var_172_8.prefab_name ~= "" and arg_169_1.actors_[var_172_8.prefab_name] ~= nil then
						local var_172_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_8.prefab_name].transform, "story_v_out_412071", "412071040", "story_v_out_412071.awb")

						arg_169_1:RecordAudio("412071040", var_172_13)
						arg_169_1:RecordAudio("412071040", var_172_13)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_412071", "412071040", "story_v_out_412071.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_412071", "412071040", "story_v_out_412071.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_14 = math.max(var_172_7, arg_169_1.talkMaxDuration)

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_14 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_6) / var_172_14

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_6 + var_172_14 and arg_169_1.time_ < var_172_6 + var_172_14 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412071041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 412071041
		arg_173_1.duration_ = 10.3

		local var_173_0 = {
			zh = 10.3,
			ja = 10.166
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
				arg_173_0:Play412071042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10083ui_story = arg_173_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10083ui_story"].transform.position).z)
				arg_173_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10083ui_story"].transform.localEulerAngles = arg_173_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, -2.6, -2.8)
				arg_173_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10083ui_story"].transform.position).z)
				arg_173_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10083ui_story"].transform.localEulerAngles = arg_173_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["10083ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect10083ui_story == nil then
				arg_173_1.var_.characterEffect10083ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect10083ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect10083ui_story then
				arg_173_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action1_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_4 = arg_173_1.actors_["10078ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10078ui_story = var_176_4.localPosition
			end

			local var_176_5 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_5 then
				var_176_4.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_173_1.time_ - 0) / var_176_5)
				var_176_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_4.position).x, (manager.ui.mainCamera.transform.position - var_176_4.position).y, (manager.ui.mainCamera.transform.position - var_176_4.position).z)
				var_176_4.localEulerAngles.z = 0
				var_176_4.localEulerAngles.x = 0
				var_176_4.localEulerAngles = var_176_4.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_5 and arg_173_1.time_ < 0 + var_176_5 + arg_176_0 then
				var_176_4.localPosition = Vector3.New(0, 100, 0)
				var_176_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_4.position).x, (manager.ui.mainCamera.transform.position - var_176_4.position).y, (manager.ui.mainCamera.transform.position - var_176_4.position).z)
				var_176_4.localEulerAngles.z = 0
				var_176_4.localEulerAngles.x = 0
				var_176_4.localEulerAngles = var_176_4.localEulerAngles
			end

			local var_176_6 = arg_173_1.actors_["10078ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect10078ui_story == nil then
				arg_173_1.var_.characterEffect10078ui_story = var_176_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_7 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 and not isNil(var_176_6) then
				if arg_173_1.var_.characterEffect10078ui_story and not isNil(var_176_6) then
					arg_173_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_7)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect10078ui_story then
				arg_173_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_176_8 = arg_173_1.actors_["1097ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1097ui_story = var_176_8.localPosition
			end

			local var_176_9 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_9 then
				var_176_8.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_173_1.time_ - 0) / var_176_9)
				var_176_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_8.position).x, (manager.ui.mainCamera.transform.position - var_176_8.position).y, (manager.ui.mainCamera.transform.position - var_176_8.position).z)
				var_176_8.localEulerAngles.z = 0
				var_176_8.localEulerAngles.x = 0
				var_176_8.localEulerAngles = var_176_8.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_9 and arg_173_1.time_ < 0 + var_176_9 + arg_176_0 then
				var_176_8.localPosition = Vector3.New(0, 100, 0)
				var_176_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_8.position).x, (manager.ui.mainCamera.transform.position - var_176_8.position).y, (manager.ui.mainCamera.transform.position - var_176_8.position).z)
				var_176_8.localEulerAngles.z = 0
				var_176_8.localEulerAngles.x = 0
				var_176_8.localEulerAngles = var_176_8.localEulerAngles
			end

			local var_176_10 = arg_173_1.actors_["1097ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_10) and arg_173_1.var_.characterEffect1097ui_story == nil then
				arg_173_1.var_.characterEffect1097ui_story = var_176_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_11 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_11 and not isNil(var_176_10) then
				if arg_173_1.var_.characterEffect1097ui_story and not isNil(var_176_10) then
					arg_173_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_11)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_11 and arg_173_1.time_ < 0 + var_176_11 + arg_176_0 and not isNil(var_176_10) and arg_173_1.var_.characterEffect1097ui_story then
				arg_173_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_176_12 = 0
			local var_176_13 = 1.35

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_12 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_14 = arg_173_1:GetWordFromCfg(412071041)
				local var_176_15 = arg_173_1:FormatText(var_176_14.content)

				arg_173_1.text_.text = var_176_15

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_17 = 54 <= 0 and var_176_13 or var_176_13 * (utf8.len(var_176_15) / 54)

				if (54 <= 0 and var_176_13 or var_176_13 * (utf8.len(var_176_15) / 54)) > 0 and var_176_13 < var_176_17 then
					arg_173_1.talkMaxDuration = var_176_17

					if var_176_17 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_17 + var_176_12
					end
				end

				arg_173_1.text_.text = var_176_15
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071041", "story_v_out_412071.awb") ~= 0 then
					local var_176_18 = manager.audio:GetVoiceLength("story_v_out_412071", "412071041", "story_v_out_412071.awb") / 1000

					if var_176_18 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_18 + var_176_12
					end

					if var_176_14.prefab_name ~= "" and arg_173_1.actors_[var_176_14.prefab_name] ~= nil then
						local var_176_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_14.prefab_name].transform, "story_v_out_412071", "412071041", "story_v_out_412071.awb")

						arg_173_1:RecordAudio("412071041", var_176_19)
						arg_173_1:RecordAudio("412071041", var_176_19)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_412071", "412071041", "story_v_out_412071.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_412071", "412071041", "story_v_out_412071.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_20 = math.max(var_176_13, arg_173_1.talkMaxDuration)

			if var_176_12 <= arg_173_1.time_ and arg_173_1.time_ < var_176_12 + var_176_20 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_12) / var_176_20

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_12 + var_176_20 and arg_173_1.time_ < var_176_12 + var_176_20 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412071042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 412071042
		arg_177_1.duration_ = 5.37

		local var_177_0 = {
			zh = 5.366,
			ja = 4.933
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
				arg_177_0:Play412071043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10078ui_story = arg_177_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10078ui_story"].transform.position).z)
				arg_177_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["10078ui_story"].transform.localEulerAngles = arg_177_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_177_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10078ui_story"].transform.position).z)
				arg_177_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["10078ui_story"].transform.localEulerAngles = arg_177_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["10078ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect10078ui_story == nil then
				arg_177_1.var_.characterEffect10078ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect10078ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect10078ui_story then
				arg_177_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_180_4 = arg_177_1.actors_["10083ui_story"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10083ui_story = var_180_4.localPosition
			end

			local var_180_5 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_5 then
				var_180_4.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_177_1.time_ - 0) / var_180_5)
				var_180_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_4.position).x, (manager.ui.mainCamera.transform.position - var_180_4.position).y, (manager.ui.mainCamera.transform.position - var_180_4.position).z)
				var_180_4.localEulerAngles.z = 0
				var_180_4.localEulerAngles.x = 0
				var_180_4.localEulerAngles = var_180_4.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_5 and arg_177_1.time_ < 0 + var_180_5 + arg_180_0 then
				var_180_4.localPosition = Vector3.New(0, 100, 0)
				var_180_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_4.position).x, (manager.ui.mainCamera.transform.position - var_180_4.position).y, (manager.ui.mainCamera.transform.position - var_180_4.position).z)
				var_180_4.localEulerAngles.z = 0
				var_180_4.localEulerAngles.x = 0
				var_180_4.localEulerAngles = var_180_4.localEulerAngles
			end

			local var_180_6 = arg_177_1.actors_["10083ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect10083ui_story == nil then
				arg_177_1.var_.characterEffect10083ui_story = var_180_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_7 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 and not isNil(var_180_6) then
				if arg_177_1.var_.characterEffect10083ui_story and not isNil(var_180_6) then
					arg_177_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_177_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_7)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect10083ui_story then
				arg_177_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_177_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_180_8 = 0
			local var_180_9 = 0.325

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_10 = arg_177_1:GetWordFromCfg(412071042)
				local var_180_11 = arg_177_1:FormatText(var_180_10.content)

				arg_177_1.text_.text = var_180_11

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_13 = 13 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_11) / 13)

				if (13 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_11) / 13)) > 0 and var_180_9 < var_180_13 then
					arg_177_1.talkMaxDuration = var_180_13

					if var_180_13 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_8
					end
				end

				arg_177_1.text_.text = var_180_11
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071042", "story_v_out_412071.awb") ~= 0 then
					local var_180_14 = manager.audio:GetVoiceLength("story_v_out_412071", "412071042", "story_v_out_412071.awb") / 1000

					if var_180_14 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_14 + var_180_8
					end

					if var_180_10.prefab_name ~= "" and arg_177_1.actors_[var_180_10.prefab_name] ~= nil then
						local var_180_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_10.prefab_name].transform, "story_v_out_412071", "412071042", "story_v_out_412071.awb")

						arg_177_1:RecordAudio("412071042", var_180_15)
						arg_177_1:RecordAudio("412071042", var_180_15)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_412071", "412071042", "story_v_out_412071.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_412071", "412071042", "story_v_out_412071.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_16 = math.max(var_180_9, arg_177_1.talkMaxDuration)

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_16 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_8) / var_180_16

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_8 + var_180_16 and arg_177_1.time_ < var_180_8 + var_180_16 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play412071043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 412071043
		arg_181_1.duration_ = 9.23

		local var_181_0 = {
			zh = 8.166,
			ja = 9.233
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
				arg_181_0:Play412071044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10083ui_story = arg_181_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["10083ui_story"].transform.position).z)
				arg_181_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["10083ui_story"].transform.localEulerAngles = arg_181_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, -2.6, -2.8)
				arg_181_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["10083ui_story"].transform.position).z)
				arg_181_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["10083ui_story"].transform.localEulerAngles = arg_181_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["10083ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect10083ui_story == nil then
				arg_181_1.var_.characterEffect10083ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect10083ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect10083ui_story then
				arg_181_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action4_1")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_184_4 = arg_181_1.actors_["10078ui_story"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10078ui_story = var_184_4.localPosition
			end

			local var_184_5 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_5 then
				var_184_4.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_5)
				var_184_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_4.position).x, (manager.ui.mainCamera.transform.position - var_184_4.position).y, (manager.ui.mainCamera.transform.position - var_184_4.position).z)
				var_184_4.localEulerAngles.z = 0
				var_184_4.localEulerAngles.x = 0
				var_184_4.localEulerAngles = var_184_4.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_5 and arg_181_1.time_ < 0 + var_184_5 + arg_184_0 then
				var_184_4.localPosition = Vector3.New(0, 100, 0)
				var_184_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_4.position).x, (manager.ui.mainCamera.transform.position - var_184_4.position).y, (manager.ui.mainCamera.transform.position - var_184_4.position).z)
				var_184_4.localEulerAngles.z = 0
				var_184_4.localEulerAngles.x = 0
				var_184_4.localEulerAngles = var_184_4.localEulerAngles
			end

			local var_184_6 = arg_181_1.actors_["10078ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_6) and arg_181_1.var_.characterEffect10078ui_story == nil then
				arg_181_1.var_.characterEffect10078ui_story = var_184_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_7 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 and not isNil(var_184_6) then
				if arg_181_1.var_.characterEffect10078ui_story and not isNil(var_184_6) then
					arg_181_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_181_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_7)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 and not isNil(var_184_6) and arg_181_1.var_.characterEffect10078ui_story then
				arg_181_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_181_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_184_8 = 0
			local var_184_9 = 0.925

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_10 = arg_181_1:GetWordFromCfg(412071043)
				local var_184_11 = arg_181_1:FormatText(var_184_10.content)

				arg_181_1.text_.text = var_184_11

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_13 = 37 <= 0 and var_184_9 or var_184_9 * (utf8.len(var_184_11) / 37)

				if (37 <= 0 and var_184_9 or var_184_9 * (utf8.len(var_184_11) / 37)) > 0 and var_184_9 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_8
					end
				end

				arg_181_1.text_.text = var_184_11
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071043", "story_v_out_412071.awb") ~= 0 then
					local var_184_14 = manager.audio:GetVoiceLength("story_v_out_412071", "412071043", "story_v_out_412071.awb") / 1000

					if var_184_14 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_14 + var_184_8
					end

					if var_184_10.prefab_name ~= "" and arg_181_1.actors_[var_184_10.prefab_name] ~= nil then
						local var_184_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_10.prefab_name].transform, "story_v_out_412071", "412071043", "story_v_out_412071.awb")

						arg_181_1:RecordAudio("412071043", var_184_15)
						arg_181_1:RecordAudio("412071043", var_184_15)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_412071", "412071043", "story_v_out_412071.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_412071", "412071043", "story_v_out_412071.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_16 = math.max(var_184_9, arg_181_1.talkMaxDuration)

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_16 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_8) / var_184_16

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_8 + var_184_16 and arg_181_1.time_ < var_184_8 + var_184_16 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play412071044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 412071044
		arg_185_1.duration_ = 4.03

		local var_185_0 = {
			zh = 1.666,
			ja = 4.033
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
				arg_185_0:Play412071045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1097ui_story = arg_185_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1097ui_story"].transform.position).z)
				arg_185_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1097ui_story"].transform.localEulerAngles = arg_185_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_185_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1097ui_story"].transform.position).z)
				arg_185_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1097ui_story"].transform.localEulerAngles = arg_185_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["1097ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1097ui_story == nil then
				arg_185_1.var_.characterEffect1097ui_story = var_188_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 and not isNil(var_188_1) then
				if arg_185_1.var_.characterEffect1097ui_story and not isNil(var_188_1) then
					arg_185_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1097ui_story then
				arg_185_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_188_4 = arg_185_1.actors_["10083ui_story"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10083ui_story = var_188_4.localPosition
			end

			local var_188_5 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_5 then
				var_188_4.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 0) / var_188_5)
				var_188_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_4.position).x, (manager.ui.mainCamera.transform.position - var_188_4.position).y, (manager.ui.mainCamera.transform.position - var_188_4.position).z)
				var_188_4.localEulerAngles.z = 0
				var_188_4.localEulerAngles.x = 0
				var_188_4.localEulerAngles = var_188_4.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_5 and arg_185_1.time_ < 0 + var_188_5 + arg_188_0 then
				var_188_4.localPosition = Vector3.New(0, 100, 0)
				var_188_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_4.position).x, (manager.ui.mainCamera.transform.position - var_188_4.position).y, (manager.ui.mainCamera.transform.position - var_188_4.position).z)
				var_188_4.localEulerAngles.z = 0
				var_188_4.localEulerAngles.x = 0
				var_188_4.localEulerAngles = var_188_4.localEulerAngles
			end

			local var_188_6 = arg_185_1.actors_["10083ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect10083ui_story == nil then
				arg_185_1.var_.characterEffect10083ui_story = var_188_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_7 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 and not isNil(var_188_6) then
				if arg_185_1.var_.characterEffect10083ui_story and not isNil(var_188_6) then
					arg_185_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_185_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_7)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect10083ui_story then
				arg_185_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_185_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_188_8 = 0
			local var_188_9 = 0.15

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_10 = arg_185_1:GetWordFromCfg(412071044)
				local var_188_11 = arg_185_1:FormatText(var_188_10.content)

				arg_185_1.text_.text = var_188_11

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 6 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 6)

				if (6 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 6)) > 0 and var_188_9 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_11
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071044", "story_v_out_412071.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_out_412071", "412071044", "story_v_out_412071.awb") / 1000

					if var_188_14 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_8
					end

					if var_188_10.prefab_name ~= "" and arg_185_1.actors_[var_188_10.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_10.prefab_name].transform, "story_v_out_412071", "412071044", "story_v_out_412071.awb")

						arg_185_1:RecordAudio("412071044", var_188_15)
						arg_185_1:RecordAudio("412071044", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_412071", "412071044", "story_v_out_412071.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_412071", "412071044", "story_v_out_412071.awb")
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
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
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
	Play412071045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 412071045
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play412071046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1097ui_story = arg_189_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1097ui_story"].transform.position).z)
				arg_189_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1097ui_story"].transform.localEulerAngles = arg_189_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1097ui_story"].transform.position).z)
				arg_189_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1097ui_story"].transform.localEulerAngles = arg_189_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_192_1 = arg_189_1.actors_["1097ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1097ui_story == nil then
				arg_189_1.var_.characterEffect1097ui_story = var_192_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 and not isNil(var_192_1) then
				if arg_189_1.var_.characterEffect1097ui_story and not isNil(var_192_1) then
					arg_189_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_2)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1097ui_story then
				arg_189_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_192_3 = 0
			local var_192_4 = 0.7

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_3 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_5 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(412071045).content)

				arg_189_1.text_.text = var_192_5

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_7 = 28 <= 0 and var_192_4 or var_192_4 * (utf8.len(var_192_5) / 28)

				if (28 <= 0 and var_192_4 or var_192_4 * (utf8.len(var_192_5) / 28)) > 0 and var_192_4 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_3 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_3
					end
				end

				arg_189_1.text_.text = var_192_5
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_8 = math.max(var_192_4, arg_189_1.talkMaxDuration)

			if var_192_3 <= arg_189_1.time_ and arg_189_1.time_ < var_192_3 + var_192_8 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_3) / var_192_8

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_3 + var_192_8 and arg_189_1.time_ < var_192_3 + var_192_8 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412071046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 412071046
		arg_193_1.duration_ = 4.43

		local var_193_0 = {
			zh = 3.233,
			ja = 4.433
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
				arg_193_0:Play412071047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10078ui_story = arg_193_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10078ui_story"].transform.position).z)
				arg_193_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["10078ui_story"].transform.localEulerAngles = arg_193_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_193_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10078ui_story"].transform.position).z)
				arg_193_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["10078ui_story"].transform.localEulerAngles = arg_193_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["10078ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect10078ui_story == nil then
				arg_193_1.var_.characterEffect10078ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect10078ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect10078ui_story then
				arg_193_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_196_4 = 0
			local var_196_5 = 0.175

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(412071046)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 7 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 7)

				if (7 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 7)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071046", "story_v_out_412071.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_out_412071", "412071046", "story_v_out_412071.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_out_412071", "412071046", "story_v_out_412071.awb")

						arg_193_1:RecordAudio("412071046", var_196_11)
						arg_193_1:RecordAudio("412071046", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_412071", "412071046", "story_v_out_412071.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_412071", "412071046", "story_v_out_412071.awb")
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

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play412071047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 412071047
		arg_197_1.duration_ = 3.63

		local var_197_0 = {
			zh = 3.633,
			ja = 1.999999999999
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
				arg_197_0:Play412071048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1097ui_story = arg_197_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1097ui_story"].transform.position).z)
				arg_197_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1097ui_story"].transform.localEulerAngles = arg_197_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_197_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1097ui_story"].transform.position).z)
				arg_197_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1097ui_story"].transform.localEulerAngles = arg_197_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["1097ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1097ui_story == nil then
				arg_197_1.var_.characterEffect1097ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect1097ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1097ui_story then
				arg_197_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_200_4 = arg_197_1.actors_["10078ui_story"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos10078ui_story = var_200_4.localPosition
			end

			local var_200_5 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_5 then
				var_200_4.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_197_1.time_ - 0) / var_200_5)
				var_200_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_4.position).x, (manager.ui.mainCamera.transform.position - var_200_4.position).y, (manager.ui.mainCamera.transform.position - var_200_4.position).z)
				var_200_4.localEulerAngles.z = 0
				var_200_4.localEulerAngles.x = 0
				var_200_4.localEulerAngles = var_200_4.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_5 and arg_197_1.time_ < 0 + var_200_5 + arg_200_0 then
				var_200_4.localPosition = Vector3.New(0, 100, 0)
				var_200_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_4.position).x, (manager.ui.mainCamera.transform.position - var_200_4.position).y, (manager.ui.mainCamera.transform.position - var_200_4.position).z)
				var_200_4.localEulerAngles.z = 0
				var_200_4.localEulerAngles.x = 0
				var_200_4.localEulerAngles = var_200_4.localEulerAngles
			end

			local var_200_6 = arg_197_1.actors_["10078ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_6) and arg_197_1.var_.characterEffect10078ui_story == nil then
				arg_197_1.var_.characterEffect10078ui_story = var_200_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_7 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 and not isNil(var_200_6) then
				if arg_197_1.var_.characterEffect10078ui_story and not isNil(var_200_6) then
					arg_197_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_197_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_7)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 and not isNil(var_200_6) and arg_197_1.var_.characterEffect10078ui_story then
				arg_197_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_197_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_200_8 = 0
			local var_200_9 = 0.4

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_10 = arg_197_1:GetWordFromCfg(412071047)
				local var_200_11 = arg_197_1:FormatText(var_200_10.content)

				arg_197_1.text_.text = var_200_11

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_13 = 16 <= 0 and var_200_9 or var_200_9 * (utf8.len(var_200_11) / 16)

				if (16 <= 0 and var_200_9 or var_200_9 * (utf8.len(var_200_11) / 16)) > 0 and var_200_9 < var_200_13 then
					arg_197_1.talkMaxDuration = var_200_13

					if var_200_13 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_13 + var_200_8
					end
				end

				arg_197_1.text_.text = var_200_11
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071047", "story_v_out_412071.awb") ~= 0 then
					local var_200_14 = manager.audio:GetVoiceLength("story_v_out_412071", "412071047", "story_v_out_412071.awb") / 1000

					if var_200_14 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_14 + var_200_8
					end

					if var_200_10.prefab_name ~= "" and arg_197_1.actors_[var_200_10.prefab_name] ~= nil then
						local var_200_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_10.prefab_name].transform, "story_v_out_412071", "412071047", "story_v_out_412071.awb")

						arg_197_1:RecordAudio("412071047", var_200_15)
						arg_197_1:RecordAudio("412071047", var_200_15)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_412071", "412071047", "story_v_out_412071.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_412071", "412071047", "story_v_out_412071.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_16 = math.max(var_200_9, arg_197_1.talkMaxDuration)

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_16 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_8) / var_200_16

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_8 + var_200_16 and arg_197_1.time_ < var_200_8 + var_200_16 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play412071048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 412071048
		arg_201_1.duration_ = 7.17

		local var_201_0 = {
			zh = 5.133,
			ja = 7.166
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
				arg_201_0:Play412071049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.625

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:GetWordFromCfg(412071048)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 25 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 25)

				if (25 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 25)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071048", "story_v_out_412071.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_412071", "412071048", "story_v_out_412071.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_412071", "412071048", "story_v_out_412071.awb")

						arg_201_1:RecordAudio("412071048", var_204_6)
						arg_201_1:RecordAudio("412071048", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_412071", "412071048", "story_v_out_412071.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_412071", "412071048", "story_v_out_412071.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play412071049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 412071049
		arg_205_1.duration_ = 15.1

		local var_205_0 = {
			zh = 9.43300000298023,
			ja = 15.1000000029802
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
				arg_205_0:Play412071050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if arg_205_1.bgs_.F02_1 == nil then
				local var_208_0 = Object.Instantiate(arg_205_1.paintGo_)

				var_208_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F02_1")
				var_208_0.name = "F02_1"
				var_208_0.transform.parent = arg_205_1.stage_.transform
				var_208_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_205_1.bgs_.F02_1 = var_208_0
			end

			if 2.00000000298023 < arg_205_1.time_ and arg_205_1.time_ <= 2.00000000298023 + arg_208_0 then
				local var_208_1 = arg_205_1.bgs_.F02_1

				arg_205_1.bgs_.F02_1.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_208_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_208_2 = var_208_1:GetComponent("SpriteRenderer")

				if var_208_2 and var_208_2.sprite then
					local var_208_3 = 2 * (var_208_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_208_1.transform.localScale = Vector3.New(var_208_3 / var_208_2.sprite.bounds.size.y < var_208_3 * manager.ui.mainCameraCom_.aspect / var_208_2.sprite.bounds.size.x and var_208_3 * manager.ui.mainCameraCom_.aspect / var_208_2.sprite.bounds.size.x or var_208_3 / var_208_2.sprite.bounds.size.y, var_208_3 / var_208_2.sprite.bounds.size.y < var_208_3 * manager.ui.mainCameraCom_.aspect / var_208_2.sprite.bounds.size.x and var_208_3 * manager.ui.mainCameraCom_.aspect / var_208_2.sprite.bounds.size.x or var_208_3 / var_208_2.sprite.bounds.size.y, 0)
				end

				for iter_208_0, iter_208_1 in pairs(arg_205_1.bgs_) do
					if iter_208_0 ~= "F02_1" then
						iter_208_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_208_4 = 4.00000000298023

			if 4.00000000298023 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.allBtn_.enabled = false
			end

			if arg_205_1.time_ >= var_208_4 + 0.3 and arg_205_1.time_ < var_208_4 + 0.3 + arg_208_0 then
				arg_205_1.allBtn_.enabled = true
			end

			local var_208_5 = 0

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_6 = 2

			if var_208_5 <= arg_205_1.time_ and arg_205_1.time_ < var_208_5 + var_208_6 then
				local var_208_7 = Color.New(0, 0, 0)

				var_208_7.a = Mathf.Lerp(0, 1, (arg_205_1.time_ - var_208_5) / var_208_6)
				arg_205_1.mask_.color = var_208_7
			end

			if arg_205_1.time_ >= var_208_5 + var_208_6 and arg_205_1.time_ < var_208_5 + var_208_6 + arg_208_0 then
				local var_208_8 = Color.New(0, 0, 0)

				var_208_8.a = 1
				arg_205_1.mask_.color = var_208_8
			end

			local var_208_9 = 2

			if 2 < arg_205_1.time_ and arg_205_1.time_ <= var_208_9 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_10 = 2

			if var_208_9 <= arg_205_1.time_ and arg_205_1.time_ < var_208_9 + var_208_10 then
				local var_208_11 = Color.New(0, 0, 0)

				var_208_11.a = Mathf.Lerp(1, 0, (arg_205_1.time_ - var_208_9) / var_208_10)
				arg_205_1.mask_.color = var_208_11
			end

			if arg_205_1.time_ >= var_208_9 + var_208_10 and arg_205_1.time_ < var_208_9 + var_208_10 + arg_208_0 then
				local var_208_12 = Color.New(0, 0, 0)

				arg_205_1.mask_.enabled = false
				var_208_12.a = 0
				arg_205_1.mask_.color = var_208_12
			end

			local var_208_13 = arg_205_1.actors_["1097ui_story"].transform

			if 3.8 < arg_205_1.time_ and arg_205_1.time_ <= 3.8 + arg_208_0 then
				arg_205_1.var_.moveOldPos1097ui_story = var_208_13.localPosition
			end

			local var_208_14 = 0.001

			if 3.8 <= arg_205_1.time_ and arg_205_1.time_ < 3.8 + var_208_14 then
				var_208_13.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_205_1.time_ - 3.8) / var_208_14)
				var_208_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_13.position).x, (manager.ui.mainCamera.transform.position - var_208_13.position).y, (manager.ui.mainCamera.transform.position - var_208_13.position).z)
				var_208_13.localEulerAngles.z = 0
				var_208_13.localEulerAngles.x = 0
				var_208_13.localEulerAngles = var_208_13.localEulerAngles
			end

			if arg_205_1.time_ >= 3.8 + var_208_14 and arg_205_1.time_ < 3.8 + var_208_14 + arg_208_0 then
				var_208_13.localPosition = Vector3.New(0, -0.54, -6.3)
				var_208_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_13.position).x, (manager.ui.mainCamera.transform.position - var_208_13.position).y, (manager.ui.mainCamera.transform.position - var_208_13.position).z)
				var_208_13.localEulerAngles.z = 0
				var_208_13.localEulerAngles.x = 0
				var_208_13.localEulerAngles = var_208_13.localEulerAngles
			end

			local var_208_15 = arg_205_1.actors_["1097ui_story"]

			if 3.8 < arg_205_1.time_ and arg_205_1.time_ <= 3.8 + arg_208_0 and not isNil(var_208_15) and arg_205_1.var_.characterEffect1097ui_story == nil then
				arg_205_1.var_.characterEffect1097ui_story = var_208_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_16 = 0.200000002980232

			if 3.8 <= arg_205_1.time_ and arg_205_1.time_ < 3.8 + var_208_16 and not isNil(var_208_15) then
				if arg_205_1.var_.characterEffect1097ui_story and not isNil(var_208_15) then
					arg_205_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 3.8 + var_208_16 and arg_205_1.time_ < 3.8 + var_208_16 + arg_208_0 and not isNil(var_208_15) and arg_205_1.var_.characterEffect1097ui_story then
				arg_205_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 3.8 < arg_205_1.time_ and arg_205_1.time_ <= 3.8 + arg_208_0 then
				arg_205_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 3.8 < arg_205_1.time_ and arg_205_1.time_ <= 3.8 + arg_208_0 then
				arg_205_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_208_18 = arg_205_1.actors_["1097ui_story"].transform

			if 1.96599999815226 < arg_205_1.time_ and arg_205_1.time_ <= 1.96599999815226 + arg_208_0 then
				arg_205_1.var_.moveOldPos1097ui_story = var_208_18.localPosition
			end

			local var_208_19 = 0.001

			if 1.96599999815226 <= arg_205_1.time_ and arg_205_1.time_ < 1.96599999815226 + var_208_19 then
				var_208_18.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_205_1.time_ - 1.96599999815226) / var_208_19)
				var_208_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_18.position).x, (manager.ui.mainCamera.transform.position - var_208_18.position).y, (manager.ui.mainCamera.transform.position - var_208_18.position).z)
				var_208_18.localEulerAngles.z = 0
				var_208_18.localEulerAngles.x = 0
				var_208_18.localEulerAngles = var_208_18.localEulerAngles
			end

			if arg_205_1.time_ >= 1.96599999815226 + var_208_19 and arg_205_1.time_ < 1.96599999815226 + var_208_19 + arg_208_0 then
				var_208_18.localPosition = Vector3.New(0, 100, 0)
				var_208_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_18.position).x, (manager.ui.mainCamera.transform.position - var_208_18.position).y, (manager.ui.mainCamera.transform.position - var_208_18.position).z)
				var_208_18.localEulerAngles.z = 0
				var_208_18.localEulerAngles.x = 0
				var_208_18.localEulerAngles = var_208_18.localEulerAngles
			end

			if arg_205_1.frameCnt_ <= 1 then
				arg_205_1.dialog_:SetActive(false)
			end

			local var_208_20 = 4.00000000298023
			local var_208_21 = 0.5

			if 4.00000000298023 < arg_205_1.time_ and arg_205_1.time_ <= var_208_20 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0

				arg_205_1.dialog_:SetActive(true)

				arg_205_1.dialogCg_.alpha = 0

				local var_208_22 = LeanTween.value(arg_205_1.dialog_, 0, 1, 0.3)

				var_208_22:setOnUpdate(LuaHelper.FloatAction(function(arg_209_0)
					arg_205_1.dialogCg_.alpha = arg_209_0
				end))
				var_208_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_205_1.dialog_)
					var_208_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_205_1.duration_ = arg_205_1.duration_ + 0.3

				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_23 = arg_205_1:GetWordFromCfg(412071049)
				local var_208_24 = arg_205_1:FormatText(var_208_23.content)

				arg_205_1.text_.text = var_208_24

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_26 = 20 <= 0 and var_208_21 or var_208_21 * (utf8.len(var_208_24) / 20)

				if (20 <= 0 and var_208_21 or var_208_21 * (utf8.len(var_208_24) / 20)) > 0 and var_208_21 < var_208_26 then
					arg_205_1.talkMaxDuration = var_208_26
					var_208_20 = var_208_20 + 0.3

					if var_208_26 + var_208_20 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_26 + var_208_20
					end
				end

				arg_205_1.text_.text = var_208_24
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071049", "story_v_out_412071.awb") ~= 0 then
					local var_208_27 = manager.audio:GetVoiceLength("story_v_out_412071", "412071049", "story_v_out_412071.awb") / 1000

					if var_208_27 + var_208_20 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_27 + var_208_20
					end

					if var_208_23.prefab_name ~= "" and arg_205_1.actors_[var_208_23.prefab_name] ~= nil then
						local var_208_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_23.prefab_name].transform, "story_v_out_412071", "412071049", "story_v_out_412071.awb")

						arg_205_1:RecordAudio("412071049", var_208_28)
						arg_205_1:RecordAudio("412071049", var_208_28)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_412071", "412071049", "story_v_out_412071.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_412071", "412071049", "story_v_out_412071.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_29 = var_208_20 + 0.3
			local var_208_30 = math.max(var_208_21, arg_205_1.talkMaxDuration)

			if var_208_20 + 0.3 <= arg_205_1.time_ and arg_205_1.time_ < var_208_29 + var_208_30 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_29) / var_208_30

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_29 + var_208_30 and arg_205_1.time_ < var_208_29 + var_208_30 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play412071050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 412071050
		arg_211_1.duration_ = 3.37

		local var_211_0 = {
			zh = 2.133,
			ja = 3.366
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play412071051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1097ui_story = arg_211_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1097ui_story"].transform.position).z)
				arg_211_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1097ui_story"].transform.localEulerAngles = arg_211_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1097ui_story"].transform.position).z)
				arg_211_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1097ui_story"].transform.localEulerAngles = arg_211_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["1097ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1097ui_story == nil then
				arg_211_1.var_.characterEffect1097ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect1097ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_2)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1097ui_story then
				arg_211_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_214_3 = manager.ui.mainCamera.transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.shakeOldPos = var_214_3.localPosition
			end

			local var_214_4 = 1

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				local var_214_5, var_214_6 = math.modf((arg_211_1.time_ - 0) / 0.066)

				var_214_3.localPosition = Vector3.New(var_214_6 * 0.13, var_214_6 * 0.13, var_214_6 * 0.13) + arg_211_1.var_.shakeOldPos
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				var_214_3.localPosition = arg_211_1.var_.shakeOldPos
			end

			local var_214_7 = 0

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_7 + arg_214_0 then
				arg_211_1.allBtn_.enabled = false
			end

			if arg_211_1.time_ >= var_214_7 + 1 and arg_211_1.time_ < var_214_7 + 1 + arg_214_0 then
				arg_211_1.allBtn_.enabled = true
			end

			local var_214_8 = 0
			local var_214_9 = 0.45

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_8 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[913].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097_sheep")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_10 = arg_211_1:GetWordFromCfg(412071050)
				local var_214_11 = arg_211_1:FormatText(var_214_10.content)

				arg_211_1.text_.text = var_214_11

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_13 = 18 <= 0 and var_214_9 or var_214_9 * (utf8.len(var_214_11) / 18)

				if (18 <= 0 and var_214_9 or var_214_9 * (utf8.len(var_214_11) / 18)) > 0 and var_214_9 < var_214_13 then
					arg_211_1.talkMaxDuration = var_214_13

					if var_214_13 + var_214_8 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_13 + var_214_8
					end
				end

				arg_211_1.text_.text = var_214_11
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071050", "story_v_out_412071.awb") ~= 0 then
					local var_214_14 = manager.audio:GetVoiceLength("story_v_out_412071", "412071050", "story_v_out_412071.awb") / 1000

					if var_214_14 + var_214_8 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_14 + var_214_8
					end

					if var_214_10.prefab_name ~= "" and arg_211_1.actors_[var_214_10.prefab_name] ~= nil then
						local var_214_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_10.prefab_name].transform, "story_v_out_412071", "412071050", "story_v_out_412071.awb")

						arg_211_1:RecordAudio("412071050", var_214_15)
						arg_211_1:RecordAudio("412071050", var_214_15)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_412071", "412071050", "story_v_out_412071.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_412071", "412071050", "story_v_out_412071.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_16 = math.max(var_214_9, arg_211_1.talkMaxDuration)

			if var_214_8 <= arg_211_1.time_ and arg_211_1.time_ < var_214_8 + var_214_16 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_8) / var_214_16

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_8 + var_214_16 and arg_211_1.time_ < var_214_8 + var_214_16 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play412071051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 412071051
		arg_215_1.duration_ = 5.33

		local var_215_0 = {
			zh = 4.433,
			ja = 5.333
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play412071052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos10078ui_story = arg_215_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["10078ui_story"].transform.position).z)
				arg_215_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["10078ui_story"].transform.localEulerAngles = arg_215_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_215_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["10078ui_story"].transform.position).z)
				arg_215_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["10078ui_story"].transform.localEulerAngles = arg_215_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["10078ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect10078ui_story == nil then
				arg_215_1.var_.characterEffect10078ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect10078ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect10078ui_story then
				arg_215_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action2_1")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_218_4 = 0
			local var_218_5 = 0.325

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_6 = arg_215_1:GetWordFromCfg(412071051)
				local var_218_7 = arg_215_1:FormatText(var_218_6.content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 13 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 13)

				if (13 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 13)) > 0 and var_218_5 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_4
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071051", "story_v_out_412071.awb") ~= 0 then
					local var_218_10 = manager.audio:GetVoiceLength("story_v_out_412071", "412071051", "story_v_out_412071.awb") / 1000

					if var_218_10 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_4
					end

					if var_218_6.prefab_name ~= "" and arg_215_1.actors_[var_218_6.prefab_name] ~= nil then
						local var_218_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_6.prefab_name].transform, "story_v_out_412071", "412071051", "story_v_out_412071.awb")

						arg_215_1:RecordAudio("412071051", var_218_11)
						arg_215_1:RecordAudio("412071051", var_218_11)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_412071", "412071051", "story_v_out_412071.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_412071", "412071051", "story_v_out_412071.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_12 = math.max(var_218_5, arg_215_1.talkMaxDuration)

			if var_218_4 <= arg_215_1.time_ and arg_215_1.time_ < var_218_4 + var_218_12 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_4) / var_218_12

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_4 + var_218_12 and arg_215_1.time_ < var_218_4 + var_218_12 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play412071052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 412071052
		arg_219_1.duration_ = 4

		local var_219_0 = {
			zh = 2.9,
			ja = 4
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play412071053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos10083ui_story = arg_219_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10083ui_story"].transform.position).z)
				arg_219_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["10083ui_story"].transform.localEulerAngles = arg_219_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, -2.6, -2.8)
				arg_219_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10083ui_story"].transform.position).z)
				arg_219_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["10083ui_story"].transform.localEulerAngles = arg_219_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_222_1 = arg_219_1.actors_["10083ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect10083ui_story == nil then
				arg_219_1.var_.characterEffect10083ui_story = var_222_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 and not isNil(var_222_1) then
				if arg_219_1.var_.characterEffect10083ui_story and not isNil(var_222_1) then
					arg_219_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect10083ui_story then
				arg_219_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action5_1")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_222_4 = arg_219_1.actors_["10078ui_story"].transform

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos10078ui_story = var_222_4.localPosition
			end

			local var_222_5 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_5 then
				var_222_4.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_219_1.time_ - 0) / var_222_5)
				var_222_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_4.position).x, (manager.ui.mainCamera.transform.position - var_222_4.position).y, (manager.ui.mainCamera.transform.position - var_222_4.position).z)
				var_222_4.localEulerAngles.z = 0
				var_222_4.localEulerAngles.x = 0
				var_222_4.localEulerAngles = var_222_4.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_5 and arg_219_1.time_ < 0 + var_222_5 + arg_222_0 then
				var_222_4.localPosition = Vector3.New(0, 100, 0)
				var_222_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_4.position).x, (manager.ui.mainCamera.transform.position - var_222_4.position).y, (manager.ui.mainCamera.transform.position - var_222_4.position).z)
				var_222_4.localEulerAngles.z = 0
				var_222_4.localEulerAngles.x = 0
				var_222_4.localEulerAngles = var_222_4.localEulerAngles
			end

			local var_222_6 = arg_219_1.actors_["10078ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_6) and arg_219_1.var_.characterEffect10078ui_story == nil then
				arg_219_1.var_.characterEffect10078ui_story = var_222_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_7 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_7 and not isNil(var_222_6) then
				if arg_219_1.var_.characterEffect10078ui_story and not isNil(var_222_6) then
					arg_219_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_219_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_7)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_7 and arg_219_1.time_ < 0 + var_222_7 + arg_222_0 and not isNil(var_222_6) and arg_219_1.var_.characterEffect10078ui_story then
				arg_219_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_219_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_222_8 = 0
			local var_222_9 = 0.325

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_10 = arg_219_1:GetWordFromCfg(412071052)
				local var_222_11 = arg_219_1:FormatText(var_222_10.content)

				arg_219_1.text_.text = var_222_11

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_13 = 13 <= 0 and var_222_9 or var_222_9 * (utf8.len(var_222_11) / 13)

				if (13 <= 0 and var_222_9 or var_222_9 * (utf8.len(var_222_11) / 13)) > 0 and var_222_9 < var_222_13 then
					arg_219_1.talkMaxDuration = var_222_13

					if var_222_13 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_13 + var_222_8
					end
				end

				arg_219_1.text_.text = var_222_11
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071052", "story_v_out_412071.awb") ~= 0 then
					local var_222_14 = manager.audio:GetVoiceLength("story_v_out_412071", "412071052", "story_v_out_412071.awb") / 1000

					if var_222_14 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_14 + var_222_8
					end

					if var_222_10.prefab_name ~= "" and arg_219_1.actors_[var_222_10.prefab_name] ~= nil then
						local var_222_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_10.prefab_name].transform, "story_v_out_412071", "412071052", "story_v_out_412071.awb")

						arg_219_1:RecordAudio("412071052", var_222_15)
						arg_219_1:RecordAudio("412071052", var_222_15)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_412071", "412071052", "story_v_out_412071.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_412071", "412071052", "story_v_out_412071.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_16 = math.max(var_222_9, arg_219_1.talkMaxDuration)

			if var_222_8 <= arg_219_1.time_ and arg_219_1.time_ < var_222_8 + var_222_16 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_8) / var_222_16

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_8 + var_222_16 and arg_219_1.time_ < var_222_8 + var_222_16 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play412071053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 412071053
		arg_223_1.duration_ = 10.63

		local var_223_0 = {
			zh = 3.266,
			ja = 10.633
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play412071054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1097ui_story = arg_223_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1097ui_story"].transform.position).z)
				arg_223_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1097ui_story"].transform.localEulerAngles = arg_223_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_223_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1097ui_story"].transform.position).z)
				arg_223_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1097ui_story"].transform.localEulerAngles = arg_223_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["1097ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1097ui_story == nil then
				arg_223_1.var_.characterEffect1097ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect1097ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1097ui_story then
				arg_223_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_226_4 = arg_223_1.actors_["10083ui_story"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos10083ui_story = var_226_4.localPosition
			end

			local var_226_5 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_5 then
				var_226_4.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 0) / var_226_5)
				var_226_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_4.position).x, (manager.ui.mainCamera.transform.position - var_226_4.position).y, (manager.ui.mainCamera.transform.position - var_226_4.position).z)
				var_226_4.localEulerAngles.z = 0
				var_226_4.localEulerAngles.x = 0
				var_226_4.localEulerAngles = var_226_4.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_5 and arg_223_1.time_ < 0 + var_226_5 + arg_226_0 then
				var_226_4.localPosition = Vector3.New(0, 100, 0)
				var_226_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_4.position).x, (manager.ui.mainCamera.transform.position - var_226_4.position).y, (manager.ui.mainCamera.transform.position - var_226_4.position).z)
				var_226_4.localEulerAngles.z = 0
				var_226_4.localEulerAngles.x = 0
				var_226_4.localEulerAngles = var_226_4.localEulerAngles
			end

			local var_226_6 = arg_223_1.actors_["10083ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_6) and arg_223_1.var_.characterEffect10083ui_story == nil then
				arg_223_1.var_.characterEffect10083ui_story = var_226_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_7 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_7 and not isNil(var_226_6) then
				if arg_223_1.var_.characterEffect10083ui_story and not isNil(var_226_6) then
					arg_223_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_223_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_7)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_7 and arg_223_1.time_ < 0 + var_226_7 + arg_226_0 and not isNil(var_226_6) and arg_223_1.var_.characterEffect10083ui_story then
				arg_223_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_223_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_226_8 = 0
			local var_226_9 = 0.375

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_10 = arg_223_1:GetWordFromCfg(412071053)
				local var_226_11 = arg_223_1:FormatText(var_226_10.content)

				arg_223_1.text_.text = var_226_11

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_13 = 15 <= 0 and var_226_9 or var_226_9 * (utf8.len(var_226_11) / 15)

				if (15 <= 0 and var_226_9 or var_226_9 * (utf8.len(var_226_11) / 15)) > 0 and var_226_9 < var_226_13 then
					arg_223_1.talkMaxDuration = var_226_13

					if var_226_13 + var_226_8 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_13 + var_226_8
					end
				end

				arg_223_1.text_.text = var_226_11
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071053", "story_v_out_412071.awb") ~= 0 then
					local var_226_14 = manager.audio:GetVoiceLength("story_v_out_412071", "412071053", "story_v_out_412071.awb") / 1000

					if var_226_14 + var_226_8 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_14 + var_226_8
					end

					if var_226_10.prefab_name ~= "" and arg_223_1.actors_[var_226_10.prefab_name] ~= nil then
						local var_226_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_10.prefab_name].transform, "story_v_out_412071", "412071053", "story_v_out_412071.awb")

						arg_223_1:RecordAudio("412071053", var_226_15)
						arg_223_1:RecordAudio("412071053", var_226_15)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_412071", "412071053", "story_v_out_412071.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_412071", "412071053", "story_v_out_412071.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_16 = math.max(var_226_9, arg_223_1.talkMaxDuration)

			if var_226_8 <= arg_223_1.time_ and arg_223_1.time_ < var_226_8 + var_226_16 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_8) / var_226_16

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_8 + var_226_16 and arg_223_1.time_ < var_226_8 + var_226_16 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play412071054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 412071054
		arg_227_1.duration_ = 9.6

		local var_227_0 = {
			zh = 9.6,
			ja = 9.133
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play412071055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos10078ui_story = arg_227_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["10078ui_story"].transform.position).z)
				arg_227_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["10078ui_story"].transform.localEulerAngles = arg_227_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_227_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["10078ui_story"].transform.position).z)
				arg_227_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["10078ui_story"].transform.localEulerAngles = arg_227_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["10078ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect10078ui_story == nil then
				arg_227_1.var_.characterEffect10078ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect10078ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect10078ui_story then
				arg_227_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046actionlink/6046action425")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_230_4 = arg_227_1.actors_["1097ui_story"].transform

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1097ui_story = var_230_4.localPosition
			end

			local var_230_5 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_5 then
				var_230_4.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_227_1.time_ - 0) / var_230_5)
				var_230_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_4.position).x, (manager.ui.mainCamera.transform.position - var_230_4.position).y, (manager.ui.mainCamera.transform.position - var_230_4.position).z)
				var_230_4.localEulerAngles.z = 0
				var_230_4.localEulerAngles.x = 0
				var_230_4.localEulerAngles = var_230_4.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_5 and arg_227_1.time_ < 0 + var_230_5 + arg_230_0 then
				var_230_4.localPosition = Vector3.New(0, 100, 0)
				var_230_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_4.position).x, (manager.ui.mainCamera.transform.position - var_230_4.position).y, (manager.ui.mainCamera.transform.position - var_230_4.position).z)
				var_230_4.localEulerAngles.z = 0
				var_230_4.localEulerAngles.x = 0
				var_230_4.localEulerAngles = var_230_4.localEulerAngles
			end

			local var_230_6 = arg_227_1.actors_["1097ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_6) and arg_227_1.var_.characterEffect1097ui_story == nil then
				arg_227_1.var_.characterEffect1097ui_story = var_230_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_7 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 and not isNil(var_230_6) then
				if arg_227_1.var_.characterEffect1097ui_story and not isNil(var_230_6) then
					arg_227_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_7)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 and not isNil(var_230_6) and arg_227_1.var_.characterEffect1097ui_story then
				arg_227_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_230_8 = 0
			local var_230_9 = 0.725

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_10 = arg_227_1:GetWordFromCfg(412071054)
				local var_230_11 = arg_227_1:FormatText(var_230_10.content)

				arg_227_1.text_.text = var_230_11

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_13 = 29 <= 0 and var_230_9 or var_230_9 * (utf8.len(var_230_11) / 29)

				if (29 <= 0 and var_230_9 or var_230_9 * (utf8.len(var_230_11) / 29)) > 0 and var_230_9 < var_230_13 then
					arg_227_1.talkMaxDuration = var_230_13

					if var_230_13 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_13 + var_230_8
					end
				end

				arg_227_1.text_.text = var_230_11
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071054", "story_v_out_412071.awb") ~= 0 then
					local var_230_14 = manager.audio:GetVoiceLength("story_v_out_412071", "412071054", "story_v_out_412071.awb") / 1000

					if var_230_14 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_14 + var_230_8
					end

					if var_230_10.prefab_name ~= "" and arg_227_1.actors_[var_230_10.prefab_name] ~= nil then
						local var_230_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_10.prefab_name].transform, "story_v_out_412071", "412071054", "story_v_out_412071.awb")

						arg_227_1:RecordAudio("412071054", var_230_15)
						arg_227_1:RecordAudio("412071054", var_230_15)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_412071", "412071054", "story_v_out_412071.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_412071", "412071054", "story_v_out_412071.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_16 = math.max(var_230_9, arg_227_1.talkMaxDuration)

			if var_230_8 <= arg_227_1.time_ and arg_227_1.time_ < var_230_8 + var_230_16 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_8) / var_230_16

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_8 + var_230_16 and arg_227_1.time_ < var_230_8 + var_230_16 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play412071055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 412071055
		arg_231_1.duration_ = 8.73

		local var_231_0 = {
			zh = 8.133,
			ja = 8.733
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play412071056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.65

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_1 = arg_231_1:GetWordFromCfg(412071055)
				local var_234_2 = arg_231_1:FormatText(var_234_1.content)

				arg_231_1.text_.text = var_234_2

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_4 = 26 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 26)

				if (26 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 26)) > 0 and var_234_0 < var_234_4 then
					arg_231_1.talkMaxDuration = var_234_4

					if var_234_4 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_4 + 0
					end
				end

				arg_231_1.text_.text = var_234_2
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071055", "story_v_out_412071.awb") ~= 0 then
					local var_234_5 = manager.audio:GetVoiceLength("story_v_out_412071", "412071055", "story_v_out_412071.awb") / 1000

					if var_234_5 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + 0
					end

					if var_234_1.prefab_name ~= "" and arg_231_1.actors_[var_234_1.prefab_name] ~= nil then
						local var_234_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_1.prefab_name].transform, "story_v_out_412071", "412071055", "story_v_out_412071.awb")

						arg_231_1:RecordAudio("412071055", var_234_6)
						arg_231_1:RecordAudio("412071055", var_234_6)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_412071", "412071055", "story_v_out_412071.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_412071", "412071055", "story_v_out_412071.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_7 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_7 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_7

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_7 and arg_231_1.time_ < 0 + var_234_7 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play412071056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 412071056
		arg_235_1.duration_ = 4.23

		local var_235_0 = {
			zh = 2.566,
			ja = 4.233
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
				arg_235_0:Play412071057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos1097ui_story = arg_235_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_238_0 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 then
				arg_235_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_235_1.time_ - 0) / var_238_0)
				arg_235_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1097ui_story"].transform.position).z)
				arg_235_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1097ui_story"].transform.localEulerAngles = arg_235_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 then
				arg_235_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_235_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1097ui_story"].transform.position).z)
				arg_235_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1097ui_story"].transform.localEulerAngles = arg_235_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_238_1 = arg_235_1.actors_["1097ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect1097ui_story == nil then
				arg_235_1.var_.characterEffect1097ui_story = var_238_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_2 and not isNil(var_238_1) then
				if arg_235_1.var_.characterEffect1097ui_story and not isNil(var_238_1) then
					arg_235_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_2 and arg_235_1.time_ < 0 + var_238_2 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect1097ui_story then
				arg_235_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_238_4 = arg_235_1.actors_["10078ui_story"].transform

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos10078ui_story = var_238_4.localPosition
			end

			local var_238_5 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_5 then
				var_238_4.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_235_1.time_ - 0) / var_238_5)
				var_238_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_4.position).x, (manager.ui.mainCamera.transform.position - var_238_4.position).y, (manager.ui.mainCamera.transform.position - var_238_4.position).z)
				var_238_4.localEulerAngles.z = 0
				var_238_4.localEulerAngles.x = 0
				var_238_4.localEulerAngles = var_238_4.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_5 and arg_235_1.time_ < 0 + var_238_5 + arg_238_0 then
				var_238_4.localPosition = Vector3.New(0, 100, 0)
				var_238_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_4.position).x, (manager.ui.mainCamera.transform.position - var_238_4.position).y, (manager.ui.mainCamera.transform.position - var_238_4.position).z)
				var_238_4.localEulerAngles.z = 0
				var_238_4.localEulerAngles.x = 0
				var_238_4.localEulerAngles = var_238_4.localEulerAngles
			end

			local var_238_6 = arg_235_1.actors_["10078ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_6) and arg_235_1.var_.characterEffect10078ui_story == nil then
				arg_235_1.var_.characterEffect10078ui_story = var_238_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_7 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 and not isNil(var_238_6) then
				if arg_235_1.var_.characterEffect10078ui_story and not isNil(var_238_6) then
					arg_235_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_235_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_7)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 and not isNil(var_238_6) and arg_235_1.var_.characterEffect10078ui_story then
				arg_235_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_235_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_238_8 = 0
			local var_238_9 = 0.25

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_8 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_10 = arg_235_1:GetWordFromCfg(412071056)
				local var_238_11 = arg_235_1:FormatText(var_238_10.content)

				arg_235_1.text_.text = var_238_11

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_13 = 10 <= 0 and var_238_9 or var_238_9 * (utf8.len(var_238_11) / 10)

				if (10 <= 0 and var_238_9 or var_238_9 * (utf8.len(var_238_11) / 10)) > 0 and var_238_9 < var_238_13 then
					arg_235_1.talkMaxDuration = var_238_13

					if var_238_13 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_13 + var_238_8
					end
				end

				arg_235_1.text_.text = var_238_11
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071056", "story_v_out_412071.awb") ~= 0 then
					local var_238_14 = manager.audio:GetVoiceLength("story_v_out_412071", "412071056", "story_v_out_412071.awb") / 1000

					if var_238_14 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_14 + var_238_8
					end

					if var_238_10.prefab_name ~= "" and arg_235_1.actors_[var_238_10.prefab_name] ~= nil then
						local var_238_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_10.prefab_name].transform, "story_v_out_412071", "412071056", "story_v_out_412071.awb")

						arg_235_1:RecordAudio("412071056", var_238_15)
						arg_235_1:RecordAudio("412071056", var_238_15)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_412071", "412071056", "story_v_out_412071.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_412071", "412071056", "story_v_out_412071.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_16 = math.max(var_238_9, arg_235_1.talkMaxDuration)

			if var_238_8 <= arg_235_1.time_ and arg_235_1.time_ < var_238_8 + var_238_16 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_8) / var_238_16

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_8 + var_238_16 and arg_235_1.time_ < var_238_8 + var_238_16 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412071057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 412071057
		arg_239_1.duration_ = 5.97

		local var_239_0 = {
			zh = 5.966,
			ja = 4.766
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
				arg_239_0:Play412071058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action3_1")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_242_0 = 0
			local var_242_1 = 0.5

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_2 = arg_239_1:GetWordFromCfg(412071057)
				local var_242_3 = arg_239_1:FormatText(var_242_2.content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 19 <= 0 and var_242_1 or var_242_1 * (utf8.len(var_242_3) / 19)

				if (19 <= 0 and var_242_1 or var_242_1 * (utf8.len(var_242_3) / 19)) > 0 and var_242_1 < var_242_5 then
					arg_239_1.talkMaxDuration = var_242_5

					if var_242_5 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071057", "story_v_out_412071.awb") ~= 0 then
					local var_242_6 = manager.audio:GetVoiceLength("story_v_out_412071", "412071057", "story_v_out_412071.awb") / 1000

					if var_242_6 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_6 + var_242_0
					end

					if var_242_2.prefab_name ~= "" and arg_239_1.actors_[var_242_2.prefab_name] ~= nil then
						local var_242_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_2.prefab_name].transform, "story_v_out_412071", "412071057", "story_v_out_412071.awb")

						arg_239_1:RecordAudio("412071057", var_242_7)
						arg_239_1:RecordAudio("412071057", var_242_7)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_412071", "412071057", "story_v_out_412071.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_412071", "412071057", "story_v_out_412071.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_8 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_8 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_8

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_8 and arg_239_1.time_ < var_242_0 + var_242_8 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play412071058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 412071058
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play412071059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1097ui_story = arg_243_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1097ui_story"].transform.position).z)
				arg_243_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1097ui_story"].transform.localEulerAngles = arg_243_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_243_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1097ui_story"].transform.position).z)
				arg_243_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1097ui_story"].transform.localEulerAngles = arg_243_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_246_1 = arg_243_1.actors_["1097ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1097ui_story == nil then
				arg_243_1.var_.characterEffect1097ui_story = var_246_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_2 and not isNil(var_246_1) then
				if arg_243_1.var_.characterEffect1097ui_story and not isNil(var_246_1) then
					arg_243_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_2)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_2 and arg_243_1.time_ < 0 + var_246_2 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1097ui_story then
				arg_243_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_246_3 = 0
			local var_246_4 = 0.2

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

				local var_246_5 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(412071058).content)

				arg_243_1.text_.text = var_246_5

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_7 = 8 <= 0 and var_246_4 or var_246_4 * (utf8.len(var_246_5) / 8)

				if (8 <= 0 and var_246_4 or var_246_4 * (utf8.len(var_246_5) / 8)) > 0 and var_246_4 < var_246_7 then
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
				actorName = "1097ui_story",
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
	Play412071059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 412071059
		arg_247_1.duration_ = 10.33

		local var_247_0 = {
			zh = 7.8,
			ja = 10.333
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play412071060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos10078ui_story = arg_247_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_250_0 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				arg_247_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10078ui_story, Vector3.New(-0.7, -0.5, -6.3), (arg_247_1.time_ - 0) / var_250_0)
				arg_247_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10078ui_story"].transform.position).z)
				arg_247_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["10078ui_story"].transform.localEulerAngles = arg_247_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				arg_247_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				arg_247_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10078ui_story"].transform.position).z)
				arg_247_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["10078ui_story"].transform.localEulerAngles = arg_247_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_250_1 = arg_247_1.actors_["10078ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect10078ui_story == nil then
				arg_247_1.var_.characterEffect10078ui_story = var_250_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_2 and not isNil(var_250_1) then
				if arg_247_1.var_.characterEffect10078ui_story and not isNil(var_250_1) then
					arg_247_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_2 and arg_247_1.time_ < 0 + var_250_2 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect10078ui_story then
				arg_247_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_250_4 = arg_247_1.actors_["1097ui_story"].transform

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1097ui_story = var_250_4.localPosition
			end

			local var_250_5 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_5 then
				var_250_4.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_247_1.time_ - 0) / var_250_5)
				var_250_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_250_4.position).x, (manager.ui.mainCamera.transform.position - var_250_4.position).y, (manager.ui.mainCamera.transform.position - var_250_4.position).z)
				var_250_4.localEulerAngles.z = 0
				var_250_4.localEulerAngles.x = 0
				var_250_4.localEulerAngles = var_250_4.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_5 and arg_247_1.time_ < 0 + var_250_5 + arg_250_0 then
				var_250_4.localPosition = Vector3.New(0.7, -0.54, -6.3)
				var_250_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_250_4.position).x, (manager.ui.mainCamera.transform.position - var_250_4.position).y, (manager.ui.mainCamera.transform.position - var_250_4.position).z)
				var_250_4.localEulerAngles.z = 0
				var_250_4.localEulerAngles.x = 0
				var_250_4.localEulerAngles = var_250_4.localEulerAngles
			end

			local var_250_6 = arg_247_1.actors_["1097ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_6) and arg_247_1.var_.characterEffect1097ui_story == nil then
				arg_247_1.var_.characterEffect1097ui_story = var_250_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_7 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_7 and not isNil(var_250_6) then
				if arg_247_1.var_.characterEffect1097ui_story and not isNil(var_250_6) then
					arg_247_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_7)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_7 and arg_247_1.time_ < 0 + var_250_7 + arg_250_0 and not isNil(var_250_6) and arg_247_1.var_.characterEffect1097ui_story then
				arg_247_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_250_8 = 0
			local var_250_9 = 0.525

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_8 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_10 = arg_247_1:GetWordFromCfg(412071059)
				local var_250_11 = arg_247_1:FormatText(var_250_10.content)

				arg_247_1.text_.text = var_250_11

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_13 = 21 <= 0 and var_250_9 or var_250_9 * (utf8.len(var_250_11) / 21)

				if (21 <= 0 and var_250_9 or var_250_9 * (utf8.len(var_250_11) / 21)) > 0 and var_250_9 < var_250_13 then
					arg_247_1.talkMaxDuration = var_250_13

					if var_250_13 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_13 + var_250_8
					end
				end

				arg_247_1.text_.text = var_250_11
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071059", "story_v_out_412071.awb") ~= 0 then
					local var_250_14 = manager.audio:GetVoiceLength("story_v_out_412071", "412071059", "story_v_out_412071.awb") / 1000

					if var_250_14 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_14 + var_250_8
					end

					if var_250_10.prefab_name ~= "" and arg_247_1.actors_[var_250_10.prefab_name] ~= nil then
						local var_250_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_10.prefab_name].transform, "story_v_out_412071", "412071059", "story_v_out_412071.awb")

						arg_247_1:RecordAudio("412071059", var_250_15)
						arg_247_1:RecordAudio("412071059", var_250_15)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_412071", "412071059", "story_v_out_412071.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_412071", "412071059", "story_v_out_412071.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_16 = math.max(var_250_9, arg_247_1.talkMaxDuration)

			if var_250_8 <= arg_247_1.time_ and arg_247_1.time_ < var_250_8 + var_250_16 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_8) / var_250_16

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_8 + var_250_16 and arg_247_1.time_ < var_250_8 + var_250_16 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play412071060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 412071060
		arg_251_1.duration_ = 2.1

		local var_251_0 = {
			zh = 2.1,
			ja = 1.999999999999
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
				arg_251_0:Play412071061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1097ui_story = arg_251_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1097ui_story"].transform.position).z)
				arg_251_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1097ui_story"].transform.localEulerAngles = arg_251_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0.7, -0.54, -6.3)
				arg_251_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1097ui_story"].transform.position).z)
				arg_251_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1097ui_story"].transform.localEulerAngles = arg_251_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_254_1 = arg_251_1.actors_["1097ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1097ui_story == nil then
				arg_251_1.var_.characterEffect1097ui_story = var_254_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_2 and not isNil(var_254_1) then
				if arg_251_1.var_.characterEffect1097ui_story and not isNil(var_254_1) then
					arg_251_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_2 and arg_251_1.time_ < 0 + var_254_2 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1097ui_story then
				arg_251_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action3_2")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_254_4 = arg_251_1.actors_["10078ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_4) and arg_251_1.var_.characterEffect10078ui_story == nil then
				arg_251_1.var_.characterEffect10078ui_story = var_254_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_5 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_5 and not isNil(var_254_4) then
				if arg_251_1.var_.characterEffect10078ui_story and not isNil(var_254_4) then
					arg_251_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_251_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_5)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_5 and arg_251_1.time_ < 0 + var_254_5 + arg_254_0 and not isNil(var_254_4) and arg_251_1.var_.characterEffect10078ui_story then
				arg_251_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_251_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_254_6 = 0
			local var_254_7 = 0.15

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_6 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_8 = arg_251_1:GetWordFromCfg(412071060)
				local var_254_9 = arg_251_1:FormatText(var_254_8.content)

				arg_251_1.text_.text = var_254_9

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_11 = 6 <= 0 and var_254_7 or var_254_7 * (utf8.len(var_254_9) / 6)

				if (6 <= 0 and var_254_7 or var_254_7 * (utf8.len(var_254_9) / 6)) > 0 and var_254_7 < var_254_11 then
					arg_251_1.talkMaxDuration = var_254_11

					if var_254_11 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_11 + var_254_6
					end
				end

				arg_251_1.text_.text = var_254_9
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071060", "story_v_out_412071.awb") ~= 0 then
					local var_254_12 = manager.audio:GetVoiceLength("story_v_out_412071", "412071060", "story_v_out_412071.awb") / 1000

					if var_254_12 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_12 + var_254_6
					end

					if var_254_8.prefab_name ~= "" and arg_251_1.actors_[var_254_8.prefab_name] ~= nil then
						local var_254_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_8.prefab_name].transform, "story_v_out_412071", "412071060", "story_v_out_412071.awb")

						arg_251_1:RecordAudio("412071060", var_254_13)
						arg_251_1:RecordAudio("412071060", var_254_13)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_412071", "412071060", "story_v_out_412071.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_412071", "412071060", "story_v_out_412071.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_14 = math.max(var_254_7, arg_251_1.talkMaxDuration)

			if var_254_6 <= arg_251_1.time_ and arg_251_1.time_ < var_254_6 + var_254_14 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_6) / var_254_14

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_6 + var_254_14 and arg_251_1.time_ < var_254_6 + var_254_14 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play412071061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 412071061
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play412071062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos10078ui_story = arg_255_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_258_0 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 then
				arg_255_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_255_1.time_ - 0) / var_258_0)
				arg_255_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10078ui_story"].transform.position).z)
				arg_255_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["10078ui_story"].transform.localEulerAngles = arg_255_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 then
				arg_255_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_255_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10078ui_story"].transform.position).z)
				arg_255_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["10078ui_story"].transform.localEulerAngles = arg_255_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_258_1 = arg_255_1.actors_["10078ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect10078ui_story == nil then
				arg_255_1.var_.characterEffect10078ui_story = var_258_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_2 and not isNil(var_258_1) then
				if arg_255_1.var_.characterEffect10078ui_story and not isNil(var_258_1) then
					arg_255_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_255_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_2)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_2 and arg_255_1.time_ < 0 + var_258_2 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect10078ui_story then
				arg_255_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_255_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_258_3 = arg_255_1.actors_["1097ui_story"].transform

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1097ui_story = var_258_3.localPosition
			end

			local var_258_4 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_4 then
				var_258_3.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_255_1.time_ - 0) / var_258_4)
				var_258_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_3.position).x, (manager.ui.mainCamera.transform.position - var_258_3.position).y, (manager.ui.mainCamera.transform.position - var_258_3.position).z)
				var_258_3.localEulerAngles.z = 0
				var_258_3.localEulerAngles.x = 0
				var_258_3.localEulerAngles = var_258_3.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_4 and arg_255_1.time_ < 0 + var_258_4 + arg_258_0 then
				var_258_3.localPosition = Vector3.New(0, 100, 0)
				var_258_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_3.position).x, (manager.ui.mainCamera.transform.position - var_258_3.position).y, (manager.ui.mainCamera.transform.position - var_258_3.position).z)
				var_258_3.localEulerAngles.z = 0
				var_258_3.localEulerAngles.x = 0
				var_258_3.localEulerAngles = var_258_3.localEulerAngles
			end

			local var_258_5 = arg_255_1.actors_["1097ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_5) and arg_255_1.var_.characterEffect1097ui_story == nil then
				arg_255_1.var_.characterEffect1097ui_story = var_258_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_6 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_6 and not isNil(var_258_5) then
				if arg_255_1.var_.characterEffect1097ui_story and not isNil(var_258_5) then
					arg_255_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_6)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_6 and arg_255_1.time_ < 0 + var_258_6 + arg_258_0 and not isNil(var_258_5) and arg_255_1.var_.characterEffect1097ui_story then
				arg_255_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_258_7 = 0
			local var_258_8 = 0.575

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

				local var_258_9 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(412071061).content)

				arg_255_1.text_.text = var_258_9

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_11 = 23 <= 0 and var_258_8 or var_258_8 * (utf8.len(var_258_9) / 23)

				if (23 <= 0 and var_258_8 or var_258_8 * (utf8.len(var_258_9) / 23)) > 0 and var_258_8 < var_258_11 then
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

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play412071062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 412071062
		arg_259_1.duration_ = 10.1

		local var_259_0 = {
			zh = 8.066,
			ja = 10.1
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play412071063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1097ui_story = arg_259_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_262_0 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 then
				arg_259_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_259_1.time_ - 0) / var_262_0)
				arg_259_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1097ui_story"].transform.position).z)
				arg_259_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1097ui_story"].transform.localEulerAngles = arg_259_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 then
				arg_259_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0.7, -0.54, -6.3)
				arg_259_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1097ui_story"].transform.position).z)
				arg_259_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1097ui_story"].transform.localEulerAngles = arg_259_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_262_1 = arg_259_1.actors_["1097ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1097ui_story == nil then
				arg_259_1.var_.characterEffect1097ui_story = var_262_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_2 and not isNil(var_262_1) then
				if arg_259_1.var_.characterEffect1097ui_story and not isNil(var_262_1) then
					arg_259_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_2 and arg_259_1.time_ < 0 + var_262_2 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1097ui_story then
				arg_259_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_262_4 = 0
			local var_262_5 = 0.875

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_6 = arg_259_1:GetWordFromCfg(412071062)
				local var_262_7 = arg_259_1:FormatText(var_262_6.content)

				arg_259_1.text_.text = var_262_7

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_9 = 35 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 35)

				if (35 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 35)) > 0 and var_262_5 < var_262_9 then
					arg_259_1.talkMaxDuration = var_262_9

					if var_262_9 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_9 + var_262_4
					end
				end

				arg_259_1.text_.text = var_262_7
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071062", "story_v_out_412071.awb") ~= 0 then
					local var_262_10 = manager.audio:GetVoiceLength("story_v_out_412071", "412071062", "story_v_out_412071.awb") / 1000

					if var_262_10 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_4
					end

					if var_262_6.prefab_name ~= "" and arg_259_1.actors_[var_262_6.prefab_name] ~= nil then
						local var_262_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_6.prefab_name].transform, "story_v_out_412071", "412071062", "story_v_out_412071.awb")

						arg_259_1:RecordAudio("412071062", var_262_11)
						arg_259_1:RecordAudio("412071062", var_262_11)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_412071", "412071062", "story_v_out_412071.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_412071", "412071062", "story_v_out_412071.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_12 = math.max(var_262_5, arg_259_1.talkMaxDuration)

			if var_262_4 <= arg_259_1.time_ and arg_259_1.time_ < var_262_4 + var_262_12 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_4) / var_262_12

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_4 + var_262_12 and arg_259_1.time_ < var_262_4 + var_262_12 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play412071063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 412071063
		arg_263_1.duration_ = 2.87

		local var_263_0 = {
			zh = 2.866,
			ja = 2.533
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
			arg_263_1.auto_ = false
		end

		function arg_263_1.playNext_(arg_265_0)
			arg_263_1.onStoryFinished_()
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos10078ui_story = arg_263_1.actors_["10078ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["10078ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10078ui_story, Vector3.New(-0.7, -0.5, -6.3), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["10078ui_story"].transform.position).z)
				arg_263_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["10078ui_story"].transform.localEulerAngles = arg_263_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["10078ui_story"].transform.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				arg_263_1.actors_["10078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["10078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["10078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["10078ui_story"].transform.position).z)
				arg_263_1.actors_["10078ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["10078ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["10078ui_story"].transform.localEulerAngles = arg_263_1.actors_["10078ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["10078ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect10078ui_story == nil then
				arg_263_1.var_.characterEffect10078ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect10078ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect10078ui_story then
				arg_263_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_266_4 = arg_263_1.actors_["1097ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_4) and arg_263_1.var_.characterEffect1097ui_story == nil then
				arg_263_1.var_.characterEffect1097ui_story = var_266_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_5 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_5 and not isNil(var_266_4) then
				if arg_263_1.var_.characterEffect1097ui_story and not isNil(var_266_4) then
					arg_263_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_5)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_5 and arg_263_1.time_ < 0 + var_266_5 + arg_266_0 and not isNil(var_266_4) and arg_263_1.var_.characterEffect1097ui_story then
				arg_263_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_266_6 = 0
			local var_266_7 = 0.225

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_6 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_8 = arg_263_1:GetWordFromCfg(412071063)
				local var_266_9 = arg_263_1:FormatText(var_266_8.content)

				arg_263_1.text_.text = var_266_9

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_11 = 9 <= 0 and var_266_7 or var_266_7 * (utf8.len(var_266_9) / 9)

				if (9 <= 0 and var_266_7 or var_266_7 * (utf8.len(var_266_9) / 9)) > 0 and var_266_7 < var_266_11 then
					arg_263_1.talkMaxDuration = var_266_11

					if var_266_11 + var_266_6 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_11 + var_266_6
					end
				end

				arg_263_1.text_.text = var_266_9
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071063", "story_v_out_412071.awb") ~= 0 then
					local var_266_12 = manager.audio:GetVoiceLength("story_v_out_412071", "412071063", "story_v_out_412071.awb") / 1000

					if var_266_12 + var_266_6 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_12 + var_266_6
					end

					if var_266_8.prefab_name ~= "" and arg_263_1.actors_[var_266_8.prefab_name] ~= nil then
						local var_266_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_8.prefab_name].transform, "story_v_out_412071", "412071063", "story_v_out_412071.awb")

						arg_263_1:RecordAudio("412071063", var_266_13)
						arg_263_1:RecordAudio("412071063", var_266_13)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_412071", "412071063", "story_v_out_412071.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_412071", "412071063", "story_v_out_412071.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_14 = math.max(var_266_7, arg_263_1.talkMaxDuration)

			if var_266_6 <= arg_263_1.time_ and arg_263_1.time_ < var_266_6 + var_266_14 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_6) / var_266_14

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_6 + var_266_14 and arg_263_1.time_ < var_266_6 + var_266_14 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST85b",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/F02_1"
	},
	voices = {
		"story_v_out_412071.awb"
	}
}
