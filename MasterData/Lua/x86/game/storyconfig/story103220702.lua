return {
	Play322072001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322072001
		arg_1_1.duration_ = 4.13

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play322072002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L17f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L17f")
				var_4_0.name = "L17f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L17f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L17f

				arg_1_1.bgs_.L17f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L17f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.166666666666667 and arg_1_1.time_ < var_4_4 + 0.166666666666667 + arg_4_0 then
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

			local var_4_9 = "10152ui_story"

			if arg_1_1.actors_["10152ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10152ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "10152ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["10152ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10152ui_story = var_4_13.localPosition

				local var_4_14 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_14 then
					var_4_14:EnableDynamicBone(false)
				end
			end

			local var_4_15 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10152ui_story, Vector3.New(0, -1.73, -5.5), (arg_1_1.time_ - 1.8) / var_4_15)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1.73, -5.5)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles

				local var_4_16 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_16 then
					var_4_16:EnableDynamicBone(true)
				end
			end

			local var_4_17 = arg_1_1.actors_["10152ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect10152ui_story == nil then
				arg_1_1.var_.characterEffect10152ui_story = var_4_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_18 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_18 and not isNil(var_4_17) then
				if arg_1_1.var_.characterEffect10152ui_story and not isNil(var_4_17) then
					arg_1_1.var_.characterEffect10152ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_18 and arg_1_1.time_ < 1.8 + var_4_18 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect10152ui_story then
				arg_1_1.var_.characterEffect10152ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10152ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10152ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled.awb")

				local var_4_25 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_25 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_25

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_25
						arg_1_1.bgmTxt2_.text = var_4_25
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

			if 0.200000002980232 < arg_1_1.time_ and arg_1_1.time_ <= 0.200000002980232 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			local var_4_27 = 2.00000000298023
			local var_4_28 = 0.0666666636864348

			if 2.00000000298023 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_29 = arg_1_1:GetWordFromCfg(322072001)
				local var_4_30 = arg_1_1:FormatText(var_4_29.content)

				arg_1_1.text_.text = var_4_30

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_32 = 2 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_30) / 2)

				if (2 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_30) / 2)) > 0 and var_4_28 < var_4_32 then
					arg_1_1.talkMaxDuration = var_4_32

					if var_4_32 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_27
					end
				end

				arg_1_1.text_.text = var_4_30
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072001", "story_v_out_322072.awb") ~= 0 then
					local var_4_33 = manager.audio:GetVoiceLength("story_v_out_322072", "322072001", "story_v_out_322072.awb") / 1000

					if var_4_33 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_27
					end

					if var_4_29.prefab_name ~= "" and arg_1_1.actors_[var_4_29.prefab_name] ~= nil then
						local var_4_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_29.prefab_name].transform, "story_v_out_322072", "322072001", "story_v_out_322072.awb")

						arg_1_1:RecordAudio("322072001", var_4_34)
						arg_1_1:RecordAudio("322072001", var_4_34)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322072", "322072001", "story_v_out_322072.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322072", "322072001", "story_v_out_322072.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_35 = math.max(var_4_28, arg_1_1.talkMaxDuration)

			if var_4_27 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_35 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_27) / var_4_35

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_27 + var_4_35 and arg_1_1.time_ < var_4_27 + var_4_35 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10152ui_story",
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
	Play322072002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 322072002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play322072003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos10152ui_story = arg_7_1.actors_["10152ui_story"].transform.localPosition

				local var_10_0 = GameObjectTools.GetOrAddComponent(arg_7_1.actors_["10152ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_10_0 then
					var_10_0:EnableDynamicBone(false)
				end
			end

			local var_10_1 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_1 then
				arg_7_1.actors_["10152ui_story"].transform.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos10152ui_story, Vector3.New(0, 100, 0), (arg_7_1.time_ - 0) / var_10_1)
				arg_7_1.actors_["10152ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_7_1.actors_["10152ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["10152ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["10152ui_story"].transform.position).z)
				arg_7_1.actors_["10152ui_story"].transform.localEulerAngles.z = 0
				arg_7_1.actors_["10152ui_story"].transform.localEulerAngles.x = 0
				arg_7_1.actors_["10152ui_story"].transform.localEulerAngles = arg_7_1.actors_["10152ui_story"].transform.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_1 and arg_7_1.time_ < 0 + var_10_1 + arg_10_0 then
				arg_7_1.actors_["10152ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_["10152ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_7_1.actors_["10152ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["10152ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["10152ui_story"].transform.position).z)
				arg_7_1.actors_["10152ui_story"].transform.localEulerAngles.z = 0
				arg_7_1.actors_["10152ui_story"].transform.localEulerAngles.x = 0
				arg_7_1.actors_["10152ui_story"].transform.localEulerAngles = arg_7_1.actors_["10152ui_story"].transform.localEulerAngles

				local var_10_2 = GameObjectTools.GetOrAddComponent(arg_7_1.actors_["10152ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_10_2 then
					var_10_2:EnableDynamicBone(true)
				end
			end

			local var_10_3 = 0
			local var_10_4 = 1.175

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_3 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_5 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(322072002).content)

				arg_7_1.text_.text = var_10_5

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_7 = 47 <= 0 and var_10_4 or var_10_4 * (utf8.len(var_10_5) / 47)

				if (47 <= 0 and var_10_4 or var_10_4 * (utf8.len(var_10_5) / 47)) > 0 and var_10_4 < var_10_7 then
					arg_7_1.talkMaxDuration = var_10_7

					if var_10_7 + var_10_3 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_7 + var_10_3
					end
				end

				arg_7_1.text_.text = var_10_5
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_8 = math.max(var_10_4, arg_7_1.talkMaxDuration)

			if var_10_3 <= arg_7_1.time_ and arg_7_1.time_ < var_10_3 + var_10_8 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_3) / var_10_8

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_3 + var_10_8 and arg_7_1.time_ < var_10_3 + var_10_8 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10152ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play322072003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 322072003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play322072004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0.233333333333333 < arg_11_1.time_ and arg_11_1.time_ <= 0.233333333333333 + arg_14_0 then
				arg_11_1:AudioAction("play", "effect", "se_story_side_1094", "se_story_1094_run", "")
			end

			if 1 < arg_11_1.time_ and arg_11_1.time_ <= 1 + arg_14_0 then
				arg_11_1:AudioAction("play", "effect", "se_story_10", "se_story_10_monster", "")
			end

			local var_14_2 = manager.ui.mainCamera.transform

			if 1.03333333333333 < arg_11_1.time_ and arg_11_1.time_ <= 1.03333333333333 + arg_14_0 then
				arg_11_1.var_.shakeOldPos = var_14_2.localPosition
			end

			local var_14_3 = 0.966666666665666

			if 1.03333333333333 <= arg_11_1.time_ and arg_11_1.time_ < 1.03333333333333 + var_14_3 then
				local var_14_4, var_14_5 = math.modf((arg_11_1.time_ - 1.03333333333333) / 0.066)

				var_14_2.localPosition = Vector3.New(var_14_5 * 0.13, var_14_5 * 0.13, var_14_5 * 0.13) + arg_11_1.var_.shakeOldPos
			end

			if arg_11_1.time_ >= 1.03333333333333 + var_14_3 and arg_11_1.time_ < 1.03333333333333 + var_14_3 + arg_14_0 then
				var_14_2.localPosition = arg_11_1.var_.shakeOldPos
			end

			local var_14_6 = 0
			local var_14_7 = 1.725

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_6 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_8 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(322072003).content)

				arg_11_1.text_.text = var_14_8

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_10 = 69 <= 0 and var_14_7 or var_14_7 * (utf8.len(var_14_8) / 69)

				if (69 <= 0 and var_14_7 or var_14_7 * (utf8.len(var_14_8) / 69)) > 0 and var_14_7 < var_14_10 then
					arg_11_1.talkMaxDuration = var_14_10

					if var_14_10 + var_14_6 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_10 + var_14_6
					end
				end

				arg_11_1.text_.text = var_14_8
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_11 = math.max(var_14_7, arg_11_1.talkMaxDuration)

			if var_14_6 <= arg_11_1.time_ and arg_11_1.time_ < var_14_6 + var_14_11 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_6) / var_14_11

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_6 + var_14_11 and arg_11_1.time_ < var_14_6 + var_14_11 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play322072004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 322072004
		arg_15_1.duration_ = 2.07

		local var_15_0 = {
			zh = 1.999999999999,
			ja = 2.066
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play322072005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if arg_15_1.actors_["1156ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1156ui_story"))) then
				local var_18_0 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_15_1.stage_.transform)

				var_18_0.name = "1156ui_story"
				var_18_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.actors_["1156ui_story"] = var_18_0

				local var_18_1 = var_18_0:GetComponentInChildren(typeof(CharacterEffect))

				var_18_1.enabled = true

				local var_18_2 = GameObjectTools.GetOrAddComponent(var_18_0, typeof(DynamicBoneHelper))

				if var_18_2 then
					var_18_2:EnableDynamicBone(false)
				end

				arg_15_1:ShowWeapon(var_18_1.transform, false)

				arg_15_1.var_["1156ui_story" .. "Animator"] = var_18_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_15_1.var_["1156ui_story" .. "Animator"].applyRootMotion = true
				arg_15_1.var_["1156ui_story" .. "LipSync"] = var_18_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_18_3 = arg_15_1.actors_["1156ui_story"].transform

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1156ui_story = var_18_3.localPosition
			end

			local var_18_4 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_4 then
				var_18_3.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1156ui_story, Vector3.New(-0.9, -1.1, -6.18), (arg_15_1.time_ - 0) / var_18_4)
				var_18_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_3.position).x, (manager.ui.mainCamera.transform.position - var_18_3.position).y, (manager.ui.mainCamera.transform.position - var_18_3.position).z)
				var_18_3.localEulerAngles.z = 0
				var_18_3.localEulerAngles.x = 0
				var_18_3.localEulerAngles = var_18_3.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_4 and arg_15_1.time_ < 0 + var_18_4 + arg_18_0 then
				var_18_3.localPosition = Vector3.New(-0.9, -1.1, -6.18)
				var_18_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_3.position).x, (manager.ui.mainCamera.transform.position - var_18_3.position).y, (manager.ui.mainCamera.transform.position - var_18_3.position).z)
				var_18_3.localEulerAngles.z = 0
				var_18_3.localEulerAngles.x = 0
				var_18_3.localEulerAngles = var_18_3.localEulerAngles
			end

			local var_18_5 = arg_15_1.actors_["1156ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_5) and arg_15_1.var_.characterEffect1156ui_story == nil then
				arg_15_1.var_.characterEffect1156ui_story = var_18_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_6 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_6 and not isNil(var_18_5) then
				if arg_15_1.var_.characterEffect1156ui_story and not isNil(var_18_5) then
					arg_15_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_6 and arg_15_1.time_ < 0 + var_18_6 + arg_18_0 and not isNil(var_18_5) and arg_15_1.var_.characterEffect1156ui_story then
				arg_15_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_18_8 = 0
			local var_18_9 = 0.15

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_8 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_10 = arg_15_1:GetWordFromCfg(322072004)
				local var_18_11 = arg_15_1:FormatText(var_18_10.content)

				arg_15_1.text_.text = var_18_11

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_13 = 6 <= 0 and var_18_9 or var_18_9 * (utf8.len(var_18_11) / 6)

				if (6 <= 0 and var_18_9 or var_18_9 * (utf8.len(var_18_11) / 6)) > 0 and var_18_9 < var_18_13 then
					arg_15_1.talkMaxDuration = var_18_13

					if var_18_13 + var_18_8 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_13 + var_18_8
					end
				end

				arg_15_1.text_.text = var_18_11
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072004", "story_v_out_322072.awb") ~= 0 then
					local var_18_14 = manager.audio:GetVoiceLength("story_v_out_322072", "322072004", "story_v_out_322072.awb") / 1000

					if var_18_14 + var_18_8 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_14 + var_18_8
					end

					if var_18_10.prefab_name ~= "" and arg_15_1.actors_[var_18_10.prefab_name] ~= nil then
						local var_18_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_10.prefab_name].transform, "story_v_out_322072", "322072004", "story_v_out_322072.awb")

						arg_15_1:RecordAudio("322072004", var_18_15)
						arg_15_1:RecordAudio("322072004", var_18_15)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_322072", "322072004", "story_v_out_322072.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_322072", "322072004", "story_v_out_322072.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_16 = math.max(var_18_9, arg_15_1.talkMaxDuration)

			if var_18_8 <= arg_15_1.time_ and arg_15_1.time_ < var_18_8 + var_18_16 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_8) / var_18_16

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_8 + var_18_16 and arg_15_1.time_ < var_18_8 + var_18_16 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
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

		arg_15_1:InitPlayNodeList()
	end,
	Play322072005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 322072005
		arg_19_1.duration_ = 6.37

		local var_19_0 = {
			zh = 6.366,
			ja = 3.766
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play322072006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if arg_19_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_22_0 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_19_1.stage_.transform)

				var_22_0.name = "404001ui_story"
				var_22_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.actors_["404001ui_story"] = var_22_0

				local var_22_1 = var_22_0:GetComponentInChildren(typeof(CharacterEffect))

				var_22_1.enabled = true

				local var_22_2 = GameObjectTools.GetOrAddComponent(var_22_0, typeof(DynamicBoneHelper))

				if var_22_2 then
					var_22_2:EnableDynamicBone(false)
				end

				arg_19_1:ShowWeapon(var_22_1.transform, false)

				arg_19_1.var_["404001ui_story" .. "Animator"] = var_22_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_19_1.var_["404001ui_story" .. "Animator"].applyRootMotion = true
				arg_19_1.var_["404001ui_story" .. "LipSync"] = var_22_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_22_3 = arg_19_1.actors_["404001ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos404001ui_story = var_22_3.localPosition
			end

			local var_22_4 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				var_22_3.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_19_1.time_ - 0) / var_22_4)
				var_22_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_3.position).x, (manager.ui.mainCamera.transform.position - var_22_3.position).y, (manager.ui.mainCamera.transform.position - var_22_3.position).z)
				var_22_3.localEulerAngles.z = 0
				var_22_3.localEulerAngles.x = 0
				var_22_3.localEulerAngles = var_22_3.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				var_22_3.localPosition = Vector3.New(0.8, -1.55, -5.5)
				var_22_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_3.position).x, (manager.ui.mainCamera.transform.position - var_22_3.position).y, (manager.ui.mainCamera.transform.position - var_22_3.position).z)
				var_22_3.localEulerAngles.z = 0
				var_22_3.localEulerAngles.x = 0
				var_22_3.localEulerAngles = var_22_3.localEulerAngles
			end

			local var_22_5 = arg_19_1.actors_["404001ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.characterEffect404001ui_story == nil then
				arg_19_1.var_.characterEffect404001ui_story = var_22_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_6 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_6 and not isNil(var_22_5) then
				if arg_19_1.var_.characterEffect404001ui_story and not isNil(var_22_5) then
					arg_19_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_6 and arg_19_1.time_ < 0 + var_22_6 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.characterEffect404001ui_story then
				arg_19_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_22_8 = arg_19_1.actors_["1156ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_8) and arg_19_1.var_.characterEffect1156ui_story == nil then
				arg_19_1.var_.characterEffect1156ui_story = var_22_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_9 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_9 and not isNil(var_22_8) then
				if arg_19_1.var_.characterEffect1156ui_story and not isNil(var_22_8) then
					arg_19_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_9)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_9 and arg_19_1.time_ < 0 + var_22_9 + arg_22_0 and not isNil(var_22_8) and arg_19_1.var_.characterEffect1156ui_story then
				arg_19_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_22_10 = 0
			local var_22_11 = 0.475

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_10 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_12 = arg_19_1:GetWordFromCfg(322072005)
				local var_22_13 = arg_19_1:FormatText(var_22_12.content)

				arg_19_1.text_.text = var_22_13

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_15 = 19 <= 0 and var_22_11 or var_22_11 * (utf8.len(var_22_13) / 19)

				if (19 <= 0 and var_22_11 or var_22_11 * (utf8.len(var_22_13) / 19)) > 0 and var_22_11 < var_22_15 then
					arg_19_1.talkMaxDuration = var_22_15

					if var_22_15 + var_22_10 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_15 + var_22_10
					end
				end

				arg_19_1.text_.text = var_22_13
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072005", "story_v_out_322072.awb") ~= 0 then
					local var_22_16 = manager.audio:GetVoiceLength("story_v_out_322072", "322072005", "story_v_out_322072.awb") / 1000

					if var_22_16 + var_22_10 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_16 + var_22_10
					end

					if var_22_12.prefab_name ~= "" and arg_19_1.actors_[var_22_12.prefab_name] ~= nil then
						local var_22_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_12.prefab_name].transform, "story_v_out_322072", "322072005", "story_v_out_322072.awb")

						arg_19_1:RecordAudio("322072005", var_22_17)
						arg_19_1:RecordAudio("322072005", var_22_17)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_322072", "322072005", "story_v_out_322072.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_322072", "322072005", "story_v_out_322072.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_18 = math.max(var_22_11, arg_19_1.talkMaxDuration)

			if var_22_10 <= arg_19_1.time_ and arg_19_1.time_ < var_22_10 + var_22_18 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_10) / var_22_18

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_10 + var_22_18 and arg_19_1.time_ < var_22_10 + var_22_18 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
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

		arg_19_1:InitPlayNodeList()
	end,
	Play322072006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 322072006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play322072007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos404001ui_story = arg_23_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_26_0 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 then
				arg_23_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_23_1.time_ - 0) / var_26_0)
				arg_23_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["404001ui_story"].transform.position).z)
				arg_23_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["404001ui_story"].transform.localEulerAngles = arg_23_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 then
				arg_23_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["404001ui_story"].transform.position).z)
				arg_23_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["404001ui_story"].transform.localEulerAngles = arg_23_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_26_1 = arg_23_1.actors_["1156ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1156ui_story = var_26_1.localPosition
			end

			local var_26_2 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_2 then
				var_26_1.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_23_1.time_ - 0) / var_26_2)
				var_26_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_1.position).x, (manager.ui.mainCamera.transform.position - var_26_1.position).y, (manager.ui.mainCamera.transform.position - var_26_1.position).z)
				var_26_1.localEulerAngles.z = 0
				var_26_1.localEulerAngles.x = 0
				var_26_1.localEulerAngles = var_26_1.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_2 and arg_23_1.time_ < 0 + var_26_2 + arg_26_0 then
				var_26_1.localPosition = Vector3.New(0, 100, 0)
				var_26_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_1.position).x, (manager.ui.mainCamera.transform.position - var_26_1.position).y, (manager.ui.mainCamera.transform.position - var_26_1.position).z)
				var_26_1.localEulerAngles.z = 0
				var_26_1.localEulerAngles.x = 0
				var_26_1.localEulerAngles = var_26_1.localEulerAngles
			end

			local var_26_3 = arg_23_1.actors_["404001ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_3) and arg_23_1.var_.characterEffect404001ui_story == nil then
				arg_23_1.var_.characterEffect404001ui_story = var_26_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_4 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 and not isNil(var_26_3) then
				if arg_23_1.var_.characterEffect404001ui_story and not isNil(var_26_3) then
					arg_23_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_23_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_4)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 and not isNil(var_26_3) and arg_23_1.var_.characterEffect404001ui_story then
				arg_23_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_23_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0.466666666666667 < arg_23_1.time_ and arg_23_1.time_ <= 0.466666666666667 + arg_26_0 then
				arg_23_1:AudioAction("play", "effect", "se_story_145", "se_story_145_fire01", "")
			end

			local var_26_6 = 0
			local var_26_7 = 1.2

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_8 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(322072006).content)

				arg_23_1.text_.text = var_26_8

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_10 = 48 <= 0 and var_26_7 or var_26_7 * (utf8.len(var_26_8) / 48)

				if (48 <= 0 and var_26_7 or var_26_7 * (utf8.len(var_26_8) / 48)) > 0 and var_26_7 < var_26_10 then
					arg_23_1.talkMaxDuration = var_26_10

					if var_26_10 + var_26_6 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_10 + var_26_6
					end
				end

				arg_23_1.text_.text = var_26_8
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_11 = math.max(var_26_7, arg_23_1.talkMaxDuration)

			if var_26_6 <= arg_23_1.time_ and arg_23_1.time_ < var_26_6 + var_26_11 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_6) / var_26_11

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_6 + var_26_11 and arg_23_1.time_ < var_26_6 + var_26_11 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
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
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play322072007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 322072007
		arg_27_1.duration_ = 3.47

		local var_27_0 = {
			zh = 2.866,
			ja = 3.466
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play322072008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if arg_27_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_30_0 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_27_1.stage_.transform)

				var_30_0.name = "1284ui_story"
				var_30_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.actors_["1284ui_story"] = var_30_0

				local var_30_1 = var_30_0:GetComponentInChildren(typeof(CharacterEffect))

				var_30_1.enabled = true

				local var_30_2 = GameObjectTools.GetOrAddComponent(var_30_0, typeof(DynamicBoneHelper))

				if var_30_2 then
					var_30_2:EnableDynamicBone(false)
				end

				arg_27_1:ShowWeapon(var_30_1.transform, false)

				arg_27_1.var_["1284ui_story" .. "Animator"] = var_30_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_27_1.var_["1284ui_story" .. "Animator"].applyRootMotion = true
				arg_27_1.var_["1284ui_story" .. "LipSync"] = var_30_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_30_3 = arg_27_1.actors_["1284ui_story"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1284ui_story = var_30_3.localPosition
			end

			local var_30_4 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				var_30_3.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_27_1.time_ - 0) / var_30_4)
				var_30_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_3.position).x, (manager.ui.mainCamera.transform.position - var_30_3.position).y, (manager.ui.mainCamera.transform.position - var_30_3.position).z)
				var_30_3.localEulerAngles.z = 0
				var_30_3.localEulerAngles.x = 0
				var_30_3.localEulerAngles = var_30_3.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				var_30_3.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				var_30_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_3.position).x, (manager.ui.mainCamera.transform.position - var_30_3.position).y, (manager.ui.mainCamera.transform.position - var_30_3.position).z)
				var_30_3.localEulerAngles.z = 0
				var_30_3.localEulerAngles.x = 0
				var_30_3.localEulerAngles = var_30_3.localEulerAngles
			end

			local var_30_5 = arg_27_1.actors_["1284ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_5) and arg_27_1.var_.characterEffect1284ui_story == nil then
				arg_27_1.var_.characterEffect1284ui_story = var_30_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_6 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_6 and not isNil(var_30_5) then
				if arg_27_1.var_.characterEffect1284ui_story and not isNil(var_30_5) then
					arg_27_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_6 and arg_27_1.time_ < 0 + var_30_6 + arg_30_0 and not isNil(var_30_5) and arg_27_1.var_.characterEffect1284ui_story then
				arg_27_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_30_8 = 0
			local var_30_9 = 0.4

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_8 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_10 = arg_27_1:GetWordFromCfg(322072007)
				local var_30_11 = arg_27_1:FormatText(var_30_10.content)

				arg_27_1.text_.text = var_30_11

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_13 = 16 <= 0 and var_30_9 or var_30_9 * (utf8.len(var_30_11) / 16)

				if (16 <= 0 and var_30_9 or var_30_9 * (utf8.len(var_30_11) / 16)) > 0 and var_30_9 < var_30_13 then
					arg_27_1.talkMaxDuration = var_30_13

					if var_30_13 + var_30_8 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_13 + var_30_8
					end
				end

				arg_27_1.text_.text = var_30_11
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072007", "story_v_out_322072.awb") ~= 0 then
					local var_30_14 = manager.audio:GetVoiceLength("story_v_out_322072", "322072007", "story_v_out_322072.awb") / 1000

					if var_30_14 + var_30_8 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_14 + var_30_8
					end

					if var_30_10.prefab_name ~= "" and arg_27_1.actors_[var_30_10.prefab_name] ~= nil then
						local var_30_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_10.prefab_name].transform, "story_v_out_322072", "322072007", "story_v_out_322072.awb")

						arg_27_1:RecordAudio("322072007", var_30_15)
						arg_27_1:RecordAudio("322072007", var_30_15)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_322072", "322072007", "story_v_out_322072.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_322072", "322072007", "story_v_out_322072.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_16 = math.max(var_30_9, arg_27_1.talkMaxDuration)

			if var_30_8 <= arg_27_1.time_ and arg_27_1.time_ < var_30_8 + var_30_16 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_8) / var_30_16

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_8 + var_30_16 and arg_27_1.time_ < var_30_8 + var_30_16 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play322072008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 322072008
		arg_31_1.duration_ = 3.97

		local var_31_0 = {
			zh = 3.333,
			ja = 3.966
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play322072009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos404001ui_story = arg_31_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["404001ui_story"].transform.position).z)
				arg_31_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["404001ui_story"].transform.localEulerAngles = arg_31_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0.8, -1.55, -5.5)
				arg_31_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["404001ui_story"].transform.position).z)
				arg_31_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["404001ui_story"].transform.localEulerAngles = arg_31_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["404001ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect404001ui_story == nil then
				arg_31_1.var_.characterEffect404001ui_story = var_34_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 and not isNil(var_34_1) then
				if arg_31_1.var_.characterEffect404001ui_story and not isNil(var_34_1) then
					arg_31_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect404001ui_story then
				arg_31_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_34_4 = arg_31_1.actors_["1284ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_4) and arg_31_1.var_.characterEffect1284ui_story == nil then
				arg_31_1.var_.characterEffect1284ui_story = var_34_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_5 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_5 and not isNil(var_34_4) then
				if arg_31_1.var_.characterEffect1284ui_story and not isNil(var_34_4) then
					arg_31_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_5)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_5 and arg_31_1.time_ < 0 + var_34_5 + arg_34_0 and not isNil(var_34_4) and arg_31_1.var_.characterEffect1284ui_story then
				arg_31_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_34_6 = 0
			local var_34_7 = 0.4

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_6 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_8 = arg_31_1:GetWordFromCfg(322072008)
				local var_34_9 = arg_31_1:FormatText(var_34_8.content)

				arg_31_1.text_.text = var_34_9

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_11 = 16 <= 0 and var_34_7 or var_34_7 * (utf8.len(var_34_9) / 16)

				if (16 <= 0 and var_34_7 or var_34_7 * (utf8.len(var_34_9) / 16)) > 0 and var_34_7 < var_34_11 then
					arg_31_1.talkMaxDuration = var_34_11

					if var_34_11 + var_34_6 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_11 + var_34_6
					end
				end

				arg_31_1.text_.text = var_34_9
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072008", "story_v_out_322072.awb") ~= 0 then
					local var_34_12 = manager.audio:GetVoiceLength("story_v_out_322072", "322072008", "story_v_out_322072.awb") / 1000

					if var_34_12 + var_34_6 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_12 + var_34_6
					end

					if var_34_8.prefab_name ~= "" and arg_31_1.actors_[var_34_8.prefab_name] ~= nil then
						local var_34_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_8.prefab_name].transform, "story_v_out_322072", "322072008", "story_v_out_322072.awb")

						arg_31_1:RecordAudio("322072008", var_34_13)
						arg_31_1:RecordAudio("322072008", var_34_13)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_322072", "322072008", "story_v_out_322072.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_322072", "322072008", "story_v_out_322072.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_14 = math.max(var_34_7, arg_31_1.talkMaxDuration)

			if var_34_6 <= arg_31_1.time_ and arg_31_1.time_ < var_34_6 + var_34_14 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_6) / var_34_14

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_6 + var_34_14 and arg_31_1.time_ < var_34_6 + var_34_14 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
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

		arg_31_1:InitPlayNodeList()
	end,
	Play322072009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 322072009
		arg_35_1.duration_ = 2

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play322072010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1156ui_story = arg_35_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1156ui_story"].transform.position).z)
				arg_35_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1156ui_story"].transform.localEulerAngles = arg_35_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.18)
				arg_35_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1156ui_story"].transform.position).z)
				arg_35_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1156ui_story"].transform.localEulerAngles = arg_35_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["404001ui_story"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos404001ui_story = var_38_1.localPosition
			end

			local var_38_2 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 then
				var_38_1.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_35_1.time_ - 0) / var_38_2)
				var_38_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_1.position).x, (manager.ui.mainCamera.transform.position - var_38_1.position).y, (manager.ui.mainCamera.transform.position - var_38_1.position).z)
				var_38_1.localEulerAngles.z = 0
				var_38_1.localEulerAngles.x = 0
				var_38_1.localEulerAngles = var_38_1.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 then
				var_38_1.localPosition = Vector3.New(0, 100, 0)
				var_38_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_1.position).x, (manager.ui.mainCamera.transform.position - var_38_1.position).y, (manager.ui.mainCamera.transform.position - var_38_1.position).z)
				var_38_1.localEulerAngles.z = 0
				var_38_1.localEulerAngles.x = 0
				var_38_1.localEulerAngles = var_38_1.localEulerAngles
			end

			local var_38_3 = arg_35_1.actors_["1284ui_story"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1284ui_story = var_38_3.localPosition
			end

			local var_38_4 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				var_38_3.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_35_1.time_ - 0) / var_38_4)
				var_38_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_3.position).x, (manager.ui.mainCamera.transform.position - var_38_3.position).y, (manager.ui.mainCamera.transform.position - var_38_3.position).z)
				var_38_3.localEulerAngles.z = 0
				var_38_3.localEulerAngles.x = 0
				var_38_3.localEulerAngles = var_38_3.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				var_38_3.localPosition = Vector3.New(0, 100, 0)
				var_38_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_3.position).x, (manager.ui.mainCamera.transform.position - var_38_3.position).y, (manager.ui.mainCamera.transform.position - var_38_3.position).z)
				var_38_3.localEulerAngles.z = 0
				var_38_3.localEulerAngles.x = 0
				var_38_3.localEulerAngles = var_38_3.localEulerAngles
			end

			local var_38_5 = arg_35_1.actors_["1156ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_5) and arg_35_1.var_.characterEffect1156ui_story == nil then
				arg_35_1.var_.characterEffect1156ui_story = var_38_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_6 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_6 and not isNil(var_38_5) then
				if arg_35_1.var_.characterEffect1156ui_story and not isNil(var_38_5) then
					arg_35_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_6 and arg_35_1.time_ < 0 + var_38_6 + arg_38_0 and not isNil(var_38_5) and arg_35_1.var_.characterEffect1156ui_story then
				arg_35_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_38_8 = arg_35_1.actors_["404001ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_8) and arg_35_1.var_.characterEffect404001ui_story == nil then
				arg_35_1.var_.characterEffect404001ui_story = var_38_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_9 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_9 and not isNil(var_38_8) then
				if arg_35_1.var_.characterEffect404001ui_story and not isNil(var_38_8) then
					arg_35_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_35_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_9)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_9 and arg_35_1.time_ < 0 + var_38_9 + arg_38_0 and not isNil(var_38_8) and arg_35_1.var_.characterEffect404001ui_story then
				arg_35_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_35_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action6_1")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_38_10 = 0
			local var_38_11 = 0.15

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_10 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_12 = arg_35_1:GetWordFromCfg(322072009)
				local var_38_13 = arg_35_1:FormatText(var_38_12.content)

				arg_35_1.text_.text = var_38_13

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_15 = 6 <= 0 and var_38_11 or var_38_11 * (utf8.len(var_38_13) / 6)

				if (6 <= 0 and var_38_11 or var_38_11 * (utf8.len(var_38_13) / 6)) > 0 and var_38_11 < var_38_15 then
					arg_35_1.talkMaxDuration = var_38_15

					if var_38_15 + var_38_10 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_15 + var_38_10
					end
				end

				arg_35_1.text_.text = var_38_13
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072009", "story_v_out_322072.awb") ~= 0 then
					local var_38_16 = manager.audio:GetVoiceLength("story_v_out_322072", "322072009", "story_v_out_322072.awb") / 1000

					if var_38_16 + var_38_10 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_16 + var_38_10
					end

					if var_38_12.prefab_name ~= "" and arg_35_1.actors_[var_38_12.prefab_name] ~= nil then
						local var_38_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_12.prefab_name].transform, "story_v_out_322072", "322072009", "story_v_out_322072.awb")

						arg_35_1:RecordAudio("322072009", var_38_17)
						arg_35_1:RecordAudio("322072009", var_38_17)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_322072", "322072009", "story_v_out_322072.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_322072", "322072009", "story_v_out_322072.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_18 = math.max(var_38_11, arg_35_1.talkMaxDuration)

			if var_38_10 <= arg_35_1.time_ and arg_35_1.time_ < var_38_10 + var_38_18 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_10) / var_38_18

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_10 + var_38_18 and arg_35_1.time_ < var_38_10 + var_38_18 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
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

		arg_35_1:InitPlayNodeList()
	end,
	Play322072010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 322072010
		arg_39_1.duration_ = 9

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play322072011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_9000

			if arg_39_1.bgs_.L19f == nil then
				local var_42_0 = Object.Instantiate(arg_39_1.paintGo_)

				var_42_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L19f")
				var_42_0.name = "L19f"
				var_42_0.transform.parent = arg_39_1.stage_.transform
				var_42_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.bgs_.L19f = var_42_0
			end

			if 2 < arg_39_1.time_ and arg_39_1.time_ <= 2 + arg_42_0 then
				local var_42_1 = arg_39_1.bgs_.L19f

				arg_39_1.bgs_.L19f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_42_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_42_2 = var_42_1:GetComponent("SpriteRenderer")

				if var_42_2 and var_42_2.sprite then
					local var_42_3 = 2 * (var_42_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_42_1.transform.localScale = Vector3.New(var_42_3 / var_42_2.sprite.bounds.size.y < var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x and var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x or var_42_3 / var_42_2.sprite.bounds.size.y, var_42_3 / var_42_2.sprite.bounds.size.y < var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x and var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x or var_42_3 / var_42_2.sprite.bounds.size.y, 0)
				end

				for iter_42_0, iter_42_1 in pairs(arg_39_1.bgs_) do
					if iter_42_0 ~= "L19f" then
						iter_42_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_42_4 = 4

			if 4 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.allBtn_.enabled = false
			end

			if arg_39_1.time_ >= var_42_4 + 0.3 and arg_39_1.time_ < var_42_4 + 0.3 + arg_42_0 then
				arg_39_1.allBtn_.enabled = true
			end

			local var_42_5 = 0

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_5 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_6 = 2

			if var_42_5 <= arg_39_1.time_ and arg_39_1.time_ < var_42_5 + var_42_6 then
				local var_42_7 = Color.New(0, 0, 0)

				var_42_7.a = Mathf.Lerp(0, 1, (arg_39_1.time_ - var_42_5) / var_42_6)
				arg_39_1.mask_.color = var_42_7
			end

			if arg_39_1.time_ >= var_42_5 + var_42_6 and arg_39_1.time_ < var_42_5 + var_42_6 + arg_42_0 then
				local var_42_8 = Color.New(0, 0, 0)

				var_42_8.a = 1
				arg_39_1.mask_.color = var_42_8
			end

			local var_42_9 = 2

			if 2 < arg_39_1.time_ and arg_39_1.time_ <= var_42_9 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_10 = 2

			if var_42_9 <= arg_39_1.time_ and arg_39_1.time_ < var_42_9 + var_42_10 then
				local var_42_11 = Color.New(0, 0, 0)

				var_42_11.a = Mathf.Lerp(1, 0, (arg_39_1.time_ - var_42_9) / var_42_10)
				arg_39_1.mask_.color = var_42_11
			end

			if arg_39_1.time_ >= var_42_9 + var_42_10 and arg_39_1.time_ < var_42_9 + var_42_10 + arg_42_0 then
				local var_42_12 = Color.New(0, 0, 0)

				arg_39_1.mask_.enabled = false
				var_42_12.a = 0
				arg_39_1.mask_.color = var_42_12
			end

			local var_42_13 = arg_39_1.actors_["1156ui_story"].transform

			if 1.96599999815226 < arg_39_1.time_ and arg_39_1.time_ <= 1.96599999815226 + arg_42_0 then
				arg_39_1.var_.moveOldPos1156ui_story = var_42_13.localPosition
			end

			local var_42_14 = 0.001

			if 1.96599999815226 <= arg_39_1.time_ and arg_39_1.time_ < 1.96599999815226 + var_42_14 then
				var_42_13.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_39_1.time_ - 1.96599999815226) / var_42_14)
				var_42_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_13.position).x, (manager.ui.mainCamera.transform.position - var_42_13.position).y, (manager.ui.mainCamera.transform.position - var_42_13.position).z)
				var_42_13.localEulerAngles.z = 0
				var_42_13.localEulerAngles.x = 0
				var_42_13.localEulerAngles = var_42_13.localEulerAngles
			end

			if arg_39_1.time_ >= 1.96599999815226 + var_42_14 and arg_39_1.time_ < 1.96599999815226 + var_42_14 + arg_42_0 then
				var_42_13.localPosition = Vector3.New(0, 100, 0)
				var_42_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_13.position).x, (manager.ui.mainCamera.transform.position - var_42_13.position).y, (manager.ui.mainCamera.transform.position - var_42_13.position).z)
				var_42_13.localEulerAngles.z = 0
				var_42_13.localEulerAngles.x = 0
				var_42_13.localEulerAngles = var_42_13.localEulerAngles
			end

			local var_42_15 = arg_39_1.actors_["1156ui_story"]

			if 1.96599999815226 < arg_39_1.time_ and arg_39_1.time_ <= 1.96599999815226 + arg_42_0 and not isNil(var_42_15) and arg_39_1.var_.characterEffect1156ui_story == nil then
				arg_39_1.var_.characterEffect1156ui_story = var_42_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_16 = 0.034000001847744

			if 1.96599999815226 <= arg_39_1.time_ and arg_39_1.time_ < 1.96599999815226 + var_42_16 and not isNil(var_42_15) then
				if arg_39_1.var_.characterEffect1156ui_story and not isNil(var_42_15) then
					arg_39_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 1.96599999815226) / var_42_16)
				end
			end

			if arg_39_1.time_ >= 1.96599999815226 + var_42_16 and arg_39_1.time_ < 1.96599999815226 + var_42_16 + arg_42_0 and not isNil(var_42_15) and arg_39_1.var_.characterEffect1156ui_story then
				arg_39_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 2.5 < arg_39_1.time_ and arg_39_1.time_ <= 2.5 + arg_42_0 then
				arg_39_1:AudioAction("play", "effect", "se_story_8", "se_story_8_fire05", "")
			end

			if 0.2 < arg_39_1.time_ and arg_39_1.time_ <= 0.2 + arg_42_0 then
				arg_39_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			if 1.5 < arg_39_1.time_ and arg_39_1.time_ <= 1.5 + arg_42_0 then
				arg_39_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_stone_l19f", "")
			end

			if 2.5 < arg_39_1.time_ and arg_39_1.time_ <= 2.5 + arg_42_0 then
				local var_42_20 = arg_39_1.var_.effect2010

				if not arg_39_1.var_.effect2010 then
					var_42_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), manager.ui.mainCamera.transform)
					var_42_20.name = "2010"
					arg_39_1.var_.effect2010 = var_42_20
				else
					var_42_20.transform:SetParent(var_42_9000)
				end

				var_42_20.transform.localPosition = Vector3.New(0, 0, -3.86)
				var_42_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_42_22 = arg_39_1.bgs_.L19f.transform

			if 2 < arg_39_1.time_ and arg_39_1.time_ <= 2 + arg_42_0 then
				arg_39_1.var_.moveOldPosL19f = var_42_22.localPosition
			end

			local var_42_23 = 0.001

			if 2 <= arg_39_1.time_ and arg_39_1.time_ < 2 + var_42_23 then
				var_42_22.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPosL19f, Vector3.New(0, 1, 10), (arg_39_1.time_ - 2) / var_42_23)
			end

			if arg_39_1.time_ >= 2 + var_42_23 and arg_39_1.time_ < 2 + var_42_23 + arg_42_0 then
				var_42_22.localPosition = Vector3.New(0, 1, 10)
			end

			local var_42_24 = arg_39_1.bgs_.L19f.transform

			if 2.034 < arg_39_1.time_ and arg_39_1.time_ <= 2.034 + arg_42_0 then
				arg_39_1.var_.moveOldPosL19f = var_42_24.localPosition
			end

			local var_42_25 = 1.466

			if 2.034 <= arg_39_1.time_ and arg_39_1.time_ < 2.034 + var_42_25 then
				var_42_24.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPosL19f, Vector3.New(0, 1, 8), (arg_39_1.time_ - 2.034) / var_42_25)
			end

			if arg_39_1.time_ >= 2.034 + var_42_25 and arg_39_1.time_ < 2.034 + var_42_25 + arg_42_0 then
				var_42_24.localPosition = Vector3.New(0, 1, 8)
			end

			if arg_39_1.frameCnt_ <= 1 then
				arg_39_1.dialog_:SetActive(false)
			end

			local var_42_26 = 4
			local var_42_27 = 1.6

			if 4 < arg_39_1.time_ and arg_39_1.time_ <= var_42_26 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				arg_39_1.dialog_:SetActive(true)

				arg_39_1.dialogCg_.alpha = 0

				local var_42_28 = LeanTween.value(arg_39_1.dialog_, 0, 1, 0.3)

				var_42_28:setOnUpdate(LuaHelper.FloatAction(function(arg_43_0)
					arg_39_1.dialogCg_.alpha = arg_43_0
				end))
				var_42_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_39_1.dialog_)
					var_42_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_39_1.duration_ = arg_39_1.duration_ + 0.3

				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_29 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(322072010).content)

				arg_39_1.text_.text = var_42_29

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_31 = 64 <= 0 and var_42_27 or var_42_27 * (utf8.len(var_42_29) / 64)

				if (64 <= 0 and var_42_27 or var_42_27 * (utf8.len(var_42_29) / 64)) > 0 and var_42_27 < var_42_31 then
					arg_39_1.talkMaxDuration = var_42_31
					var_42_26 = var_42_26 + 0.3

					if var_42_31 + var_42_26 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_31 + var_42_26
					end
				end

				arg_39_1.text_.text = var_42_29
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_32 = var_42_26 + 0.3
			local var_42_33 = math.max(var_42_27, arg_39_1.talkMaxDuration)

			if var_42_26 + 0.3 <= arg_39_1.time_ and arg_39_1.time_ < var_42_32 + var_42_33 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_32) / var_42_33

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_32 + var_42_33 and arg_39_1.time_ < var_42_32 + var_42_33 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "L19f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "L19f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.466,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play322072011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322072011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play322072012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_9000

			if 0.1 < arg_45_1.time_ and arg_45_1.time_ <= 0.1 + arg_48_0 then
				arg_45_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_explosion", "")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				local var_48_1 = arg_45_1.var_.effect2011

				if not arg_45_1.var_.effect2011 then
					var_48_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rockfall"), manager.ui.mainCamera.transform)
					var_48_1.name = "2011"
					arg_45_1.var_.effect2011 = var_48_1
				else
					var_48_1.transform:SetParent(var_48_9000)
				end

				var_48_1.transform.localPosition = Vector3.New(0, 0, -8.33)
				var_48_1.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_48_3 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_48_4 = var_48_1.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_48_0, iter_48_1 in ipairs((var_48_4:ToTable())) do
					iter_48_1.transform.localScale = Vector3.New(iter_48_1.transform.localScale.x / var_48_3 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_48_4 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_48_1.transform.localScale.y / var_48_3, iter_48_1.transform.localScale.z)
				end
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				if arg_45_1.var_.effect2010 then
					Object.Destroy(arg_45_1.var_.effect2010)

					arg_45_1.var_.effect2010 = nil
				end
			end

			local var_48_7 = manager.ui.mainCamera.transform

			if 0.1 < arg_45_1.time_ and arg_45_1.time_ <= 0.1 + arg_48_0 then
				arg_45_1.var_.shakeOldPos = var_48_7.localPosition
			end

			local var_48_8 = 0.9

			if 0.1 <= arg_45_1.time_ and arg_45_1.time_ < 0.1 + var_48_8 then
				local var_48_9, var_48_10 = math.modf((arg_45_1.time_ - 0.1) / 0.066)

				var_48_7.localPosition = Vector3.New(var_48_10 * 0.13, var_48_10 * 0.13, var_48_10 * 0.13) + arg_45_1.var_.shakeOldPos
			end

			if arg_45_1.time_ >= 0.1 + var_48_8 and arg_45_1.time_ < 0.1 + var_48_8 + arg_48_0 then
				var_48_7.localPosition = arg_45_1.var_.shakeOldPos
			end

			local var_48_11 = 0
			local var_48_12 = 1.25

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_11 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_13 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(322072011).content)

				arg_45_1.text_.text = var_48_13

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_15 = 50 <= 0 and var_48_12 or var_48_12 * (utf8.len(var_48_13) / 50)

				if (50 <= 0 and var_48_12 or var_48_12 * (utf8.len(var_48_13) / 50)) > 0 and var_48_12 < var_48_15 then
					arg_45_1.talkMaxDuration = var_48_15

					if var_48_15 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_15 + var_48_11
					end
				end

				arg_45_1.text_.text = var_48_13
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_12, arg_45_1.talkMaxDuration)

			if var_48_11 <= arg_45_1.time_ and arg_45_1.time_ < var_48_11 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_11) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_11 + var_48_16 and arg_45_1.time_ < var_48_11 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play322072012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322072012
		arg_49_1.duration_ = 5.33

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play322072013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				if arg_49_1.var_.effect2011 then
					Object.Destroy(arg_49_1.var_.effect2011)

					arg_49_1.var_.effect2011 = nil
				end
			end

			local var_52_1 = 0

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_2 = 0.333333333333333

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = Color.New(0, 0, 0)

				var_52_3.a = Mathf.Lerp(0, 1, (arg_49_1.time_ - var_52_1) / var_52_2)
				arg_49_1.mask_.color = var_52_3
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				local var_52_4 = Color.New(0, 0, 0)

				var_52_4.a = 1
				arg_49_1.mask_.color = var_52_4
			end

			local var_52_5 = 0.333333333333333

			if 0.333333333333333 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_6 = 0.333333333333333

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_6 then
				local var_52_7 = Color.New(0, 0, 0)

				var_52_7.a = Mathf.Lerp(1, 0, (arg_49_1.time_ - var_52_5) / var_52_6)
				arg_49_1.mask_.color = var_52_7
			end

			if arg_49_1.time_ >= var_52_5 + var_52_6 and arg_49_1.time_ < var_52_5 + var_52_6 + arg_52_0 then
				local var_52_8 = Color.New(0, 0, 0)

				arg_49_1.mask_.enabled = false
				var_52_8.a = 0
				arg_49_1.mask_.color = var_52_8
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_9 = 0.333333333333333
			local var_52_10 = 1.05

			if 0.333333333333333 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_11 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_11:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_49_1.dialogCg_.alpha = arg_53_0
				end))
				var_52_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_12 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(322072012).content)

				arg_49_1.text_.text = var_52_12

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_14 = 42 <= 0 and var_52_10 or var_52_10 * (utf8.len(var_52_12) / 42)

				if (42 <= 0 and var_52_10 or var_52_10 * (utf8.len(var_52_12) / 42)) > 0 and var_52_10 < var_52_14 then
					arg_49_1.talkMaxDuration = var_52_14
					var_52_9 = var_52_9 + 0.3

					if var_52_14 + var_52_9 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_9
					end
				end

				arg_49_1.text_.text = var_52_12
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_15 = var_52_9 + 0.3
			local var_52_16 = math.max(var_52_10, arg_49_1.talkMaxDuration)

			if var_52_9 + 0.3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_15) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_15 + var_52_16 and arg_49_1.time_ < var_52_15 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play322072013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 322072013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play322072014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0.1 < arg_55_1.time_ and arg_55_1.time_ <= 0.1 + arg_58_0 then
				arg_55_1:AudioAction("play", "effect", "se_story_145", "se_story_145_monster_scream01", "")
			end

			local var_58_1 = manager.ui.mainCamera.transform

			if 0.125 < arg_55_1.time_ and arg_55_1.time_ <= 0.125 + arg_58_0 then
				arg_55_1.var_.shakeOldPos = var_58_1.localPosition
			end

			local var_58_2 = 0.541666666666667

			if 0.125 <= arg_55_1.time_ and arg_55_1.time_ < 0.125 + var_58_2 then
				local var_58_3, var_58_4 = math.modf((arg_55_1.time_ - 0.125) / 0.066)

				var_58_1.localPosition = Vector3.New(var_58_4 * 0.13, var_58_4 * 0.13, var_58_4 * 0.13) + arg_55_1.var_.shakeOldPos
			end

			if arg_55_1.time_ >= 0.125 + var_58_2 and arg_55_1.time_ < 0.125 + var_58_2 + arg_58_0 then
				var_58_1.localPosition = arg_55_1.var_.shakeOldPos
			end

			local var_58_5 = 0
			local var_58_6 = 0.125

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_5 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[1363].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4052")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_7 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(322072013).content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 5 <= 0 and var_58_6 or var_58_6 * (utf8.len(var_58_7) / 5)

				if (5 <= 0 and var_58_6 or var_58_6 * (utf8.len(var_58_7) / 5)) > 0 and var_58_6 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_5 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_5
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_10 = math.max(var_58_6, arg_55_1.talkMaxDuration)

			if var_58_5 <= arg_55_1.time_ and arg_55_1.time_ < var_58_5 + var_58_10 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_5) / var_58_10

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_5 + var_58_10 and arg_55_1.time_ < var_58_5 + var_58_10 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play322072014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 322072014
		arg_59_1.duration_ = 6.2

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play322072015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_9000

			if 0.5 < arg_59_1.time_ and arg_59_1.time_ <= 0.5 + arg_62_0 then
				arg_59_1:AudioAction("play", "effect", "se_story_141", "se_story_141_snake07", "")
			end

			if 0.5 < arg_59_1.time_ and arg_59_1.time_ <= 0.5 + arg_62_0 then
				local var_62_1 = arg_59_1.var_.effect2014

				if not arg_59_1.var_.effect2014 then
					var_62_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_zhua"), manager.ui.mainCamera.transform)
					var_62_1.name = "2014"
					arg_59_1.var_.effect2014 = var_62_1
				else
					var_62_1.transform:SetParent(var_62_9000)
				end

				var_62_1.transform.localPosition = Vector3.New(-0.42, 0, -6.04)
				var_62_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.96666666666667 < arg_59_1.time_ and arg_59_1.time_ <= 3.96666666666667 + arg_62_0 then
				if arg_59_1.var_.effect2014 then
					Object.Destroy(arg_59_1.var_.effect2014)

					arg_59_1.var_.effect2014 = nil
				end
			end

			local var_62_4 = manager.ui.mainCamera.transform

			if 0.5 < arg_59_1.time_ and arg_59_1.time_ <= 0.5 + arg_62_0 then
				arg_59_1.var_.shakeOldPos = var_62_4.localPosition
			end

			local var_62_5 = 0.45

			if 0.5 <= arg_59_1.time_ and arg_59_1.time_ < 0.5 + var_62_5 then
				local var_62_6, var_62_7 = math.modf((arg_59_1.time_ - 0.5) / 0.066)

				var_62_4.localPosition = Vector3.New(var_62_7 * 0.13, var_62_7 * 0.13, var_62_7 * 0.13) + arg_59_1.var_.shakeOldPos
			end

			if arg_59_1.time_ >= 0.5 + var_62_5 and arg_59_1.time_ < 0.5 + var_62_5 + arg_62_0 then
				var_62_4.localPosition = arg_59_1.var_.shakeOldPos
			end

			local var_62_8 = 0.566666666666667

			if 0.566666666666667 < arg_59_1.time_ and arg_59_1.time_ <= var_62_8 + arg_62_0 then
				arg_59_1.mask_.enabled = true
				arg_59_1.mask_.raycastTarget = false

				arg_59_1:SetGaussion(false)
			end

			local var_62_9 = 0.0666666666666667

			if var_62_8 <= arg_59_1.time_ and arg_59_1.time_ < var_62_8 + var_62_9 then
				local var_62_10 = Color.New(1, 0.3820755, 0.3968858)

				var_62_10.a = Mathf.Lerp(1, 0, (arg_59_1.time_ - var_62_8) / var_62_9)
				arg_59_1.mask_.color = var_62_10
			end

			if arg_59_1.time_ >= var_62_8 + var_62_9 and arg_59_1.time_ < var_62_8 + var_62_9 + arg_62_0 then
				local var_62_11 = Color.New(1, 0.3820755, 0.3968858)

				arg_59_1.mask_.enabled = false
				var_62_11.a = 0
				arg_59_1.mask_.color = var_62_11
			end

			local var_62_12 = 0
			local var_62_13 = 0.95

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_12 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_14 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(322072014).content)

				arg_59_1.text_.text = var_62_14

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_16 = 38 <= 0 and var_62_13 or var_62_13 * (utf8.len(var_62_14) / 38)

				if (38 <= 0 and var_62_13 or var_62_13 * (utf8.len(var_62_14) / 38)) > 0 and var_62_13 < var_62_16 then
					arg_59_1.talkMaxDuration = var_62_16

					if var_62_16 + var_62_12 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_16 + var_62_12
					end
				end

				arg_59_1.text_.text = var_62_14
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_17 = math.max(var_62_13, arg_59_1.talkMaxDuration)

			if var_62_12 <= arg_59_1.time_ and arg_59_1.time_ < var_62_12 + var_62_17 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_12) / var_62_17

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_12 + var_62_17 and arg_59_1.time_ < var_62_12 + var_62_17 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play322072015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 322072015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play322072016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0.1 < arg_63_1.time_ and arg_63_1.time_ <= 0.1 + arg_66_0 then
				arg_63_1:AudioAction("play", "effect", "se_story_145", "se_story_145_star_movement_wobble02", "")
			end

			local var_66_1 = 0
			local var_66_2 = 1.55

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_3 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(322072015).content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 62 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 62)

				if (62 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 62)) > 0 and var_66_2 < var_66_5 then
					arg_63_1.talkMaxDuration = var_66_5

					if var_66_5 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + var_66_1
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_6 = math.max(var_66_2, arg_63_1.talkMaxDuration)

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_6 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_1) / var_66_6

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_1 + var_66_6 and arg_63_1.time_ < var_66_1 + var_66_6 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play322072016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 322072016
		arg_67_1.duration_ = 2.63

		local var_67_0 = {
			zh = 1.466,
			ja = 2.633
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
				arg_67_0:Play322072017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.175

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10150")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:GetWordFromCfg(322072016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 7 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 7)

				if (7 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 7)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072016", "story_v_out_322072.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_322072", "322072016", "story_v_out_322072.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_322072", "322072016", "story_v_out_322072.awb")

						arg_67_1:RecordAudio("322072016", var_70_6)
						arg_67_1:RecordAudio("322072016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_322072", "322072016", "story_v_out_322072.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_322072", "322072016", "story_v_out_322072.awb")
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
	Play322072017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 322072017
		arg_71_1.duration_ = 11.23

		local var_71_0 = {
			zh = 9.166,
			ja = 11.233
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
				arg_71_0:Play322072018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if arg_71_1.bgs_.ST61a == nil then
				local var_74_0 = Object.Instantiate(arg_71_1.paintGo_)

				var_74_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST61a")
				var_74_0.name = "ST61a"
				var_74_0.transform.parent = arg_71_1.stage_.transform
				var_74_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.bgs_.ST61a = var_74_0
			end

			if 2 < arg_71_1.time_ and arg_71_1.time_ <= 2 + arg_74_0 then
				local var_74_1 = arg_71_1.bgs_.ST61a

				arg_71_1.bgs_.ST61a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_74_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_74_2 = var_74_1:GetComponent("SpriteRenderer")

				if var_74_2 and var_74_2.sprite then
					local var_74_3 = 2 * (var_74_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_74_1.transform.localScale = Vector3.New(var_74_3 / var_74_2.sprite.bounds.size.y < var_74_3 * manager.ui.mainCameraCom_.aspect / var_74_2.sprite.bounds.size.x and var_74_3 * manager.ui.mainCameraCom_.aspect / var_74_2.sprite.bounds.size.x or var_74_3 / var_74_2.sprite.bounds.size.y, var_74_3 / var_74_2.sprite.bounds.size.y < var_74_3 * manager.ui.mainCameraCom_.aspect / var_74_2.sprite.bounds.size.x and var_74_3 * manager.ui.mainCameraCom_.aspect / var_74_2.sprite.bounds.size.x or var_74_3 / var_74_2.sprite.bounds.size.y, 0)
				end

				for iter_74_0, iter_74_1 in pairs(arg_71_1.bgs_) do
					if iter_74_0 ~= "ST61a" then
						iter_74_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_74_4 = 3.999999999999

			if 3.999999999999 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.allBtn_.enabled = false
			end

			if arg_71_1.time_ >= var_74_4 + 0.3 and arg_71_1.time_ < var_74_4 + 0.3 + arg_74_0 then
				arg_71_1.allBtn_.enabled = true
			end

			local var_74_5 = 0

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_6 = 2

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_6 then
				local var_74_7 = Color.New(0, 0, 0)

				var_74_7.a = Mathf.Lerp(0, 1, (arg_71_1.time_ - var_74_5) / var_74_6)
				arg_71_1.mask_.color = var_74_7
			end

			if arg_71_1.time_ >= var_74_5 + var_74_6 and arg_71_1.time_ < var_74_5 + var_74_6 + arg_74_0 then
				local var_74_8 = Color.New(0, 0, 0)

				var_74_8.a = 1
				arg_71_1.mask_.color = var_74_8
			end

			local var_74_9 = 2

			if 2 < arg_71_1.time_ and arg_71_1.time_ <= var_74_9 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_10 = 2

			if var_74_9 <= arg_71_1.time_ and arg_71_1.time_ < var_74_9 + var_74_10 then
				local var_74_11 = Color.New(0, 0, 0)

				var_74_11.a = Mathf.Lerp(1, 0, (arg_71_1.time_ - var_74_9) / var_74_10)
				arg_71_1.mask_.color = var_74_11
			end

			if arg_71_1.time_ >= var_74_9 + var_74_10 and arg_71_1.time_ < var_74_9 + var_74_10 + arg_74_0 then
				local var_74_12 = Color.New(0, 0, 0)

				arg_71_1.mask_.enabled = false
				var_74_12.a = 0
				arg_71_1.mask_.color = var_74_12
			end

			local var_74_13 = "1089ui_story"

			if arg_71_1.actors_["1089ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1089ui_story"))) then
				local var_74_14 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_71_1.stage_.transform)

				var_74_14.name = var_74_13
				var_74_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.actors_[var_74_13] = var_74_14

				local var_74_15 = var_74_14:GetComponentInChildren(typeof(CharacterEffect))

				var_74_15.enabled = true

				local var_74_16 = GameObjectTools.GetOrAddComponent(var_74_14, typeof(DynamicBoneHelper))

				if var_74_16 then
					var_74_16:EnableDynamicBone(false)
				end

				arg_71_1:ShowWeapon(var_74_15.transform, false)

				arg_71_1.var_[var_74_13 .. "Animator"] = var_74_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_71_1.var_[var_74_13 .. "Animator"].applyRootMotion = true
				arg_71_1.var_[var_74_13 .. "LipSync"] = var_74_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_74_17 = arg_71_1.actors_["1089ui_story"].transform

			if 3.8 < arg_71_1.time_ and arg_71_1.time_ <= 3.8 + arg_74_0 then
				arg_71_1.var_.moveOldPos1089ui_story = var_74_17.localPosition
			end

			local var_74_18 = 0.001

			if 3.8 <= arg_71_1.time_ and arg_71_1.time_ < 3.8 + var_74_18 then
				var_74_17.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_71_1.time_ - 3.8) / var_74_18)
				var_74_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_17.position).x, (manager.ui.mainCamera.transform.position - var_74_17.position).y, (manager.ui.mainCamera.transform.position - var_74_17.position).z)
				var_74_17.localEulerAngles.z = 0
				var_74_17.localEulerAngles.x = 0
				var_74_17.localEulerAngles = var_74_17.localEulerAngles
			end

			if arg_71_1.time_ >= 3.8 + var_74_18 and arg_71_1.time_ < 3.8 + var_74_18 + arg_74_0 then
				var_74_17.localPosition = Vector3.New(0, -1.1, -6.17)
				var_74_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_17.position).x, (manager.ui.mainCamera.transform.position - var_74_17.position).y, (manager.ui.mainCamera.transform.position - var_74_17.position).z)
				var_74_17.localEulerAngles.z = 0
				var_74_17.localEulerAngles.x = 0
				var_74_17.localEulerAngles = var_74_17.localEulerAngles
			end

			local var_74_19 = arg_71_1.actors_["1089ui_story"]

			if 3.8 < arg_71_1.time_ and arg_71_1.time_ <= 3.8 + arg_74_0 and not isNil(var_74_19) and arg_71_1.var_.characterEffect1089ui_story == nil then
				arg_71_1.var_.characterEffect1089ui_story = var_74_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_20 = 0.200000002980232

			if 3.8 <= arg_71_1.time_ and arg_71_1.time_ < 3.8 + var_74_20 and not isNil(var_74_19) then
				if arg_71_1.var_.characterEffect1089ui_story and not isNil(var_74_19) then
					arg_71_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 3.8 + var_74_20 and arg_71_1.time_ < 3.8 + var_74_20 + arg_74_0 and not isNil(var_74_19) and arg_71_1.var_.characterEffect1089ui_story then
				arg_71_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 3.8 < arg_71_1.time_ and arg_71_1.time_ <= 3.8 + arg_74_0 then
				arg_71_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			if 3.8 < arg_71_1.time_ and arg_71_1.time_ <= 3.8 + arg_74_0 then
				arg_71_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_74_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_71_1.bgmTxt_.text ~= var_74_24 and arg_71_1.bgmTxt_.text ~= "" then
						if arg_71_1.bgmTxt2_.text ~= "" then
							arg_71_1.bgmTxt_.text = arg_71_1.bgmTxt2_.text
						end

						arg_71_1.bgmTxt2_.text = var_74_24

						arg_71_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_71_1.bgmTxt_.text = var_74_24
						arg_71_1.bgmTxt2_.text = var_74_24
					end

					if arg_71_1.bgmTimer then
						arg_71_1.bgmTimer:Stop()

						arg_71_1.bgmTimer = nil
					end

					if arg_71_1.settingData.show_music_name == 1 then
						arg_71_1.musicController:SetSelectedState("show")
						arg_71_1.musicAnimator_:Play("open", 0, 0)

						if arg_71_1.settingData.music_time ~= 0 then
							arg_71_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_71_1.settingData.music_time), function()
								if arg_71_1 == nil or isNil(arg_71_1.bgmTxt_) then
									return
								end

								arg_71_1.musicController:SetSelectedState("hide")
								arg_71_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.366666666666667 < arg_71_1.time_ and arg_71_1.time_ <= 0.366666666666667 + arg_74_0 then
				arg_71_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious.awb")

				local var_74_27 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious")

				if "" ~= "" then
					if arg_71_1.bgmTxt_.text ~= var_74_27 and arg_71_1.bgmTxt_.text ~= "" then
						if arg_71_1.bgmTxt2_.text ~= "" then
							arg_71_1.bgmTxt_.text = arg_71_1.bgmTxt2_.text
						end

						arg_71_1.bgmTxt2_.text = var_74_27

						arg_71_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_71_1.bgmTxt_.text = var_74_27
						arg_71_1.bgmTxt2_.text = var_74_27
					end

					if arg_71_1.bgmTimer then
						arg_71_1.bgmTimer:Stop()

						arg_71_1.bgmTimer = nil
					end

					if arg_71_1.settingData.show_music_name == 1 then
						arg_71_1.musicController:SetSelectedState("show")
						arg_71_1.musicAnimator_:Play("open", 0, 0)

						if arg_71_1.settingData.music_time ~= 0 then
							arg_71_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_71_1.settingData.music_time), function()
								if arg_71_1 == nil or isNil(arg_71_1.bgmTxt_) then
									return
								end

								arg_71_1.musicController:SetSelectedState("hide")
								arg_71_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.200000002980232 < arg_71_1.time_ and arg_71_1.time_ <= 0.200000002980232 + arg_74_0 then
				arg_71_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_stone_l19f", "")
			end

			if 1.5 < arg_71_1.time_ and arg_71_1.time_ <= 1.5 + arg_74_0 then
				arg_71_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_street_night02", "")
			end

			if 0.37 < arg_71_1.time_ and arg_71_1.time_ <= 0.37 + arg_74_0 then
				arg_71_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "init_story", "bgm_activity_4_5_story_serious.awb")

				local var_74_32 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "init_story")

				if "" ~= "" then
					if arg_71_1.bgmTxt_.text ~= var_74_32 and arg_71_1.bgmTxt_.text ~= "" then
						if arg_71_1.bgmTxt2_.text ~= "" then
							arg_71_1.bgmTxt_.text = arg_71_1.bgmTxt2_.text
						end

						arg_71_1.bgmTxt2_.text = var_74_32

						arg_71_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_71_1.bgmTxt_.text = var_74_32
						arg_71_1.bgmTxt2_.text = var_74_32
					end

					if arg_71_1.bgmTimer then
						arg_71_1.bgmTimer:Stop()

						arg_71_1.bgmTimer = nil
					end

					if arg_71_1.settingData.show_music_name == 1 then
						arg_71_1.musicController:SetSelectedState("show")
						arg_71_1.musicAnimator_:Play("open", 0, 0)

						if arg_71_1.settingData.music_time ~= 0 then
							arg_71_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_71_1.settingData.music_time), function()
								if arg_71_1 == nil or isNil(arg_71_1.bgmTxt_) then
									return
								end

								arg_71_1.musicController:SetSelectedState("hide")
								arg_71_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_71_1.frameCnt_ <= 1 then
				arg_71_1.dialog_:SetActive(false)
			end

			local var_74_33 = 4
			local var_74_34 = 0.625

			if 4 < arg_71_1.time_ and arg_71_1.time_ <= var_74_33 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				arg_71_1.dialog_:SetActive(true)

				arg_71_1.dialogCg_.alpha = 0

				local var_74_35 = LeanTween.value(arg_71_1.dialog_, 0, 1, 0.3)

				var_74_35:setOnUpdate(LuaHelper.FloatAction(function(arg_78_0)
					arg_71_1.dialogCg_.alpha = arg_78_0
				end))
				var_74_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_71_1.dialog_)
					var_74_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_71_1.duration_ = arg_71_1.duration_ + 0.3

				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_36 = arg_71_1:GetWordFromCfg(322072017)
				local var_74_37 = arg_71_1:FormatText(var_74_36.content)

				arg_71_1.text_.text = var_74_37

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_39 = 25 <= 0 and var_74_34 or var_74_34 * (utf8.len(var_74_37) / 25)

				if (25 <= 0 and var_74_34 or var_74_34 * (utf8.len(var_74_37) / 25)) > 0 and var_74_34 < var_74_39 then
					arg_71_1.talkMaxDuration = var_74_39
					var_74_33 = var_74_33 + 0.3

					if var_74_39 + var_74_33 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_39 + var_74_33
					end
				end

				arg_71_1.text_.text = var_74_37
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072017", "story_v_out_322072.awb") ~= 0 then
					local var_74_40 = manager.audio:GetVoiceLength("story_v_out_322072", "322072017", "story_v_out_322072.awb") / 1000

					if var_74_40 + var_74_33 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_40 + var_74_33
					end

					if var_74_36.prefab_name ~= "" and arg_71_1.actors_[var_74_36.prefab_name] ~= nil then
						local var_74_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_36.prefab_name].transform, "story_v_out_322072", "322072017", "story_v_out_322072.awb")

						arg_71_1:RecordAudio("322072017", var_74_41)
						arg_71_1:RecordAudio("322072017", var_74_41)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_322072", "322072017", "story_v_out_322072.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_322072", "322072017", "story_v_out_322072.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_42 = var_74_33 + 0.3
			local var_74_43 = math.max(var_74_34, arg_71_1.talkMaxDuration)

			if var_74_33 + 0.3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_42 + var_74_43 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_42) / var_74_43

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_42 + var_74_43 and arg_71_1.time_ < var_74_42 + var_74_43 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play322072018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 322072018
		arg_80_1.duration_ = 5.1

		local var_80_0 = {
			zh = 3.9,
			ja = 5.1
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
				arg_80_0:Play322072019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_83_0 = 0
			local var_83_1 = 0.475

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_2 = arg_80_1:GetWordFromCfg(322072018)
				local var_83_3 = arg_80_1:FormatText(var_83_2.content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 19 <= 0 and var_83_1 or var_83_1 * (utf8.len(var_83_3) / 19)

				if (19 <= 0 and var_83_1 or var_83_1 * (utf8.len(var_83_3) / 19)) > 0 and var_83_1 < var_83_5 then
					arg_80_1.talkMaxDuration = var_83_5

					if var_83_5 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072018", "story_v_out_322072.awb") ~= 0 then
					local var_83_6 = manager.audio:GetVoiceLength("story_v_out_322072", "322072018", "story_v_out_322072.awb") / 1000

					if var_83_6 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_6 + var_83_0
					end

					if var_83_2.prefab_name ~= "" and arg_80_1.actors_[var_83_2.prefab_name] ~= nil then
						local var_83_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_2.prefab_name].transform, "story_v_out_322072", "322072018", "story_v_out_322072.awb")

						arg_80_1:RecordAudio("322072018", var_83_7)
						arg_80_1:RecordAudio("322072018", var_83_7)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_322072", "322072018", "story_v_out_322072.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_322072", "322072018", "story_v_out_322072.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_8 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_8 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_8

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_8 and arg_80_1.time_ < var_83_0 + var_83_8 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play322072019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 322072019
		arg_84_1.duration_ = 11.2

		local var_84_0 = {
			zh = 6.8,
			ja = 11.2
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
				arg_84_0:Play322072020(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1089ui_story"]) and arg_84_1.var_.characterEffect1089ui_story == nil then
				arg_84_1.var_.characterEffect1089ui_story = arg_84_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1089ui_story"]) then
				if arg_84_1.var_.characterEffect1089ui_story and not isNil(arg_84_1.actors_["1089ui_story"]) then
					arg_84_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_0)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1089ui_story"]) and arg_84_1.var_.characterEffect1089ui_story then
				arg_84_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_87_1 = 0
			local var_87_2 = 0.8

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_84_1.callingController_:SetSelectedState("calling")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:GetWordFromCfg(322072019)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_6 = 32 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_4) / 32)

				if (32 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_4) / 32)) > 0 and var_87_2 < var_87_6 then
					arg_84_1.talkMaxDuration = var_87_6

					if var_87_6 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_6 + var_87_1
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072019", "story_v_out_322072.awb") ~= 0 then
					local var_87_7 = manager.audio:GetVoiceLength("story_v_out_322072", "322072019", "story_v_out_322072.awb") / 1000

					if var_87_7 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_1
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_out_322072", "322072019", "story_v_out_322072.awb")

						arg_84_1:RecordAudio("322072019", var_87_8)
						arg_84_1:RecordAudio("322072019", var_87_8)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_322072", "322072019", "story_v_out_322072.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_322072", "322072019", "story_v_out_322072.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_9 = math.max(var_87_2, arg_84_1.talkMaxDuration)

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_9 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_1) / var_87_9

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_1 + var_87_9 and arg_84_1.time_ < var_87_1 + var_87_9 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play322072020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 322072020
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play322072021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1089ui_story = arg_88_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_91_0 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 then
				arg_88_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_88_1.time_ - 0) / var_91_0)
				arg_88_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1089ui_story"].transform.position).z)
				arg_88_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1089ui_story"].transform.localEulerAngles = arg_88_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 then
				arg_88_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1089ui_story"].transform.position).z)
				arg_88_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1089ui_story"].transform.localEulerAngles = arg_88_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_91_1 = "10103ui_story"

			if arg_88_1.actors_["10103ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10103ui_story"))) then
				local var_91_2 = Object.Instantiate(Asset.Load("Char/" .. "10103ui_story"), arg_88_1.stage_.transform)

				var_91_2.name = var_91_1
				var_91_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.actors_[var_91_1] = var_91_2

				local var_91_3 = var_91_2:GetComponentInChildren(typeof(CharacterEffect))

				var_91_3.enabled = true

				local var_91_4 = GameObjectTools.GetOrAddComponent(var_91_2, typeof(DynamicBoneHelper))

				if var_91_4 then
					var_91_4:EnableDynamicBone(false)
				end

				arg_88_1:ShowWeapon(var_91_3.transform, false)

				arg_88_1.var_[var_91_1 .. "Animator"] = var_91_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_88_1.var_[var_91_1 .. "Animator"].applyRootMotion = true
				arg_88_1.var_[var_91_1 .. "LipSync"] = var_91_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_91_5 = arg_88_1.actors_["10103ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos10103ui_story = var_91_5.localPosition

				local var_91_6 = GameObjectTools.GetOrAddComponent(var_91_5.gameObject, typeof(DynamicBoneHelper))

				if var_91_6 then
					var_91_6:EnableDynamicBone(false)
				end
			end

			local var_91_7 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_7 then
				var_91_5.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_88_1.time_ - 0) / var_91_7)
				var_91_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_5.position).x, (manager.ui.mainCamera.transform.position - var_91_5.position).y, (manager.ui.mainCamera.transform.position - var_91_5.position).z)
				var_91_5.localEulerAngles.z = 0
				var_91_5.localEulerAngles.x = 0
				var_91_5.localEulerAngles = var_91_5.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_7 and arg_88_1.time_ < 0 + var_91_7 + arg_91_0 then
				var_91_5.localPosition = Vector3.New(0, 100, 0)
				var_91_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_5.position).x, (manager.ui.mainCamera.transform.position - var_91_5.position).y, (manager.ui.mainCamera.transform.position - var_91_5.position).z)
				var_91_5.localEulerAngles.z = 0
				var_91_5.localEulerAngles.x = 0
				var_91_5.localEulerAngles = var_91_5.localEulerAngles

				local var_91_8 = GameObjectTools.GetOrAddComponent(var_91_5.gameObject, typeof(DynamicBoneHelper))

				if var_91_8 then
					var_91_8:EnableDynamicBone(true)
				end
			end

			if 0.1 < arg_88_1.time_ and arg_88_1.time_ <= 0.1 + arg_91_0 then
				arg_88_1:AudioAction("play", "effect", "se_story_141", "se_story_141_footstep_upstairs", "")
			end

			local var_91_10 = 0
			local var_91_11 = 1.075

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_12 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(322072020).content)

				arg_88_1.text_.text = var_91_12

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_14 = 43 <= 0 and var_91_11 or var_91_11 * (utf8.len(var_91_12) / 43)

				if (43 <= 0 and var_91_11 or var_91_11 * (utf8.len(var_91_12) / 43)) > 0 and var_91_11 < var_91_14 then
					arg_88_1.talkMaxDuration = var_91_14

					if var_91_14 + var_91_10 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_14 + var_91_10
					end
				end

				arg_88_1.text_.text = var_91_12
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_15 = math.max(var_91_11, arg_88_1.talkMaxDuration)

			if var_91_10 <= arg_88_1.time_ and arg_88_1.time_ < var_91_10 + var_91_15 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_10) / var_91_15

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_10 + var_91_15 and arg_88_1.time_ < var_91_10 + var_91_15 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play322072021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 322072021
		arg_92_1.duration_ = 2.1

		local var_92_0 = {
			zh = 1.8,
			ja = 2.1
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
				arg_92_0:Play322072022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0.225

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_92_1.callingController_:SetSelectedState("calling")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_1 = arg_92_1:GetWordFromCfg(322072021)
				local var_95_2 = arg_92_1:FormatText(var_95_1.content)

				arg_92_1.text_.text = var_95_2

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 9 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 9)

				if (9 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 9)) > 0 and var_95_0 < var_95_4 then
					arg_92_1.talkMaxDuration = var_95_4

					if var_95_4 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_4 + 0
					end
				end

				arg_92_1.text_.text = var_95_2
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072021", "story_v_out_322072.awb") ~= 0 then
					local var_95_5 = manager.audio:GetVoiceLength("story_v_out_322072", "322072021", "story_v_out_322072.awb") / 1000

					if var_95_5 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + 0
					end

					if var_95_1.prefab_name ~= "" and arg_92_1.actors_[var_95_1.prefab_name] ~= nil then
						local var_95_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_1.prefab_name].transform, "story_v_out_322072", "322072021", "story_v_out_322072.awb")

						arg_92_1:RecordAudio("322072021", var_95_6)
						arg_92_1:RecordAudio("322072021", var_95_6)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_322072", "322072021", "story_v_out_322072.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_322072", "322072021", "story_v_out_322072.awb")
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
	Play322072022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 322072022
		arg_96_1.duration_ = 2

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play322072023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1089ui_story = arg_96_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_99_0 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 then
				arg_96_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_96_1.time_ - 0) / var_99_0)
				arg_96_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1089ui_story"].transform.position).z)
				arg_96_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1089ui_story"].transform.localEulerAngles = arg_96_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 then
				arg_96_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.17)
				arg_96_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1089ui_story"].transform.position).z)
				arg_96_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1089ui_story"].transform.localEulerAngles = arg_96_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_99_1 = arg_96_1.actors_["1089ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1089ui_story == nil then
				arg_96_1.var_.characterEffect1089ui_story = var_99_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_2 and not isNil(var_99_1) then
				if arg_96_1.var_.characterEffect1089ui_story and not isNil(var_99_1) then
					arg_96_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_2 and arg_96_1.time_ < 0 + var_99_2 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1089ui_story then
				arg_96_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_2")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_99_4 = 0
			local var_99_5 = 0.05

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_6 = arg_96_1:GetWordFromCfg(322072022)
				local var_99_7 = arg_96_1:FormatText(var_99_6.content)

				arg_96_1.text_.text = var_99_7

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 2 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 2)

				if (2 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 2)) > 0 and var_99_5 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_4
					end
				end

				arg_96_1.text_.text = var_99_7
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072022", "story_v_out_322072.awb") ~= 0 then
					local var_99_10 = manager.audio:GetVoiceLength("story_v_out_322072", "322072022", "story_v_out_322072.awb") / 1000

					if var_99_10 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_4
					end

					if var_99_6.prefab_name ~= "" and arg_96_1.actors_[var_99_6.prefab_name] ~= nil then
						local var_99_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_6.prefab_name].transform, "story_v_out_322072", "322072022", "story_v_out_322072.awb")

						arg_96_1:RecordAudio("322072022", var_99_11)
						arg_96_1:RecordAudio("322072022", var_99_11)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_322072", "322072022", "story_v_out_322072.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_322072", "322072022", "story_v_out_322072.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_12 = math.max(var_99_5, arg_96_1.talkMaxDuration)

			if var_99_4 <= arg_96_1.time_ and arg_96_1.time_ < var_99_4 + var_99_12 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_4) / var_99_12

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_4 + var_99_12 and arg_96_1.time_ < var_99_4 + var_99_12 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
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

		arg_96_1:InitPlayNodeList()
	end,
	Play322072023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 322072023
		arg_100_1.duration_ = 7.97

		local var_100_0 = {
			zh = 5.766,
			ja = 7.966
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play322072024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1089ui_story"]) and arg_100_1.var_.characterEffect1089ui_story == nil then
				arg_100_1.var_.characterEffect1089ui_story = arg_100_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1089ui_story"]) then
				if arg_100_1.var_.characterEffect1089ui_story and not isNil(arg_100_1.actors_["1089ui_story"]) then
					arg_100_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1089ui_story"]) and arg_100_1.var_.characterEffect1089ui_story then
				arg_100_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_103_1 = 0
			local var_103_2 = 0.575

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_100_1.callingController_:SetSelectedState("calling")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:GetWordFromCfg(322072023)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_6 = 23 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_4) / 23)

				if (23 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_4) / 23)) > 0 and var_103_2 < var_103_6 then
					arg_100_1.talkMaxDuration = var_103_6

					if var_103_6 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_6 + var_103_1
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072023", "story_v_out_322072.awb") ~= 0 then
					local var_103_7 = manager.audio:GetVoiceLength("story_v_out_322072", "322072023", "story_v_out_322072.awb") / 1000

					if var_103_7 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_1
					end

					if var_103_3.prefab_name ~= "" and arg_100_1.actors_[var_103_3.prefab_name] ~= nil then
						local var_103_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_3.prefab_name].transform, "story_v_out_322072", "322072023", "story_v_out_322072.awb")

						arg_100_1:RecordAudio("322072023", var_103_8)
						arg_100_1:RecordAudio("322072023", var_103_8)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_322072", "322072023", "story_v_out_322072.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_322072", "322072023", "story_v_out_322072.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_9 = math.max(var_103_2, arg_100_1.talkMaxDuration)

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_9 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_1) / var_103_9

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_1 + var_103_9 and arg_100_1.time_ < var_103_1 + var_103_9 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play322072024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 322072024
		arg_104_1.duration_ = 3.5

		local var_104_0 = {
			zh = 1.999999999999,
			ja = 3.5
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play322072025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1089ui_story = arg_104_1.actors_["1089ui_story"].transform.localPosition

				arg_104_1:ShowWeapon(arg_104_1.var_["1089ui_story" .. "Animator"].transform, false)
			end

			local var_107_0 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 then
				arg_104_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_104_1.time_ - 0) / var_107_0)
				arg_104_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1089ui_story"].transform.position).z)
				arg_104_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1089ui_story"].transform.localEulerAngles = arg_104_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 then
				arg_104_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.17)
				arg_104_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1089ui_story"].transform.position).z)
				arg_104_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1089ui_story"].transform.localEulerAngles = arg_104_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_107_1 = arg_104_1.actors_["1089ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_1) and arg_104_1.var_.characterEffect1089ui_story == nil then
				arg_104_1.var_.characterEffect1089ui_story = var_107_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_2 and not isNil(var_107_1) then
				if arg_104_1.var_.characterEffect1089ui_story and not isNil(var_107_1) then
					arg_104_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_2 and arg_104_1.time_ < 0 + var_107_2 + arg_107_0 and not isNil(var_107_1) and arg_104_1.var_.characterEffect1089ui_story then
				arg_104_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_107_4 = 0
			local var_107_5 = 0.125

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_6 = arg_104_1:GetWordFromCfg(322072024)
				local var_107_7 = arg_104_1:FormatText(var_107_6.content)

				arg_104_1.text_.text = var_107_7

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_9 = 5 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 5)

				if (5 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 5)) > 0 and var_107_5 < var_107_9 then
					arg_104_1.talkMaxDuration = var_107_9

					if var_107_9 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_9 + var_107_4
					end
				end

				arg_104_1.text_.text = var_107_7
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072024", "story_v_out_322072.awb") ~= 0 then
					local var_107_10 = manager.audio:GetVoiceLength("story_v_out_322072", "322072024", "story_v_out_322072.awb") / 1000

					if var_107_10 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_4
					end

					if var_107_6.prefab_name ~= "" and arg_104_1.actors_[var_107_6.prefab_name] ~= nil then
						local var_107_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_6.prefab_name].transform, "story_v_out_322072", "322072024", "story_v_out_322072.awb")

						arg_104_1:RecordAudio("322072024", var_107_11)
						arg_104_1:RecordAudio("322072024", var_107_11)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_322072", "322072024", "story_v_out_322072.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_322072", "322072024", "story_v_out_322072.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_12 = math.max(var_107_5, arg_104_1.talkMaxDuration)

			if var_107_4 <= arg_104_1.time_ and arg_104_1.time_ < var_107_4 + var_107_12 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_4) / var_107_12

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_4 + var_107_12 and arg_104_1.time_ < var_107_4 + var_107_12 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
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

		arg_104_1:InitPlayNodeList()
	end,
	Play322072025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 322072025
		arg_108_1.duration_ = 4.8

		local var_108_0 = {
			zh = 2.866,
			ja = 4.8
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play322072026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1089ui_story"]) and arg_108_1.var_.characterEffect1089ui_story == nil then
				arg_108_1.var_.characterEffect1089ui_story = arg_108_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1089ui_story"]) then
				if arg_108_1.var_.characterEffect1089ui_story and not isNil(arg_108_1.actors_["1089ui_story"]) then
					arg_108_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_0)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1089ui_story"]) and arg_108_1.var_.characterEffect1089ui_story then
				arg_108_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_111_1 = 0
			local var_111_2 = 0.25

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_108_1.callingController_:SetSelectedState("calling")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:GetWordFromCfg(322072025)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_6 = 10 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_4) / 10)

				if (10 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_4) / 10)) > 0 and var_111_2 < var_111_6 then
					arg_108_1.talkMaxDuration = var_111_6

					if var_111_6 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_6 + var_111_1
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072025", "story_v_out_322072.awb") ~= 0 then
					local var_111_7 = manager.audio:GetVoiceLength("story_v_out_322072", "322072025", "story_v_out_322072.awb") / 1000

					if var_111_7 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_1
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_out_322072", "322072025", "story_v_out_322072.awb")

						arg_108_1:RecordAudio("322072025", var_111_8)
						arg_108_1:RecordAudio("322072025", var_111_8)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_322072", "322072025", "story_v_out_322072.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_322072", "322072025", "story_v_out_322072.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_9 = math.max(var_111_2, arg_108_1.talkMaxDuration)

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_9 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_1) / var_111_9

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_1 + var_111_9 and arg_108_1.time_ < var_111_1 + var_111_9 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play322072026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 322072026
		arg_112_1.duration_ = 5.3

		local var_112_0 = {
			zh = 4.033,
			ja = 5.3
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play322072027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1089ui_story"]) and arg_112_1.var_.characterEffect1089ui_story == nil then
				arg_112_1.var_.characterEffect1089ui_story = arg_112_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1089ui_story"]) then
				if arg_112_1.var_.characterEffect1089ui_story and not isNil(arg_112_1.actors_["1089ui_story"]) then
					arg_112_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1089ui_story"]) and arg_112_1.var_.characterEffect1089ui_story then
				arg_112_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_2")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_115_2 = 0
			local var_115_3 = 0.475

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_4 = arg_112_1:GetWordFromCfg(322072026)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 19 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 19)

				if (19 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 19)) > 0 and var_115_3 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_2
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072026", "story_v_out_322072.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_322072", "322072026", "story_v_out_322072.awb") / 1000

					if var_115_8 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_2
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_out_322072", "322072026", "story_v_out_322072.awb")

						arg_112_1:RecordAudio("322072026", var_115_9)
						arg_112_1:RecordAudio("322072026", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_322072", "322072026", "story_v_out_322072.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_322072", "322072026", "story_v_out_322072.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_3, arg_112_1.talkMaxDuration)

			if var_115_2 <= arg_112_1.time_ and arg_112_1.time_ < var_115_2 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_2) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_2 + var_115_10 and arg_112_1.time_ < var_115_2 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play322072027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 322072027
		arg_116_1.duration_ = 6.13

		local var_116_0 = {
			zh = 3.366,
			ja = 6.133
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play322072028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_119_0 = 0
			local var_119_1 = 0.3

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_2 = arg_116_1:GetWordFromCfg(322072027)
				local var_119_3 = arg_116_1:FormatText(var_119_2.content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 12 <= 0 and var_119_1 or var_119_1 * (utf8.len(var_119_3) / 12)

				if (12 <= 0 and var_119_1 or var_119_1 * (utf8.len(var_119_3) / 12)) > 0 and var_119_1 < var_119_5 then
					arg_116_1.talkMaxDuration = var_119_5

					if var_119_5 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072027", "story_v_out_322072.awb") ~= 0 then
					local var_119_6 = manager.audio:GetVoiceLength("story_v_out_322072", "322072027", "story_v_out_322072.awb") / 1000

					if var_119_6 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_6 + var_119_0
					end

					if var_119_2.prefab_name ~= "" and arg_116_1.actors_[var_119_2.prefab_name] ~= nil then
						local var_119_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_2.prefab_name].transform, "story_v_out_322072", "322072027", "story_v_out_322072.awb")

						arg_116_1:RecordAudio("322072027", var_119_7)
						arg_116_1:RecordAudio("322072027", var_119_7)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_322072", "322072027", "story_v_out_322072.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_322072", "322072027", "story_v_out_322072.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_8 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_8 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_8

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_8 and arg_116_1.time_ < var_119_0 + var_119_8 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play322072028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 322072028
		arg_120_1.duration_ = 1.9

		local var_120_0 = {
			zh = 1.033,
			ja = 1.9
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play322072029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1089ui_story"]) and arg_120_1.var_.characterEffect1089ui_story == nil then
				arg_120_1.var_.characterEffect1089ui_story = arg_120_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1089ui_story"]) then
				if arg_120_1.var_.characterEffect1089ui_story and not isNil(arg_120_1.actors_["1089ui_story"]) then
					arg_120_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_0)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1089ui_story"]) and arg_120_1.var_.characterEffect1089ui_story then
				arg_120_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_123_1 = 0
			local var_123_2 = 0.075

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_120_1.callingController_:SetSelectedState("calling")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:GetWordFromCfg(322072028)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_6 = 3 <= 0 and var_123_2 or var_123_2 * (utf8.len(var_123_4) / 3)

				if (3 <= 0 and var_123_2 or var_123_2 * (utf8.len(var_123_4) / 3)) > 0 and var_123_2 < var_123_6 then
					arg_120_1.talkMaxDuration = var_123_6

					if var_123_6 + var_123_1 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_6 + var_123_1
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072028", "story_v_out_322072.awb") ~= 0 then
					local var_123_7 = manager.audio:GetVoiceLength("story_v_out_322072", "322072028", "story_v_out_322072.awb") / 1000

					if var_123_7 + var_123_1 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_1
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_322072", "322072028", "story_v_out_322072.awb")

						arg_120_1:RecordAudio("322072028", var_123_8)
						arg_120_1:RecordAudio("322072028", var_123_8)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_322072", "322072028", "story_v_out_322072.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_322072", "322072028", "story_v_out_322072.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_9 = math.max(var_123_2, arg_120_1.talkMaxDuration)

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_9 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_1) / var_123_9

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_1 + var_123_9 and arg_120_1.time_ < var_123_1 + var_123_9 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play322072029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 322072029
		arg_124_1.duration_ = 11.23

		local var_124_0 = {
			zh = 6.8,
			ja = 11.233
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play322072030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1089ui_story"]) and arg_124_1.var_.characterEffect1089ui_story == nil then
				arg_124_1.var_.characterEffect1089ui_story = arg_124_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1089ui_story"]) then
				if arg_124_1.var_.characterEffect1089ui_story and not isNil(arg_124_1.actors_["1089ui_story"]) then
					arg_124_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1089ui_story"]) and arg_124_1.var_.characterEffect1089ui_story then
				arg_124_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			local var_127_2 = 0
			local var_127_3 = 0.825

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_2 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_4 = arg_124_1:GetWordFromCfg(322072029)
				local var_127_5 = arg_124_1:FormatText(var_127_4.content)

				arg_124_1.text_.text = var_127_5

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_7 = 33 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_5) / 33)

				if (33 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_5) / 33)) > 0 and var_127_3 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_2
					end
				end

				arg_124_1.text_.text = var_127_5
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072029", "story_v_out_322072.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_322072", "322072029", "story_v_out_322072.awb") / 1000

					if var_127_8 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_2
					end

					if var_127_4.prefab_name ~= "" and arg_124_1.actors_[var_127_4.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_4.prefab_name].transform, "story_v_out_322072", "322072029", "story_v_out_322072.awb")

						arg_124_1:RecordAudio("322072029", var_127_9)
						arg_124_1:RecordAudio("322072029", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_322072", "322072029", "story_v_out_322072.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_322072", "322072029", "story_v_out_322072.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_3, arg_124_1.talkMaxDuration)

			if var_127_2 <= arg_124_1.time_ and arg_124_1.time_ < var_127_2 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_2) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_2 + var_127_10 and arg_124_1.time_ < var_127_2 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play322072030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 322072030
		arg_128_1.duration_ = 8.3

		local var_128_0 = {
			zh = 8.3,
			ja = 7.833
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play322072031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089actionlink/1089action437")
			end

			local var_131_0 = 0
			local var_131_1 = 1.05

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_2 = arg_128_1:GetWordFromCfg(322072030)
				local var_131_3 = arg_128_1:FormatText(var_131_2.content)

				arg_128_1.text_.text = var_131_3

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 42 <= 0 and var_131_1 or var_131_1 * (utf8.len(var_131_3) / 42)

				if (42 <= 0 and var_131_1 or var_131_1 * (utf8.len(var_131_3) / 42)) > 0 and var_131_1 < var_131_5 then
					arg_128_1.talkMaxDuration = var_131_5

					if var_131_5 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + var_131_0
					end
				end

				arg_128_1.text_.text = var_131_3
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072030", "story_v_out_322072.awb") ~= 0 then
					local var_131_6 = manager.audio:GetVoiceLength("story_v_out_322072", "322072030", "story_v_out_322072.awb") / 1000

					if var_131_6 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_6 + var_131_0
					end

					if var_131_2.prefab_name ~= "" and arg_128_1.actors_[var_131_2.prefab_name] ~= nil then
						local var_131_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_2.prefab_name].transform, "story_v_out_322072", "322072030", "story_v_out_322072.awb")

						arg_128_1:RecordAudio("322072030", var_131_7)
						arg_128_1:RecordAudio("322072030", var_131_7)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_322072", "322072030", "story_v_out_322072.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_322072", "322072030", "story_v_out_322072.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_8 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_8 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_8

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_8 and arg_128_1.time_ < var_131_0 + var_131_8 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play322072031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 322072031
		arg_132_1.duration_ = 4.07

		local var_132_0 = {
			zh = 4.066,
			ja = 3.1
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play322072032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1089ui_story"]) and arg_132_1.var_.characterEffect1089ui_story == nil then
				arg_132_1.var_.characterEffect1089ui_story = arg_132_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1089ui_story"]) then
				if arg_132_1.var_.characterEffect1089ui_story and not isNil(arg_132_1.actors_["1089ui_story"]) then
					arg_132_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_0)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1089ui_story"]) and arg_132_1.var_.characterEffect1089ui_story then
				arg_132_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_135_1 = 0
			local var_135_2 = 0.45

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_132_1.callingController_:SetSelectedState("calling")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_3 = arg_132_1:GetWordFromCfg(322072031)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_6 = 18 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_4) / 18)

				if (18 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_4) / 18)) > 0 and var_135_2 < var_135_6 then
					arg_132_1.talkMaxDuration = var_135_6

					if var_135_6 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_6 + var_135_1
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072031", "story_v_out_322072.awb") ~= 0 then
					local var_135_7 = manager.audio:GetVoiceLength("story_v_out_322072", "322072031", "story_v_out_322072.awb") / 1000

					if var_135_7 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_1
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_322072", "322072031", "story_v_out_322072.awb")

						arg_132_1:RecordAudio("322072031", var_135_8)
						arg_132_1:RecordAudio("322072031", var_135_8)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_322072", "322072031", "story_v_out_322072.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_322072", "322072031", "story_v_out_322072.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_9 = math.max(var_135_2, arg_132_1.talkMaxDuration)

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_9 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_1) / var_135_9

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_1 + var_135_9 and arg_132_1.time_ < var_135_1 + var_135_9 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play322072032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 322072032
		arg_136_1.duration_ = 11.4

		local var_136_0 = {
			zh = 8.866,
			ja = 11.4
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play322072033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1089ui_story = arg_136_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_139_0 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 then
				arg_136_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_136_1.time_ - 0) / var_139_0)
				arg_136_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1089ui_story"].transform.position).z)
				arg_136_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1089ui_story"].transform.localEulerAngles = arg_136_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 then
				arg_136_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.17)
				arg_136_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1089ui_story"].transform.position).z)
				arg_136_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1089ui_story"].transform.localEulerAngles = arg_136_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_139_1 = arg_136_1.actors_["1089ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect1089ui_story == nil then
				arg_136_1.var_.characterEffect1089ui_story = var_139_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_2 and not isNil(var_139_1) then
				if arg_136_1.var_.characterEffect1089ui_story and not isNil(var_139_1) then
					arg_136_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_2 and arg_136_1.time_ < 0 + var_139_2 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect1089ui_story then
				arg_136_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089actionlink/1089action474")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_139_4 = 0

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.allBtn_.enabled = false
			end

			if arg_136_1.time_ >= var_139_4 + 2 and arg_136_1.time_ < var_139_4 + 2 + arg_139_0 then
				arg_136_1.allBtn_.enabled = true
			end

			local var_139_5 = 0
			local var_139_6 = 0.95

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_7 = arg_136_1:GetWordFromCfg(322072032)
				local var_139_8 = arg_136_1:FormatText(var_139_7.content)

				arg_136_1.text_.text = var_139_8

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_10 = 38 <= 0 and var_139_6 or var_139_6 * (utf8.len(var_139_8) / 38)

				if (38 <= 0 and var_139_6 or var_139_6 * (utf8.len(var_139_8) / 38)) > 0 and var_139_6 < var_139_10 then
					arg_136_1.talkMaxDuration = var_139_10

					if var_139_10 + var_139_5 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_5
					end
				end

				arg_136_1.text_.text = var_139_8
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072032", "story_v_out_322072.awb") ~= 0 then
					local var_139_11 = manager.audio:GetVoiceLength("story_v_out_322072", "322072032", "story_v_out_322072.awb") / 1000

					if var_139_11 + var_139_5 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_11 + var_139_5
					end

					if var_139_7.prefab_name ~= "" and arg_136_1.actors_[var_139_7.prefab_name] ~= nil then
						local var_139_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_7.prefab_name].transform, "story_v_out_322072", "322072032", "story_v_out_322072.awb")

						arg_136_1:RecordAudio("322072032", var_139_12)
						arg_136_1:RecordAudio("322072032", var_139_12)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_322072", "322072032", "story_v_out_322072.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_322072", "322072032", "story_v_out_322072.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_13 = math.max(var_139_6, arg_136_1.talkMaxDuration)

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_13 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_5) / var_139_13

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_5 + var_139_13 and arg_136_1.time_ < var_139_5 + var_139_13 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
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

		arg_136_1:InitPlayNodeList()
	end,
	Play322072033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 322072033
		arg_140_1.duration_ = 4.73

		local var_140_0 = {
			zh = 4.2,
			ja = 4.733
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play322072034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action4_2")
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_143_0 = 0

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.allBtn_.enabled = false
			end

			if arg_140_1.time_ >= var_143_0 + 2 and arg_140_1.time_ < var_143_0 + 2 + arg_143_0 then
				arg_140_1.allBtn_.enabled = true
			end

			local var_143_1 = 0
			local var_143_2 = 0.5

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_3 = arg_140_1:GetWordFromCfg(322072033)
				local var_143_4 = arg_140_1:FormatText(var_143_3.content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_6 = 20 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_4) / 20)

				if (20 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_4) / 20)) > 0 and var_143_2 < var_143_6 then
					arg_140_1.talkMaxDuration = var_143_6

					if var_143_6 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_6 + var_143_1
					end
				end

				arg_140_1.text_.text = var_143_4
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072033", "story_v_out_322072.awb") ~= 0 then
					local var_143_7 = manager.audio:GetVoiceLength("story_v_out_322072", "322072033", "story_v_out_322072.awb") / 1000

					if var_143_7 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_1
					end

					if var_143_3.prefab_name ~= "" and arg_140_1.actors_[var_143_3.prefab_name] ~= nil then
						local var_143_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_3.prefab_name].transform, "story_v_out_322072", "322072033", "story_v_out_322072.awb")

						arg_140_1:RecordAudio("322072033", var_143_8)
						arg_140_1:RecordAudio("322072033", var_143_8)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_322072", "322072033", "story_v_out_322072.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_322072", "322072033", "story_v_out_322072.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_9 = math.max(var_143_2, arg_140_1.talkMaxDuration)

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_9 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_1) / var_143_9

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_1 + var_143_9 and arg_140_1.time_ < var_143_1 + var_143_9 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play322072034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 322072034
		arg_144_1.duration_ = 9.43

		local var_144_0 = {
			zh = 4.266,
			ja = 9.433
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play322072035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1089ui_story"]) and arg_144_1.var_.characterEffect1089ui_story == nil then
				arg_144_1.var_.characterEffect1089ui_story = arg_144_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1089ui_story"]) then
				if arg_144_1.var_.characterEffect1089ui_story and not isNil(arg_144_1.actors_["1089ui_story"]) then
					arg_144_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_0)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1089ui_story"]) and arg_144_1.var_.characterEffect1089ui_story then
				arg_144_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_147_1 = 0
			local var_147_2 = 0.425

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_144_1.callingController_:SetSelectedState("calling")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:GetWordFromCfg(322072034)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_6 = 17 <= 0 and var_147_2 or var_147_2 * (utf8.len(var_147_4) / 17)

				if (17 <= 0 and var_147_2 or var_147_2 * (utf8.len(var_147_4) / 17)) > 0 and var_147_2 < var_147_6 then
					arg_144_1.talkMaxDuration = var_147_6

					if var_147_6 + var_147_1 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_6 + var_147_1
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072034", "story_v_out_322072.awb") ~= 0 then
					local var_147_7 = manager.audio:GetVoiceLength("story_v_out_322072", "322072034", "story_v_out_322072.awb") / 1000

					if var_147_7 + var_147_1 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_1
					end

					if var_147_3.prefab_name ~= "" and arg_144_1.actors_[var_147_3.prefab_name] ~= nil then
						local var_147_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_3.prefab_name].transform, "story_v_out_322072", "322072034", "story_v_out_322072.awb")

						arg_144_1:RecordAudio("322072034", var_147_8)
						arg_144_1:RecordAudio("322072034", var_147_8)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_322072", "322072034", "story_v_out_322072.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_322072", "322072034", "story_v_out_322072.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_9 = math.max(var_147_2, arg_144_1.talkMaxDuration)

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_9 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_1) / var_147_9

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_1 + var_147_9 and arg_144_1.time_ < var_147_1 + var_147_9 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play322072035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 322072035
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play322072036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1089ui_story = arg_148_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_151_0 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 then
				arg_148_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_0)
				arg_148_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1089ui_story"].transform.position).z)
				arg_148_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1089ui_story"].transform.localEulerAngles = arg_148_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 then
				arg_148_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1089ui_story"].transform.position).z)
				arg_148_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1089ui_story"].transform.localEulerAngles = arg_148_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if 0.4 < arg_148_1.time_ and arg_148_1.time_ <= 0.4 + arg_151_0 then
				arg_148_1:AudioAction("play", "effect", "se_story_144", "se_story_144_door_open", "")
			end

			if 1 < arg_148_1.time_ and arg_148_1.time_ <= 1 + arg_151_0 then
				arg_148_1:AudioAction("play", "effect", "se_story_144", "se_story_144_foley_gun02", "")
			end

			local var_151_3 = 0
			local var_151_4 = 1.4

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_3 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_5 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(322072035).content)

				arg_148_1.text_.text = var_151_5

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_7 = 56 <= 0 and var_151_4 or var_151_4 * (utf8.len(var_151_5) / 56)

				if (56 <= 0 and var_151_4 or var_151_4 * (utf8.len(var_151_5) / 56)) > 0 and var_151_4 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_3 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_3
					end
				end

				arg_148_1.text_.text = var_151_5
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_8 = math.max(var_151_4, arg_148_1.talkMaxDuration)

			if var_151_3 <= arg_148_1.time_ and arg_148_1.time_ < var_151_3 + var_151_8 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_3) / var_151_8

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_3 + var_151_8 and arg_148_1.time_ < var_151_3 + var_151_8 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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

		arg_148_1:InitPlayNodeList()
	end,
	Play322072036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 322072036
		arg_152_1.duration_ = 4.03

		local var_152_0 = {
			zh = 2.7,
			ja = 4.033
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play322072037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos10103ui_story = arg_152_1.actors_["10103ui_story"].transform.localPosition

				local var_155_0 = GameObjectTools.GetOrAddComponent(arg_152_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_155_0 then
					var_155_0:EnableDynamicBone(false)
				end
			end

			local var_155_1 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_1 then
				arg_152_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10103ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_152_1.time_ - 0) / var_155_1)
				arg_152_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["10103ui_story"].transform.position).z)
				arg_152_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["10103ui_story"].transform.localEulerAngles = arg_152_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_1 and arg_152_1.time_ < 0 + var_155_1 + arg_155_0 then
				arg_152_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_152_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["10103ui_story"].transform.position).z)
				arg_152_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["10103ui_story"].transform.localEulerAngles = arg_152_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_155_2 = GameObjectTools.GetOrAddComponent(arg_152_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_155_2 then
					var_155_2:EnableDynamicBone(true)
				end
			end

			local var_155_3 = arg_152_1.actors_["10103ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_3) and arg_152_1.var_.characterEffect10103ui_story == nil then
				arg_152_1.var_.characterEffect10103ui_story = var_155_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_4 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_4 and not isNil(var_155_3) then
				if arg_152_1.var_.characterEffect10103ui_story and not isNil(var_155_3) then
					arg_152_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_4 and arg_152_1.time_ < 0 + var_155_4 + arg_155_0 and not isNil(var_155_3) and arg_152_1.var_.characterEffect10103ui_story then
				arg_152_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				if not isNil(arg_152_1.actors_["10103ui_story"]) then
					local var_155_6 = GameObjectTools.GetOrAddComponent(arg_152_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_155_6 then
						var_155_6:EnableDynamicBone(true)
					end
				end
			end

			local var_155_7 = 0
			local var_155_8 = 0.075

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_7 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_9 = arg_152_1:GetWordFromCfg(322072036)
				local var_155_10 = arg_152_1:FormatText(var_155_9.content)

				arg_152_1.text_.text = var_155_10

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_12 = 3 <= 0 and var_155_8 or var_155_8 * (utf8.len(var_155_10) / 3)

				if (3 <= 0 and var_155_8 or var_155_8 * (utf8.len(var_155_10) / 3)) > 0 and var_155_8 < var_155_12 then
					arg_152_1.talkMaxDuration = var_155_12

					if var_155_12 + var_155_7 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_12 + var_155_7
					end
				end

				arg_152_1.text_.text = var_155_10
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072036", "story_v_out_322072.awb") ~= 0 then
					local var_155_13 = manager.audio:GetVoiceLength("story_v_out_322072", "322072036", "story_v_out_322072.awb") / 1000

					if var_155_13 + var_155_7 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_13 + var_155_7
					end

					if var_155_9.prefab_name ~= "" and arg_152_1.actors_[var_155_9.prefab_name] ~= nil then
						local var_155_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_9.prefab_name].transform, "story_v_out_322072", "322072036", "story_v_out_322072.awb")

						arg_152_1:RecordAudio("322072036", var_155_14)
						arg_152_1:RecordAudio("322072036", var_155_14)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_322072", "322072036", "story_v_out_322072.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_322072", "322072036", "story_v_out_322072.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_15 = math.max(var_155_8, arg_152_1.talkMaxDuration)

			if var_155_7 <= arg_152_1.time_ and arg_152_1.time_ < var_155_7 + var_155_15 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_7) / var_155_15

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_7 + var_155_15 and arg_152_1.time_ < var_155_7 + var_155_15 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play322072037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 322072037
		arg_156_1.duration_ = 8.4

		local var_156_0 = {
			zh = 6.233,
			ja = 8.4
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play322072038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1089ui_story = arg_156_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_159_0 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 then
				arg_156_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1089ui_story, Vector3.New(0.7, -1.1, -6.17), (arg_156_1.time_ - 0) / var_159_0)
				arg_156_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1089ui_story"].transform.position).z)
				arg_156_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1089ui_story"].transform.localEulerAngles = arg_156_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 then
				arg_156_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0.7, -1.1, -6.17)
				arg_156_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1089ui_story"].transform.position).z)
				arg_156_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1089ui_story"].transform.localEulerAngles = arg_156_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_159_1 = arg_156_1.actors_["1089ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1089ui_story == nil then
				arg_156_1.var_.characterEffect1089ui_story = var_159_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_2 and not isNil(var_159_1) then
				if arg_156_1.var_.characterEffect1089ui_story and not isNil(var_159_1) then
					arg_156_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= 0 + var_159_2 and arg_156_1.time_ < 0 + var_159_2 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1089ui_story then
				arg_156_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_159_4 = arg_156_1.actors_["10103ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.characterEffect10103ui_story == nil then
				arg_156_1.var_.characterEffect10103ui_story = var_159_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_5 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_5 and not isNil(var_159_4) then
				if arg_156_1.var_.characterEffect10103ui_story and not isNil(var_159_4) then
					arg_156_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_156_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_5)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_5 and arg_156_1.time_ < 0 + var_159_5 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.characterEffect10103ui_story then
				arg_156_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_156_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_159_6 = 0
			local var_159_7 = 0.55

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_6 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_8 = arg_156_1:GetWordFromCfg(322072037)
				local var_159_9 = arg_156_1:FormatText(var_159_8.content)

				arg_156_1.text_.text = var_159_9

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_11 = 22 <= 0 and var_159_7 or var_159_7 * (utf8.len(var_159_9) / 22)

				if (22 <= 0 and var_159_7 or var_159_7 * (utf8.len(var_159_9) / 22)) > 0 and var_159_7 < var_159_11 then
					arg_156_1.talkMaxDuration = var_159_11

					if var_159_11 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_11 + var_159_6
					end
				end

				arg_156_1.text_.text = var_159_9
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072037", "story_v_out_322072.awb") ~= 0 then
					local var_159_12 = manager.audio:GetVoiceLength("story_v_out_322072", "322072037", "story_v_out_322072.awb") / 1000

					if var_159_12 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_12 + var_159_6
					end

					if var_159_8.prefab_name ~= "" and arg_156_1.actors_[var_159_8.prefab_name] ~= nil then
						local var_159_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_8.prefab_name].transform, "story_v_out_322072", "322072037", "story_v_out_322072.awb")

						arg_156_1:RecordAudio("322072037", var_159_13)
						arg_156_1:RecordAudio("322072037", var_159_13)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_322072", "322072037", "story_v_out_322072.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_322072", "322072037", "story_v_out_322072.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_14 = math.max(var_159_7, arg_156_1.talkMaxDuration)

			if var_159_6 <= arg_156_1.time_ and arg_156_1.time_ < var_159_6 + var_159_14 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_6) / var_159_14

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_6 + var_159_14 and arg_156_1.time_ < var_159_6 + var_159_14 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
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

		arg_156_1:InitPlayNodeList()
	end,
	Play322072038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 322072038
		arg_160_1.duration_ = 13.9

		local var_160_0 = {
			zh = 8.8,
			ja = 13.9
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play322072039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos10103ui_story = arg_160_1.actors_["10103ui_story"].transform.localPosition

				local var_163_0 = GameObjectTools.GetOrAddComponent(arg_160_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_163_0 then
					var_163_0:EnableDynamicBone(false)
				end
			end

			local var_163_1 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_1 then
				arg_160_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10103ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_160_1.time_ - 0) / var_163_1)
				arg_160_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["10103ui_story"].transform.position).z)
				arg_160_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["10103ui_story"].transform.localEulerAngles = arg_160_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_1 and arg_160_1.time_ < 0 + var_163_1 + arg_163_0 then
				arg_160_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_160_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["10103ui_story"].transform.position).z)
				arg_160_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["10103ui_story"].transform.localEulerAngles = arg_160_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_163_2 = GameObjectTools.GetOrAddComponent(arg_160_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_163_2 then
					var_163_2:EnableDynamicBone(true)
				end
			end

			local var_163_3 = arg_160_1.actors_["10103ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_3) and arg_160_1.var_.characterEffect10103ui_story == nil then
				arg_160_1.var_.characterEffect10103ui_story = var_163_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_4 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_4 and not isNil(var_163_3) then
				if arg_160_1.var_.characterEffect10103ui_story and not isNil(var_163_3) then
					arg_160_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_4 and arg_160_1.time_ < 0 + var_163_4 + arg_163_0 and not isNil(var_163_3) and arg_160_1.var_.characterEffect10103ui_story then
				arg_160_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_163_6 = arg_160_1.actors_["1089ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_6) and arg_160_1.var_.characterEffect1089ui_story == nil then
				arg_160_1.var_.characterEffect1089ui_story = var_163_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_7 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_7 and not isNil(var_163_6) then
				if arg_160_1.var_.characterEffect1089ui_story and not isNil(var_163_6) then
					arg_160_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 0) / var_163_7)
				end
			end

			if arg_160_1.time_ >= 0 + var_163_7 and arg_160_1.time_ < 0 + var_163_7 + arg_163_0 and not isNil(var_163_6) and arg_160_1.var_.characterEffect1089ui_story then
				arg_160_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action4_1")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				if not isNil(arg_160_1.actors_["10103ui_story"]) then
					local var_163_8 = GameObjectTools.GetOrAddComponent(arg_160_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_163_8 then
						var_163_8:EnableDynamicBone(true)
					end
				end
			end

			local var_163_9 = 0
			local var_163_10 = 1

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_9 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_11 = arg_160_1:GetWordFromCfg(322072038)
				local var_163_12 = arg_160_1:FormatText(var_163_11.content)

				arg_160_1.text_.text = var_163_12

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_14 = 40 <= 0 and var_163_10 or var_163_10 * (utf8.len(var_163_12) / 40)

				if (40 <= 0 and var_163_10 or var_163_10 * (utf8.len(var_163_12) / 40)) > 0 and var_163_10 < var_163_14 then
					arg_160_1.talkMaxDuration = var_163_14

					if var_163_14 + var_163_9 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_14 + var_163_9
					end
				end

				arg_160_1.text_.text = var_163_12
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072038", "story_v_out_322072.awb") ~= 0 then
					local var_163_15 = manager.audio:GetVoiceLength("story_v_out_322072", "322072038", "story_v_out_322072.awb") / 1000

					if var_163_15 + var_163_9 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_15 + var_163_9
					end

					if var_163_11.prefab_name ~= "" and arg_160_1.actors_[var_163_11.prefab_name] ~= nil then
						local var_163_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_11.prefab_name].transform, "story_v_out_322072", "322072038", "story_v_out_322072.awb")

						arg_160_1:RecordAudio("322072038", var_163_16)
						arg_160_1:RecordAudio("322072038", var_163_16)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_322072", "322072038", "story_v_out_322072.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_322072", "322072038", "story_v_out_322072.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_17 = math.max(var_163_10, arg_160_1.talkMaxDuration)

			if var_163_9 <= arg_160_1.time_ and arg_160_1.time_ < var_163_9 + var_163_17 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_9) / var_163_17

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_9 + var_163_17 and arg_160_1.time_ < var_163_9 + var_163_17 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play322072039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 322072039
		arg_164_1.duration_ = 11.77

		local var_164_0 = {
			zh = 7.2,
			ja = 11.766
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play322072040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if arg_164_1.bgs_.L15f == nil then
				local var_167_0 = Object.Instantiate(arg_164_1.paintGo_)

				var_167_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L15f")
				var_167_0.name = "L15f"
				var_167_0.transform.parent = arg_164_1.stage_.transform
				var_167_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_164_1.bgs_.L15f = var_167_0
			end

			if 2 < arg_164_1.time_ and arg_164_1.time_ <= 2 + arg_167_0 then
				local var_167_1 = arg_164_1.bgs_.L15f

				arg_164_1.bgs_.L15f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_167_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_167_2 = var_167_1:GetComponent("SpriteRenderer")

				if var_167_2 and var_167_2.sprite then
					local var_167_3 = 2 * (var_167_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_167_1.transform.localScale = Vector3.New(var_167_3 / var_167_2.sprite.bounds.size.y < var_167_3 * manager.ui.mainCameraCom_.aspect / var_167_2.sprite.bounds.size.x and var_167_3 * manager.ui.mainCameraCom_.aspect / var_167_2.sprite.bounds.size.x or var_167_3 / var_167_2.sprite.bounds.size.y, var_167_3 / var_167_2.sprite.bounds.size.y < var_167_3 * manager.ui.mainCameraCom_.aspect / var_167_2.sprite.bounds.size.x and var_167_3 * manager.ui.mainCameraCom_.aspect / var_167_2.sprite.bounds.size.x or var_167_3 / var_167_2.sprite.bounds.size.y, 0)
				end

				for iter_167_0, iter_167_1 in pairs(arg_164_1.bgs_) do
					if iter_167_0 ~= "L15f" then
						iter_167_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_167_4 = 4

			if 4 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				arg_164_1.allBtn_.enabled = false
			end

			if arg_164_1.time_ >= var_167_4 + 0.3 and arg_164_1.time_ < var_167_4 + 0.3 + arg_167_0 then
				arg_164_1.allBtn_.enabled = true
			end

			local var_167_5 = 0

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_6 = 2

			if var_167_5 <= arg_164_1.time_ and arg_164_1.time_ < var_167_5 + var_167_6 then
				local var_167_7 = Color.New(0, 0, 0)

				var_167_7.a = Mathf.Lerp(0, 1, (arg_164_1.time_ - var_167_5) / var_167_6)
				arg_164_1.mask_.color = var_167_7
			end

			if arg_164_1.time_ >= var_167_5 + var_167_6 and arg_164_1.time_ < var_167_5 + var_167_6 + arg_167_0 then
				local var_167_8 = Color.New(0, 0, 0)

				var_167_8.a = 1
				arg_164_1.mask_.color = var_167_8
			end

			local var_167_9 = 2

			if 2 < arg_164_1.time_ and arg_164_1.time_ <= var_167_9 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_10 = 2

			if var_167_9 <= arg_164_1.time_ and arg_164_1.time_ < var_167_9 + var_167_10 then
				local var_167_11 = Color.New(0, 0, 0)

				var_167_11.a = Mathf.Lerp(1, 0, (arg_164_1.time_ - var_167_9) / var_167_10)
				arg_164_1.mask_.color = var_167_11
			end

			if arg_164_1.time_ >= var_167_9 + var_167_10 and arg_164_1.time_ < var_167_9 + var_167_10 + arg_167_0 then
				local var_167_12 = Color.New(0, 0, 0)

				arg_164_1.mask_.enabled = false
				var_167_12.a = 0
				arg_164_1.mask_.color = var_167_12
			end

			local var_167_13 = arg_164_1.actors_["10103ui_story"].transform

			if 1.96599999815226 < arg_164_1.time_ and arg_164_1.time_ <= 1.96599999815226 + arg_167_0 then
				arg_164_1.var_.moveOldPos10103ui_story = var_167_13.localPosition

				local var_167_14 = GameObjectTools.GetOrAddComponent(var_167_13.gameObject, typeof(DynamicBoneHelper))

				if var_167_14 then
					var_167_14:EnableDynamicBone(false)
				end
			end

			local var_167_15 = 0.001

			if 1.96599999815226 <= arg_164_1.time_ and arg_164_1.time_ < 1.96599999815226 + var_167_15 then
				var_167_13.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_164_1.time_ - 1.96599999815226) / var_167_15)
				var_167_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_13.position).x, (manager.ui.mainCamera.transform.position - var_167_13.position).y, (manager.ui.mainCamera.transform.position - var_167_13.position).z)
				var_167_13.localEulerAngles.z = 0
				var_167_13.localEulerAngles.x = 0
				var_167_13.localEulerAngles = var_167_13.localEulerAngles
			end

			if arg_164_1.time_ >= 1.96599999815226 + var_167_15 and arg_164_1.time_ < 1.96599999815226 + var_167_15 + arg_167_0 then
				var_167_13.localPosition = Vector3.New(0, 100, 0)
				var_167_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_13.position).x, (manager.ui.mainCamera.transform.position - var_167_13.position).y, (manager.ui.mainCamera.transform.position - var_167_13.position).z)
				var_167_13.localEulerAngles.z = 0
				var_167_13.localEulerAngles.x = 0
				var_167_13.localEulerAngles = var_167_13.localEulerAngles

				local var_167_16 = GameObjectTools.GetOrAddComponent(var_167_13.gameObject, typeof(DynamicBoneHelper))

				if var_167_16 then
					var_167_16:EnableDynamicBone(true)
				end
			end

			local var_167_17 = arg_164_1.actors_["10103ui_story"].transform

			if 3.8 < arg_164_1.time_ and arg_164_1.time_ <= 3.8 + arg_167_0 then
				arg_164_1.var_.moveOldPos10103ui_story = var_167_17.localPosition

				local var_167_18 = GameObjectTools.GetOrAddComponent(var_167_17.gameObject, typeof(DynamicBoneHelper))

				if var_167_18 then
					var_167_18:EnableDynamicBone(false)
				end
			end

			local var_167_19 = 0.001

			if 3.8 <= arg_164_1.time_ and arg_164_1.time_ < 3.8 + var_167_19 then
				var_167_17.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10103ui_story, Vector3.New(0, -0.95, -6.2), (arg_164_1.time_ - 3.8) / var_167_19)
				var_167_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_17.position).x, (manager.ui.mainCamera.transform.position - var_167_17.position).y, (manager.ui.mainCamera.transform.position - var_167_17.position).z)
				var_167_17.localEulerAngles.z = 0
				var_167_17.localEulerAngles.x = 0
				var_167_17.localEulerAngles = var_167_17.localEulerAngles
			end

			if arg_164_1.time_ >= 3.8 + var_167_19 and arg_164_1.time_ < 3.8 + var_167_19 + arg_167_0 then
				var_167_17.localPosition = Vector3.New(0, -0.95, -6.2)
				var_167_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_17.position).x, (manager.ui.mainCamera.transform.position - var_167_17.position).y, (manager.ui.mainCamera.transform.position - var_167_17.position).z)
				var_167_17.localEulerAngles.z = 0
				var_167_17.localEulerAngles.x = 0
				var_167_17.localEulerAngles = var_167_17.localEulerAngles

				local var_167_20 = GameObjectTools.GetOrAddComponent(var_167_17.gameObject, typeof(DynamicBoneHelper))

				if var_167_20 then
					var_167_20:EnableDynamicBone(true)
				end
			end

			local var_167_21 = arg_164_1.actors_["1089ui_story"].transform

			if 1.96599999815226 < arg_164_1.time_ and arg_164_1.time_ <= 1.96599999815226 + arg_167_0 then
				arg_164_1.var_.moveOldPos1089ui_story = var_167_21.localPosition
			end

			local var_167_22 = 0.001

			if 1.96599999815226 <= arg_164_1.time_ and arg_164_1.time_ < 1.96599999815226 + var_167_22 then
				var_167_21.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_164_1.time_ - 1.96599999815226) / var_167_22)
				var_167_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_21.position).x, (manager.ui.mainCamera.transform.position - var_167_21.position).y, (manager.ui.mainCamera.transform.position - var_167_21.position).z)
				var_167_21.localEulerAngles.z = 0
				var_167_21.localEulerAngles.x = 0
				var_167_21.localEulerAngles = var_167_21.localEulerAngles
			end

			if arg_164_1.time_ >= 1.96599999815226 + var_167_22 and arg_164_1.time_ < 1.96599999815226 + var_167_22 + arg_167_0 then
				var_167_21.localPosition = Vector3.New(0, 100, 0)
				var_167_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_21.position).x, (manager.ui.mainCamera.transform.position - var_167_21.position).y, (manager.ui.mainCamera.transform.position - var_167_21.position).z)
				var_167_21.localEulerAngles.z = 0
				var_167_21.localEulerAngles.x = 0
				var_167_21.localEulerAngles = var_167_21.localEulerAngles
			end

			local var_167_23 = arg_164_1.actors_["10103ui_story"]

			if 3.8 < arg_164_1.time_ and arg_164_1.time_ <= 3.8 + arg_167_0 and not isNil(var_167_23) and arg_164_1.var_.characterEffect10103ui_story == nil then
				arg_164_1.var_.characterEffect10103ui_story = var_167_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_24 = 0.2

			if 3.8 <= arg_164_1.time_ and arg_164_1.time_ < 3.8 + var_167_24 and not isNil(var_167_23) then
				if arg_164_1.var_.characterEffect10103ui_story and not isNil(var_167_23) then
					arg_164_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 3.8 + var_167_24 and arg_164_1.time_ < 3.8 + var_167_24 + arg_167_0 and not isNil(var_167_23) and arg_164_1.var_.characterEffect10103ui_story then
				arg_164_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 3.8 < arg_164_1.time_ and arg_164_1.time_ <= 3.8 + arg_167_0 then
				arg_164_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			if 3.8 < arg_164_1.time_ and arg_164_1.time_ <= 3.8 + arg_167_0 then
				arg_164_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0.2 < arg_164_1.time_ and arg_164_1.time_ <= 0.2 + arg_167_0 then
				arg_164_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_street_night02", "")
			end

			if 1.56666666666667 < arg_164_1.time_ and arg_164_1.time_ <= 1.56666666666667 + arg_167_0 then
				arg_164_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			local var_167_28 = 1.96599999815226

			arg_164_1.isInRecall_ = false

			if var_167_28 < arg_164_1.time_ and arg_164_1.time_ <= var_167_28 + arg_167_0 then
				arg_164_1.screenFilterGo_:SetActive(true)

				arg_164_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_167_2, iter_167_3 in pairs(arg_164_1.actors_) do
					for iter_167_4, iter_167_5 in ipairs((iter_167_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_167_5.color = iter_167_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_167_29 = 0.0166666666666667

			if var_167_28 <= arg_164_1.time_ and arg_164_1.time_ < var_167_28 + var_167_29 then
				arg_164_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_164_1.time_ - var_167_28) / var_167_29)
			end

			if arg_164_1.time_ >= var_167_28 + var_167_29 and arg_164_1.time_ < var_167_28 + var_167_29 + arg_167_0 then
				arg_164_1.screenFilterEffect_.weight = 1
			end

			if 3.8 < arg_164_1.time_ and arg_164_1.time_ <= 3.8 + arg_167_0 then
				if not isNil(arg_164_1.actors_["10103ui_story"]) then
					local var_167_30 = GameObjectTools.GetOrAddComponent(arg_164_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_167_30 then
						var_167_30:EnableDynamicBone(true)
					end
				end
			end

			if arg_164_1.frameCnt_ <= 1 then
				arg_164_1.dialog_:SetActive(false)
			end

			local var_167_31 = 4
			local var_167_32 = 0.425

			if 4 < arg_164_1.time_ and arg_164_1.time_ <= var_167_31 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0

				arg_164_1.dialog_:SetActive(true)

				arg_164_1.dialogCg_.alpha = 0

				local var_167_33 = LeanTween.value(arg_164_1.dialog_, 0, 1, 0.3)

				var_167_33:setOnUpdate(LuaHelper.FloatAction(function(arg_168_0)
					arg_164_1.dialogCg_.alpha = arg_168_0
				end))
				var_167_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_164_1.dialog_)
					var_167_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_164_1.duration_ = arg_164_1.duration_ + 0.3

				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_34 = arg_164_1:GetWordFromCfg(322072039)
				local var_167_35 = arg_164_1:FormatText(var_167_34.content)

				arg_164_1.text_.text = var_167_35

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_37 = 17 <= 0 and var_167_32 or var_167_32 * (utf8.len(var_167_35) / 17)

				if (17 <= 0 and var_167_32 or var_167_32 * (utf8.len(var_167_35) / 17)) > 0 and var_167_32 < var_167_37 then
					arg_164_1.talkMaxDuration = var_167_37
					var_167_31 = var_167_31 + 0.3

					if var_167_37 + var_167_31 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_37 + var_167_31
					end
				end

				arg_164_1.text_.text = var_167_35
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072039", "story_v_out_322072.awb") ~= 0 then
					local var_167_38 = manager.audio:GetVoiceLength("story_v_out_322072", "322072039", "story_v_out_322072.awb") / 1000

					if var_167_38 + var_167_31 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_38 + var_167_31
					end

					if var_167_34.prefab_name ~= "" and arg_164_1.actors_[var_167_34.prefab_name] ~= nil then
						local var_167_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_34.prefab_name].transform, "story_v_out_322072", "322072039", "story_v_out_322072.awb")

						arg_164_1:RecordAudio("322072039", var_167_39)
						arg_164_1:RecordAudio("322072039", var_167_39)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_322072", "322072039", "story_v_out_322072.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_322072", "322072039", "story_v_out_322072.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_40 = var_167_31 + 0.3
			local var_167_41 = math.max(var_167_32, arg_164_1.talkMaxDuration)

			if var_167_31 + 0.3 <= arg_164_1.time_ and arg_164_1.time_ < var_167_40 + var_167_41 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_40) / var_167_41

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_40 + var_167_41 and arg_164_1.time_ < var_167_40 + var_167_41 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play322072040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 322072040
		arg_170_1.duration_ = 5.87

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play322072041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_9000

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos10103ui_story = arg_170_1.actors_["10103ui_story"].transform.localPosition

				local var_173_0 = GameObjectTools.GetOrAddComponent(arg_170_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_173_0 then
					var_173_0:EnableDynamicBone(false)
				end
			end

			local var_173_1 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_1 then
				arg_170_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_170_1.time_ - 0) / var_173_1)
				arg_170_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["10103ui_story"].transform.position).z)
				arg_170_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["10103ui_story"].transform.localEulerAngles = arg_170_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_1 and arg_170_1.time_ < 0 + var_173_1 + arg_173_0 then
				arg_170_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_170_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["10103ui_story"].transform.position).z)
				arg_170_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["10103ui_story"].transform.localEulerAngles = arg_170_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_173_2 = GameObjectTools.GetOrAddComponent(arg_170_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_173_2 then
					var_173_2:EnableDynamicBone(true)
				end
			end

			if 0.200000002980232 < arg_170_1.time_ and arg_170_1.time_ <= 0.200000002980232 + arg_173_0 then
				arg_170_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_car02", "")
			end

			if 0.200000002980232 < arg_170_1.time_ and arg_170_1.time_ <= 0.200000002980232 + arg_173_0 then
				local var_173_4 = arg_170_1.var_.effect2040

				if not arg_170_1.var_.effect2040 then
					var_173_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), manager.ui.mainCamera.transform)
					var_173_4.name = "2040"
					arg_170_1.var_.effect2040 = var_173_4
				else
					var_173_4.transform:SetParent(var_173_9000)
				end

				var_173_4.transform.localPosition = Vector3.New(0, 0, -3.11)
				var_173_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_170_1.frameCnt_ <= 1 then
				arg_170_1.dialog_:SetActive(false)
			end

			local var_173_6 = 0.866666669646899
			local var_173_7 = 1.65

			if 0.866666669646899 < arg_170_1.time_ and arg_170_1.time_ <= var_173_6 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0

				arg_170_1.dialog_:SetActive(true)

				arg_170_1.dialogCg_.alpha = 0

				local var_173_8 = LeanTween.value(arg_170_1.dialog_, 0, 1, 0.3)

				var_173_8:setOnUpdate(LuaHelper.FloatAction(function(arg_174_0)
					arg_170_1.dialogCg_.alpha = arg_174_0
				end))
				var_173_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_170_1.dialog_)
					var_173_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_170_1.duration_ = arg_170_1.duration_ + 0.3

				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_9 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(322072040).content)

				arg_170_1.text_.text = var_173_9

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_11 = 66 <= 0 and var_173_7 or var_173_7 * (utf8.len(var_173_9) / 66)

				if (66 <= 0 and var_173_7 or var_173_7 * (utf8.len(var_173_9) / 66)) > 0 and var_173_7 < var_173_11 then
					arg_170_1.talkMaxDuration = var_173_11
					var_173_6 = var_173_6 + 0.3

					if var_173_11 + var_173_6 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_11 + var_173_6
					end
				end

				arg_170_1.text_.text = var_173_9
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_12 = var_173_6 + 0.3
			local var_173_13 = math.max(var_173_7, arg_170_1.talkMaxDuration)

			if var_173_6 + 0.3 <= arg_170_1.time_ and arg_170_1.time_ < var_173_12 + var_173_13 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_12) / var_173_13

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_12 + var_173_13 and arg_170_1.time_ < var_173_12 + var_173_13 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play322072041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 322072041
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play322072042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				if arg_176_1.var_.effect2040 then
					Object.Destroy(arg_176_1.var_.effect2040)

					arg_176_1.var_.effect2040 = nil
				end
			end

			local var_179_1 = 0
			local var_179_2 = 1.15

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_3 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(322072041).content)

				arg_176_1.text_.text = var_179_3

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_5 = 46 <= 0 and var_179_2 or var_179_2 * (utf8.len(var_179_3) / 46)

				if (46 <= 0 and var_179_2 or var_179_2 * (utf8.len(var_179_3) / 46)) > 0 and var_179_2 < var_179_5 then
					arg_176_1.talkMaxDuration = var_179_5

					if var_179_5 + var_179_1 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_5 + var_179_1
					end
				end

				arg_176_1.text_.text = var_179_3
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_6 = math.max(var_179_2, arg_176_1.talkMaxDuration)

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_6 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_1) / var_179_6

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_1 + var_179_6 and arg_176_1.time_ < var_179_1 + var_179_6 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play322072042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 322072042
		arg_180_1.duration_ = 11.33

		local var_180_0 = {
			zh = 7.766,
			ja = 11.333
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play322072043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos10103ui_story = arg_180_1.actors_["10103ui_story"].transform.localPosition

				local var_183_0 = GameObjectTools.GetOrAddComponent(arg_180_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_183_0 then
					var_183_0:EnableDynamicBone(false)
				end
			end

			local var_183_1 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_1 then
				arg_180_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10103ui_story, Vector3.New(0, -0.95, -6.2), (arg_180_1.time_ - 0) / var_183_1)
				arg_180_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["10103ui_story"].transform.position).z)
				arg_180_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["10103ui_story"].transform.localEulerAngles = arg_180_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_1 and arg_180_1.time_ < 0 + var_183_1 + arg_183_0 then
				arg_180_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.2)
				arg_180_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["10103ui_story"].transform.position).z)
				arg_180_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["10103ui_story"].transform.localEulerAngles = arg_180_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_183_2 = GameObjectTools.GetOrAddComponent(arg_180_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_183_2 then
					var_183_2:EnableDynamicBone(true)
				end
			end

			local var_183_3 = arg_180_1.actors_["10103ui_story"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_3) and arg_180_1.var_.characterEffect10103ui_story == nil then
				arg_180_1.var_.characterEffect10103ui_story = var_183_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_4 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_4 and not isNil(var_183_3) then
				if arg_180_1.var_.characterEffect10103ui_story and not isNil(var_183_3) then
					arg_180_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= 0 + var_183_4 and arg_180_1.time_ < 0 + var_183_4 + arg_183_0 and not isNil(var_183_3) and arg_180_1.var_.characterEffect10103ui_story then
				arg_180_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action9_1")
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				if not isNil(arg_180_1.actors_["10103ui_story"]) then
					local var_183_6 = GameObjectTools.GetOrAddComponent(arg_180_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_183_6 then
						var_183_6:EnableDynamicBone(true)
					end
				end
			end

			local var_183_7 = 0
			local var_183_8 = 0.725

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_7 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_9 = arg_180_1:GetWordFromCfg(322072042)
				local var_183_10 = arg_180_1:FormatText(var_183_9.content)

				arg_180_1.text_.text = var_183_10

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_12 = 29 <= 0 and var_183_8 or var_183_8 * (utf8.len(var_183_10) / 29)

				if (29 <= 0 and var_183_8 or var_183_8 * (utf8.len(var_183_10) / 29)) > 0 and var_183_8 < var_183_12 then
					arg_180_1.talkMaxDuration = var_183_12

					if var_183_12 + var_183_7 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_12 + var_183_7
					end
				end

				arg_180_1.text_.text = var_183_10
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072042", "story_v_out_322072.awb") ~= 0 then
					local var_183_13 = manager.audio:GetVoiceLength("story_v_out_322072", "322072042", "story_v_out_322072.awb") / 1000

					if var_183_13 + var_183_7 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_13 + var_183_7
					end

					if var_183_9.prefab_name ~= "" and arg_180_1.actors_[var_183_9.prefab_name] ~= nil then
						local var_183_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_9.prefab_name].transform, "story_v_out_322072", "322072042", "story_v_out_322072.awb")

						arg_180_1:RecordAudio("322072042", var_183_14)
						arg_180_1:RecordAudio("322072042", var_183_14)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_322072", "322072042", "story_v_out_322072.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_322072", "322072042", "story_v_out_322072.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_15 = math.max(var_183_8, arg_180_1.talkMaxDuration)

			if var_183_7 <= arg_180_1.time_ and arg_180_1.time_ < var_183_7 + var_183_15 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_7) / var_183_15

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_7 + var_183_15 and arg_180_1.time_ < var_183_7 + var_183_15 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play322072043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 322072043
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play322072044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos10103ui_story = arg_184_1.actors_["10103ui_story"].transform.localPosition

				local var_187_0 = GameObjectTools.GetOrAddComponent(arg_184_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_187_0 then
					var_187_0:EnableDynamicBone(false)
				end
			end

			local var_187_1 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_1 then
				arg_184_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_184_1.time_ - 0) / var_187_1)
				arg_184_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["10103ui_story"].transform.position).z)
				arg_184_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["10103ui_story"].transform.localEulerAngles = arg_184_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_184_1.time_ >= 0 + var_187_1 and arg_184_1.time_ < 0 + var_187_1 + arg_187_0 then
				arg_184_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_184_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["10103ui_story"].transform.position).z)
				arg_184_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["10103ui_story"].transform.localEulerAngles = arg_184_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_187_2 = GameObjectTools.GetOrAddComponent(arg_184_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_187_2 then
					var_187_2:EnableDynamicBone(true)
				end
			end

			if 0.466666666666 < arg_184_1.time_ and arg_184_1.time_ <= 0.466666666666 + arg_187_0 then
				arg_184_1:AudioAction("play", "effect", "se_story_145", "se_story_145_sword", "")
			end

			local var_187_4 = 0
			local var_187_5 = 1.225

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_6 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(322072043).content)

				arg_184_1.text_.text = var_187_6

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_8 = 49 <= 0 and var_187_5 or var_187_5 * (utf8.len(var_187_6) / 49)

				if (49 <= 0 and var_187_5 or var_187_5 * (utf8.len(var_187_6) / 49)) > 0 and var_187_5 < var_187_8 then
					arg_184_1.talkMaxDuration = var_187_8

					if var_187_8 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_4
					end
				end

				arg_184_1.text_.text = var_187_6
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_9 = math.max(var_187_5, arg_184_1.talkMaxDuration)

			if var_187_4 <= arg_184_1.time_ and arg_184_1.time_ < var_187_4 + var_187_9 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_4) / var_187_9

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_4 + var_187_9 and arg_184_1.time_ < var_187_4 + var_187_9 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play322072044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 322072044
		arg_188_1.duration_ = 5.3

		local var_188_0 = {
			zh = 1.999999999999,
			ja = 5.3
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play322072045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos10103ui_story = arg_188_1.actors_["10103ui_story"].transform.localPosition

				local var_191_0 = GameObjectTools.GetOrAddComponent(arg_188_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_191_0 then
					var_191_0:EnableDynamicBone(false)
				end
			end

			local var_191_1 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_1 then
				arg_188_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10103ui_story, Vector3.New(0, -0.95, -6.2), (arg_188_1.time_ - 0) / var_191_1)
				arg_188_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["10103ui_story"].transform.position).z)
				arg_188_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["10103ui_story"].transform.localEulerAngles = arg_188_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_188_1.time_ >= 0 + var_191_1 and arg_188_1.time_ < 0 + var_191_1 + arg_191_0 then
				arg_188_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.2)
				arg_188_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["10103ui_story"].transform.position).z)
				arg_188_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["10103ui_story"].transform.localEulerAngles = arg_188_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_191_2 = GameObjectTools.GetOrAddComponent(arg_188_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_191_2 then
					var_191_2:EnableDynamicBone(true)
				end
			end

			local var_191_3 = arg_188_1.actors_["10103ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_3) and arg_188_1.var_.characterEffect10103ui_story == nil then
				arg_188_1.var_.characterEffect10103ui_story = var_191_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_4 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_4 and not isNil(var_191_3) then
				if arg_188_1.var_.characterEffect10103ui_story and not isNil(var_191_3) then
					arg_188_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= 0 + var_191_4 and arg_188_1.time_ < 0 + var_191_4 + arg_191_0 and not isNil(var_191_3) and arg_188_1.var_.characterEffect10103ui_story then
				arg_188_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action9_2")
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				if not isNil(arg_188_1.actors_["10103ui_story"]) then
					local var_191_6 = GameObjectTools.GetOrAddComponent(arg_188_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_191_6 then
						var_191_6:EnableDynamicBone(true)
					end
				end
			end

			local var_191_7 = 0
			local var_191_8 = 0.2

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_7 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_9 = arg_188_1:GetWordFromCfg(322072044)
				local var_191_10 = arg_188_1:FormatText(var_191_9.content)

				arg_188_1.text_.text = var_191_10

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_12 = 8 <= 0 and var_191_8 or var_191_8 * (utf8.len(var_191_10) / 8)

				if (8 <= 0 and var_191_8 or var_191_8 * (utf8.len(var_191_10) / 8)) > 0 and var_191_8 < var_191_12 then
					arg_188_1.talkMaxDuration = var_191_12

					if var_191_12 + var_191_7 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_12 + var_191_7
					end
				end

				arg_188_1.text_.text = var_191_10
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072044", "story_v_out_322072.awb") ~= 0 then
					local var_191_13 = manager.audio:GetVoiceLength("story_v_out_322072", "322072044", "story_v_out_322072.awb") / 1000

					if var_191_13 + var_191_7 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_13 + var_191_7
					end

					if var_191_9.prefab_name ~= "" and arg_188_1.actors_[var_191_9.prefab_name] ~= nil then
						local var_191_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_9.prefab_name].transform, "story_v_out_322072", "322072044", "story_v_out_322072.awb")

						arg_188_1:RecordAudio("322072044", var_191_14)
						arg_188_1:RecordAudio("322072044", var_191_14)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_322072", "322072044", "story_v_out_322072.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_322072", "322072044", "story_v_out_322072.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_15 = math.max(var_191_8, arg_188_1.talkMaxDuration)

			if var_191_7 <= arg_188_1.time_ and arg_188_1.time_ < var_191_7 + var_191_15 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_7) / var_191_15

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_7 + var_191_15 and arg_188_1.time_ < var_191_7 + var_191_15 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play322072045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 322072045
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play322072046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos10103ui_story = arg_192_1.actors_["10103ui_story"].transform.localPosition

				local var_195_0 = GameObjectTools.GetOrAddComponent(arg_192_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_195_0 then
					var_195_0:EnableDynamicBone(false)
				end
			end

			local var_195_1 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_1 then
				arg_192_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_192_1.time_ - 0) / var_195_1)
				arg_192_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["10103ui_story"].transform.position).z)
				arg_192_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["10103ui_story"].transform.localEulerAngles = arg_192_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_192_1.time_ >= 0 + var_195_1 and arg_192_1.time_ < 0 + var_195_1 + arg_195_0 then
				arg_192_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_192_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["10103ui_story"].transform.position).z)
				arg_192_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["10103ui_story"].transform.localEulerAngles = arg_192_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_195_2 = GameObjectTools.GetOrAddComponent(arg_192_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_195_2 then
					var_195_2:EnableDynamicBone(true)
				end
			end

			if 0.6 < arg_192_1.time_ and arg_192_1.time_ <= 0.6 + arg_195_0 then
				arg_192_1:AudioAction("play", "effect", "se_story_128", "se_story_128_metal", "")
			end

			local var_195_4 = 0
			local var_195_5 = 1.075

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_4 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_6 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(322072045).content)

				arg_192_1.text_.text = var_195_6

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_8 = 43 <= 0 and var_195_5 or var_195_5 * (utf8.len(var_195_6) / 43)

				if (43 <= 0 and var_195_5 or var_195_5 * (utf8.len(var_195_6) / 43)) > 0 and var_195_5 < var_195_8 then
					arg_192_1.talkMaxDuration = var_195_8

					if var_195_8 + var_195_4 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_8 + var_195_4
					end
				end

				arg_192_1.text_.text = var_195_6
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_9 = math.max(var_195_5, arg_192_1.talkMaxDuration)

			if var_195_4 <= arg_192_1.time_ and arg_192_1.time_ < var_195_4 + var_195_9 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_4) / var_195_9

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_4 + var_195_9 and arg_192_1.time_ < var_195_4 + var_195_9 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play322072046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 322072046
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play322072047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0.2 < arg_196_1.time_ and arg_196_1.time_ <= 0.2 + arg_199_0 then
				arg_196_1:AudioAction("play", "effect", "se_story_145", "se_story_145_fire02", "")
			end

			local var_199_1 = manager.ui.mainCamera.transform

			if 0.2 < arg_196_1.time_ and arg_196_1.time_ <= 0.2 + arg_199_0 then
				arg_196_1.var_.shakeOldPos = var_199_1.localPosition
			end

			local var_199_2 = 0.6

			if 0.2 <= arg_196_1.time_ and arg_196_1.time_ < 0.2 + var_199_2 then
				local var_199_3, var_199_4 = math.modf((arg_196_1.time_ - 0.2) / 0.066)

				var_199_1.localPosition = Vector3.New(var_199_4 * 0.13, var_199_4 * 0.13, var_199_4 * 0.13) + arg_196_1.var_.shakeOldPos
			end

			if arg_196_1.time_ >= 0.2 + var_199_2 and arg_196_1.time_ < 0.2 + var_199_2 + arg_199_0 then
				var_199_1.localPosition = arg_196_1.var_.shakeOldPos
			end

			local var_199_5 = 0
			local var_199_6 = 1.4

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_5 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_7 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(322072046).content)

				arg_196_1.text_.text = var_199_7

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_9 = 56 <= 0 and var_199_6 or var_199_6 * (utf8.len(var_199_7) / 56)

				if (56 <= 0 and var_199_6 or var_199_6 * (utf8.len(var_199_7) / 56)) > 0 and var_199_6 < var_199_9 then
					arg_196_1.talkMaxDuration = var_199_9

					if var_199_9 + var_199_5 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_9 + var_199_5
					end
				end

				arg_196_1.text_.text = var_199_7
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_10 = math.max(var_199_6, arg_196_1.talkMaxDuration)

			if var_199_5 <= arg_196_1.time_ and arg_196_1.time_ < var_199_5 + var_199_10 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_5) / var_199_10

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_5 + var_199_10 and arg_196_1.time_ < var_199_5 + var_199_10 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play322072047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 322072047
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play322072048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0.175 < arg_200_1.time_ and arg_200_1.time_ <= 0.175 + arg_203_0 then
				arg_200_1:AudioAction("play", "effect", "se_story_145", "se_story_145_machanical_arm", "")
			end

			local var_203_1 = 0
			local var_203_2 = 1.175

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_3 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(322072047).content)

				arg_200_1.text_.text = var_203_3

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_5 = 47 <= 0 and var_203_2 or var_203_2 * (utf8.len(var_203_3) / 47)

				if (47 <= 0 and var_203_2 or var_203_2 * (utf8.len(var_203_3) / 47)) > 0 and var_203_2 < var_203_5 then
					arg_200_1.talkMaxDuration = var_203_5

					if var_203_5 + var_203_1 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_5 + var_203_1
					end
				end

				arg_200_1.text_.text = var_203_3
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_6 = math.max(var_203_2, arg_200_1.talkMaxDuration)

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_6 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_1) / var_203_6

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_1 + var_203_6 and arg_200_1.time_ < var_203_1 + var_203_6 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play322072048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 322072048
		arg_204_1.duration_ = 2

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play322072049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if arg_204_1.actors_["10150ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10150ui_story"))) then
				local var_207_0 = Object.Instantiate(Asset.Load("Char/" .. "10150ui_story"), arg_204_1.stage_.transform)

				var_207_0.name = "10150ui_story"
				var_207_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_204_1.actors_["10150ui_story"] = var_207_0

				local var_207_1 = var_207_0:GetComponentInChildren(typeof(CharacterEffect))

				var_207_1.enabled = true

				local var_207_2 = GameObjectTools.GetOrAddComponent(var_207_0, typeof(DynamicBoneHelper))

				if var_207_2 then
					var_207_2:EnableDynamicBone(false)
				end

				arg_204_1:ShowWeapon(var_207_1.transform, false)

				arg_204_1.var_["10150ui_story" .. "Animator"] = var_207_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_204_1.var_["10150ui_story" .. "Animator"].applyRootMotion = true
				arg_204_1.var_["10150ui_story" .. "LipSync"] = var_207_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_207_3 = arg_204_1.actors_["10150ui_story"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos10150ui_story = var_207_3.localPosition

				local var_207_4 = GameObjectTools.GetOrAddComponent(var_207_3.gameObject, typeof(DynamicBoneHelper))

				if var_207_4 then
					var_207_4:EnableDynamicBone(false)
				end
			end

			local var_207_5 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_5 then
				var_207_3.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10150ui_story, Vector3.New(-0.9, -1.73, -5.5), (arg_204_1.time_ - 0) / var_207_5)
				var_207_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_3.position).x, (manager.ui.mainCamera.transform.position - var_207_3.position).y, (manager.ui.mainCamera.transform.position - var_207_3.position).z)
				var_207_3.localEulerAngles.z = 0
				var_207_3.localEulerAngles.x = 0
				var_207_3.localEulerAngles = var_207_3.localEulerAngles
			end

			if arg_204_1.time_ >= 0 + var_207_5 and arg_204_1.time_ < 0 + var_207_5 + arg_207_0 then
				var_207_3.localPosition = Vector3.New(-0.9, -1.73, -5.5)
				var_207_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_3.position).x, (manager.ui.mainCamera.transform.position - var_207_3.position).y, (manager.ui.mainCamera.transform.position - var_207_3.position).z)
				var_207_3.localEulerAngles.z = 0
				var_207_3.localEulerAngles.x = 0
				var_207_3.localEulerAngles = var_207_3.localEulerAngles

				local var_207_6 = GameObjectTools.GetOrAddComponent(var_207_3.gameObject, typeof(DynamicBoneHelper))

				if var_207_6 then
					var_207_6:EnableDynamicBone(true)
				end
			end

			local var_207_7 = arg_204_1.actors_["10150ui_story"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_7) and arg_204_1.var_.characterEffect10150ui_story == nil then
				arg_204_1.var_.characterEffect10150ui_story = var_207_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_8 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_8 and not isNil(var_207_7) then
				if arg_204_1.var_.characterEffect10150ui_story and not isNil(var_207_7) then
					arg_204_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 0 + var_207_8 and arg_204_1.time_ < 0 + var_207_8 + arg_207_0 and not isNil(var_207_7) and arg_204_1.var_.characterEffect10150ui_story then
				arg_204_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action3_1")
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_207_10 = 0
			local var_207_11 = 0.125

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_10 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_12 = arg_204_1:GetWordFromCfg(322072048)
				local var_207_13 = arg_204_1:FormatText(var_207_12.content)

				arg_204_1.text_.text = var_207_13

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_15 = 5 <= 0 and var_207_11 or var_207_11 * (utf8.len(var_207_13) / 5)

				if (5 <= 0 and var_207_11 or var_207_11 * (utf8.len(var_207_13) / 5)) > 0 and var_207_11 < var_207_15 then
					arg_204_1.talkMaxDuration = var_207_15

					if var_207_15 + var_207_10 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_15 + var_207_10
					end
				end

				arg_204_1.text_.text = var_207_13
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072048", "story_v_out_322072.awb") ~= 0 then
					local var_207_16 = manager.audio:GetVoiceLength("story_v_out_322072", "322072048", "story_v_out_322072.awb") / 1000

					if var_207_16 + var_207_10 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_16 + var_207_10
					end

					if var_207_12.prefab_name ~= "" and arg_204_1.actors_[var_207_12.prefab_name] ~= nil then
						local var_207_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_12.prefab_name].transform, "story_v_out_322072", "322072048", "story_v_out_322072.awb")

						arg_204_1:RecordAudio("322072048", var_207_17)
						arg_204_1:RecordAudio("322072048", var_207_17)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_322072", "322072048", "story_v_out_322072.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_322072", "322072048", "story_v_out_322072.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_18 = math.max(var_207_11, arg_204_1.talkMaxDuration)

			if var_207_10 <= arg_204_1.time_ and arg_204_1.time_ < var_207_10 + var_207_18 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_10) / var_207_18

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_10 + var_207_18 and arg_204_1.time_ < var_207_10 + var_207_18 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
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

		arg_204_1:InitPlayNodeList()
	end,
	Play322072049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 322072049
		arg_208_1.duration_ = 8.17

		local var_208_0 = {
			zh = 6.866,
			ja = 8.166
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play322072050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos10103ui_story = arg_208_1.actors_["10103ui_story"].transform.localPosition

				local var_211_0 = GameObjectTools.GetOrAddComponent(arg_208_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_211_0 then
					var_211_0:EnableDynamicBone(false)
				end
			end

			local var_211_1 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_1 then
				arg_208_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10103ui_story, Vector3.New(0.7, -0.95, -6.2), (arg_208_1.time_ - 0) / var_211_1)
				arg_208_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_208_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["10103ui_story"].transform.position).z)
				arg_208_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_208_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_208_1.actors_["10103ui_story"].transform.localEulerAngles = arg_208_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_208_1.time_ >= 0 + var_211_1 and arg_208_1.time_ < 0 + var_211_1 + arg_211_0 then
				arg_208_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.2)
				arg_208_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_208_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["10103ui_story"].transform.position).z)
				arg_208_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_208_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_208_1.actors_["10103ui_story"].transform.localEulerAngles = arg_208_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_211_2 = GameObjectTools.GetOrAddComponent(arg_208_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_211_2 then
					var_211_2:EnableDynamicBone(true)
				end
			end

			local var_211_3 = arg_208_1.actors_["10103ui_story"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_3) and arg_208_1.var_.characterEffect10103ui_story == nil then
				arg_208_1.var_.characterEffect10103ui_story = var_211_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_4 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_4 and not isNil(var_211_3) then
				if arg_208_1.var_.characterEffect10103ui_story and not isNil(var_211_3) then
					arg_208_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= 0 + var_211_4 and arg_208_1.time_ < 0 + var_211_4 + arg_211_0 and not isNil(var_211_3) and arg_208_1.var_.characterEffect10103ui_story then
				arg_208_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_211_6 = arg_208_1.actors_["10150ui_story"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_6) and arg_208_1.var_.characterEffect10150ui_story == nil then
				arg_208_1.var_.characterEffect10150ui_story = var_211_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_7 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_7 and not isNil(var_211_6) then
				if arg_208_1.var_.characterEffect10150ui_story and not isNil(var_211_6) then
					arg_208_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_208_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_7)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_7 and arg_208_1.time_ < 0 + var_211_7 + arg_211_0 and not isNil(var_211_6) and arg_208_1.var_.characterEffect10150ui_story then
				arg_208_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_208_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_1")
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				if not isNil(arg_208_1.actors_["10103ui_story"]) then
					local var_211_8 = GameObjectTools.GetOrAddComponent(arg_208_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_211_8 then
						var_211_8:EnableDynamicBone(true)
					end
				end
			end

			local var_211_9 = 0
			local var_211_10 = 0.75

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_9 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_11 = arg_208_1:GetWordFromCfg(322072049)
				local var_211_12 = arg_208_1:FormatText(var_211_11.content)

				arg_208_1.text_.text = var_211_12

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_14 = 30 <= 0 and var_211_10 or var_211_10 * (utf8.len(var_211_12) / 30)

				if (30 <= 0 and var_211_10 or var_211_10 * (utf8.len(var_211_12) / 30)) > 0 and var_211_10 < var_211_14 then
					arg_208_1.talkMaxDuration = var_211_14

					if var_211_14 + var_211_9 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_14 + var_211_9
					end
				end

				arg_208_1.text_.text = var_211_12
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072049", "story_v_out_322072.awb") ~= 0 then
					local var_211_15 = manager.audio:GetVoiceLength("story_v_out_322072", "322072049", "story_v_out_322072.awb") / 1000

					if var_211_15 + var_211_9 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_15 + var_211_9
					end

					if var_211_11.prefab_name ~= "" and arg_208_1.actors_[var_211_11.prefab_name] ~= nil then
						local var_211_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_11.prefab_name].transform, "story_v_out_322072", "322072049", "story_v_out_322072.awb")

						arg_208_1:RecordAudio("322072049", var_211_16)
						arg_208_1:RecordAudio("322072049", var_211_16)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_322072", "322072049", "story_v_out_322072.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_322072", "322072049", "story_v_out_322072.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_17 = math.max(var_211_10, arg_208_1.talkMaxDuration)

			if var_211_9 <= arg_208_1.time_ and arg_208_1.time_ < var_211_9 + var_211_17 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_9) / var_211_17

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_9 + var_211_17 and arg_208_1.time_ < var_211_9 + var_211_17 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play322072050 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 322072050
		arg_212_1.duration_ = 4

		local var_212_0 = {
			zh = 1.999999999999,
			ja = 4
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play322072051(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos10150ui_story = arg_212_1.actors_["10150ui_story"].transform.localPosition

				local var_215_0 = GameObjectTools.GetOrAddComponent(arg_212_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_215_0 then
					var_215_0:EnableDynamicBone(false)
				end
			end

			local var_215_1 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_1 then
				arg_212_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10150ui_story, Vector3.New(-0.9, -1.73, -5.5), (arg_212_1.time_ - 0) / var_215_1)
				arg_212_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["10150ui_story"].transform.position).z)
				arg_212_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["10150ui_story"].transform.localEulerAngles = arg_212_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_1 and arg_212_1.time_ < 0 + var_215_1 + arg_215_0 then
				arg_212_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(-0.9, -1.73, -5.5)
				arg_212_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["10150ui_story"].transform.position).z)
				arg_212_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["10150ui_story"].transform.localEulerAngles = arg_212_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_215_2 = GameObjectTools.GetOrAddComponent(arg_212_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_215_2 then
					var_215_2:EnableDynamicBone(true)
				end
			end

			local var_215_3 = arg_212_1.actors_["10150ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_3) and arg_212_1.var_.characterEffect10150ui_story == nil then
				arg_212_1.var_.characterEffect10150ui_story = var_215_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_4 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_4 and not isNil(var_215_3) then
				if arg_212_1.var_.characterEffect10150ui_story and not isNil(var_215_3) then
					arg_212_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_4 and arg_212_1.time_ < 0 + var_215_4 + arg_215_0 and not isNil(var_215_3) and arg_212_1.var_.characterEffect10150ui_story then
				arg_212_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_215_6 = arg_212_1.actors_["10103ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_6) and arg_212_1.var_.characterEffect10103ui_story == nil then
				arg_212_1.var_.characterEffect10103ui_story = var_215_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_7 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_7 and not isNil(var_215_6) then
				if arg_212_1.var_.characterEffect10103ui_story and not isNil(var_215_6) then
					arg_212_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_212_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_212_1.time_ - 0) / var_215_7)
				end
			end

			if arg_212_1.time_ >= 0 + var_215_7 and arg_212_1.time_ < 0 + var_215_7 + arg_215_0 and not isNil(var_215_6) and arg_212_1.var_.characterEffect10103ui_story then
				arg_212_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_212_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action3_2")
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_215_8 = 0
			local var_215_9 = 0.2

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_8 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_10 = arg_212_1:GetWordFromCfg(322072050)
				local var_215_11 = arg_212_1:FormatText(var_215_10.content)

				arg_212_1.text_.text = var_215_11

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_13 = 8 <= 0 and var_215_9 or var_215_9 * (utf8.len(var_215_11) / 8)

				if (8 <= 0 and var_215_9 or var_215_9 * (utf8.len(var_215_11) / 8)) > 0 and var_215_9 < var_215_13 then
					arg_212_1.talkMaxDuration = var_215_13

					if var_215_13 + var_215_8 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_13 + var_215_8
					end
				end

				arg_212_1.text_.text = var_215_11
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072050", "story_v_out_322072.awb") ~= 0 then
					local var_215_14 = manager.audio:GetVoiceLength("story_v_out_322072", "322072050", "story_v_out_322072.awb") / 1000

					if var_215_14 + var_215_8 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_14 + var_215_8
					end

					if var_215_10.prefab_name ~= "" and arg_212_1.actors_[var_215_10.prefab_name] ~= nil then
						local var_215_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_10.prefab_name].transform, "story_v_out_322072", "322072050", "story_v_out_322072.awb")

						arg_212_1:RecordAudio("322072050", var_215_15)
						arg_212_1:RecordAudio("322072050", var_215_15)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_322072", "322072050", "story_v_out_322072.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_322072", "322072050", "story_v_out_322072.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_16 = math.max(var_215_9, arg_212_1.talkMaxDuration)

			if var_215_8 <= arg_212_1.time_ and arg_212_1.time_ < var_215_8 + var_215_16 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_8) / var_215_16

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_8 + var_215_16 and arg_212_1.time_ < var_215_8 + var_215_16 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
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

		arg_212_1:InitPlayNodeList()
	end,
	Play322072051 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 322072051
		arg_216_1.duration_ = 7.8

		local var_216_0 = {
			zh = 5.866,
			ja = 7.8
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play322072052(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos10103ui_story = arg_216_1.actors_["10103ui_story"].transform.localPosition

				local var_219_0 = GameObjectTools.GetOrAddComponent(arg_216_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_219_0 then
					var_219_0:EnableDynamicBone(false)
				end
			end

			local var_219_1 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_1 then
				arg_216_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10103ui_story, Vector3.New(0.7, -0.95, -6.2), (arg_216_1.time_ - 0) / var_219_1)
				arg_216_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["10103ui_story"].transform.position).z)
				arg_216_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["10103ui_story"].transform.localEulerAngles = arg_216_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_1 and arg_216_1.time_ < 0 + var_219_1 + arg_219_0 then
				arg_216_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.2)
				arg_216_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["10103ui_story"].transform.position).z)
				arg_216_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["10103ui_story"].transform.localEulerAngles = arg_216_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_219_2 = GameObjectTools.GetOrAddComponent(arg_216_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_219_2 then
					var_219_2:EnableDynamicBone(true)
				end
			end

			local var_219_3 = arg_216_1.actors_["10103ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_3) and arg_216_1.var_.characterEffect10103ui_story == nil then
				arg_216_1.var_.characterEffect10103ui_story = var_219_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_4 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_4 and not isNil(var_219_3) then
				if arg_216_1.var_.characterEffect10103ui_story and not isNil(var_219_3) then
					arg_216_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= 0 + var_219_4 and arg_216_1.time_ < 0 + var_219_4 + arg_219_0 and not isNil(var_219_3) and arg_216_1.var_.characterEffect10103ui_story then
				arg_216_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_219_6 = arg_216_1.actors_["10150ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_6) and arg_216_1.var_.characterEffect10150ui_story == nil then
				arg_216_1.var_.characterEffect10150ui_story = var_219_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_7 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_7 and not isNil(var_219_6) then
				if arg_216_1.var_.characterEffect10150ui_story and not isNil(var_219_6) then
					arg_216_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_216_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_7)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_7 and arg_216_1.time_ < 0 + var_219_7 + arg_219_0 and not isNil(var_219_6) and arg_216_1.var_.characterEffect10150ui_story then
				arg_216_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_216_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_2")
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				if not isNil(arg_216_1.actors_["10103ui_story"]) then
					local var_219_8 = GameObjectTools.GetOrAddComponent(arg_216_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_219_8 then
						var_219_8:EnableDynamicBone(true)
					end
				end
			end

			local var_219_9 = 0
			local var_219_10 = 0.7

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_9 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_11 = arg_216_1:GetWordFromCfg(322072051)
				local var_219_12 = arg_216_1:FormatText(var_219_11.content)

				arg_216_1.text_.text = var_219_12

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_14 = 28 <= 0 and var_219_10 or var_219_10 * (utf8.len(var_219_12) / 28)

				if (28 <= 0 and var_219_10 or var_219_10 * (utf8.len(var_219_12) / 28)) > 0 and var_219_10 < var_219_14 then
					arg_216_1.talkMaxDuration = var_219_14

					if var_219_14 + var_219_9 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_14 + var_219_9
					end
				end

				arg_216_1.text_.text = var_219_12
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072051", "story_v_out_322072.awb") ~= 0 then
					local var_219_15 = manager.audio:GetVoiceLength("story_v_out_322072", "322072051", "story_v_out_322072.awb") / 1000

					if var_219_15 + var_219_9 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_15 + var_219_9
					end

					if var_219_11.prefab_name ~= "" and arg_216_1.actors_[var_219_11.prefab_name] ~= nil then
						local var_219_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_11.prefab_name].transform, "story_v_out_322072", "322072051", "story_v_out_322072.awb")

						arg_216_1:RecordAudio("322072051", var_219_16)
						arg_216_1:RecordAudio("322072051", var_219_16)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_322072", "322072051", "story_v_out_322072.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_322072", "322072051", "story_v_out_322072.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_17 = math.max(var_219_10, arg_216_1.talkMaxDuration)

			if var_219_9 <= arg_216_1.time_ and arg_216_1.time_ < var_219_9 + var_219_17 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_9) / var_219_17

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_9 + var_219_17 and arg_216_1.time_ < var_219_9 + var_219_17 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play322072052 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 322072052
		arg_220_1.duration_ = 8.77

		local var_220_0 = {
			zh = 5.433,
			ja = 8.766
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play322072053(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0.575

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_1 = arg_220_1:GetWordFromCfg(322072052)
				local var_223_2 = arg_220_1:FormatText(var_223_1.content)

				arg_220_1.text_.text = var_223_2

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_4 = 23 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_2) / 23)

				if (23 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_2) / 23)) > 0 and var_223_0 < var_223_4 then
					arg_220_1.talkMaxDuration = var_223_4

					if var_223_4 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_4 + 0
					end
				end

				arg_220_1.text_.text = var_223_2
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072052", "story_v_out_322072.awb") ~= 0 then
					local var_223_5 = manager.audio:GetVoiceLength("story_v_out_322072", "322072052", "story_v_out_322072.awb") / 1000

					if var_223_5 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_5 + 0
					end

					if var_223_1.prefab_name ~= "" and arg_220_1.actors_[var_223_1.prefab_name] ~= nil then
						local var_223_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_1.prefab_name].transform, "story_v_out_322072", "322072052", "story_v_out_322072.awb")

						arg_220_1:RecordAudio("322072052", var_223_6)
						arg_220_1:RecordAudio("322072052", var_223_6)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_322072", "322072052", "story_v_out_322072.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_322072", "322072052", "story_v_out_322072.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_7 = math.max(var_223_0, arg_220_1.talkMaxDuration)

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_7 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - 0) / var_223_7

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= 0 + var_223_7 and arg_220_1.time_ < 0 + var_223_7 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play322072053 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 322072053
		arg_224_1.duration_ = 8.27

		local var_224_0 = {
			zh = 8.266,
			ja = 7.366
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play322072054(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0.75

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_1 = arg_224_1:GetWordFromCfg(322072053)
				local var_227_2 = arg_224_1:FormatText(var_227_1.content)

				arg_224_1.text_.text = var_227_2

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_4 = 30 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_2) / 30)

				if (30 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_2) / 30)) > 0 and var_227_0 < var_227_4 then
					arg_224_1.talkMaxDuration = var_227_4

					if var_227_4 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_4 + 0
					end
				end

				arg_224_1.text_.text = var_227_2
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072053", "story_v_out_322072.awb") ~= 0 then
					local var_227_5 = manager.audio:GetVoiceLength("story_v_out_322072", "322072053", "story_v_out_322072.awb") / 1000

					if var_227_5 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_5 + 0
					end

					if var_227_1.prefab_name ~= "" and arg_224_1.actors_[var_227_1.prefab_name] ~= nil then
						local var_227_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_1.prefab_name].transform, "story_v_out_322072", "322072053", "story_v_out_322072.awb")

						arg_224_1:RecordAudio("322072053", var_227_6)
						arg_224_1:RecordAudio("322072053", var_227_6)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_322072", "322072053", "story_v_out_322072.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_322072", "322072053", "story_v_out_322072.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_7 = math.max(var_227_0, arg_224_1.talkMaxDuration)

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_7 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - 0) / var_227_7

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= 0 + var_227_7 and arg_224_1.time_ < 0 + var_227_7 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play322072054 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 322072054
		arg_228_1.duration_ = 2.07

		local var_228_0 = {
			zh = 2.066,
			ja = 2.033
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play322072055(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos10150ui_story = arg_228_1.actors_["10150ui_story"].transform.localPosition

				local var_231_0 = GameObjectTools.GetOrAddComponent(arg_228_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_231_0 then
					var_231_0:EnableDynamicBone(false)
				end
			end

			local var_231_1 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_1 then
				arg_228_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10150ui_story, Vector3.New(-0.9, -1.73, -5.5), (arg_228_1.time_ - 0) / var_231_1)
				arg_228_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["10150ui_story"].transform.position).z)
				arg_228_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["10150ui_story"].transform.localEulerAngles = arg_228_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_228_1.time_ >= 0 + var_231_1 and arg_228_1.time_ < 0 + var_231_1 + arg_231_0 then
				arg_228_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(-0.9, -1.73, -5.5)
				arg_228_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["10150ui_story"].transform.position).z)
				arg_228_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["10150ui_story"].transform.localEulerAngles = arg_228_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_231_2 = GameObjectTools.GetOrAddComponent(arg_228_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_231_2 then
					var_231_2:EnableDynamicBone(true)
				end
			end

			local var_231_3 = arg_228_1.actors_["10150ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_3) and arg_228_1.var_.characterEffect10150ui_story == nil then
				arg_228_1.var_.characterEffect10150ui_story = var_231_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_4 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_4 and not isNil(var_231_3) then
				if arg_228_1.var_.characterEffect10150ui_story and not isNil(var_231_3) then
					arg_228_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_4 and arg_228_1.time_ < 0 + var_231_4 + arg_231_0 and not isNil(var_231_3) and arg_228_1.var_.characterEffect10150ui_story then
				arg_228_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_231_6 = arg_228_1.actors_["10103ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_6) and arg_228_1.var_.characterEffect10103ui_story == nil then
				arg_228_1.var_.characterEffect10103ui_story = var_231_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_7 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_7 and not isNil(var_231_6) then
				if arg_228_1.var_.characterEffect10103ui_story and not isNil(var_231_6) then
					arg_228_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_228_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_228_1.time_ - 0) / var_231_7)
				end
			end

			if arg_228_1.time_ >= 0 + var_231_7 and arg_228_1.time_ < 0 + var_231_7 + arg_231_0 and not isNil(var_231_6) and arg_228_1.var_.characterEffect10103ui_story then
				arg_228_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_228_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action5_1")
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_231_8 = 0
			local var_231_9 = 0.175

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_8 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_10 = arg_228_1:GetWordFromCfg(322072054)
				local var_231_11 = arg_228_1:FormatText(var_231_10.content)

				arg_228_1.text_.text = var_231_11

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_13 = 7 <= 0 and var_231_9 or var_231_9 * (utf8.len(var_231_11) / 7)

				if (7 <= 0 and var_231_9 or var_231_9 * (utf8.len(var_231_11) / 7)) > 0 and var_231_9 < var_231_13 then
					arg_228_1.talkMaxDuration = var_231_13

					if var_231_13 + var_231_8 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_13 + var_231_8
					end
				end

				arg_228_1.text_.text = var_231_11
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072054", "story_v_out_322072.awb") ~= 0 then
					local var_231_14 = manager.audio:GetVoiceLength("story_v_out_322072", "322072054", "story_v_out_322072.awb") / 1000

					if var_231_14 + var_231_8 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_14 + var_231_8
					end

					if var_231_10.prefab_name ~= "" and arg_228_1.actors_[var_231_10.prefab_name] ~= nil then
						local var_231_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_10.prefab_name].transform, "story_v_out_322072", "322072054", "story_v_out_322072.awb")

						arg_228_1:RecordAudio("322072054", var_231_15)
						arg_228_1:RecordAudio("322072054", var_231_15)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_322072", "322072054", "story_v_out_322072.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_322072", "322072054", "story_v_out_322072.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_16 = math.max(var_231_9, arg_228_1.talkMaxDuration)

			if var_231_8 <= arg_228_1.time_ and arg_228_1.time_ < var_231_8 + var_231_16 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_8) / var_231_16

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_8 + var_231_16 and arg_228_1.time_ < var_231_8 + var_231_16 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
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

		arg_228_1:InitPlayNodeList()
	end,
	Play322072055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 322072055
		arg_232_1.duration_ = 9.6

		local var_232_0 = {
			zh = 4.166,
			ja = 9.6
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play322072056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos10103ui_story = arg_232_1.actors_["10103ui_story"].transform.localPosition

				local var_235_0 = GameObjectTools.GetOrAddComponent(arg_232_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_235_0 then
					var_235_0:EnableDynamicBone(false)
				end
			end

			local var_235_1 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_1 then
				arg_232_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10103ui_story, Vector3.New(0.7, -0.95, -6.2), (arg_232_1.time_ - 0) / var_235_1)
				arg_232_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["10103ui_story"].transform.position).z)
				arg_232_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["10103ui_story"].transform.localEulerAngles = arg_232_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_1 and arg_232_1.time_ < 0 + var_235_1 + arg_235_0 then
				arg_232_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.2)
				arg_232_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["10103ui_story"].transform.position).z)
				arg_232_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["10103ui_story"].transform.localEulerAngles = arg_232_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_235_2 = GameObjectTools.GetOrAddComponent(arg_232_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_235_2 then
					var_235_2:EnableDynamicBone(true)
				end
			end

			local var_235_3 = arg_232_1.actors_["10103ui_story"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_3) and arg_232_1.var_.characterEffect10103ui_story == nil then
				arg_232_1.var_.characterEffect10103ui_story = var_235_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_4 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_4 and not isNil(var_235_3) then
				if arg_232_1.var_.characterEffect10103ui_story and not isNil(var_235_3) then
					arg_232_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= 0 + var_235_4 and arg_232_1.time_ < 0 + var_235_4 + arg_235_0 and not isNil(var_235_3) and arg_232_1.var_.characterEffect10103ui_story then
				arg_232_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_235_6 = arg_232_1.actors_["10150ui_story"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_6) and arg_232_1.var_.characterEffect10150ui_story == nil then
				arg_232_1.var_.characterEffect10150ui_story = var_235_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_7 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_7 and not isNil(var_235_6) then
				if arg_232_1.var_.characterEffect10150ui_story and not isNil(var_235_6) then
					arg_232_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_232_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_232_1.time_ - 0) / var_235_7)
				end
			end

			if arg_232_1.time_ >= 0 + var_235_7 and arg_232_1.time_ < 0 + var_235_7 + arg_235_0 and not isNil(var_235_6) and arg_232_1.var_.characterEffect10150ui_story then
				arg_232_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_232_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action4_1")
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				if not isNil(arg_232_1.actors_["10103ui_story"]) then
					local var_235_8 = GameObjectTools.GetOrAddComponent(arg_232_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_235_8 then
						var_235_8:EnableDynamicBone(true)
					end
				end
			end

			local var_235_9 = 0
			local var_235_10 = 0.55

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_9 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_11 = arg_232_1:GetWordFromCfg(322072055)
				local var_235_12 = arg_232_1:FormatText(var_235_11.content)

				arg_232_1.text_.text = var_235_12

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_14 = 22 <= 0 and var_235_10 or var_235_10 * (utf8.len(var_235_12) / 22)

				if (22 <= 0 and var_235_10 or var_235_10 * (utf8.len(var_235_12) / 22)) > 0 and var_235_10 < var_235_14 then
					arg_232_1.talkMaxDuration = var_235_14

					if var_235_14 + var_235_9 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_14 + var_235_9
					end
				end

				arg_232_1.text_.text = var_235_12
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072055", "story_v_out_322072.awb") ~= 0 then
					local var_235_15 = manager.audio:GetVoiceLength("story_v_out_322072", "322072055", "story_v_out_322072.awb") / 1000

					if var_235_15 + var_235_9 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_15 + var_235_9
					end

					if var_235_11.prefab_name ~= "" and arg_232_1.actors_[var_235_11.prefab_name] ~= nil then
						local var_235_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_11.prefab_name].transform, "story_v_out_322072", "322072055", "story_v_out_322072.awb")

						arg_232_1:RecordAudio("322072055", var_235_16)
						arg_232_1:RecordAudio("322072055", var_235_16)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_322072", "322072055", "story_v_out_322072.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_322072", "322072055", "story_v_out_322072.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_17 = math.max(var_235_10, arg_232_1.talkMaxDuration)

			if var_235_9 <= arg_232_1.time_ and arg_232_1.time_ < var_235_9 + var_235_17 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_9) / var_235_17

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_9 + var_235_17 and arg_232_1.time_ < var_235_9 + var_235_17 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play322072056 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 322072056
		arg_236_1.duration_ = 6.13

		local var_236_0 = {
			zh = 4.966,
			ja = 6.133
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play322072057(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos10150ui_story = arg_236_1.actors_["10150ui_story"].transform.localPosition

				local var_239_0 = GameObjectTools.GetOrAddComponent(arg_236_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_239_0 then
					var_239_0:EnableDynamicBone(false)
				end
			end

			local var_239_1 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_1 then
				arg_236_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10150ui_story, Vector3.New(-0.9, -1.73, -5.5), (arg_236_1.time_ - 0) / var_239_1)
				arg_236_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["10150ui_story"].transform.position).z)
				arg_236_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["10150ui_story"].transform.localEulerAngles = arg_236_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_1 and arg_236_1.time_ < 0 + var_239_1 + arg_239_0 then
				arg_236_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(-0.9, -1.73, -5.5)
				arg_236_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["10150ui_story"].transform.position).z)
				arg_236_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["10150ui_story"].transform.localEulerAngles = arg_236_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_239_2 = GameObjectTools.GetOrAddComponent(arg_236_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_239_2 then
					var_239_2:EnableDynamicBone(true)
				end
			end

			local var_239_3 = arg_236_1.actors_["10150ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_3) and arg_236_1.var_.characterEffect10150ui_story == nil then
				arg_236_1.var_.characterEffect10150ui_story = var_239_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_4 = 0.200000002980232

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_4 and not isNil(var_239_3) then
				if arg_236_1.var_.characterEffect10150ui_story and not isNil(var_239_3) then
					arg_236_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= 0 + var_239_4 and arg_236_1.time_ < 0 + var_239_4 + arg_239_0 and not isNil(var_239_3) and arg_236_1.var_.characterEffect10150ui_story then
				arg_236_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_239_6 = arg_236_1.actors_["10103ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_6) and arg_236_1.var_.characterEffect10103ui_story == nil then
				arg_236_1.var_.characterEffect10103ui_story = var_239_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_7 = 0.200000002980232

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_7 and not isNil(var_239_6) then
				if arg_236_1.var_.characterEffect10103ui_story and not isNil(var_239_6) then
					arg_236_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_236_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_236_1.time_ - 0) / var_239_7)
				end
			end

			if arg_236_1.time_ >= 0 + var_239_7 and arg_236_1.time_ < 0 + var_239_7 + arg_239_0 and not isNil(var_239_6) and arg_236_1.var_.characterEffect10103ui_story then
				arg_236_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_236_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action5_2")
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_239_8 = 0
			local var_239_9 = 0.325

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_8 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_10 = arg_236_1:GetWordFromCfg(322072056)
				local var_239_11 = arg_236_1:FormatText(var_239_10.content)

				arg_236_1.text_.text = var_239_11

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_13 = 13 <= 0 and var_239_9 or var_239_9 * (utf8.len(var_239_11) / 13)

				if (13 <= 0 and var_239_9 or var_239_9 * (utf8.len(var_239_11) / 13)) > 0 and var_239_9 < var_239_13 then
					arg_236_1.talkMaxDuration = var_239_13

					if var_239_13 + var_239_8 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_13 + var_239_8
					end
				end

				arg_236_1.text_.text = var_239_11
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072056", "story_v_out_322072.awb") ~= 0 then
					local var_239_14 = manager.audio:GetVoiceLength("story_v_out_322072", "322072056", "story_v_out_322072.awb") / 1000

					if var_239_14 + var_239_8 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_14 + var_239_8
					end

					if var_239_10.prefab_name ~= "" and arg_236_1.actors_[var_239_10.prefab_name] ~= nil then
						local var_239_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_10.prefab_name].transform, "story_v_out_322072", "322072056", "story_v_out_322072.awb")

						arg_236_1:RecordAudio("322072056", var_239_15)
						arg_236_1:RecordAudio("322072056", var_239_15)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_322072", "322072056", "story_v_out_322072.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_322072", "322072056", "story_v_out_322072.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_16 = math.max(var_239_9, arg_236_1.talkMaxDuration)

			if var_239_8 <= arg_236_1.time_ and arg_236_1.time_ < var_239_8 + var_239_16 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_8) / var_239_16

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_8 + var_239_16 and arg_236_1.time_ < var_239_8 + var_239_16 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
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

		arg_236_1:InitPlayNodeList()
	end,
	Play322072057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 322072057
		arg_240_1.duration_ = 9.2

		local var_240_0 = {
			zh = 5.733,
			ja = 9.2
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play322072058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos10103ui_story = arg_240_1.actors_["10103ui_story"].transform.localPosition

				local var_243_0 = GameObjectTools.GetOrAddComponent(arg_240_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_243_0 then
					var_243_0:EnableDynamicBone(false)
				end
			end

			local var_243_1 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_1 then
				arg_240_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10103ui_story, Vector3.New(0.7, -0.95, -6.2), (arg_240_1.time_ - 0) / var_243_1)
				arg_240_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["10103ui_story"].transform.position).z)
				arg_240_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["10103ui_story"].transform.localEulerAngles = arg_240_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_1 and arg_240_1.time_ < 0 + var_243_1 + arg_243_0 then
				arg_240_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.2)
				arg_240_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["10103ui_story"].transform.position).z)
				arg_240_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["10103ui_story"].transform.localEulerAngles = arg_240_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_243_2 = GameObjectTools.GetOrAddComponent(arg_240_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_243_2 then
					var_243_2:EnableDynamicBone(true)
				end
			end

			local var_243_3 = arg_240_1.actors_["10103ui_story"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_3) and arg_240_1.var_.characterEffect10103ui_story == nil then
				arg_240_1.var_.characterEffect10103ui_story = var_243_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_4 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_4 and not isNil(var_243_3) then
				if arg_240_1.var_.characterEffect10103ui_story and not isNil(var_243_3) then
					arg_240_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= 0 + var_243_4 and arg_240_1.time_ < 0 + var_243_4 + arg_243_0 and not isNil(var_243_3) and arg_240_1.var_.characterEffect10103ui_story then
				arg_240_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_243_6 = arg_240_1.actors_["10150ui_story"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_6) and arg_240_1.var_.characterEffect10150ui_story == nil then
				arg_240_1.var_.characterEffect10150ui_story = var_243_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_7 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_7 and not isNil(var_243_6) then
				if arg_240_1.var_.characterEffect10150ui_story and not isNil(var_243_6) then
					arg_240_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_240_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_240_1.time_ - 0) / var_243_7)
				end
			end

			if arg_240_1.time_ >= 0 + var_243_7 and arg_240_1.time_ < 0 + var_243_7 + arg_243_0 and not isNil(var_243_6) and arg_240_1.var_.characterEffect10150ui_story then
				arg_240_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_240_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action4_2")
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				if not isNil(arg_240_1.actors_["10103ui_story"]) then
					local var_243_8 = GameObjectTools.GetOrAddComponent(arg_240_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_243_8 then
						var_243_8:EnableDynamicBone(true)
					end
				end
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_243_9 = 0
			local var_243_10 = 0.525

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_9 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_11 = arg_240_1:GetWordFromCfg(322072057)
				local var_243_12 = arg_240_1:FormatText(var_243_11.content)

				arg_240_1.text_.text = var_243_12

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_14 = 21 <= 0 and var_243_10 or var_243_10 * (utf8.len(var_243_12) / 21)

				if (21 <= 0 and var_243_10 or var_243_10 * (utf8.len(var_243_12) / 21)) > 0 and var_243_10 < var_243_14 then
					arg_240_1.talkMaxDuration = var_243_14

					if var_243_14 + var_243_9 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_14 + var_243_9
					end
				end

				arg_240_1.text_.text = var_243_12
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072057", "story_v_out_322072.awb") ~= 0 then
					local var_243_15 = manager.audio:GetVoiceLength("story_v_out_322072", "322072057", "story_v_out_322072.awb") / 1000

					if var_243_15 + var_243_9 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_15 + var_243_9
					end

					if var_243_11.prefab_name ~= "" and arg_240_1.actors_[var_243_11.prefab_name] ~= nil then
						local var_243_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_11.prefab_name].transform, "story_v_out_322072", "322072057", "story_v_out_322072.awb")

						arg_240_1:RecordAudio("322072057", var_243_16)
						arg_240_1:RecordAudio("322072057", var_243_16)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_322072", "322072057", "story_v_out_322072.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_322072", "322072057", "story_v_out_322072.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_17 = math.max(var_243_10, arg_240_1.talkMaxDuration)

			if var_243_9 <= arg_240_1.time_ and arg_240_1.time_ < var_243_9 + var_243_17 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_9) / var_243_17

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_9 + var_243_17 and arg_240_1.time_ < var_243_9 + var_243_17 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play322072058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 322072058
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play322072059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0.1 < arg_244_1.time_ and arg_244_1.time_ <= 0.1 + arg_247_0 then
				arg_244_1:AudioAction("play", "effect", "se_story_136", "se_story_136_carengine", "")
			end

			local var_247_1 = arg_244_1.actors_["10150ui_story"].transform

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos10150ui_story = var_247_1.localPosition

				local var_247_2 = GameObjectTools.GetOrAddComponent(var_247_1.gameObject, typeof(DynamicBoneHelper))

				if var_247_2 then
					var_247_2:EnableDynamicBone(false)
				end
			end

			local var_247_3 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_3 then
				var_247_1.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos10150ui_story, Vector3.New(0, 100, 0), (arg_244_1.time_ - 0) / var_247_3)
				var_247_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_247_1.position).x, (manager.ui.mainCamera.transform.position - var_247_1.position).y, (manager.ui.mainCamera.transform.position - var_247_1.position).z)
				var_247_1.localEulerAngles.z = 0
				var_247_1.localEulerAngles.x = 0
				var_247_1.localEulerAngles = var_247_1.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_3 and arg_244_1.time_ < 0 + var_247_3 + arg_247_0 then
				var_247_1.localPosition = Vector3.New(0, 100, 0)
				var_247_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_247_1.position).x, (manager.ui.mainCamera.transform.position - var_247_1.position).y, (manager.ui.mainCamera.transform.position - var_247_1.position).z)
				var_247_1.localEulerAngles.z = 0
				var_247_1.localEulerAngles.x = 0
				var_247_1.localEulerAngles = var_247_1.localEulerAngles

				local var_247_4 = GameObjectTools.GetOrAddComponent(var_247_1.gameObject, typeof(DynamicBoneHelper))

				if var_247_4 then
					var_247_4:EnableDynamicBone(true)
				end
			end

			local var_247_5 = arg_244_1.actors_["10103ui_story"].transform

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos10103ui_story = var_247_5.localPosition

				local var_247_6 = GameObjectTools.GetOrAddComponent(var_247_5.gameObject, typeof(DynamicBoneHelper))

				if var_247_6 then
					var_247_6:EnableDynamicBone(false)
				end
			end

			local var_247_7 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_7 then
				var_247_5.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_244_1.time_ - 0) / var_247_7)
				var_247_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_247_5.position).x, (manager.ui.mainCamera.transform.position - var_247_5.position).y, (manager.ui.mainCamera.transform.position - var_247_5.position).z)
				var_247_5.localEulerAngles.z = 0
				var_247_5.localEulerAngles.x = 0
				var_247_5.localEulerAngles = var_247_5.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_7 and arg_244_1.time_ < 0 + var_247_7 + arg_247_0 then
				var_247_5.localPosition = Vector3.New(0, 100, 0)
				var_247_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_247_5.position).x, (manager.ui.mainCamera.transform.position - var_247_5.position).y, (manager.ui.mainCamera.transform.position - var_247_5.position).z)
				var_247_5.localEulerAngles.z = 0
				var_247_5.localEulerAngles.x = 0
				var_247_5.localEulerAngles = var_247_5.localEulerAngles

				local var_247_8 = GameObjectTools.GetOrAddComponent(var_247_5.gameObject, typeof(DynamicBoneHelper))

				if var_247_8 then
					var_247_8:EnableDynamicBone(true)
				end
			end

			local var_247_9 = 0
			local var_247_10 = 1.2

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_9 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_11 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(322072058).content)

				arg_244_1.text_.text = var_247_11

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_13 = 48 <= 0 and var_247_10 or var_247_10 * (utf8.len(var_247_11) / 48)

				if (48 <= 0 and var_247_10 or var_247_10 * (utf8.len(var_247_11) / 48)) > 0 and var_247_10 < var_247_13 then
					arg_244_1.talkMaxDuration = var_247_13

					if var_247_13 + var_247_9 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_13 + var_247_9
					end
				end

				arg_244_1.text_.text = var_247_11
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_14 = math.max(var_247_10, arg_244_1.talkMaxDuration)

			if var_247_9 <= arg_244_1.time_ and arg_244_1.time_ < var_247_9 + var_247_14 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_9) / var_247_14

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_9 + var_247_14 and arg_244_1.time_ < var_247_9 + var_247_14 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play322072059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 322072059
		arg_248_1.duration_ = 16.43

		local var_248_0 = {
			zh = 8.7,
			ja = 16.433
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play322072060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos10103ui_story = arg_248_1.actors_["10103ui_story"].transform.localPosition

				local var_251_0 = GameObjectTools.GetOrAddComponent(arg_248_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_251_0 then
					var_251_0:EnableDynamicBone(false)
				end
			end

			local var_251_1 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_1 then
				arg_248_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos10103ui_story, Vector3.New(0, -0.95, -6.2), (arg_248_1.time_ - 0) / var_251_1)
				arg_248_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["10103ui_story"].transform.position).z)
				arg_248_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["10103ui_story"].transform.localEulerAngles = arg_248_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_1 and arg_248_1.time_ < 0 + var_251_1 + arg_251_0 then
				arg_248_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.2)
				arg_248_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["10103ui_story"].transform.position).z)
				arg_248_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["10103ui_story"].transform.localEulerAngles = arg_248_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_251_2 = GameObjectTools.GetOrAddComponent(arg_248_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_251_2 then
					var_251_2:EnableDynamicBone(true)
				end
			end

			local var_251_3 = arg_248_1.actors_["10103ui_story"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_3) and arg_248_1.var_.characterEffect10103ui_story == nil then
				arg_248_1.var_.characterEffect10103ui_story = var_251_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_4 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_4 and not isNil(var_251_3) then
				if arg_248_1.var_.characterEffect10103ui_story and not isNil(var_251_3) then
					arg_248_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= 0 + var_251_4 and arg_248_1.time_ < 0 + var_251_4 + arg_251_0 and not isNil(var_251_3) and arg_248_1.var_.characterEffect10103ui_story then
				arg_248_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				if not isNil(arg_248_1.actors_["10103ui_story"]) then
					local var_251_6 = GameObjectTools.GetOrAddComponent(arg_248_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_251_6 then
						var_251_6:EnableDynamicBone(true)
					end
				end
			end

			local var_251_7 = 0
			local var_251_8 = 1.125

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_7 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_9 = arg_248_1:GetWordFromCfg(322072059)
				local var_251_10 = arg_248_1:FormatText(var_251_9.content)

				arg_248_1.text_.text = var_251_10

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_12 = 45 <= 0 and var_251_8 or var_251_8 * (utf8.len(var_251_10) / 45)

				if (45 <= 0 and var_251_8 or var_251_8 * (utf8.len(var_251_10) / 45)) > 0 and var_251_8 < var_251_12 then
					arg_248_1.talkMaxDuration = var_251_12

					if var_251_12 + var_251_7 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_12 + var_251_7
					end
				end

				arg_248_1.text_.text = var_251_10
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072059", "story_v_out_322072.awb") ~= 0 then
					local var_251_13 = manager.audio:GetVoiceLength("story_v_out_322072", "322072059", "story_v_out_322072.awb") / 1000

					if var_251_13 + var_251_7 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_13 + var_251_7
					end

					if var_251_9.prefab_name ~= "" and arg_248_1.actors_[var_251_9.prefab_name] ~= nil then
						local var_251_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_9.prefab_name].transform, "story_v_out_322072", "322072059", "story_v_out_322072.awb")

						arg_248_1:RecordAudio("322072059", var_251_14)
						arg_248_1:RecordAudio("322072059", var_251_14)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_322072", "322072059", "story_v_out_322072.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_322072", "322072059", "story_v_out_322072.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_15 = math.max(var_251_8, arg_248_1.talkMaxDuration)

			if var_251_7 <= arg_248_1.time_ and arg_248_1.time_ < var_251_7 + var_251_15 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_7) / var_251_15

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_7 + var_251_15 and arg_248_1.time_ < var_251_7 + var_251_15 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play322072060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 322072060
		arg_252_1.duration_ = 7.1

		local var_252_0 = {
			zh = 3.766,
			ja = 7.1
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play322072061(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action9_1")
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				if not isNil(arg_252_1.actors_["10103ui_story"]) then
					local var_255_0 = GameObjectTools.GetOrAddComponent(arg_252_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_255_0 then
						var_255_0:EnableDynamicBone(true)
					end
				end
			end

			local var_255_1 = 0
			local var_255_2 = 0.4

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_3 = arg_252_1:GetWordFromCfg(322072060)
				local var_255_4 = arg_252_1:FormatText(var_255_3.content)

				arg_252_1.text_.text = var_255_4

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_6 = 16 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_4) / 16)

				if (16 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_4) / 16)) > 0 and var_255_2 < var_255_6 then
					arg_252_1.talkMaxDuration = var_255_6

					if var_255_6 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_6 + var_255_1
					end
				end

				arg_252_1.text_.text = var_255_4
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072060", "story_v_out_322072.awb") ~= 0 then
					local var_255_7 = manager.audio:GetVoiceLength("story_v_out_322072", "322072060", "story_v_out_322072.awb") / 1000

					if var_255_7 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_7 + var_255_1
					end

					if var_255_3.prefab_name ~= "" and arg_252_1.actors_[var_255_3.prefab_name] ~= nil then
						local var_255_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_3.prefab_name].transform, "story_v_out_322072", "322072060", "story_v_out_322072.awb")

						arg_252_1:RecordAudio("322072060", var_255_8)
						arg_252_1:RecordAudio("322072060", var_255_8)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_322072", "322072060", "story_v_out_322072.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_322072", "322072060", "story_v_out_322072.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_9 = math.max(var_255_2, arg_252_1.talkMaxDuration)

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_9 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_1) / var_255_9

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_1 + var_255_9 and arg_252_1.time_ < var_255_1 + var_255_9 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play322072061 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 322072061
		arg_256_1.duration_ = 2

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play322072062(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.var_.moveOldPos10150ui_story = arg_256_1.actors_["10150ui_story"].transform.localPosition

				local var_259_0 = GameObjectTools.GetOrAddComponent(arg_256_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_259_0 then
					var_259_0:EnableDynamicBone(false)
				end
			end

			local var_259_1 = 0.001

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_1 then
				arg_256_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos10150ui_story, Vector3.New(-0.9, -1.73, -5.5), (arg_256_1.time_ - 0) / var_259_1)
				arg_256_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["10150ui_story"].transform.position).z)
				arg_256_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["10150ui_story"].transform.localEulerAngles = arg_256_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_256_1.time_ >= 0 + var_259_1 and arg_256_1.time_ < 0 + var_259_1 + arg_259_0 then
				arg_256_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(-0.9, -1.73, -5.5)
				arg_256_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["10150ui_story"].transform.position).z)
				arg_256_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["10150ui_story"].transform.localEulerAngles = arg_256_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_259_2 = GameObjectTools.GetOrAddComponent(arg_256_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_259_2 then
					var_259_2:EnableDynamicBone(true)
				end
			end

			local var_259_3 = arg_256_1.actors_["10150ui_story"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_3) and arg_256_1.var_.characterEffect10150ui_story == nil then
				arg_256_1.var_.characterEffect10150ui_story = var_259_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_4 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_4 and not isNil(var_259_3) then
				if arg_256_1.var_.characterEffect10150ui_story and not isNil(var_259_3) then
					arg_256_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 0 + var_259_4 and arg_256_1.time_ < 0 + var_259_4 + arg_259_0 and not isNil(var_259_3) and arg_256_1.var_.characterEffect10150ui_story then
				arg_256_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_259_6 = arg_256_1.actors_["10103ui_story"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_6) and arg_256_1.var_.characterEffect10103ui_story == nil then
				arg_256_1.var_.characterEffect10103ui_story = var_259_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_7 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_7 and not isNil(var_259_6) then
				if arg_256_1.var_.characterEffect10103ui_story and not isNil(var_259_6) then
					arg_256_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_256_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_256_1.time_ - 0) / var_259_7)
				end
			end

			if arg_256_1.time_ >= 0 + var_259_7 and arg_256_1.time_ < 0 + var_259_7 + arg_259_0 and not isNil(var_259_6) and arg_256_1.var_.characterEffect10103ui_story then
				arg_256_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_256_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_259_8 = arg_256_1.actors_["10103ui_story"].transform

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.var_.moveOldPos10103ui_story = var_259_8.localPosition

				local var_259_9 = GameObjectTools.GetOrAddComponent(var_259_8.gameObject, typeof(DynamicBoneHelper))

				if var_259_9 then
					var_259_9:EnableDynamicBone(false)
				end
			end

			local var_259_10 = 0.001

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_10 then
				var_259_8.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos10103ui_story, Vector3.New(0.7, -0.95, -6.2), (arg_256_1.time_ - 0) / var_259_10)
				var_259_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_259_8.position).x, (manager.ui.mainCamera.transform.position - var_259_8.position).y, (manager.ui.mainCamera.transform.position - var_259_8.position).z)
				var_259_8.localEulerAngles.z = 0
				var_259_8.localEulerAngles.x = 0
				var_259_8.localEulerAngles = var_259_8.localEulerAngles
			end

			if arg_256_1.time_ >= 0 + var_259_10 and arg_256_1.time_ < 0 + var_259_10 + arg_259_0 then
				var_259_8.localPosition = Vector3.New(0.7, -0.95, -6.2)
				var_259_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_259_8.position).x, (manager.ui.mainCamera.transform.position - var_259_8.position).y, (manager.ui.mainCamera.transform.position - var_259_8.position).z)
				var_259_8.localEulerAngles.z = 0
				var_259_8.localEulerAngles.x = 0
				var_259_8.localEulerAngles = var_259_8.localEulerAngles

				local var_259_11 = GameObjectTools.GetOrAddComponent(var_259_8.gameObject, typeof(DynamicBoneHelper))

				if var_259_11 then
					var_259_11:EnableDynamicBone(true)
				end
			end

			local var_259_12 = 0
			local var_259_13 = 0.1

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_12 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_14 = arg_256_1:GetWordFromCfg(322072061)
				local var_259_15 = arg_256_1:FormatText(var_259_14.content)

				arg_256_1.text_.text = var_259_15

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_17 = 4 <= 0 and var_259_13 or var_259_13 * (utf8.len(var_259_15) / 4)

				if (4 <= 0 and var_259_13 or var_259_13 * (utf8.len(var_259_15) / 4)) > 0 and var_259_13 < var_259_17 then
					arg_256_1.talkMaxDuration = var_259_17

					if var_259_17 + var_259_12 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_17 + var_259_12
					end
				end

				arg_256_1.text_.text = var_259_15
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072061", "story_v_out_322072.awb") ~= 0 then
					local var_259_18 = manager.audio:GetVoiceLength("story_v_out_322072", "322072061", "story_v_out_322072.awb") / 1000

					if var_259_18 + var_259_12 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_18 + var_259_12
					end

					if var_259_14.prefab_name ~= "" and arg_256_1.actors_[var_259_14.prefab_name] ~= nil then
						local var_259_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_14.prefab_name].transform, "story_v_out_322072", "322072061", "story_v_out_322072.awb")

						arg_256_1:RecordAudio("322072061", var_259_19)
						arg_256_1:RecordAudio("322072061", var_259_19)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_322072", "322072061", "story_v_out_322072.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_322072", "322072061", "story_v_out_322072.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_20 = math.max(var_259_13, arg_256_1.talkMaxDuration)

			if var_259_12 <= arg_256_1.time_ and arg_256_1.time_ < var_259_12 + var_259_20 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_12) / var_259_20

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_12 + var_259_20 and arg_256_1.time_ < var_259_12 + var_259_20 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play322072062 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 322072062
		arg_260_1.duration_ = 6.77

		local var_260_0 = {
			zh = 4.633,
			ja = 6.766
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play322072063(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos10103ui_story = arg_260_1.actors_["10103ui_story"].transform.localPosition

				local var_263_0 = GameObjectTools.GetOrAddComponent(arg_260_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_263_0 then
					var_263_0:EnableDynamicBone(false)
				end
			end

			local var_263_1 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_1 then
				arg_260_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10103ui_story, Vector3.New(0.7, -0.95, -6.2), (arg_260_1.time_ - 0) / var_263_1)
				arg_260_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["10103ui_story"].transform.position).z)
				arg_260_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["10103ui_story"].transform.localEulerAngles = arg_260_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_260_1.time_ >= 0 + var_263_1 and arg_260_1.time_ < 0 + var_263_1 + arg_263_0 then
				arg_260_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.2)
				arg_260_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["10103ui_story"].transform.position).z)
				arg_260_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["10103ui_story"].transform.localEulerAngles = arg_260_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_263_2 = GameObjectTools.GetOrAddComponent(arg_260_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_263_2 then
					var_263_2:EnableDynamicBone(true)
				end
			end

			local var_263_3 = arg_260_1.actors_["10103ui_story"]

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(var_263_3) and arg_260_1.var_.characterEffect10103ui_story == nil then
				arg_260_1.var_.characterEffect10103ui_story = var_263_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_4 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_4 and not isNil(var_263_3) then
				if arg_260_1.var_.characterEffect10103ui_story and not isNil(var_263_3) then
					arg_260_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= 0 + var_263_4 and arg_260_1.time_ < 0 + var_263_4 + arg_263_0 and not isNil(var_263_3) and arg_260_1.var_.characterEffect10103ui_story then
				arg_260_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_263_6 = arg_260_1.actors_["10150ui_story"]

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(var_263_6) and arg_260_1.var_.characterEffect10150ui_story == nil then
				arg_260_1.var_.characterEffect10150ui_story = var_263_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_7 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_7 and not isNil(var_263_6) then
				if arg_260_1.var_.characterEffect10150ui_story and not isNil(var_263_6) then
					arg_260_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_260_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_260_1.time_ - 0) / var_263_7)
				end
			end

			if arg_260_1.time_ >= 0 + var_263_7 and arg_260_1.time_ < 0 + var_263_7 + arg_263_0 and not isNil(var_263_6) and arg_260_1.var_.characterEffect10150ui_story then
				arg_260_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_260_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action9_2")
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				if not isNil(arg_260_1.actors_["10103ui_story"]) then
					local var_263_8 = GameObjectTools.GetOrAddComponent(arg_260_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_263_8 then
						var_263_8:EnableDynamicBone(true)
					end
				end
			end

			local var_263_9 = 0
			local var_263_10 = 0.475

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_9 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_11 = arg_260_1:GetWordFromCfg(322072062)
				local var_263_12 = arg_260_1:FormatText(var_263_11.content)

				arg_260_1.text_.text = var_263_12

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_14 = 19 <= 0 and var_263_10 or var_263_10 * (utf8.len(var_263_12) / 19)

				if (19 <= 0 and var_263_10 or var_263_10 * (utf8.len(var_263_12) / 19)) > 0 and var_263_10 < var_263_14 then
					arg_260_1.talkMaxDuration = var_263_14

					if var_263_14 + var_263_9 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_14 + var_263_9
					end
				end

				arg_260_1.text_.text = var_263_12
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072062", "story_v_out_322072.awb") ~= 0 then
					local var_263_15 = manager.audio:GetVoiceLength("story_v_out_322072", "322072062", "story_v_out_322072.awb") / 1000

					if var_263_15 + var_263_9 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_15 + var_263_9
					end

					if var_263_11.prefab_name ~= "" and arg_260_1.actors_[var_263_11.prefab_name] ~= nil then
						local var_263_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_11.prefab_name].transform, "story_v_out_322072", "322072062", "story_v_out_322072.awb")

						arg_260_1:RecordAudio("322072062", var_263_16)
						arg_260_1:RecordAudio("322072062", var_263_16)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_322072", "322072062", "story_v_out_322072.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_322072", "322072062", "story_v_out_322072.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_17 = math.max(var_263_10, arg_260_1.talkMaxDuration)

			if var_263_9 <= arg_260_1.time_ and arg_260_1.time_ < var_263_9 + var_263_17 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_9) / var_263_17

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_9 + var_263_17 and arg_260_1.time_ < var_263_9 + var_263_17 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play322072063 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 322072063
		arg_264_1.duration_ = 15.3

		local var_264_0 = {
			zh = 13.733,
			ja = 15.3
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play322072064(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if arg_264_1.bgs_.ST0510 == nil then
				local var_267_0 = Object.Instantiate(arg_264_1.paintGo_)

				var_267_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0510")
				var_267_0.name = "ST0510"
				var_267_0.transform.parent = arg_264_1.stage_.transform
				var_267_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_264_1.bgs_.ST0510 = var_267_0
			end

			if 2 < arg_264_1.time_ and arg_264_1.time_ <= 2 + arg_267_0 then
				local var_267_1 = arg_264_1.bgs_.ST0510

				arg_264_1.bgs_.ST0510.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_267_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_267_2 = var_267_1:GetComponent("SpriteRenderer")

				if var_267_2 and var_267_2.sprite then
					local var_267_3 = 2 * (var_267_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_267_1.transform.localScale = Vector3.New(var_267_3 / var_267_2.sprite.bounds.size.y < var_267_3 * manager.ui.mainCameraCom_.aspect / var_267_2.sprite.bounds.size.x and var_267_3 * manager.ui.mainCameraCom_.aspect / var_267_2.sprite.bounds.size.x or var_267_3 / var_267_2.sprite.bounds.size.y, var_267_3 / var_267_2.sprite.bounds.size.y < var_267_3 * manager.ui.mainCameraCom_.aspect / var_267_2.sprite.bounds.size.x and var_267_3 * manager.ui.mainCameraCom_.aspect / var_267_2.sprite.bounds.size.x or var_267_3 / var_267_2.sprite.bounds.size.y, 0)
				end

				for iter_267_0, iter_267_1 in pairs(arg_264_1.bgs_) do
					if iter_267_0 ~= "ST0510" then
						iter_267_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_267_4 = 4

			if 4 < arg_264_1.time_ and arg_264_1.time_ <= var_267_4 + arg_267_0 then
				arg_264_1.allBtn_.enabled = false
			end

			if arg_264_1.time_ >= var_267_4 + 0.3 and arg_264_1.time_ < var_267_4 + 0.3 + arg_267_0 then
				arg_264_1.allBtn_.enabled = true
			end

			local var_267_5 = 0

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_5 + arg_267_0 then
				arg_264_1.mask_.enabled = true
				arg_264_1.mask_.raycastTarget = true

				arg_264_1:SetGaussion(false)
			end

			local var_267_6 = 2

			if var_267_5 <= arg_264_1.time_ and arg_264_1.time_ < var_267_5 + var_267_6 then
				local var_267_7 = Color.New(0, 0, 0)

				var_267_7.a = Mathf.Lerp(0, 1, (arg_264_1.time_ - var_267_5) / var_267_6)
				arg_264_1.mask_.color = var_267_7
			end

			if arg_264_1.time_ >= var_267_5 + var_267_6 and arg_264_1.time_ < var_267_5 + var_267_6 + arg_267_0 then
				local var_267_8 = Color.New(0, 0, 0)

				var_267_8.a = 1
				arg_264_1.mask_.color = var_267_8
			end

			local var_267_9 = 2

			if 2 < arg_264_1.time_ and arg_264_1.time_ <= var_267_9 + arg_267_0 then
				arg_264_1.mask_.enabled = true
				arg_264_1.mask_.raycastTarget = true

				arg_264_1:SetGaussion(false)
			end

			local var_267_10 = 2

			if var_267_9 <= arg_264_1.time_ and arg_264_1.time_ < var_267_9 + var_267_10 then
				local var_267_11 = Color.New(0, 0, 0)

				var_267_11.a = Mathf.Lerp(1, 0, (arg_264_1.time_ - var_267_9) / var_267_10)
				arg_264_1.mask_.color = var_267_11
			end

			if arg_264_1.time_ >= var_267_9 + var_267_10 and arg_264_1.time_ < var_267_9 + var_267_10 + arg_267_0 then
				local var_267_12 = Color.New(0, 0, 0)

				arg_264_1.mask_.enabled = false
				var_267_12.a = 0
				arg_264_1.mask_.color = var_267_12
			end

			local var_267_13 = arg_264_1.actors_["10103ui_story"].transform

			if 1.96599999815226 < arg_264_1.time_ and arg_264_1.time_ <= 1.96599999815226 + arg_267_0 then
				arg_264_1.var_.moveOldPos10103ui_story = var_267_13.localPosition

				local var_267_14 = GameObjectTools.GetOrAddComponent(var_267_13.gameObject, typeof(DynamicBoneHelper))

				if var_267_14 then
					var_267_14:EnableDynamicBone(false)
				end
			end

			local var_267_15 = 0.001

			if 1.96599999815226 <= arg_264_1.time_ and arg_264_1.time_ < 1.96599999815226 + var_267_15 then
				var_267_13.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_264_1.time_ - 1.96599999815226) / var_267_15)
				var_267_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_267_13.position).x, (manager.ui.mainCamera.transform.position - var_267_13.position).y, (manager.ui.mainCamera.transform.position - var_267_13.position).z)
				var_267_13.localEulerAngles.z = 0
				var_267_13.localEulerAngles.x = 0
				var_267_13.localEulerAngles = var_267_13.localEulerAngles
			end

			if arg_264_1.time_ >= 1.96599999815226 + var_267_15 and arg_264_1.time_ < 1.96599999815226 + var_267_15 + arg_267_0 then
				var_267_13.localPosition = Vector3.New(0, 100, 0)
				var_267_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_267_13.position).x, (manager.ui.mainCamera.transform.position - var_267_13.position).y, (manager.ui.mainCamera.transform.position - var_267_13.position).z)
				var_267_13.localEulerAngles.z = 0
				var_267_13.localEulerAngles.x = 0
				var_267_13.localEulerAngles = var_267_13.localEulerAngles

				local var_267_16 = GameObjectTools.GetOrAddComponent(var_267_13.gameObject, typeof(DynamicBoneHelper))

				if var_267_16 then
					var_267_16:EnableDynamicBone(true)
				end
			end

			local var_267_17 = arg_264_1.actors_["10103ui_story"].transform

			if 3.8 < arg_264_1.time_ and arg_264_1.time_ <= 3.8 + arg_267_0 then
				arg_264_1.var_.moveOldPos10103ui_story = var_267_17.localPosition

				local var_267_18 = GameObjectTools.GetOrAddComponent(var_267_17.gameObject, typeof(DynamicBoneHelper))

				if var_267_18 then
					var_267_18:EnableDynamicBone(false)
				end
			end

			local var_267_19 = 0.001

			if 3.8 <= arg_264_1.time_ and arg_264_1.time_ < 3.8 + var_267_19 then
				var_267_17.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos10103ui_story, Vector3.New(0, -0.95, -6.2), (arg_264_1.time_ - 3.8) / var_267_19)
				var_267_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_267_17.position).x, (manager.ui.mainCamera.transform.position - var_267_17.position).y, (manager.ui.mainCamera.transform.position - var_267_17.position).z)
				var_267_17.localEulerAngles.z = 0
				var_267_17.localEulerAngles.x = 0
				var_267_17.localEulerAngles = var_267_17.localEulerAngles
			end

			if arg_264_1.time_ >= 3.8 + var_267_19 and arg_264_1.time_ < 3.8 + var_267_19 + arg_267_0 then
				var_267_17.localPosition = Vector3.New(0, -0.95, -6.2)
				var_267_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_267_17.position).x, (manager.ui.mainCamera.transform.position - var_267_17.position).y, (manager.ui.mainCamera.transform.position - var_267_17.position).z)
				var_267_17.localEulerAngles.z = 0
				var_267_17.localEulerAngles.x = 0
				var_267_17.localEulerAngles = var_267_17.localEulerAngles

				local var_267_20 = GameObjectTools.GetOrAddComponent(var_267_17.gameObject, typeof(DynamicBoneHelper))

				if var_267_20 then
					var_267_20:EnableDynamicBone(true)
				end
			end

			local var_267_21 = arg_264_1.actors_["10150ui_story"].transform

			if 1.96599999815226 < arg_264_1.time_ and arg_264_1.time_ <= 1.96599999815226 + arg_267_0 then
				arg_264_1.var_.moveOldPos10150ui_story = var_267_21.localPosition

				local var_267_22 = GameObjectTools.GetOrAddComponent(var_267_21.gameObject, typeof(DynamicBoneHelper))

				if var_267_22 then
					var_267_22:EnableDynamicBone(false)
				end
			end

			local var_267_23 = 0.001

			if 1.96599999815226 <= arg_264_1.time_ and arg_264_1.time_ < 1.96599999815226 + var_267_23 then
				var_267_21.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos10150ui_story, Vector3.New(0, 100, 0), (arg_264_1.time_ - 1.96599999815226) / var_267_23)
				var_267_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_267_21.position).x, (manager.ui.mainCamera.transform.position - var_267_21.position).y, (manager.ui.mainCamera.transform.position - var_267_21.position).z)
				var_267_21.localEulerAngles.z = 0
				var_267_21.localEulerAngles.x = 0
				var_267_21.localEulerAngles = var_267_21.localEulerAngles
			end

			if arg_264_1.time_ >= 1.96599999815226 + var_267_23 and arg_264_1.time_ < 1.96599999815226 + var_267_23 + arg_267_0 then
				var_267_21.localPosition = Vector3.New(0, 100, 0)
				var_267_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_267_21.position).x, (manager.ui.mainCamera.transform.position - var_267_21.position).y, (manager.ui.mainCamera.transform.position - var_267_21.position).z)
				var_267_21.localEulerAngles.z = 0
				var_267_21.localEulerAngles.x = 0
				var_267_21.localEulerAngles = var_267_21.localEulerAngles

				local var_267_24 = GameObjectTools.GetOrAddComponent(var_267_21.gameObject, typeof(DynamicBoneHelper))

				if var_267_24 then
					var_267_24:EnableDynamicBone(true)
				end
			end

			if 3.8 < arg_264_1.time_ and arg_264_1.time_ <= 3.8 + arg_267_0 then
				arg_264_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			if 3.8 < arg_264_1.time_ and arg_264_1.time_ <= 3.8 + arg_267_0 then
				arg_264_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0.2 < arg_264_1.time_ and arg_264_1.time_ <= 0.2 + arg_267_0 then
				arg_264_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if 1.56666666666667 < arg_264_1.time_ and arg_264_1.time_ <= 1.56666666666667 + arg_267_0 then
				arg_264_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_data", "")
			end

			local var_267_27 = 1.96599999815226

			arg_264_1.isInRecall_ = false

			if var_267_27 < arg_264_1.time_ and arg_264_1.time_ <= var_267_27 + arg_267_0 then
				arg_264_1.screenFilterGo_:SetActive(false)

				for iter_267_2, iter_267_3 in pairs(arg_264_1.actors_) do
					for iter_267_4, iter_267_5 in ipairs((iter_267_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_267_5.color = iter_267_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_267_28 = 0.0166666666666667

			if var_267_27 <= arg_264_1.time_ and arg_264_1.time_ < var_267_27 + var_267_28 then
				arg_264_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_264_1.time_ - var_267_27) / var_267_28)
			end

			if arg_264_1.time_ >= var_267_27 + var_267_28 and arg_264_1.time_ < var_267_27 + var_267_28 + arg_267_0 then
				arg_264_1.screenFilterEffect_.weight = 0
			end

			local var_267_29 = arg_264_1.actors_["10103ui_story"]

			if 3.83400000184774 < arg_264_1.time_ and arg_264_1.time_ <= 3.83400000184774 + arg_267_0 and not isNil(var_267_29) and arg_264_1.var_.characterEffect10103ui_story == nil then
				arg_264_1.var_.characterEffect10103ui_story = var_267_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_30 = 0.200000002980232

			if 3.83400000184774 <= arg_264_1.time_ and arg_264_1.time_ < 3.83400000184774 + var_267_30 and not isNil(var_267_29) then
				if arg_264_1.var_.characterEffect10103ui_story and not isNil(var_267_29) then
					arg_264_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= 3.83400000184774 + var_267_30 and arg_264_1.time_ < 3.83400000184774 + var_267_30 + arg_267_0 and not isNil(var_267_29) and arg_264_1.var_.characterEffect10103ui_story then
				arg_264_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 3.83400000184774 < arg_264_1.time_ and arg_264_1.time_ <= 3.83400000184774 + arg_267_0 then
				if not isNil(arg_264_1.actors_["10103ui_story"]) then
					local var_267_32 = GameObjectTools.GetOrAddComponent(arg_264_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_267_32 then
						var_267_32:EnableDynamicBone(true)
					end
				end
			end

			if arg_264_1.frameCnt_ <= 1 then
				arg_264_1.dialog_:SetActive(false)
			end

			local var_267_33 = 4
			local var_267_34 = 1.1

			if 4 < arg_264_1.time_ and arg_264_1.time_ <= var_267_33 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0

				arg_264_1.dialog_:SetActive(true)

				arg_264_1.dialogCg_.alpha = 0

				local var_267_35 = LeanTween.value(arg_264_1.dialog_, 0, 1, 0.3)

				var_267_35:setOnUpdate(LuaHelper.FloatAction(function(arg_268_0)
					arg_264_1.dialogCg_.alpha = arg_268_0
				end))
				var_267_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_264_1.dialog_)
					var_267_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_264_1.duration_ = arg_264_1.duration_ + 0.3

				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_36 = arg_264_1:GetWordFromCfg(322072063)
				local var_267_37 = arg_264_1:FormatText(var_267_36.content)

				arg_264_1.text_.text = var_267_37

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_39 = 44 <= 0 and var_267_34 or var_267_34 * (utf8.len(var_267_37) / 44)

				if (44 <= 0 and var_267_34 or var_267_34 * (utf8.len(var_267_37) / 44)) > 0 and var_267_34 < var_267_39 then
					arg_264_1.talkMaxDuration = var_267_39
					var_267_33 = var_267_33 + 0.3

					if var_267_39 + var_267_33 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_39 + var_267_33
					end
				end

				arg_264_1.text_.text = var_267_37
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072063", "story_v_out_322072.awb") ~= 0 then
					local var_267_40 = manager.audio:GetVoiceLength("story_v_out_322072", "322072063", "story_v_out_322072.awb") / 1000

					if var_267_40 + var_267_33 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_40 + var_267_33
					end

					if var_267_36.prefab_name ~= "" and arg_264_1.actors_[var_267_36.prefab_name] ~= nil then
						local var_267_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_36.prefab_name].transform, "story_v_out_322072", "322072063", "story_v_out_322072.awb")

						arg_264_1:RecordAudio("322072063", var_267_41)
						arg_264_1:RecordAudio("322072063", var_267_41)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_322072", "322072063", "story_v_out_322072.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_322072", "322072063", "story_v_out_322072.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_42 = var_267_33 + 0.3
			local var_267_43 = math.max(var_267_34, arg_264_1.talkMaxDuration)

			if var_267_33 + 0.3 <= arg_264_1.time_ and arg_264_1.time_ < var_267_42 + var_267_43 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_42) / var_267_43

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_42 + var_267_43 and arg_264_1.time_ < var_267_42 + var_267_43 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play322072064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 322072064
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play322072065(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0.1 < arg_270_1.time_ and arg_270_1.time_ <= 0.1 + arg_273_0 then
				arg_270_1:AudioAction("play", "effect", "se_story_145", "se_story_145_footstep03", "")
			end

			local var_273_1 = arg_270_1.actors_["10103ui_story"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos10103ui_story = var_273_1.localPosition

				local var_273_2 = GameObjectTools.GetOrAddComponent(var_273_1.gameObject, typeof(DynamicBoneHelper))

				if var_273_2 then
					var_273_2:EnableDynamicBone(false)
				end
			end

			local var_273_3 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_3 then
				var_273_1.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_270_1.time_ - 0) / var_273_3)
				var_273_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_1.position).x, (manager.ui.mainCamera.transform.position - var_273_1.position).y, (manager.ui.mainCamera.transform.position - var_273_1.position).z)
				var_273_1.localEulerAngles.z = 0
				var_273_1.localEulerAngles.x = 0
				var_273_1.localEulerAngles = var_273_1.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_3 and arg_270_1.time_ < 0 + var_273_3 + arg_273_0 then
				var_273_1.localPosition = Vector3.New(0, 100, 0)
				var_273_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_1.position).x, (manager.ui.mainCamera.transform.position - var_273_1.position).y, (manager.ui.mainCamera.transform.position - var_273_1.position).z)
				var_273_1.localEulerAngles.z = 0
				var_273_1.localEulerAngles.x = 0
				var_273_1.localEulerAngles = var_273_1.localEulerAngles

				local var_273_4 = GameObjectTools.GetOrAddComponent(var_273_1.gameObject, typeof(DynamicBoneHelper))

				if var_273_4 then
					var_273_4:EnableDynamicBone(true)
				end
			end

			local var_273_5 = 0
			local var_273_6 = 1.1

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_5 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_7 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(322072064).content)

				arg_270_1.text_.text = var_273_7

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_9 = 44 <= 0 and var_273_6 or var_273_6 * (utf8.len(var_273_7) / 44)

				if (44 <= 0 and var_273_6 or var_273_6 * (utf8.len(var_273_7) / 44)) > 0 and var_273_6 < var_273_9 then
					arg_270_1.talkMaxDuration = var_273_9

					if var_273_9 + var_273_5 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_9 + var_273_5
					end
				end

				arg_270_1.text_.text = var_273_7
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_10 = math.max(var_273_6, arg_270_1.talkMaxDuration)

			if var_273_5 <= arg_270_1.time_ and arg_270_1.time_ < var_273_5 + var_273_10 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_5) / var_273_10

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_5 + var_273_10 and arg_270_1.time_ < var_273_5 + var_273_10 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play322072065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 322072065
		arg_274_1.duration_ = 6.3

		local var_274_0 = {
			zh = 6.3,
			ja = 6.1
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
				arg_274_0:Play322072066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos10103ui_story = arg_274_1.actors_["10103ui_story"].transform.localPosition

				local var_277_0 = GameObjectTools.GetOrAddComponent(arg_274_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_277_0 then
					var_277_0:EnableDynamicBone(false)
				end
			end

			local var_277_1 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_1 then
				arg_274_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos10103ui_story, Vector3.New(0, -0.95, -6.2), (arg_274_1.time_ - 0) / var_277_1)
				arg_274_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["10103ui_story"].transform.position).z)
				arg_274_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["10103ui_story"].transform.localEulerAngles = arg_274_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_274_1.time_ >= 0 + var_277_1 and arg_274_1.time_ < 0 + var_277_1 + arg_277_0 then
				arg_274_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.2)
				arg_274_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["10103ui_story"].transform.position).z)
				arg_274_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["10103ui_story"].transform.localEulerAngles = arg_274_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_277_2 = GameObjectTools.GetOrAddComponent(arg_274_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_277_2 then
					var_277_2:EnableDynamicBone(true)
				end
			end

			local var_277_3 = arg_274_1.actors_["10103ui_story"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_3) and arg_274_1.var_.characterEffect10103ui_story == nil then
				arg_274_1.var_.characterEffect10103ui_story = var_277_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_4 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_4 and not isNil(var_277_3) then
				if arg_274_1.var_.characterEffect10103ui_story and not isNil(var_277_3) then
					arg_274_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= 0 + var_277_4 and arg_274_1.time_ < 0 + var_277_4 + arg_277_0 and not isNil(var_277_3) and arg_274_1.var_.characterEffect10103ui_story then
				arg_274_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_1")
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileD", "EmotionTimelineAnimator")
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				if not isNil(arg_274_1.actors_["10103ui_story"]) then
					local var_277_6 = GameObjectTools.GetOrAddComponent(arg_274_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_277_6 then
						var_277_6:EnableDynamicBone(true)
					end
				end
			end

			local var_277_7 = 0
			local var_277_8 = 0.375

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_7 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_9 = arg_274_1:GetWordFromCfg(322072065)
				local var_277_10 = arg_274_1:FormatText(var_277_9.content)

				arg_274_1.text_.text = var_277_10

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_12 = 15 <= 0 and var_277_8 or var_277_8 * (utf8.len(var_277_10) / 15)

				if (15 <= 0 and var_277_8 or var_277_8 * (utf8.len(var_277_10) / 15)) > 0 and var_277_8 < var_277_12 then
					arg_274_1.talkMaxDuration = var_277_12

					if var_277_12 + var_277_7 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_12 + var_277_7
					end
				end

				arg_274_1.text_.text = var_277_10
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072065", "story_v_out_322072.awb") ~= 0 then
					local var_277_13 = manager.audio:GetVoiceLength("story_v_out_322072", "322072065", "story_v_out_322072.awb") / 1000

					if var_277_13 + var_277_7 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_13 + var_277_7
					end

					if var_277_9.prefab_name ~= "" and arg_274_1.actors_[var_277_9.prefab_name] ~= nil then
						local var_277_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_9.prefab_name].transform, "story_v_out_322072", "322072065", "story_v_out_322072.awb")

						arg_274_1:RecordAudio("322072065", var_277_14)
						arg_274_1:RecordAudio("322072065", var_277_14)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_322072", "322072065", "story_v_out_322072.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_322072", "322072065", "story_v_out_322072.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_15 = math.max(var_277_8, arg_274_1.talkMaxDuration)

			if var_277_7 <= arg_274_1.time_ and arg_274_1.time_ < var_277_7 + var_277_15 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_7) / var_277_15

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_7 + var_277_15 and arg_274_1.time_ < var_277_7 + var_277_15 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play322072066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 322072066
		arg_278_1.duration_ = 15.47

		local var_278_0 = {
			zh = 10.966,
			ja = 15.466
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play322072067(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_281_0 = 0
			local var_281_1 = 1.2

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_2 = arg_278_1:GetWordFromCfg(322072066)
				local var_281_3 = arg_278_1:FormatText(var_281_2.content)

				arg_278_1.text_.text = var_281_3

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 48 <= 0 and var_281_1 or var_281_1 * (utf8.len(var_281_3) / 48)

				if (48 <= 0 and var_281_1 or var_281_1 * (utf8.len(var_281_3) / 48)) > 0 and var_281_1 < var_281_5 then
					arg_278_1.talkMaxDuration = var_281_5

					if var_281_5 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_5 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_3
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072066", "story_v_out_322072.awb") ~= 0 then
					local var_281_6 = manager.audio:GetVoiceLength("story_v_out_322072", "322072066", "story_v_out_322072.awb") / 1000

					if var_281_6 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_6 + var_281_0
					end

					if var_281_2.prefab_name ~= "" and arg_278_1.actors_[var_281_2.prefab_name] ~= nil then
						local var_281_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_2.prefab_name].transform, "story_v_out_322072", "322072066", "story_v_out_322072.awb")

						arg_278_1:RecordAudio("322072066", var_281_7)
						arg_278_1:RecordAudio("322072066", var_281_7)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_322072", "322072066", "story_v_out_322072.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_322072", "322072066", "story_v_out_322072.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_8 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_8 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_8

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_8 and arg_278_1.time_ < var_281_0 + var_281_8 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play322072067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 322072067
		arg_282_1.duration_ = 11.27

		local var_282_0 = {
			zh = 11.266,
			ja = 10.366
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play322072068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_2")
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				if not isNil(arg_282_1.actors_["10103ui_story"]) then
					local var_285_0 = GameObjectTools.GetOrAddComponent(arg_282_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_285_0 then
						var_285_0:EnableDynamicBone(true)
					end
				end
			end

			local var_285_1 = 0
			local var_285_2 = 0.95

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_3 = arg_282_1:GetWordFromCfg(322072067)
				local var_285_4 = arg_282_1:FormatText(var_285_3.content)

				arg_282_1.text_.text = var_285_4

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_6 = 38 <= 0 and var_285_2 or var_285_2 * (utf8.len(var_285_4) / 38)

				if (38 <= 0 and var_285_2 or var_285_2 * (utf8.len(var_285_4) / 38)) > 0 and var_285_2 < var_285_6 then
					arg_282_1.talkMaxDuration = var_285_6

					if var_285_6 + var_285_1 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_6 + var_285_1
					end
				end

				arg_282_1.text_.text = var_285_4
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072067", "story_v_out_322072.awb") ~= 0 then
					local var_285_7 = manager.audio:GetVoiceLength("story_v_out_322072", "322072067", "story_v_out_322072.awb") / 1000

					if var_285_7 + var_285_1 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_7 + var_285_1
					end

					if var_285_3.prefab_name ~= "" and arg_282_1.actors_[var_285_3.prefab_name] ~= nil then
						local var_285_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_3.prefab_name].transform, "story_v_out_322072", "322072067", "story_v_out_322072.awb")

						arg_282_1:RecordAudio("322072067", var_285_8)
						arg_282_1:RecordAudio("322072067", var_285_8)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_322072", "322072067", "story_v_out_322072.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_322072", "322072067", "story_v_out_322072.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_9 = math.max(var_285_2, arg_282_1.talkMaxDuration)

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_9 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_1) / var_285_9

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_1 + var_285_9 and arg_282_1.time_ < var_285_1 + var_285_9 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play322072068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 322072068
		arg_286_1.duration_ = 6.33

		local var_286_0 = {
			zh = 5.166,
			ja = 6.333
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
				arg_286_0:Play322072069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_289_0 = 0
			local var_289_1 = 0.625

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_2 = arg_286_1:GetWordFromCfg(322072068)
				local var_289_3 = arg_286_1:FormatText(var_289_2.content)

				arg_286_1.text_.text = var_289_3

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 25 <= 0 and var_289_1 or var_289_1 * (utf8.len(var_289_3) / 25)

				if (25 <= 0 and var_289_1 or var_289_1 * (utf8.len(var_289_3) / 25)) > 0 and var_289_1 < var_289_5 then
					arg_286_1.talkMaxDuration = var_289_5

					if var_289_5 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_5 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_3
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072068", "story_v_out_322072.awb") ~= 0 then
					local var_289_6 = manager.audio:GetVoiceLength("story_v_out_322072", "322072068", "story_v_out_322072.awb") / 1000

					if var_289_6 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_6 + var_289_0
					end

					if var_289_2.prefab_name ~= "" and arg_286_1.actors_[var_289_2.prefab_name] ~= nil then
						local var_289_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_2.prefab_name].transform, "story_v_out_322072", "322072068", "story_v_out_322072.awb")

						arg_286_1:RecordAudio("322072068", var_289_7)
						arg_286_1:RecordAudio("322072068", var_289_7)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_322072", "322072068", "story_v_out_322072.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_322072", "322072068", "story_v_out_322072.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_8 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_8 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_8

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_8 and arg_286_1.time_ < var_289_0 + var_289_8 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play322072069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 322072069
		arg_290_1.duration_ = 2.7

		local var_290_0 = {
			zh = 2.7,
			ja = 2.266
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
				arg_290_0:Play322072070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.var_.moveOldPos1089ui_story = arg_290_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_293_0 = 0.001

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 then
				arg_290_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos1089ui_story, Vector3.New(0.7, -1.1, -6.17), (arg_290_1.time_ - 0) / var_293_0)
				arg_290_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_290_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1089ui_story"].transform.position).z)
				arg_290_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_290_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_290_1.actors_["1089ui_story"].transform.localEulerAngles = arg_290_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 then
				arg_290_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0.7, -1.1, -6.17)
				arg_290_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_290_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1089ui_story"].transform.position).z)
				arg_290_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_290_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_290_1.actors_["1089ui_story"].transform.localEulerAngles = arg_290_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_293_1 = arg_290_1.actors_["10103ui_story"].transform

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.var_.moveOldPos10103ui_story = var_293_1.localPosition

				local var_293_2 = GameObjectTools.GetOrAddComponent(var_293_1.gameObject, typeof(DynamicBoneHelper))

				if var_293_2 then
					var_293_2:EnableDynamicBone(false)
				end
			end

			local var_293_3 = 0.001

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_3 then
				var_293_1.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos10103ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_290_1.time_ - 0) / var_293_3)
				var_293_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_293_1.position).x, (manager.ui.mainCamera.transform.position - var_293_1.position).y, (manager.ui.mainCamera.transform.position - var_293_1.position).z)
				var_293_1.localEulerAngles.z = 0
				var_293_1.localEulerAngles.x = 0
				var_293_1.localEulerAngles = var_293_1.localEulerAngles
			end

			if arg_290_1.time_ >= 0 + var_293_3 and arg_290_1.time_ < 0 + var_293_3 + arg_293_0 then
				var_293_1.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				var_293_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_293_1.position).x, (manager.ui.mainCamera.transform.position - var_293_1.position).y, (manager.ui.mainCamera.transform.position - var_293_1.position).z)
				var_293_1.localEulerAngles.z = 0
				var_293_1.localEulerAngles.x = 0
				var_293_1.localEulerAngles = var_293_1.localEulerAngles

				local var_293_4 = GameObjectTools.GetOrAddComponent(var_293_1.gameObject, typeof(DynamicBoneHelper))

				if var_293_4 then
					var_293_4:EnableDynamicBone(true)
				end
			end

			local var_293_5 = arg_290_1.actors_["1089ui_story"]

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(var_293_5) and arg_290_1.var_.characterEffect1089ui_story == nil then
				arg_290_1.var_.characterEffect1089ui_story = var_293_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_6 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_6 and not isNil(var_293_5) then
				if arg_290_1.var_.characterEffect1089ui_story and not isNil(var_293_5) then
					arg_290_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= 0 + var_293_6 and arg_290_1.time_ < 0 + var_293_6 + arg_293_0 and not isNil(var_293_5) and arg_290_1.var_.characterEffect1089ui_story then
				arg_290_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_293_8 = arg_290_1.actors_["10103ui_story"]

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(var_293_8) and arg_290_1.var_.characterEffect10103ui_story == nil then
				arg_290_1.var_.characterEffect10103ui_story = var_293_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_9 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_9 and not isNil(var_293_8) then
				if arg_290_1.var_.characterEffect10103ui_story and not isNil(var_293_8) then
					arg_290_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_290_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_290_1.time_ - 0) / var_293_9)
				end
			end

			if arg_290_1.time_ >= 0 + var_293_9 and arg_290_1.time_ < 0 + var_293_9 + arg_293_0 and not isNil(var_293_8) and arg_290_1.var_.characterEffect10103ui_story then
				arg_290_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_290_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_293_10 = 0
			local var_293_11 = 0.25

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_10 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_12 = arg_290_1:GetWordFromCfg(322072069)
				local var_293_13 = arg_290_1:FormatText(var_293_12.content)

				arg_290_1.text_.text = var_293_13

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_15 = 10 <= 0 and var_293_11 or var_293_11 * (utf8.len(var_293_13) / 10)

				if (10 <= 0 and var_293_11 or var_293_11 * (utf8.len(var_293_13) / 10)) > 0 and var_293_11 < var_293_15 then
					arg_290_1.talkMaxDuration = var_293_15

					if var_293_15 + var_293_10 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_15 + var_293_10
					end
				end

				arg_290_1.text_.text = var_293_13
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072069", "story_v_out_322072.awb") ~= 0 then
					local var_293_16 = manager.audio:GetVoiceLength("story_v_out_322072", "322072069", "story_v_out_322072.awb") / 1000

					if var_293_16 + var_293_10 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_16 + var_293_10
					end

					if var_293_12.prefab_name ~= "" and arg_290_1.actors_[var_293_12.prefab_name] ~= nil then
						local var_293_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_12.prefab_name].transform, "story_v_out_322072", "322072069", "story_v_out_322072.awb")

						arg_290_1:RecordAudio("322072069", var_293_17)
						arg_290_1:RecordAudio("322072069", var_293_17)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_322072", "322072069", "story_v_out_322072.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_322072", "322072069", "story_v_out_322072.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_18 = math.max(var_293_11, arg_290_1.talkMaxDuration)

			if var_293_10 <= arg_290_1.time_ and arg_290_1.time_ < var_293_10 + var_293_18 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_10) / var_293_18

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_10 + var_293_18 and arg_290_1.time_ < var_293_10 + var_293_18 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
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
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play322072070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 322072070
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play322072071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos1089ui_story = arg_294_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_297_0 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 then
				arg_294_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_294_1.time_ - 0) / var_297_0)
				arg_294_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_294_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1089ui_story"].transform.position).z)
				arg_294_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_294_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_294_1.actors_["1089ui_story"].transform.localEulerAngles = arg_294_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 then
				arg_294_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_294_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_294_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1089ui_story"].transform.position).z)
				arg_294_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_294_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_294_1.actors_["1089ui_story"].transform.localEulerAngles = arg_294_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_297_1 = arg_294_1.actors_["10103ui_story"].transform

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos10103ui_story = var_297_1.localPosition

				local var_297_2 = GameObjectTools.GetOrAddComponent(var_297_1.gameObject, typeof(DynamicBoneHelper))

				if var_297_2 then
					var_297_2:EnableDynamicBone(false)
				end
			end

			local var_297_3 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_3 then
				var_297_1.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_294_1.time_ - 0) / var_297_3)
				var_297_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_297_1.position).x, (manager.ui.mainCamera.transform.position - var_297_1.position).y, (manager.ui.mainCamera.transform.position - var_297_1.position).z)
				var_297_1.localEulerAngles.z = 0
				var_297_1.localEulerAngles.x = 0
				var_297_1.localEulerAngles = var_297_1.localEulerAngles
			end

			if arg_294_1.time_ >= 0 + var_297_3 and arg_294_1.time_ < 0 + var_297_3 + arg_297_0 then
				var_297_1.localPosition = Vector3.New(0, 100, 0)
				var_297_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_297_1.position).x, (manager.ui.mainCamera.transform.position - var_297_1.position).y, (manager.ui.mainCamera.transform.position - var_297_1.position).z)
				var_297_1.localEulerAngles.z = 0
				var_297_1.localEulerAngles.x = 0
				var_297_1.localEulerAngles = var_297_1.localEulerAngles

				local var_297_4 = GameObjectTools.GetOrAddComponent(var_297_1.gameObject, typeof(DynamicBoneHelper))

				if var_297_4 then
					var_297_4:EnableDynamicBone(true)
				end
			end

			local var_297_5 = 0
			local var_297_6 = 1.175

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_5 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_7 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(322072070).content)

				arg_294_1.text_.text = var_297_7

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_9 = 47 <= 0 and var_297_6 or var_297_6 * (utf8.len(var_297_7) / 47)

				if (47 <= 0 and var_297_6 or var_297_6 * (utf8.len(var_297_7) / 47)) > 0 and var_297_6 < var_297_9 then
					arg_294_1.talkMaxDuration = var_297_9

					if var_297_9 + var_297_5 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_9 + var_297_5
					end
				end

				arg_294_1.text_.text = var_297_7
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_10 = math.max(var_297_6, arg_294_1.talkMaxDuration)

			if var_297_5 <= arg_294_1.time_ and arg_294_1.time_ < var_297_5 + var_297_10 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_5) / var_297_10

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_5 + var_297_10 and arg_294_1.time_ < var_297_5 + var_297_10 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
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
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play322072071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 322072071
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play322072072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_9000

			if 0.1 < arg_298_1.time_ and arg_298_1.time_ <= 0.1 + arg_301_0 then
				arg_298_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_scan", "")
			end

			if 0.1 < arg_298_1.time_ and arg_298_1.time_ <= 0.1 + arg_301_0 then
				local var_301_1 = arg_298_1.var_.effect2071

				if not arg_298_1.var_.effect2071 then
					var_301_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_scan_in_out"), manager.ui.mainCamera.transform)
					var_301_1.name = "2071"
					arg_298_1.var_.effect2071 = var_301_1
				else
					var_301_1.transform:SetParent(var_301_9000)
				end

				var_301_1.transform.localPosition = Vector3.New(0, 0, -2.25)
				var_301_1.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_301_3 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_301_4 = var_301_1.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_301_0, iter_301_1 in ipairs((var_301_4:ToTable())) do
					iter_301_1.transform.localScale = Vector3.New(iter_301_1.transform.localScale.x / var_301_3 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_301_4 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_301_1.transform.localScale.y / var_301_3, iter_301_1.transform.localScale.z)
				end
			end

			local var_301_6 = 0
			local var_301_7 = 1.2

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_6 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_8 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(322072071).content)

				arg_298_1.text_.text = var_301_8

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_10 = 48 <= 0 and var_301_7 or var_301_7 * (utf8.len(var_301_8) / 48)

				if (48 <= 0 and var_301_7 or var_301_7 * (utf8.len(var_301_8) / 48)) > 0 and var_301_7 < var_301_10 then
					arg_298_1.talkMaxDuration = var_301_10

					if var_301_10 + var_301_6 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_10 + var_301_6
					end
				end

				arg_298_1.text_.text = var_301_8
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_11 = math.max(var_301_7, arg_298_1.talkMaxDuration)

			if var_301_6 <= arg_298_1.time_ and arg_298_1.time_ < var_301_6 + var_301_11 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_6) / var_301_11

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_6 + var_301_11 and arg_298_1.time_ < var_301_6 + var_301_11 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play322072072 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 322072072
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play322072073(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0.1 < arg_302_1.time_ and arg_302_1.time_ <= 0.1 + arg_305_0 then
				arg_302_1:AudioAction("play", "effect", "se_story_145", "se_story_145_summon_launcher", "")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				if arg_302_1.var_.effect2071 then
					Object.Destroy(arg_302_1.var_.effect2071)

					arg_302_1.var_.effect2071 = nil
				end
			end

			local var_305_2 = 0
			local var_305_3 = 1.4

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_2 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_4 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(322072072).content)

				arg_302_1.text_.text = var_305_4

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_6 = 56 <= 0 and var_305_3 or var_305_3 * (utf8.len(var_305_4) / 56)

				if (56 <= 0 and var_305_3 or var_305_3 * (utf8.len(var_305_4) / 56)) > 0 and var_305_3 < var_305_6 then
					arg_302_1.talkMaxDuration = var_305_6

					if var_305_6 + var_305_2 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_6 + var_305_2
					end
				end

				arg_302_1.text_.text = var_305_4
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_7 = math.max(var_305_3, arg_302_1.talkMaxDuration)

			if var_305_2 <= arg_302_1.time_ and arg_302_1.time_ < var_305_2 + var_305_7 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_2) / var_305_7

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_2 + var_305_7 and arg_302_1.time_ < var_305_2 + var_305_7 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play322072073 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 322072073
		arg_306_1.duration_ = 2.13

		local var_306_0 = {
			zh = 1.999999999999,
			ja = 2.133
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play322072074(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos10103ui_story = arg_306_1.actors_["10103ui_story"].transform.localPosition

				local var_309_0 = GameObjectTools.GetOrAddComponent(arg_306_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_309_0 then
					var_309_0:EnableDynamicBone(false)
				end
			end

			local var_309_1 = 0.001

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_1 then
				arg_306_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos10103ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_306_1.time_ - 0) / var_309_1)
				arg_306_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_306_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["10103ui_story"].transform.position).z)
				arg_306_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_306_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_306_1.actors_["10103ui_story"].transform.localEulerAngles = arg_306_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_306_1.time_ >= 0 + var_309_1 and arg_306_1.time_ < 0 + var_309_1 + arg_309_0 then
				arg_306_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_306_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_306_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["10103ui_story"].transform.position).z)
				arg_306_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_306_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_306_1.actors_["10103ui_story"].transform.localEulerAngles = arg_306_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_309_2 = GameObjectTools.GetOrAddComponent(arg_306_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_309_2 then
					var_309_2:EnableDynamicBone(true)
				end
			end

			local var_309_3 = arg_306_1.actors_["10103ui_story"]

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(var_309_3) and arg_306_1.var_.characterEffect10103ui_story == nil then
				arg_306_1.var_.characterEffect10103ui_story = var_309_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_4 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_4 and not isNil(var_309_3) then
				if arg_306_1.var_.characterEffect10103ui_story and not isNil(var_309_3) then
					arg_306_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_306_1.time_ >= 0 + var_309_4 and arg_306_1.time_ < 0 + var_309_4 + arg_309_0 and not isNil(var_309_3) and arg_306_1.var_.characterEffect10103ui_story then
				arg_306_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_1")
			end

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				if not isNil(arg_306_1.actors_["10103ui_story"]) then
					local var_309_6 = GameObjectTools.GetOrAddComponent(arg_306_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_309_6 then
						var_309_6:EnableDynamicBone(true)
					end
				end
			end

			local var_309_7 = 0
			local var_309_8 = 0.125

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_7 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_9 = arg_306_1:GetWordFromCfg(322072073)
				local var_309_10 = arg_306_1:FormatText(var_309_9.content)

				arg_306_1.text_.text = var_309_10

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_12 = 5 <= 0 and var_309_8 or var_309_8 * (utf8.len(var_309_10) / 5)

				if (5 <= 0 and var_309_8 or var_309_8 * (utf8.len(var_309_10) / 5)) > 0 and var_309_8 < var_309_12 then
					arg_306_1.talkMaxDuration = var_309_12

					if var_309_12 + var_309_7 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_12 + var_309_7
					end
				end

				arg_306_1.text_.text = var_309_10
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072073", "story_v_out_322072.awb") ~= 0 then
					local var_309_13 = manager.audio:GetVoiceLength("story_v_out_322072", "322072073", "story_v_out_322072.awb") / 1000

					if var_309_13 + var_309_7 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_13 + var_309_7
					end

					if var_309_9.prefab_name ~= "" and arg_306_1.actors_[var_309_9.prefab_name] ~= nil then
						local var_309_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_9.prefab_name].transform, "story_v_out_322072", "322072073", "story_v_out_322072.awb")

						arg_306_1:RecordAudio("322072073", var_309_14)
						arg_306_1:RecordAudio("322072073", var_309_14)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_322072", "322072073", "story_v_out_322072.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_322072", "322072073", "story_v_out_322072.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_15 = math.max(var_309_8, arg_306_1.talkMaxDuration)

			if var_309_7 <= arg_306_1.time_ and arg_306_1.time_ < var_309_7 + var_309_15 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_7) / var_309_15

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_7 + var_309_15 and arg_306_1.time_ < var_309_7 + var_309_15 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play322072074 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 322072074
		arg_310_1.duration_ = 17.87

		local var_310_0 = {
			zh = 9.633,
			ja = 17.866
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
				arg_310_0:Play322072075(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.moveOldPos1089ui_story = arg_310_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_313_0 = 0.001

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 then
				arg_310_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos1089ui_story, Vector3.New(0.7, -1.1, -6.17), (arg_310_1.time_ - 0) / var_313_0)
				arg_310_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_310_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["1089ui_story"].transform.position).z)
				arg_310_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_310_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_310_1.actors_["1089ui_story"].transform.localEulerAngles = arg_310_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 then
				arg_310_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0.7, -1.1, -6.17)
				arg_310_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_310_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["1089ui_story"].transform.position).z)
				arg_310_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_310_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_310_1.actors_["1089ui_story"].transform.localEulerAngles = arg_310_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_313_1 = arg_310_1.actors_["1089ui_story"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_1) and arg_310_1.var_.characterEffect1089ui_story == nil then
				arg_310_1.var_.characterEffect1089ui_story = var_313_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_2 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_2 and not isNil(var_313_1) then
				if arg_310_1.var_.characterEffect1089ui_story and not isNil(var_313_1) then
					arg_310_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= 0 + var_313_2 and arg_310_1.time_ < 0 + var_313_2 + arg_313_0 and not isNil(var_313_1) and arg_310_1.var_.characterEffect1089ui_story then
				arg_310_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_313_4 = arg_310_1.actors_["10103ui_story"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_4) and arg_310_1.var_.characterEffect10103ui_story == nil then
				arg_310_1.var_.characterEffect10103ui_story = var_313_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_5 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_5 and not isNil(var_313_4) then
				if arg_310_1.var_.characterEffect10103ui_story and not isNil(var_313_4) then
					arg_310_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_310_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_310_1.time_ - 0) / var_313_5)
				end
			end

			if arg_310_1.time_ >= 0 + var_313_5 and arg_310_1.time_ < 0 + var_313_5 + arg_313_0 and not isNil(var_313_4) and arg_310_1.var_.characterEffect10103ui_story then
				arg_310_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_310_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_313_6 = 0
			local var_313_7 = 1.125

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_6 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_8 = arg_310_1:GetWordFromCfg(322072074)
				local var_313_9 = arg_310_1:FormatText(var_313_8.content)

				arg_310_1.text_.text = var_313_9

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_11 = 45 <= 0 and var_313_7 or var_313_7 * (utf8.len(var_313_9) / 45)

				if (45 <= 0 and var_313_7 or var_313_7 * (utf8.len(var_313_9) / 45)) > 0 and var_313_7 < var_313_11 then
					arg_310_1.talkMaxDuration = var_313_11

					if var_313_11 + var_313_6 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_11 + var_313_6
					end
				end

				arg_310_1.text_.text = var_313_9
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072074", "story_v_out_322072.awb") ~= 0 then
					local var_313_12 = manager.audio:GetVoiceLength("story_v_out_322072", "322072074", "story_v_out_322072.awb") / 1000

					if var_313_12 + var_313_6 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_12 + var_313_6
					end

					if var_313_8.prefab_name ~= "" and arg_310_1.actors_[var_313_8.prefab_name] ~= nil then
						local var_313_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_8.prefab_name].transform, "story_v_out_322072", "322072074", "story_v_out_322072.awb")

						arg_310_1:RecordAudio("322072074", var_313_13)
						arg_310_1:RecordAudio("322072074", var_313_13)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_322072", "322072074", "story_v_out_322072.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_322072", "322072074", "story_v_out_322072.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_14 = math.max(var_313_7, arg_310_1.talkMaxDuration)

			if var_313_6 <= arg_310_1.time_ and arg_310_1.time_ < var_313_6 + var_313_14 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_6) / var_313_14

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_6 + var_313_14 and arg_310_1.time_ < var_313_6 + var_313_14 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
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

		arg_310_1:InitPlayNodeList()
	end,
	Play322072075 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 322072075
		arg_314_1.duration_ = 10.7

		local var_314_0 = {
			zh = 5.466,
			ja = 10.7
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
				arg_314_0:Play322072076(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0.625

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_1 = arg_314_1:GetWordFromCfg(322072075)
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

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072075", "story_v_out_322072.awb") ~= 0 then
					local var_317_5 = manager.audio:GetVoiceLength("story_v_out_322072", "322072075", "story_v_out_322072.awb") / 1000

					if var_317_5 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + 0
					end

					if var_317_1.prefab_name ~= "" and arg_314_1.actors_[var_317_1.prefab_name] ~= nil then
						local var_317_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_1.prefab_name].transform, "story_v_out_322072", "322072075", "story_v_out_322072.awb")

						arg_314_1:RecordAudio("322072075", var_317_6)
						arg_314_1:RecordAudio("322072075", var_317_6)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_322072", "322072075", "story_v_out_322072.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_322072", "322072075", "story_v_out_322072.awb")
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
	Play322072076 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 322072076
		arg_318_1.duration_ = 13.87

		local var_318_0 = {
			zh = 9.2,
			ja = 13.866
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
				arg_318_0:Play322072077(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_321_0 = 0
			local var_321_1 = 0.975

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_2 = arg_318_1:GetWordFromCfg(322072076)
				local var_321_3 = arg_318_1:FormatText(var_321_2.content)

				arg_318_1.text_.text = var_321_3

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 39 <= 0 and var_321_1 or var_321_1 * (utf8.len(var_321_3) / 39)

				if (39 <= 0 and var_321_1 or var_321_1 * (utf8.len(var_321_3) / 39)) > 0 and var_321_1 < var_321_5 then
					arg_318_1.talkMaxDuration = var_321_5

					if var_321_5 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_5 + var_321_0
					end
				end

				arg_318_1.text_.text = var_321_3
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072076", "story_v_out_322072.awb") ~= 0 then
					local var_321_6 = manager.audio:GetVoiceLength("story_v_out_322072", "322072076", "story_v_out_322072.awb") / 1000

					if var_321_6 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_6 + var_321_0
					end

					if var_321_2.prefab_name ~= "" and arg_318_1.actors_[var_321_2.prefab_name] ~= nil then
						local var_321_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_2.prefab_name].transform, "story_v_out_322072", "322072076", "story_v_out_322072.awb")

						arg_318_1:RecordAudio("322072076", var_321_7)
						arg_318_1:RecordAudio("322072076", var_321_7)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_322072", "322072076", "story_v_out_322072.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_322072", "322072076", "story_v_out_322072.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_8 = math.max(var_321_1, arg_318_1.talkMaxDuration)

			if var_321_0 <= arg_318_1.time_ and arg_318_1.time_ < var_321_0 + var_321_8 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_0) / var_321_8

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_0 + var_321_8 and arg_318_1.time_ < var_321_0 + var_321_8 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play322072077 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 322072077
		arg_322_1.duration_ = 10.9

		local var_322_0 = {
			zh = 8.533,
			ja = 10.9
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play322072078(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.var_.moveOldPos10103ui_story = arg_322_1.actors_["10103ui_story"].transform.localPosition

				local var_325_0 = GameObjectTools.GetOrAddComponent(arg_322_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_325_0 then
					var_325_0:EnableDynamicBone(false)
				end
			end

			local var_325_1 = 0.001

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_1 then
				arg_322_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos10103ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_322_1.time_ - 0) / var_325_1)
				arg_322_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_322_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["10103ui_story"].transform.position).z)
				arg_322_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_322_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_322_1.actors_["10103ui_story"].transform.localEulerAngles = arg_322_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_322_1.time_ >= 0 + var_325_1 and arg_322_1.time_ < 0 + var_325_1 + arg_325_0 then
				arg_322_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_322_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_322_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["10103ui_story"].transform.position).z)
				arg_322_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_322_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_322_1.actors_["10103ui_story"].transform.localEulerAngles = arg_322_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_325_2 = GameObjectTools.GetOrAddComponent(arg_322_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_325_2 then
					var_325_2:EnableDynamicBone(true)
				end
			end

			local var_325_3 = arg_322_1.actors_["10103ui_story"]

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(var_325_3) and arg_322_1.var_.characterEffect10103ui_story == nil then
				arg_322_1.var_.characterEffect10103ui_story = var_325_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_4 = 0.200000002980232

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_4 and not isNil(var_325_3) then
				if arg_322_1.var_.characterEffect10103ui_story and not isNil(var_325_3) then
					arg_322_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= 0 + var_325_4 and arg_322_1.time_ < 0 + var_325_4 + arg_325_0 and not isNil(var_325_3) and arg_322_1.var_.characterEffect10103ui_story then
				arg_322_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_325_6 = arg_322_1.actors_["1089ui_story"]

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(var_325_6) and arg_322_1.var_.characterEffect1089ui_story == nil then
				arg_322_1.var_.characterEffect1089ui_story = var_325_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_7 = 0.200000002980232

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_7 and not isNil(var_325_6) then
				if arg_322_1.var_.characterEffect1089ui_story and not isNil(var_325_6) then
					arg_322_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_322_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_322_1.time_ - 0) / var_325_7)
				end
			end

			if arg_322_1.time_ >= 0 + var_325_7 and arg_322_1.time_ < 0 + var_325_7 + arg_325_0 and not isNil(var_325_6) and arg_322_1.var_.characterEffect1089ui_story then
				arg_322_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_322_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_2")
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				if not isNil(arg_322_1.actors_["10103ui_story"]) then
					local var_325_8 = GameObjectTools.GetOrAddComponent(arg_322_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_325_8 then
						var_325_8:EnableDynamicBone(true)
					end
				end
			end

			local var_325_9 = 0
			local var_325_10 = 0.775

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_9 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_11 = arg_322_1:GetWordFromCfg(322072077)
				local var_325_12 = arg_322_1:FormatText(var_325_11.content)

				arg_322_1.text_.text = var_325_12

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_14 = 31 <= 0 and var_325_10 or var_325_10 * (utf8.len(var_325_12) / 31)

				if (31 <= 0 and var_325_10 or var_325_10 * (utf8.len(var_325_12) / 31)) > 0 and var_325_10 < var_325_14 then
					arg_322_1.talkMaxDuration = var_325_14

					if var_325_14 + var_325_9 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_14 + var_325_9
					end
				end

				arg_322_1.text_.text = var_325_12
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072077", "story_v_out_322072.awb") ~= 0 then
					local var_325_15 = manager.audio:GetVoiceLength("story_v_out_322072", "322072077", "story_v_out_322072.awb") / 1000

					if var_325_15 + var_325_9 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_15 + var_325_9
					end

					if var_325_11.prefab_name ~= "" and arg_322_1.actors_[var_325_11.prefab_name] ~= nil then
						local var_325_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_11.prefab_name].transform, "story_v_out_322072", "322072077", "story_v_out_322072.awb")

						arg_322_1:RecordAudio("322072077", var_325_16)
						arg_322_1:RecordAudio("322072077", var_325_16)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_322072", "322072077", "story_v_out_322072.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_322072", "322072077", "story_v_out_322072.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_17 = math.max(var_325_10, arg_322_1.talkMaxDuration)

			if var_325_9 <= arg_322_1.time_ and arg_322_1.time_ < var_325_9 + var_325_17 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_9) / var_325_17

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_9 + var_325_17 and arg_322_1.time_ < var_325_9 + var_325_17 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_322_1:InitPlayNodeList()
	end,
	Play322072078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 322072078
		arg_326_1.duration_ = 10.7

		local var_326_0 = {
			zh = 7.8,
			ja = 10.7
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
				arg_326_0:Play322072079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos1089ui_story = arg_326_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_329_0 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 then
				arg_326_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1089ui_story, Vector3.New(0.7, -1.1, -6.17), (arg_326_1.time_ - 0) / var_329_0)
				arg_326_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["1089ui_story"].transform.position).z)
				arg_326_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["1089ui_story"].transform.localEulerAngles = arg_326_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 then
				arg_326_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0.7, -1.1, -6.17)
				arg_326_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["1089ui_story"].transform.position).z)
				arg_326_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["1089ui_story"].transform.localEulerAngles = arg_326_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_329_1 = arg_326_1.actors_["1089ui_story"]

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(var_329_1) and arg_326_1.var_.characterEffect1089ui_story == nil then
				arg_326_1.var_.characterEffect1089ui_story = var_329_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_2 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_2 and not isNil(var_329_1) then
				if arg_326_1.var_.characterEffect1089ui_story and not isNil(var_329_1) then
					arg_326_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= 0 + var_329_2 and arg_326_1.time_ < 0 + var_329_2 + arg_329_0 and not isNil(var_329_1) and arg_326_1.var_.characterEffect1089ui_story then
				arg_326_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_329_4 = arg_326_1.actors_["10103ui_story"]

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(var_329_4) and arg_326_1.var_.characterEffect10103ui_story == nil then
				arg_326_1.var_.characterEffect10103ui_story = var_329_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_5 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_5 and not isNil(var_329_4) then
				if arg_326_1.var_.characterEffect10103ui_story and not isNil(var_329_4) then
					arg_326_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_326_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_326_1.time_ - 0) / var_329_5)
				end
			end

			if arg_326_1.time_ >= 0 + var_329_5 and arg_326_1.time_ < 0 + var_329_5 + arg_329_0 and not isNil(var_329_4) and arg_326_1.var_.characterEffect10103ui_story then
				arg_326_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_326_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_2")
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_329_6 = 0
			local var_329_7 = 0.85

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_6 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_8 = arg_326_1:GetWordFromCfg(322072078)
				local var_329_9 = arg_326_1:FormatText(var_329_8.content)

				arg_326_1.text_.text = var_329_9

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_11 = 34 <= 0 and var_329_7 or var_329_7 * (utf8.len(var_329_9) / 34)

				if (34 <= 0 and var_329_7 or var_329_7 * (utf8.len(var_329_9) / 34)) > 0 and var_329_7 < var_329_11 then
					arg_326_1.talkMaxDuration = var_329_11

					if var_329_11 + var_329_6 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_11 + var_329_6
					end
				end

				arg_326_1.text_.text = var_329_9
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072078", "story_v_out_322072.awb") ~= 0 then
					local var_329_12 = manager.audio:GetVoiceLength("story_v_out_322072", "322072078", "story_v_out_322072.awb") / 1000

					if var_329_12 + var_329_6 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_12 + var_329_6
					end

					if var_329_8.prefab_name ~= "" and arg_326_1.actors_[var_329_8.prefab_name] ~= nil then
						local var_329_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_8.prefab_name].transform, "story_v_out_322072", "322072078", "story_v_out_322072.awb")

						arg_326_1:RecordAudio("322072078", var_329_13)
						arg_326_1:RecordAudio("322072078", var_329_13)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_322072", "322072078", "story_v_out_322072.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_322072", "322072078", "story_v_out_322072.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_14 = math.max(var_329_7, arg_326_1.talkMaxDuration)

			if var_329_6 <= arg_326_1.time_ and arg_326_1.time_ < var_329_6 + var_329_14 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_6) / var_329_14

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_6 + var_329_14 and arg_326_1.time_ < var_329_6 + var_329_14 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
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

		arg_326_1:InitPlayNodeList()
	end,
	Play322072079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 322072079
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play322072080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["1089ui_story"]) and arg_330_1.var_.characterEffect1089ui_story == nil then
				arg_330_1.var_.characterEffect1089ui_story = arg_330_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_0 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["1089ui_story"]) then
				if arg_330_1.var_.characterEffect1089ui_story and not isNil(arg_330_1.actors_["1089ui_story"]) then
					arg_330_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_330_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_330_1.time_ - 0) / var_333_0)
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["1089ui_story"]) and arg_330_1.var_.characterEffect1089ui_story then
				arg_330_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_330_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_333_1 = 0
			local var_333_2 = 0.775

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_3 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(322072079).content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 31 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 31)

				if (31 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 31)) > 0 and var_333_2 < var_333_5 then
					arg_330_1.talkMaxDuration = var_333_5

					if var_333_5 + var_333_1 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + var_333_1
					end
				end

				arg_330_1.text_.text = var_333_3
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_6 = math.max(var_333_2, arg_330_1.talkMaxDuration)

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_6 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_1) / var_333_6

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_1 + var_333_6 and arg_330_1.time_ < var_333_1 + var_333_6 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play322072080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 322072080
		arg_334_1.duration_ = 8.93

		local var_334_0 = {
			zh = 6.4,
			ja = 8.933
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
				arg_334_0:Play322072081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos10103ui_story = arg_334_1.actors_["10103ui_story"].transform.localPosition

				local var_337_0 = GameObjectTools.GetOrAddComponent(arg_334_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_337_0 then
					var_337_0:EnableDynamicBone(false)
				end
			end

			local var_337_1 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_1 then
				arg_334_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos10103ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_334_1.time_ - 0) / var_337_1)
				arg_334_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["10103ui_story"].transform.position).z)
				arg_334_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["10103ui_story"].transform.localEulerAngles = arg_334_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_334_1.time_ >= 0 + var_337_1 and arg_334_1.time_ < 0 + var_337_1 + arg_337_0 then
				arg_334_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_334_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["10103ui_story"].transform.position).z)
				arg_334_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["10103ui_story"].transform.localEulerAngles = arg_334_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_337_2 = GameObjectTools.GetOrAddComponent(arg_334_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_337_2 then
					var_337_2:EnableDynamicBone(true)
				end
			end

			local var_337_3 = arg_334_1.actors_["10103ui_story"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_3) and arg_334_1.var_.characterEffect10103ui_story == nil then
				arg_334_1.var_.characterEffect10103ui_story = var_337_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_4 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_4 and not isNil(var_337_3) then
				if arg_334_1.var_.characterEffect10103ui_story and not isNil(var_337_3) then
					arg_334_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= 0 + var_337_4 and arg_334_1.time_ < 0 + var_337_4 + arg_337_0 and not isNil(var_337_3) and arg_334_1.var_.characterEffect10103ui_story then
				arg_334_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action9_1")
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				if not isNil(arg_334_1.actors_["10103ui_story"]) then
					local var_337_6 = GameObjectTools.GetOrAddComponent(arg_334_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_337_6 then
						var_337_6:EnableDynamicBone(true)
					end
				end
			end

			local var_337_7 = 0
			local var_337_8 = 0.525

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_7 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_9 = arg_334_1:GetWordFromCfg(322072080)
				local var_337_10 = arg_334_1:FormatText(var_337_9.content)

				arg_334_1.text_.text = var_337_10

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_12 = 21 <= 0 and var_337_8 or var_337_8 * (utf8.len(var_337_10) / 21)

				if (21 <= 0 and var_337_8 or var_337_8 * (utf8.len(var_337_10) / 21)) > 0 and var_337_8 < var_337_12 then
					arg_334_1.talkMaxDuration = var_337_12

					if var_337_12 + var_337_7 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_12 + var_337_7
					end
				end

				arg_334_1.text_.text = var_337_10
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072080", "story_v_out_322072.awb") ~= 0 then
					local var_337_13 = manager.audio:GetVoiceLength("story_v_out_322072", "322072080", "story_v_out_322072.awb") / 1000

					if var_337_13 + var_337_7 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_13 + var_337_7
					end

					if var_337_9.prefab_name ~= "" and arg_334_1.actors_[var_337_9.prefab_name] ~= nil then
						local var_337_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_9.prefab_name].transform, "story_v_out_322072", "322072080", "story_v_out_322072.awb")

						arg_334_1:RecordAudio("322072080", var_337_14)
						arg_334_1:RecordAudio("322072080", var_337_14)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_322072", "322072080", "story_v_out_322072.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_322072", "322072080", "story_v_out_322072.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_15 = math.max(var_337_8, arg_334_1.talkMaxDuration)

			if var_337_7 <= arg_334_1.time_ and arg_334_1.time_ < var_337_7 + var_337_15 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_7) / var_337_15

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_7 + var_337_15 and arg_334_1.time_ < var_337_7 + var_337_15 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play322072081 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 322072081
		arg_338_1.duration_ = 12.2

		local var_338_0 = {
			zh = 7.7,
			ja = 12.2
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
				arg_338_0:Play322072082(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["10103ui_story"]) and arg_338_1.var_.characterEffect10103ui_story == nil then
				arg_338_1.var_.characterEffect10103ui_story = arg_338_1.actors_["10103ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_0 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["10103ui_story"]) then
				if arg_338_1.var_.characterEffect10103ui_story and not isNil(arg_338_1.actors_["10103ui_story"]) then
					arg_338_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["10103ui_story"]) and arg_338_1.var_.characterEffect10103ui_story then
				arg_338_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_341_2 = 0
			local var_341_3 = 0.9

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_2 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_4 = arg_338_1:GetWordFromCfg(322072081)
				local var_341_5 = arg_338_1:FormatText(var_341_4.content)

				arg_338_1.text_.text = var_341_5

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_7 = 36 <= 0 and var_341_3 or var_341_3 * (utf8.len(var_341_5) / 36)

				if (36 <= 0 and var_341_3 or var_341_3 * (utf8.len(var_341_5) / 36)) > 0 and var_341_3 < var_341_7 then
					arg_338_1.talkMaxDuration = var_341_7

					if var_341_7 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_7 + var_341_2
					end
				end

				arg_338_1.text_.text = var_341_5
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072081", "story_v_out_322072.awb") ~= 0 then
					local var_341_8 = manager.audio:GetVoiceLength("story_v_out_322072", "322072081", "story_v_out_322072.awb") / 1000

					if var_341_8 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_8 + var_341_2
					end

					if var_341_4.prefab_name ~= "" and arg_338_1.actors_[var_341_4.prefab_name] ~= nil then
						local var_341_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_4.prefab_name].transform, "story_v_out_322072", "322072081", "story_v_out_322072.awb")

						arg_338_1:RecordAudio("322072081", var_341_9)
						arg_338_1:RecordAudio("322072081", var_341_9)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_322072", "322072081", "story_v_out_322072.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_322072", "322072081", "story_v_out_322072.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_10 = math.max(var_341_3, arg_338_1.talkMaxDuration)

			if var_341_2 <= arg_338_1.time_ and arg_338_1.time_ < var_341_2 + var_341_10 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_2) / var_341_10

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_2 + var_341_10 and arg_338_1.time_ < var_341_2 + var_341_10 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play322072082 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 322072082
		arg_342_1.duration_ = 3.33

		local var_342_0 = {
			zh = 2.766,
			ja = 3.333
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
				arg_342_0:Play322072083(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.var_.moveOldPos1089ui_story = arg_342_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_345_0 = 0.001

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 then
				arg_342_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos1089ui_story, Vector3.New(0.7, -1.1, -6.17), (arg_342_1.time_ - 0) / var_345_0)
				arg_342_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_342_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["1089ui_story"].transform.position).z)
				arg_342_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_342_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_342_1.actors_["1089ui_story"].transform.localEulerAngles = arg_342_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 then
				arg_342_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0.7, -1.1, -6.17)
				arg_342_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_342_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["1089ui_story"].transform.position).z)
				arg_342_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_342_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_342_1.actors_["1089ui_story"].transform.localEulerAngles = arg_342_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_345_1 = arg_342_1.actors_["1089ui_story"]

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(var_345_1) and arg_342_1.var_.characterEffect1089ui_story == nil then
				arg_342_1.var_.characterEffect1089ui_story = var_345_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_2 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_2 and not isNil(var_345_1) then
				if arg_342_1.var_.characterEffect1089ui_story and not isNil(var_345_1) then
					arg_342_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= 0 + var_345_2 and arg_342_1.time_ < 0 + var_345_2 + arg_345_0 and not isNil(var_345_1) and arg_342_1.var_.characterEffect1089ui_story then
				arg_342_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_345_4 = arg_342_1.actors_["10103ui_story"]

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(var_345_4) and arg_342_1.var_.characterEffect10103ui_story == nil then
				arg_342_1.var_.characterEffect10103ui_story = var_345_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_5 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_5 and not isNil(var_345_4) then
				if arg_342_1.var_.characterEffect10103ui_story and not isNil(var_345_4) then
					arg_342_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_342_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_342_1.time_ - 0) / var_345_5)
				end
			end

			if arg_342_1.time_ >= 0 + var_345_5 and arg_342_1.time_ < 0 + var_345_5 + arg_345_0 and not isNil(var_345_4) and arg_342_1.var_.characterEffect10103ui_story then
				arg_342_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_342_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			local var_345_6 = 0
			local var_345_7 = 0.3

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_6 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_8 = arg_342_1:GetWordFromCfg(322072082)
				local var_345_9 = arg_342_1:FormatText(var_345_8.content)

				arg_342_1.text_.text = var_345_9

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_11 = 12 <= 0 and var_345_7 or var_345_7 * (utf8.len(var_345_9) / 12)

				if (12 <= 0 and var_345_7 or var_345_7 * (utf8.len(var_345_9) / 12)) > 0 and var_345_7 < var_345_11 then
					arg_342_1.talkMaxDuration = var_345_11

					if var_345_11 + var_345_6 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_11 + var_345_6
					end
				end

				arg_342_1.text_.text = var_345_9
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072082", "story_v_out_322072.awb") ~= 0 then
					local var_345_12 = manager.audio:GetVoiceLength("story_v_out_322072", "322072082", "story_v_out_322072.awb") / 1000

					if var_345_12 + var_345_6 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_12 + var_345_6
					end

					if var_345_8.prefab_name ~= "" and arg_342_1.actors_[var_345_8.prefab_name] ~= nil then
						local var_345_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_8.prefab_name].transform, "story_v_out_322072", "322072082", "story_v_out_322072.awb")

						arg_342_1:RecordAudio("322072082", var_345_13)
						arg_342_1:RecordAudio("322072082", var_345_13)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_322072", "322072082", "story_v_out_322072.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_322072", "322072082", "story_v_out_322072.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_14 = math.max(var_345_7, arg_342_1.talkMaxDuration)

			if var_345_6 <= arg_342_1.time_ and arg_342_1.time_ < var_345_6 + var_345_14 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_6) / var_345_14

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_6 + var_345_14 and arg_342_1.time_ < var_345_6 + var_345_14 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
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

		arg_342_1:InitPlayNodeList()
	end,
	Play322072083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 322072083
		arg_346_1.duration_ = 7

		local var_346_0 = {
			zh = 2.833,
			ja = 7
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play322072084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos10103ui_story = arg_346_1.actors_["10103ui_story"].transform.localPosition

				local var_349_0 = GameObjectTools.GetOrAddComponent(arg_346_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_349_0 then
					var_349_0:EnableDynamicBone(false)
				end
			end

			local var_349_1 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_1 then
				arg_346_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos10103ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_346_1.time_ - 0) / var_349_1)
				arg_346_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_346_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["10103ui_story"].transform.position).z)
				arg_346_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_346_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_346_1.actors_["10103ui_story"].transform.localEulerAngles = arg_346_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_346_1.time_ >= 0 + var_349_1 and arg_346_1.time_ < 0 + var_349_1 + arg_349_0 then
				arg_346_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_346_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_346_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["10103ui_story"].transform.position).z)
				arg_346_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_346_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_346_1.actors_["10103ui_story"].transform.localEulerAngles = arg_346_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_349_2 = GameObjectTools.GetOrAddComponent(arg_346_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_349_2 then
					var_349_2:EnableDynamicBone(true)
				end
			end

			local var_349_3 = arg_346_1.actors_["10103ui_story"]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(var_349_3) and arg_346_1.var_.characterEffect10103ui_story == nil then
				arg_346_1.var_.characterEffect10103ui_story = var_349_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_4 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_4 and not isNil(var_349_3) then
				if arg_346_1.var_.characterEffect10103ui_story and not isNil(var_349_3) then
					arg_346_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= 0 + var_349_4 and arg_346_1.time_ < 0 + var_349_4 + arg_349_0 and not isNil(var_349_3) and arg_346_1.var_.characterEffect10103ui_story then
				arg_346_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_349_6 = arg_346_1.actors_["1089ui_story"]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(var_349_6) and arg_346_1.var_.characterEffect1089ui_story == nil then
				arg_346_1.var_.characterEffect1089ui_story = var_349_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_7 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_7 and not isNil(var_349_6) then
				if arg_346_1.var_.characterEffect1089ui_story and not isNil(var_349_6) then
					arg_346_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_346_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_346_1.time_ - 0) / var_349_7)
				end
			end

			if arg_346_1.time_ >= 0 + var_349_7 and arg_346_1.time_ < 0 + var_349_7 + arg_349_0 and not isNil(var_349_6) and arg_346_1.var_.characterEffect1089ui_story then
				arg_346_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_346_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action9_2")
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				if not isNil(arg_346_1.actors_["10103ui_story"]) then
					local var_349_8 = GameObjectTools.GetOrAddComponent(arg_346_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_349_8 then
						var_349_8:EnableDynamicBone(true)
					end
				end
			end

			local var_349_9 = 0
			local var_349_10 = 0.325

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_9 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_11 = arg_346_1:GetWordFromCfg(322072083)
				local var_349_12 = arg_346_1:FormatText(var_349_11.content)

				arg_346_1.text_.text = var_349_12

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_14 = 13 <= 0 and var_349_10 or var_349_10 * (utf8.len(var_349_12) / 13)

				if (13 <= 0 and var_349_10 or var_349_10 * (utf8.len(var_349_12) / 13)) > 0 and var_349_10 < var_349_14 then
					arg_346_1.talkMaxDuration = var_349_14

					if var_349_14 + var_349_9 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_14 + var_349_9
					end
				end

				arg_346_1.text_.text = var_349_12
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072083", "story_v_out_322072.awb") ~= 0 then
					local var_349_15 = manager.audio:GetVoiceLength("story_v_out_322072", "322072083", "story_v_out_322072.awb") / 1000

					if var_349_15 + var_349_9 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_15 + var_349_9
					end

					if var_349_11.prefab_name ~= "" and arg_346_1.actors_[var_349_11.prefab_name] ~= nil then
						local var_349_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_11.prefab_name].transform, "story_v_out_322072", "322072083", "story_v_out_322072.awb")

						arg_346_1:RecordAudio("322072083", var_349_16)
						arg_346_1:RecordAudio("322072083", var_349_16)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_322072", "322072083", "story_v_out_322072.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_322072", "322072083", "story_v_out_322072.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_17 = math.max(var_349_10, arg_346_1.talkMaxDuration)

			if var_349_9 <= arg_346_1.time_ and arg_346_1.time_ < var_349_9 + var_349_17 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_9) / var_349_17

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_9 + var_349_17 and arg_346_1.time_ < var_349_9 + var_349_17 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play322072084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 322072084
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play322072085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos10103ui_story = arg_350_1.actors_["10103ui_story"].transform.localPosition

				local var_353_0 = GameObjectTools.GetOrAddComponent(arg_350_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_353_0 then
					var_353_0:EnableDynamicBone(false)
				end
			end

			local var_353_1 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_1 then
				arg_350_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_350_1.time_ - 0) / var_353_1)
				arg_350_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_350_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["10103ui_story"].transform.position).z)
				arg_350_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_350_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_350_1.actors_["10103ui_story"].transform.localEulerAngles = arg_350_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_350_1.time_ >= 0 + var_353_1 and arg_350_1.time_ < 0 + var_353_1 + arg_353_0 then
				arg_350_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_350_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_350_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["10103ui_story"].transform.position).z)
				arg_350_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_350_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_350_1.actors_["10103ui_story"].transform.localEulerAngles = arg_350_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_353_2 = GameObjectTools.GetOrAddComponent(arg_350_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_353_2 then
					var_353_2:EnableDynamicBone(true)
				end
			end

			local var_353_3 = arg_350_1.actors_["1089ui_story"].transform

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos1089ui_story = var_353_3.localPosition
			end

			local var_353_4 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_4 then
				var_353_3.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_350_1.time_ - 0) / var_353_4)
				var_353_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_353_3.position).x, (manager.ui.mainCamera.transform.position - var_353_3.position).y, (manager.ui.mainCamera.transform.position - var_353_3.position).z)
				var_353_3.localEulerAngles.z = 0
				var_353_3.localEulerAngles.x = 0
				var_353_3.localEulerAngles = var_353_3.localEulerAngles
			end

			if arg_350_1.time_ >= 0 + var_353_4 and arg_350_1.time_ < 0 + var_353_4 + arg_353_0 then
				var_353_3.localPosition = Vector3.New(0, 100, 0)
				var_353_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_353_3.position).x, (manager.ui.mainCamera.transform.position - var_353_3.position).y, (manager.ui.mainCamera.transform.position - var_353_3.position).z)
				var_353_3.localEulerAngles.z = 0
				var_353_3.localEulerAngles.x = 0
				var_353_3.localEulerAngles = var_353_3.localEulerAngles
			end

			if 0.1 < arg_350_1.time_ and arg_350_1.time_ <= 0.1 + arg_353_0 then
				arg_350_1:AudioAction("play", "effect", "se_story_145", "se_story_145_summon_barrier", "")
			end

			local var_353_6 = 0
			local var_353_7 = 1.3

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_6 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_8 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(322072084).content)

				arg_350_1.text_.text = var_353_8

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_10 = 52 <= 0 and var_353_7 or var_353_7 * (utf8.len(var_353_8) / 52)

				if (52 <= 0 and var_353_7 or var_353_7 * (utf8.len(var_353_8) / 52)) > 0 and var_353_7 < var_353_10 then
					arg_350_1.talkMaxDuration = var_353_10

					if var_353_10 + var_353_6 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_10 + var_353_6
					end
				end

				arg_350_1.text_.text = var_353_8
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_11 = math.max(var_353_7, arg_350_1.talkMaxDuration)

			if var_353_6 <= arg_350_1.time_ and arg_350_1.time_ < var_353_6 + var_353_11 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_6) / var_353_11

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_6 + var_353_11 and arg_350_1.time_ < var_353_6 + var_353_11 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_350_1:InitPlayNodeList()
	end,
	Play322072085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 322072085
		arg_354_1.duration_ = 13.77

		local var_354_0 = {
			zh = 7.4,
			ja = 13.766
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play322072086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos10103ui_story = arg_354_1.actors_["10103ui_story"].transform.localPosition

				local var_357_0 = GameObjectTools.GetOrAddComponent(arg_354_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_357_0 then
					var_357_0:EnableDynamicBone(false)
				end
			end

			local var_357_1 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_1 then
				arg_354_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos10103ui_story, Vector3.New(0, -0.95, -6.2), (arg_354_1.time_ - 0) / var_357_1)
				arg_354_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_354_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["10103ui_story"].transform.position).z)
				arg_354_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_354_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_354_1.actors_["10103ui_story"].transform.localEulerAngles = arg_354_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_354_1.time_ >= 0 + var_357_1 and arg_354_1.time_ < 0 + var_357_1 + arg_357_0 then
				arg_354_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.2)
				arg_354_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_354_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["10103ui_story"].transform.position).z)
				arg_354_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_354_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_354_1.actors_["10103ui_story"].transform.localEulerAngles = arg_354_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_357_2 = GameObjectTools.GetOrAddComponent(arg_354_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_357_2 then
					var_357_2:EnableDynamicBone(true)
				end
			end

			local var_357_3 = arg_354_1.actors_["10103ui_story"]

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(var_357_3) and arg_354_1.var_.characterEffect10103ui_story == nil then
				arg_354_1.var_.characterEffect10103ui_story = var_357_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_4 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_4 and not isNil(var_357_3) then
				if arg_354_1.var_.characterEffect10103ui_story and not isNil(var_357_3) then
					arg_354_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= 0 + var_357_4 and arg_354_1.time_ < 0 + var_357_4 + arg_357_0 and not isNil(var_357_3) and arg_354_1.var_.characterEffect10103ui_story then
				arg_354_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action3_1")
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				if not isNil(arg_354_1.actors_["10103ui_story"]) then
					local var_357_6 = GameObjectTools.GetOrAddComponent(arg_354_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_357_6 then
						var_357_6:EnableDynamicBone(true)
					end
				end
			end

			local var_357_7 = 0
			local var_357_8 = 0.8

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_7 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_9 = arg_354_1:GetWordFromCfg(322072085)
				local var_357_10 = arg_354_1:FormatText(var_357_9.content)

				arg_354_1.text_.text = var_357_10

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_12 = 32 <= 0 and var_357_8 or var_357_8 * (utf8.len(var_357_10) / 32)

				if (32 <= 0 and var_357_8 or var_357_8 * (utf8.len(var_357_10) / 32)) > 0 and var_357_8 < var_357_12 then
					arg_354_1.talkMaxDuration = var_357_12

					if var_357_12 + var_357_7 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_12 + var_357_7
					end
				end

				arg_354_1.text_.text = var_357_10
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072085", "story_v_out_322072.awb") ~= 0 then
					local var_357_13 = manager.audio:GetVoiceLength("story_v_out_322072", "322072085", "story_v_out_322072.awb") / 1000

					if var_357_13 + var_357_7 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_13 + var_357_7
					end

					if var_357_9.prefab_name ~= "" and arg_354_1.actors_[var_357_9.prefab_name] ~= nil then
						local var_357_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_9.prefab_name].transform, "story_v_out_322072", "322072085", "story_v_out_322072.awb")

						arg_354_1:RecordAudio("322072085", var_357_14)
						arg_354_1:RecordAudio("322072085", var_357_14)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_322072", "322072085", "story_v_out_322072.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_322072", "322072085", "story_v_out_322072.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_15 = math.max(var_357_8, arg_354_1.talkMaxDuration)

			if var_357_7 <= arg_354_1.time_ and arg_354_1.time_ < var_357_7 + var_357_15 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_7) / var_357_15

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_7 + var_357_15 and arg_354_1.time_ < var_357_7 + var_357_15 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play322072086 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 322072086
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play322072087(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_9000

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos10103ui_story = arg_358_1.actors_["10103ui_story"].transform.localPosition

				local var_361_0 = GameObjectTools.GetOrAddComponent(arg_358_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_361_0 then
					var_361_0:EnableDynamicBone(false)
				end
			end

			local var_361_1 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_1 then
				arg_358_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_358_1.time_ - 0) / var_361_1)
				arg_358_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["10103ui_story"].transform.position).z)
				arg_358_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["10103ui_story"].transform.localEulerAngles = arg_358_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_358_1.time_ >= 0 + var_361_1 and arg_358_1.time_ < 0 + var_361_1 + arg_361_0 then
				arg_358_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_358_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["10103ui_story"].transform.position).z)
				arg_358_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["10103ui_story"].transform.localEulerAngles = arg_358_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_361_2 = GameObjectTools.GetOrAddComponent(arg_358_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_361_2 then
					var_361_2:EnableDynamicBone(true)
				end
			end

			local var_361_3 = arg_358_1.actors_["10103ui_story"]

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(var_361_3) and arg_358_1.var_.characterEffect10103ui_story == nil then
				arg_358_1.var_.characterEffect10103ui_story = var_361_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_4 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_4 and not isNil(var_361_3) then
				if arg_358_1.var_.characterEffect10103ui_story and not isNil(var_361_3) then
					arg_358_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_358_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_358_1.time_ - 0) / var_361_4)
				end
			end

			if arg_358_1.time_ >= 0 + var_361_4 and arg_358_1.time_ < 0 + var_361_4 + arg_361_0 and not isNil(var_361_3) and arg_358_1.var_.characterEffect10103ui_story then
				arg_358_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_358_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_358_1.time_ and arg_358_1.time_ <= 0.1 + arg_361_0 then
				arg_358_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_scan", "")
			end

			if 0.1 < arg_358_1.time_ and arg_358_1.time_ <= 0.1 + arg_361_0 then
				local var_361_6 = arg_358_1.var_.effect2086

				if not arg_358_1.var_.effect2086 then
					var_361_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_scan_in_out"), manager.ui.mainCamera.transform)
					var_361_6.name = "2086"
					arg_358_1.var_.effect2086 = var_361_6
				else
					var_361_6.transform:SetParent(var_361_9000)
				end

				var_361_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_361_6.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_361_8 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_361_9 = var_361_6.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_361_0, iter_361_1 in ipairs((var_361_9:ToTable())) do
					iter_361_1.transform.localScale = Vector3.New(iter_361_1.transform.localScale.x / var_361_8 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_361_9 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_361_1.transform.localScale.y / var_361_8, iter_361_1.transform.localScale.z)
				end
			end

			local var_361_11 = 0
			local var_361_12 = 0.925

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_11 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_13 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(322072086).content)

				arg_358_1.text_.text = var_361_13

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_15 = 37 <= 0 and var_361_12 or var_361_12 * (utf8.len(var_361_13) / 37)

				if (37 <= 0 and var_361_12 or var_361_12 * (utf8.len(var_361_13) / 37)) > 0 and var_361_12 < var_361_15 then
					arg_358_1.talkMaxDuration = var_361_15

					if var_361_15 + var_361_11 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_15 + var_361_11
					end
				end

				arg_358_1.text_.text = var_361_13
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_16 = math.max(var_361_12, arg_358_1.talkMaxDuration)

			if var_361_11 <= arg_358_1.time_ and arg_358_1.time_ < var_361_11 + var_361_16 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_11) / var_361_16

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_11 + var_361_16 and arg_358_1.time_ < var_361_11 + var_361_16 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play322072087 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 322072087
		arg_362_1.duration_ = 9

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play322072088(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 1.999999999999 < arg_362_1.time_ and arg_362_1.time_ <= 1.999999999999 + arg_365_0 then
				local var_365_0 = arg_362_1.bgs_.L17f

				arg_362_1.bgs_.L17f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_365_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_365_1 = var_365_0:GetComponent("SpriteRenderer")

				if var_365_1 and var_365_1.sprite then
					local var_365_2 = 2 * (var_365_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_365_0.transform.localScale = Vector3.New(var_365_2 / var_365_1.sprite.bounds.size.y < var_365_2 * manager.ui.mainCameraCom_.aspect / var_365_1.sprite.bounds.size.x and var_365_2 * manager.ui.mainCameraCom_.aspect / var_365_1.sprite.bounds.size.x or var_365_2 / var_365_1.sprite.bounds.size.y, var_365_2 / var_365_1.sprite.bounds.size.y < var_365_2 * manager.ui.mainCameraCom_.aspect / var_365_1.sprite.bounds.size.x and var_365_2 * manager.ui.mainCameraCom_.aspect / var_365_1.sprite.bounds.size.x or var_365_2 / var_365_1.sprite.bounds.size.y, 0)
				end

				for iter_365_0, iter_365_1 in pairs(arg_362_1.bgs_) do
					if iter_365_0 ~= "L17f" then
						iter_365_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_365_3 = 3.999999999999

			if 3.999999999999 < arg_362_1.time_ and arg_362_1.time_ <= var_365_3 + arg_365_0 then
				arg_362_1.allBtn_.enabled = false
			end

			if arg_362_1.time_ >= var_365_3 + 0.3 and arg_362_1.time_ < var_365_3 + 0.3 + arg_365_0 then
				arg_362_1.allBtn_.enabled = true
			end

			local var_365_4 = 0

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_4 + arg_365_0 then
				arg_362_1.mask_.enabled = true
				arg_362_1.mask_.raycastTarget = true

				arg_362_1:SetGaussion(false)
			end

			local var_365_5 = 2

			if var_365_4 <= arg_362_1.time_ and arg_362_1.time_ < var_365_4 + var_365_5 then
				local var_365_6 = Color.New(0, 0, 0)

				var_365_6.a = Mathf.Lerp(0, 1, (arg_362_1.time_ - var_365_4) / var_365_5)
				arg_362_1.mask_.color = var_365_6
			end

			if arg_362_1.time_ >= var_365_4 + var_365_5 and arg_362_1.time_ < var_365_4 + var_365_5 + arg_365_0 then
				local var_365_7 = Color.New(0, 0, 0)

				var_365_7.a = 1
				arg_362_1.mask_.color = var_365_7
			end

			local var_365_8 = 2

			if 2 < arg_362_1.time_ and arg_362_1.time_ <= var_365_8 + arg_365_0 then
				arg_362_1.mask_.enabled = true
				arg_362_1.mask_.raycastTarget = true

				arg_362_1:SetGaussion(false)
			end

			local var_365_9 = 2

			if var_365_8 <= arg_362_1.time_ and arg_362_1.time_ < var_365_8 + var_365_9 then
				local var_365_10 = Color.New(0, 0, 0)

				var_365_10.a = Mathf.Lerp(1, 0, (arg_362_1.time_ - var_365_8) / var_365_9)
				arg_362_1.mask_.color = var_365_10
			end

			if arg_362_1.time_ >= var_365_8 + var_365_9 and arg_362_1.time_ < var_365_8 + var_365_9 + arg_365_0 then
				local var_365_11 = Color.New(0, 0, 0)

				arg_362_1.mask_.enabled = false
				var_365_11.a = 0
				arg_362_1.mask_.color = var_365_11
			end

			if 0.233333333333333 < arg_362_1.time_ and arg_362_1.time_ <= 0.233333333333333 + arg_365_0 then
				arg_362_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_data", "")
			end

			if 1.6 < arg_362_1.time_ and arg_362_1.time_ <= 1.6 + arg_365_0 then
				arg_362_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			if 1.999999999999 < arg_362_1.time_ and arg_362_1.time_ <= 1.999999999999 + arg_365_0 then
				if arg_362_1.var_.effect2086 then
					Object.Destroy(arg_362_1.var_.effect2086)

					arg_362_1.var_.effect2086 = nil
				end
			end

			if 2.01666666666567 < arg_362_1.time_ and arg_362_1.time_ <= 2.01666666666567 + arg_365_0 then
				if arg_362_1.var_.effect2086 then
					Object.Destroy(arg_362_1.var_.effect2086)

					arg_362_1.var_.effect2086 = nil
				end
			end

			if 1.6 < arg_362_1.time_ and arg_362_1.time_ <= 1.6 + arg_365_0 then
				arg_362_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "battle", "bgm_activity_4_5_story_serious.awb")

				local var_365_18 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "battle")

				if "" ~= "" then
					if arg_362_1.bgmTxt_.text ~= var_365_18 and arg_362_1.bgmTxt_.text ~= "" then
						if arg_362_1.bgmTxt2_.text ~= "" then
							arg_362_1.bgmTxt_.text = arg_362_1.bgmTxt2_.text
						end

						arg_362_1.bgmTxt2_.text = var_365_18

						arg_362_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_362_1.bgmTxt_.text = var_365_18
						arg_362_1.bgmTxt2_.text = var_365_18
					end

					if arg_362_1.bgmTimer then
						arg_362_1.bgmTimer:Stop()

						arg_362_1.bgmTimer = nil
					end

					if arg_362_1.settingData.show_music_name == 1 then
						arg_362_1.musicController:SetSelectedState("show")
						arg_362_1.musicAnimator_:Play("open", 0, 0)

						if arg_362_1.settingData.music_time ~= 0 then
							arg_362_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_362_1.settingData.music_time), function()
								if arg_362_1 == nil or isNil(arg_362_1.bgmTxt_) then
									return
								end

								arg_362_1.musicController:SetSelectedState("hide")
								arg_362_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_362_1.frameCnt_ <= 1 then
				arg_362_1.dialog_:SetActive(false)
			end

			local var_365_19 = 4
			local var_365_20 = 0.925

			if 4 < arg_362_1.time_ and arg_362_1.time_ <= var_365_19 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0

				arg_362_1.dialog_:SetActive(true)

				arg_362_1.dialogCg_.alpha = 0

				local var_365_21 = LeanTween.value(arg_362_1.dialog_, 0, 1, 0.3)

				var_365_21:setOnUpdate(LuaHelper.FloatAction(function(arg_367_0)
					arg_362_1.dialogCg_.alpha = arg_367_0
				end))
				var_365_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_362_1.dialog_)
					var_365_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_362_1.duration_ = arg_362_1.duration_ + 0.3

				SetActive(arg_362_1.leftNameGo_, false)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_22 = arg_362_1:FormatText(arg_362_1:GetWordFromCfg(322072087).content)

				arg_362_1.text_.text = var_365_22

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_24 = 37 <= 0 and var_365_20 or var_365_20 * (utf8.len(var_365_22) / 37)

				if (37 <= 0 and var_365_20 or var_365_20 * (utf8.len(var_365_22) / 37)) > 0 and var_365_20 < var_365_24 then
					arg_362_1.talkMaxDuration = var_365_24
					var_365_19 = var_365_19 + 0.3

					if var_365_24 + var_365_19 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_24 + var_365_19
					end
				end

				arg_362_1.text_.text = var_365_22
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_25 = var_365_19 + 0.3
			local var_365_26 = math.max(var_365_20, arg_362_1.talkMaxDuration)

			if var_365_19 + 0.3 <= arg_362_1.time_ and arg_362_1.time_ < var_365_25 + var_365_26 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_25) / var_365_26

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_25 + var_365_26 and arg_362_1.time_ < var_365_25 + var_365_26 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play322072088 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 322072088
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play322072089(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 1.65

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_1 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(322072088).content)

				arg_369_1.text_.text = var_372_1

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_3 = 66 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_1) / 66)

				if (66 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_1) / 66)) > 0 and var_372_0 < var_372_3 then
					arg_369_1.talkMaxDuration = var_372_3

					if var_372_3 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_3 + 0
					end
				end

				arg_369_1.text_.text = var_372_1
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_4 = math.max(var_372_0, arg_369_1.talkMaxDuration)

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_4 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - 0) / var_372_4

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= 0 + var_372_4 and arg_369_1.time_ < 0 + var_372_4 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play322072089 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 322072089
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play322072090(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 1.475

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_1 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(322072089).content)

				arg_373_1.text_.text = var_376_1

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_3 = 59 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_1) / 59)

				if (59 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_1) / 59)) > 0 and var_376_0 < var_376_3 then
					arg_373_1.talkMaxDuration = var_376_3

					if var_376_3 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_3 + 0
					end
				end

				arg_373_1.text_.text = var_376_1
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_4 = math.max(var_376_0, arg_373_1.talkMaxDuration)

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_4 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - 0) / var_376_4

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= 0 + var_376_4 and arg_373_1.time_ < 0 + var_376_4 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play322072090 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 322072090
		arg_377_1.duration_ = 4.17

		local var_377_0 = {
			zh = 4.066,
			ja = 4.166
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
				arg_377_0:Play322072091(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1284ui_story = arg_377_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_380_0 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 then
				arg_377_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_377_1.time_ - 0) / var_380_0)
				arg_377_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1284ui_story"].transform.position).z)
				arg_377_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1284ui_story"].transform.localEulerAngles = arg_377_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 then
				arg_377_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				arg_377_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1284ui_story"].transform.position).z)
				arg_377_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1284ui_story"].transform.localEulerAngles = arg_377_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_380_1 = arg_377_1.actors_["1284ui_story"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1284ui_story == nil then
				arg_377_1.var_.characterEffect1284ui_story = var_380_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_2 and not isNil(var_380_1) then
				if arg_377_1.var_.characterEffect1284ui_story and not isNil(var_380_1) then
					arg_377_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= 0 + var_380_2 and arg_377_1.time_ < 0 + var_380_2 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1284ui_story then
				arg_377_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_380_4 = 0
			local var_380_5 = 0.325

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_4 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_6 = arg_377_1:GetWordFromCfg(322072090)
				local var_380_7 = arg_377_1:FormatText(var_380_6.content)

				arg_377_1.text_.text = var_380_7

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_9 = 13 <= 0 and var_380_5 or var_380_5 * (utf8.len(var_380_7) / 13)

				if (13 <= 0 and var_380_5 or var_380_5 * (utf8.len(var_380_7) / 13)) > 0 and var_380_5 < var_380_9 then
					arg_377_1.talkMaxDuration = var_380_9

					if var_380_9 + var_380_4 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_9 + var_380_4
					end
				end

				arg_377_1.text_.text = var_380_7
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072090", "story_v_out_322072.awb") ~= 0 then
					local var_380_10 = manager.audio:GetVoiceLength("story_v_out_322072", "322072090", "story_v_out_322072.awb") / 1000

					if var_380_10 + var_380_4 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_10 + var_380_4
					end

					if var_380_6.prefab_name ~= "" and arg_377_1.actors_[var_380_6.prefab_name] ~= nil then
						local var_380_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_6.prefab_name].transform, "story_v_out_322072", "322072090", "story_v_out_322072.awb")

						arg_377_1:RecordAudio("322072090", var_380_11)
						arg_377_1:RecordAudio("322072090", var_380_11)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_322072", "322072090", "story_v_out_322072.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_322072", "322072090", "story_v_out_322072.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_12 = math.max(var_380_5, arg_377_1.talkMaxDuration)

			if var_380_4 <= arg_377_1.time_ and arg_377_1.time_ < var_380_4 + var_380_12 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_4) / var_380_12

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_4 + var_380_12 and arg_377_1.time_ < var_380_4 + var_380_12 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
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

		arg_377_1:InitPlayNodeList()
	end,
	Play322072091 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 322072091
		arg_381_1.duration_ = 5.83

		local var_381_0 = {
			zh = 5.833,
			ja = 5.533
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play322072092(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos1156ui_story = arg_381_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_384_0 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 then
				arg_381_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1156ui_story, Vector3.New(0.9, -1.1, -6.18), (arg_381_1.time_ - 0) / var_384_0)
				arg_381_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1156ui_story"].transform.position).z)
				arg_381_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1156ui_story"].transform.localEulerAngles = arg_381_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 then
				arg_381_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0.9, -1.1, -6.18)
				arg_381_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1156ui_story"].transform.position).z)
				arg_381_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1156ui_story"].transform.localEulerAngles = arg_381_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_384_1 = arg_381_1.actors_["1156ui_story"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect1156ui_story == nil then
				arg_381_1.var_.characterEffect1156ui_story = var_384_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_2 and not isNil(var_384_1) then
				if arg_381_1.var_.characterEffect1156ui_story and not isNil(var_384_1) then
					arg_381_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_2 and arg_381_1.time_ < 0 + var_384_2 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect1156ui_story then
				arg_381_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_384_4 = arg_381_1.actors_["1284ui_story"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_4) and arg_381_1.var_.characterEffect1284ui_story == nil then
				arg_381_1.var_.characterEffect1284ui_story = var_384_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_5 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_5 and not isNil(var_384_4) then
				if arg_381_1.var_.characterEffect1284ui_story and not isNil(var_384_4) then
					arg_381_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_381_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_381_1.time_ - 0) / var_384_5)
				end
			end

			if arg_381_1.time_ >= 0 + var_384_5 and arg_381_1.time_ < 0 + var_384_5 + arg_384_0 and not isNil(var_384_4) and arg_381_1.var_.characterEffect1284ui_story then
				arg_381_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_381_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_384_6 = 0
			local var_384_7 = 0.725

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_6 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_8 = arg_381_1:GetWordFromCfg(322072091)
				local var_384_9 = arg_381_1:FormatText(var_384_8.content)

				arg_381_1.text_.text = var_384_9

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_11 = 29 <= 0 and var_384_7 or var_384_7 * (utf8.len(var_384_9) / 29)

				if (29 <= 0 and var_384_7 or var_384_7 * (utf8.len(var_384_9) / 29)) > 0 and var_384_7 < var_384_11 then
					arg_381_1.talkMaxDuration = var_384_11

					if var_384_11 + var_384_6 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_11 + var_384_6
					end
				end

				arg_381_1.text_.text = var_384_9
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072091", "story_v_out_322072.awb") ~= 0 then
					local var_384_12 = manager.audio:GetVoiceLength("story_v_out_322072", "322072091", "story_v_out_322072.awb") / 1000

					if var_384_12 + var_384_6 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_12 + var_384_6
					end

					if var_384_8.prefab_name ~= "" and arg_381_1.actors_[var_384_8.prefab_name] ~= nil then
						local var_384_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_8.prefab_name].transform, "story_v_out_322072", "322072091", "story_v_out_322072.awb")

						arg_381_1:RecordAudio("322072091", var_384_13)
						arg_381_1:RecordAudio("322072091", var_384_13)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_322072", "322072091", "story_v_out_322072.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_322072", "322072091", "story_v_out_322072.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_14 = math.max(var_384_7, arg_381_1.talkMaxDuration)

			if var_384_6 <= arg_381_1.time_ and arg_381_1.time_ < var_384_6 + var_384_14 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_6) / var_384_14

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_6 + var_384_14 and arg_381_1.time_ < var_384_6 + var_384_14 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
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

		arg_381_1:InitPlayNodeList()
	end,
	Play322072092 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 322072092
		arg_385_1.duration_ = 4.73

		local var_385_0 = {
			zh = 4.733,
			ja = 4.533
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play322072093(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos404001ui_story = arg_385_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_388_0 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 then
				arg_385_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_385_1.time_ - 0) / var_388_0)
				arg_385_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_385_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["404001ui_story"].transform.position).z)
				arg_385_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_385_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_385_1.actors_["404001ui_story"].transform.localEulerAngles = arg_385_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 then
				arg_385_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0.8, -1.55, -5.5)
				arg_385_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_385_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["404001ui_story"].transform.position).z)
				arg_385_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_385_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_385_1.actors_["404001ui_story"].transform.localEulerAngles = arg_385_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_388_1 = arg_385_1.actors_["1156ui_story"].transform

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos1156ui_story = var_388_1.localPosition
			end

			local var_388_2 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_2 then
				var_388_1.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_385_1.time_ - 0) / var_388_2)
				var_388_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_1.position).x, (manager.ui.mainCamera.transform.position - var_388_1.position).y, (manager.ui.mainCamera.transform.position - var_388_1.position).z)
				var_388_1.localEulerAngles.z = 0
				var_388_1.localEulerAngles.x = 0
				var_388_1.localEulerAngles = var_388_1.localEulerAngles
			end

			if arg_385_1.time_ >= 0 + var_388_2 and arg_385_1.time_ < 0 + var_388_2 + arg_388_0 then
				var_388_1.localPosition = Vector3.New(0, 100, 0)
				var_388_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_1.position).x, (manager.ui.mainCamera.transform.position - var_388_1.position).y, (manager.ui.mainCamera.transform.position - var_388_1.position).z)
				var_388_1.localEulerAngles.z = 0
				var_388_1.localEulerAngles.x = 0
				var_388_1.localEulerAngles = var_388_1.localEulerAngles
			end

			local var_388_3 = arg_385_1.actors_["404001ui_story"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_3) and arg_385_1.var_.characterEffect404001ui_story == nil then
				arg_385_1.var_.characterEffect404001ui_story = var_388_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_4 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_4 and not isNil(var_388_3) then
				if arg_385_1.var_.characterEffect404001ui_story and not isNil(var_388_3) then
					arg_385_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= 0 + var_388_4 and arg_385_1.time_ < 0 + var_388_4 + arg_388_0 and not isNil(var_388_3) and arg_385_1.var_.characterEffect404001ui_story then
				arg_385_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_388_6 = arg_385_1.actors_["1156ui_story"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_6) and arg_385_1.var_.characterEffect1156ui_story == nil then
				arg_385_1.var_.characterEffect1156ui_story = var_388_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_7 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_7 and not isNil(var_388_6) then
				if arg_385_1.var_.characterEffect1156ui_story and not isNil(var_388_6) then
					arg_385_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_7)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_7 and arg_385_1.time_ < 0 + var_388_7 + arg_388_0 and not isNil(var_388_6) and arg_385_1.var_.characterEffect1156ui_story then
				arg_385_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_1")
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_388_8 = 0
			local var_388_9 = 0.675

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_8 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_10 = arg_385_1:GetWordFromCfg(322072092)
				local var_388_11 = arg_385_1:FormatText(var_388_10.content)

				arg_385_1.text_.text = var_388_11

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_13 = 27 <= 0 and var_388_9 or var_388_9 * (utf8.len(var_388_11) / 27)

				if (27 <= 0 and var_388_9 or var_388_9 * (utf8.len(var_388_11) / 27)) > 0 and var_388_9 < var_388_13 then
					arg_385_1.talkMaxDuration = var_388_13

					if var_388_13 + var_388_8 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_13 + var_388_8
					end
				end

				arg_385_1.text_.text = var_388_11
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072092", "story_v_out_322072.awb") ~= 0 then
					local var_388_14 = manager.audio:GetVoiceLength("story_v_out_322072", "322072092", "story_v_out_322072.awb") / 1000

					if var_388_14 + var_388_8 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_14 + var_388_8
					end

					if var_388_10.prefab_name ~= "" and arg_385_1.actors_[var_388_10.prefab_name] ~= nil then
						local var_388_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_10.prefab_name].transform, "story_v_out_322072", "322072092", "story_v_out_322072.awb")

						arg_385_1:RecordAudio("322072092", var_388_15)
						arg_385_1:RecordAudio("322072092", var_388_15)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_322072", "322072092", "story_v_out_322072.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_322072", "322072092", "story_v_out_322072.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_16 = math.max(var_388_9, arg_385_1.talkMaxDuration)

			if var_388_8 <= arg_385_1.time_ and arg_385_1.time_ < var_388_8 + var_388_16 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_8) / var_388_16

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_8 + var_388_16 and arg_385_1.time_ < var_388_8 + var_388_16 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
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
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play322072093 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 322072093
		arg_389_1.duration_ = 5.6

		local var_389_0 = {
			zh = 4.766,
			ja = 5.6
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play322072094(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_2")
			end

			local var_392_0 = 0
			local var_392_1 = 0.55

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_2 = arg_389_1:GetWordFromCfg(322072093)
				local var_392_3 = arg_389_1:FormatText(var_392_2.content)

				arg_389_1.text_.text = var_392_3

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_5 = 22 <= 0 and var_392_1 or var_392_1 * (utf8.len(var_392_3) / 22)

				if (22 <= 0 and var_392_1 or var_392_1 * (utf8.len(var_392_3) / 22)) > 0 and var_392_1 < var_392_5 then
					arg_389_1.talkMaxDuration = var_392_5

					if var_392_5 + var_392_0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_5 + var_392_0
					end
				end

				arg_389_1.text_.text = var_392_3
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072093", "story_v_out_322072.awb") ~= 0 then
					local var_392_6 = manager.audio:GetVoiceLength("story_v_out_322072", "322072093", "story_v_out_322072.awb") / 1000

					if var_392_6 + var_392_0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_6 + var_392_0
					end

					if var_392_2.prefab_name ~= "" and arg_389_1.actors_[var_392_2.prefab_name] ~= nil then
						local var_392_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_2.prefab_name].transform, "story_v_out_322072", "322072093", "story_v_out_322072.awb")

						arg_389_1:RecordAudio("322072093", var_392_7)
						arg_389_1:RecordAudio("322072093", var_392_7)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_322072", "322072093", "story_v_out_322072.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_322072", "322072093", "story_v_out_322072.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_8 = math.max(var_392_1, arg_389_1.talkMaxDuration)

			if var_392_0 <= arg_389_1.time_ and arg_389_1.time_ < var_392_0 + var_392_8 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_0) / var_392_8

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_0 + var_392_8 and arg_389_1.time_ < var_392_0 + var_392_8 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play322072094 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 322072094
		arg_393_1.duration_ = 4.27

		local var_393_0 = {
			zh = 3.533,
			ja = 4.266
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play322072095(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.var_.moveOldPos1284ui_story = arg_393_1.actors_["1284ui_story"].transform.localPosition

				arg_393_1:ShowWeapon(arg_393_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_396_0 = 0.001

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 then
				arg_393_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_393_1.time_ - 0) / var_396_0)
				arg_393_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_393_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1284ui_story"].transform.position).z)
				arg_393_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_393_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_393_1.actors_["1284ui_story"].transform.localEulerAngles = arg_393_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 then
				arg_393_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				arg_393_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_393_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1284ui_story"].transform.position).z)
				arg_393_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_393_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_393_1.actors_["1284ui_story"].transform.localEulerAngles = arg_393_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_396_1 = arg_393_1.actors_["1284ui_story"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_1) and arg_393_1.var_.characterEffect1284ui_story == nil then
				arg_393_1.var_.characterEffect1284ui_story = var_396_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_2 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_2 and not isNil(var_396_1) then
				if arg_393_1.var_.characterEffect1284ui_story and not isNil(var_396_1) then
					arg_393_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= 0 + var_396_2 and arg_393_1.time_ < 0 + var_396_2 + arg_396_0 and not isNil(var_396_1) and arg_393_1.var_.characterEffect1284ui_story then
				arg_393_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_396_4 = arg_393_1.actors_["404001ui_story"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_4) and arg_393_1.var_.characterEffect404001ui_story == nil then
				arg_393_1.var_.characterEffect404001ui_story = var_396_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_5 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_5 and not isNil(var_396_4) then
				if arg_393_1.var_.characterEffect404001ui_story and not isNil(var_396_4) then
					arg_393_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_393_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_393_1.time_ - 0) / var_396_5)
				end
			end

			if arg_393_1.time_ >= 0 + var_396_5 and arg_393_1.time_ < 0 + var_396_5 + arg_396_0 and not isNil(var_396_4) and arg_393_1.var_.characterEffect404001ui_story then
				arg_393_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_393_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_1")
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_396_6 = 0
			local var_396_7 = 0.35

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_6 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_8 = arg_393_1:GetWordFromCfg(322072094)
				local var_396_9 = arg_393_1:FormatText(var_396_8.content)

				arg_393_1.text_.text = var_396_9

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_11 = 14 <= 0 and var_396_7 or var_396_7 * (utf8.len(var_396_9) / 14)

				if (14 <= 0 and var_396_7 or var_396_7 * (utf8.len(var_396_9) / 14)) > 0 and var_396_7 < var_396_11 then
					arg_393_1.talkMaxDuration = var_396_11

					if var_396_11 + var_396_6 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_11 + var_396_6
					end
				end

				arg_393_1.text_.text = var_396_9
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072094", "story_v_out_322072.awb") ~= 0 then
					local var_396_12 = manager.audio:GetVoiceLength("story_v_out_322072", "322072094", "story_v_out_322072.awb") / 1000

					if var_396_12 + var_396_6 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_12 + var_396_6
					end

					if var_396_8.prefab_name ~= "" and arg_393_1.actors_[var_396_8.prefab_name] ~= nil then
						local var_396_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_8.prefab_name].transform, "story_v_out_322072", "322072094", "story_v_out_322072.awb")

						arg_393_1:RecordAudio("322072094", var_396_13)
						arg_393_1:RecordAudio("322072094", var_396_13)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_322072", "322072094", "story_v_out_322072.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_322072", "322072094", "story_v_out_322072.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_14 = math.max(var_396_7, arg_393_1.talkMaxDuration)

			if var_396_6 <= arg_393_1.time_ and arg_393_1.time_ < var_396_6 + var_396_14 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_6) / var_396_14

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_6 + var_396_14 and arg_393_1.time_ < var_396_6 + var_396_14 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
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

		arg_393_1:InitPlayNodeList()
	end,
	Play322072095 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 322072095
		arg_397_1.duration_ = 9

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play322072096(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if arg_397_1.bgs_.MS2202 == nil then
				local var_400_0 = Object.Instantiate(arg_397_1.paintGo_)

				var_400_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2202")
				var_400_0.name = "MS2202"
				var_400_0.transform.parent = arg_397_1.stage_.transform
				var_400_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_397_1.bgs_.MS2202 = var_400_0
			end

			if 2 < arg_397_1.time_ and arg_397_1.time_ <= 2 + arg_400_0 then
				local var_400_1 = arg_397_1.bgs_.MS2202

				arg_397_1.bgs_.MS2202.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_400_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_400_2 = var_400_1:GetComponent("SpriteRenderer")

				if var_400_2 and var_400_2.sprite then
					local var_400_3 = 2 * (var_400_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_400_1.transform.localScale = Vector3.New(var_400_3 / var_400_2.sprite.bounds.size.y < var_400_3 * manager.ui.mainCameraCom_.aspect / var_400_2.sprite.bounds.size.x and var_400_3 * manager.ui.mainCameraCom_.aspect / var_400_2.sprite.bounds.size.x or var_400_3 / var_400_2.sprite.bounds.size.y, var_400_3 / var_400_2.sprite.bounds.size.y < var_400_3 * manager.ui.mainCameraCom_.aspect / var_400_2.sprite.bounds.size.x and var_400_3 * manager.ui.mainCameraCom_.aspect / var_400_2.sprite.bounds.size.x or var_400_3 / var_400_2.sprite.bounds.size.y, 0)
				end

				for iter_400_0, iter_400_1 in pairs(arg_397_1.bgs_) do
					if iter_400_0 ~= "MS2202" then
						iter_400_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_400_4 = 4

			if 4 < arg_397_1.time_ and arg_397_1.time_ <= var_400_4 + arg_400_0 then
				arg_397_1.allBtn_.enabled = false
			end

			if arg_397_1.time_ >= var_400_4 + 0.3 and arg_397_1.time_ < var_400_4 + 0.3 + arg_400_0 then
				arg_397_1.allBtn_.enabled = true
			end

			local var_400_5 = 0

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_5 + arg_400_0 then
				arg_397_1.mask_.enabled = true
				arg_397_1.mask_.raycastTarget = true

				arg_397_1:SetGaussion(false)
			end

			local var_400_6 = 2

			if var_400_5 <= arg_397_1.time_ and arg_397_1.time_ < var_400_5 + var_400_6 then
				local var_400_7 = Color.New(0, 0, 0)

				var_400_7.a = Mathf.Lerp(0, 1, (arg_397_1.time_ - var_400_5) / var_400_6)
				arg_397_1.mask_.color = var_400_7
			end

			if arg_397_1.time_ >= var_400_5 + var_400_6 and arg_397_1.time_ < var_400_5 + var_400_6 + arg_400_0 then
				local var_400_8 = Color.New(0, 0, 0)

				var_400_8.a = 1
				arg_397_1.mask_.color = var_400_8
			end

			local var_400_9 = 2

			if 2 < arg_397_1.time_ and arg_397_1.time_ <= var_400_9 + arg_400_0 then
				arg_397_1.mask_.enabled = true
				arg_397_1.mask_.raycastTarget = true

				arg_397_1:SetGaussion(false)
			end

			local var_400_10 = 2

			if var_400_9 <= arg_397_1.time_ and arg_397_1.time_ < var_400_9 + var_400_10 then
				local var_400_11 = Color.New(0, 0, 0)

				var_400_11.a = Mathf.Lerp(1, 0, (arg_397_1.time_ - var_400_9) / var_400_10)
				arg_397_1.mask_.color = var_400_11
			end

			if arg_397_1.time_ >= var_400_9 + var_400_10 and arg_397_1.time_ < var_400_9 + var_400_10 + arg_400_0 then
				local var_400_12 = Color.New(0, 0, 0)

				arg_397_1.mask_.enabled = false
				var_400_12.a = 0
				arg_397_1.mask_.color = var_400_12
			end

			local var_400_13 = arg_397_1.actors_["1284ui_story"].transform

			if 1.96599999815226 < arg_397_1.time_ and arg_397_1.time_ <= 1.96599999815226 + arg_400_0 then
				arg_397_1.var_.moveOldPos1284ui_story = var_400_13.localPosition
			end

			local var_400_14 = 0.001

			if 1.96599999815226 <= arg_397_1.time_ and arg_397_1.time_ < 1.96599999815226 + var_400_14 then
				var_400_13.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_397_1.time_ - 1.96599999815226) / var_400_14)
				var_400_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_400_13.position).x, (manager.ui.mainCamera.transform.position - var_400_13.position).y, (manager.ui.mainCamera.transform.position - var_400_13.position).z)
				var_400_13.localEulerAngles.z = 0
				var_400_13.localEulerAngles.x = 0
				var_400_13.localEulerAngles = var_400_13.localEulerAngles
			end

			if arg_397_1.time_ >= 1.96599999815226 + var_400_14 and arg_397_1.time_ < 1.96599999815226 + var_400_14 + arg_400_0 then
				var_400_13.localPosition = Vector3.New(0, 100, 0)
				var_400_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_400_13.position).x, (manager.ui.mainCamera.transform.position - var_400_13.position).y, (manager.ui.mainCamera.transform.position - var_400_13.position).z)
				var_400_13.localEulerAngles.z = 0
				var_400_13.localEulerAngles.x = 0
				var_400_13.localEulerAngles = var_400_13.localEulerAngles
			end

			local var_400_15 = arg_397_1.actors_["404001ui_story"].transform

			if 1.96599999815226 < arg_397_1.time_ and arg_397_1.time_ <= 1.96599999815226 + arg_400_0 then
				arg_397_1.var_.moveOldPos404001ui_story = var_400_15.localPosition
			end

			local var_400_16 = 0.001

			if 1.96599999815226 <= arg_397_1.time_ and arg_397_1.time_ < 1.96599999815226 + var_400_16 then
				var_400_15.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_397_1.time_ - 1.96599999815226) / var_400_16)
				var_400_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_400_15.position).x, (manager.ui.mainCamera.transform.position - var_400_15.position).y, (manager.ui.mainCamera.transform.position - var_400_15.position).z)
				var_400_15.localEulerAngles.z = 0
				var_400_15.localEulerAngles.x = 0
				var_400_15.localEulerAngles = var_400_15.localEulerAngles
			end

			if arg_397_1.time_ >= 1.96599999815226 + var_400_16 and arg_397_1.time_ < 1.96599999815226 + var_400_16 + arg_400_0 then
				var_400_15.localPosition = Vector3.New(0, 100, 0)
				var_400_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_400_15.position).x, (manager.ui.mainCamera.transform.position - var_400_15.position).y, (manager.ui.mainCamera.transform.position - var_400_15.position).z)
				var_400_15.localEulerAngles.z = 0
				var_400_15.localEulerAngles.x = 0
				var_400_15.localEulerAngles = var_400_15.localEulerAngles
			end

			if 0.2 < arg_397_1.time_ and arg_397_1.time_ <= 0.2 + arg_400_0 then
				arg_397_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			if 1.6 < arg_397_1.time_ and arg_397_1.time_ <= 1.6 + arg_400_0 then
				arg_397_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_stone_l19f", "")
			end

			if 4.2 < arg_397_1.time_ and arg_397_1.time_ <= 4.2 + arg_400_0 then
				arg_397_1:AudioAction("play", "effect", "se_story_145", "se_story_145_summon_energy", "")
			end

			if arg_397_1.frameCnt_ <= 1 then
				arg_397_1.dialog_:SetActive(false)
			end

			local var_400_20 = 4
			local var_400_21 = 1.625

			if 4 < arg_397_1.time_ and arg_397_1.time_ <= var_400_20 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0

				arg_397_1.dialog_:SetActive(true)

				arg_397_1.dialogCg_.alpha = 0

				local var_400_22 = LeanTween.value(arg_397_1.dialog_, 0, 1, 0.3)

				var_400_22:setOnUpdate(LuaHelper.FloatAction(function(arg_401_0)
					arg_397_1.dialogCg_.alpha = arg_401_0
				end))
				var_400_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_397_1.dialog_)
					var_400_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_397_1.duration_ = arg_397_1.duration_ + 0.3

				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_23 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(322072095).content)

				arg_397_1.text_.text = var_400_23

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_25 = 65 <= 0 and var_400_21 or var_400_21 * (utf8.len(var_400_23) / 65)

				if (65 <= 0 and var_400_21 or var_400_21 * (utf8.len(var_400_23) / 65)) > 0 and var_400_21 < var_400_25 then
					arg_397_1.talkMaxDuration = var_400_25
					var_400_20 = var_400_20 + 0.3

					if var_400_25 + var_400_20 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_25 + var_400_20
					end
				end

				arg_397_1.text_.text = var_400_23
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_26 = var_400_20 + 0.3
			local var_400_27 = math.max(var_400_21, arg_397_1.talkMaxDuration)

			if var_400_20 + 0.3 <= arg_397_1.time_ and arg_397_1.time_ < var_400_26 + var_400_27 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_26) / var_400_27

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_26 + var_400_27 and arg_397_1.time_ < var_400_26 + var_400_27 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
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
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play322072096 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 322072096
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play322072097(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 1.2

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, false)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_1 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(322072096).content)

				arg_403_1.text_.text = var_406_1

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_3 = 48 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 48)

				if (48 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 48)) > 0 and var_406_0 < var_406_3 then
					arg_403_1.talkMaxDuration = var_406_3

					if var_406_3 + 0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_3 + 0
					end
				end

				arg_403_1.text_.text = var_406_1
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_4 = math.max(var_406_0, arg_403_1.talkMaxDuration)

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_4 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - 0) / var_406_4

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= 0 + var_406_4 and arg_403_1.time_ < 0 + var_406_4 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play322072097 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 322072097
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play322072098(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0.8 < arg_407_1.time_ and arg_407_1.time_ <= 0.8 + arg_410_0 then
				arg_407_1:AudioAction("play", "effect", "se_story_141", "se_story_141_sword_aim", "")
			end

			local var_410_1 = 0
			local var_410_2 = 1.35

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_3 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(322072097).content)

				arg_407_1.text_.text = var_410_3

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_5 = 54 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_3) / 54)

				if (54 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_3) / 54)) > 0 and var_410_2 < var_410_5 then
					arg_407_1.talkMaxDuration = var_410_5

					if var_410_5 + var_410_1 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_5 + var_410_1
					end
				end

				arg_407_1.text_.text = var_410_3
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_6 = math.max(var_410_2, arg_407_1.talkMaxDuration)

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_6 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_1) / var_410_6

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_1 + var_410_6 and arg_407_1.time_ < var_410_1 + var_410_6 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play322072098 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 322072098
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play322072099(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0.6 < arg_411_1.time_ and arg_411_1.time_ <= 0.6 + arg_414_0 then
				arg_411_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_fireanergy1", "")
			end

			local var_414_1 = 0
			local var_414_2 = 1.35

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_3 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(322072098).content)

				arg_411_1.text_.text = var_414_3

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_5 = 54 <= 0 and var_414_2 or var_414_2 * (utf8.len(var_414_3) / 54)

				if (54 <= 0 and var_414_2 or var_414_2 * (utf8.len(var_414_3) / 54)) > 0 and var_414_2 < var_414_5 then
					arg_411_1.talkMaxDuration = var_414_5

					if var_414_5 + var_414_1 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_5 + var_414_1
					end
				end

				arg_411_1.text_.text = var_414_3
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_6 = math.max(var_414_2, arg_411_1.talkMaxDuration)

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_6 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_1) / var_414_6

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_1 + var_414_6 and arg_411_1.time_ < var_414_1 + var_414_6 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play322072099 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 322072099
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play322072100(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0.1 < arg_415_1.time_ and arg_415_1.time_ <= 0.1 + arg_418_0 then
				arg_415_1:AudioAction("play", "effect", "se_story_145", "se_story_145_monster_scream03", "")
			end

			local var_418_1 = manager.ui.mainCamera.transform

			if 0.1 < arg_415_1.time_ and arg_415_1.time_ <= 0.1 + arg_418_0 then
				arg_415_1.var_.shakeOldPos = var_418_1.localPosition
			end

			local var_418_2 = 0.533333333333333

			if 0.1 <= arg_415_1.time_ and arg_415_1.time_ < 0.1 + var_418_2 then
				local var_418_3, var_418_4 = math.modf((arg_415_1.time_ - 0.1) / 0.066)

				var_418_1.localPosition = Vector3.New(var_418_4 * 0.13, var_418_4 * 0.13, var_418_4 * 0.13) + arg_415_1.var_.shakeOldPos
			end

			if arg_415_1.time_ >= 0.1 + var_418_2 and arg_415_1.time_ < 0.1 + var_418_2 + arg_418_0 then
				var_418_1.localPosition = arg_415_1.var_.shakeOldPos
			end

			local var_418_5 = 0
			local var_418_6 = 0.075

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_5 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[1363].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4052")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_7 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(322072099).content)

				arg_415_1.text_.text = var_418_7

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_9 = 3 <= 0 and var_418_6 or var_418_6 * (utf8.len(var_418_7) / 3)

				if (3 <= 0 and var_418_6 or var_418_6 * (utf8.len(var_418_7) / 3)) > 0 and var_418_6 < var_418_9 then
					arg_415_1.talkMaxDuration = var_418_9

					if var_418_9 + var_418_5 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_9 + var_418_5
					end
				end

				arg_415_1.text_.text = var_418_7
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_10 = math.max(var_418_6, arg_415_1.talkMaxDuration)

			if var_418_5 <= arg_415_1.time_ and arg_415_1.time_ < var_418_5 + var_418_10 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_5) / var_418_10

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_5 + var_418_10 and arg_415_1.time_ < var_418_5 + var_418_10 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play322072100 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 322072100
		arg_419_1.duration_ = 3.8

		local var_419_0 = {
			zh = 3.5,
			ja = 3.8
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play322072101(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0.2

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, true)
				arg_419_1.iconController_:SetSelectedState("hero")

				arg_419_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3055")

				arg_419_1.callingController_:SetSelectedState("normal")

				arg_419_1.keyicon_.color = Color.New(1, 1, 1)
				arg_419_1.icon_.color = Color.New(1, 1, 1)

				local var_422_1 = arg_419_1:GetWordFromCfg(322072100)
				local var_422_2 = arg_419_1:FormatText(var_422_1.content)

				arg_419_1.text_.text = var_422_2

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_4 = 8 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_2) / 8)

				if (8 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_2) / 8)) > 0 and var_422_0 < var_422_4 then
					arg_419_1.talkMaxDuration = var_422_4

					if var_422_4 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_4 + 0
					end
				end

				arg_419_1.text_.text = var_422_2
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072100", "story_v_out_322072.awb") ~= 0 then
					local var_422_5 = manager.audio:GetVoiceLength("story_v_out_322072", "322072100", "story_v_out_322072.awb") / 1000

					if var_422_5 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_5 + 0
					end

					if var_422_1.prefab_name ~= "" and arg_419_1.actors_[var_422_1.prefab_name] ~= nil then
						local var_422_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_1.prefab_name].transform, "story_v_out_322072", "322072100", "story_v_out_322072.awb")

						arg_419_1:RecordAudio("322072100", var_422_6)
						arg_419_1:RecordAudio("322072100", var_422_6)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_322072", "322072100", "story_v_out_322072.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_322072", "322072100", "story_v_out_322072.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_7 = math.max(var_422_0, arg_419_1.talkMaxDuration)

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_7 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - 0) / var_422_7

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= 0 + var_422_7 and arg_419_1.time_ < 0 + var_422_7 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play322072101 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 322072101
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play322072102(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_9000

			if 0.2 < arg_423_1.time_ and arg_423_1.time_ <= 0.2 + arg_426_0 then
				arg_423_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_swordlight", "")
			end

			if 0.6 < arg_423_1.time_ and arg_423_1.time_ <= 0.6 + arg_426_0 then
				local var_426_1 = arg_423_1.var_.effect72101

				if not arg_423_1.var_.effect72101 then
					var_426_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xdaoguang"), manager.ui.mainCamera.transform)
					var_426_1.name = "72101"
					arg_423_1.var_.effect72101 = var_426_1
				else
					var_426_1.transform:SetParent(var_426_9000)
				end

				var_426_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_426_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_426_3 = 0
			local var_426_4 = 1.45

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_3 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_5 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(322072101).content)

				arg_423_1.text_.text = var_426_5

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_7 = 58 <= 0 and var_426_4 or var_426_4 * (utf8.len(var_426_5) / 58)

				if (58 <= 0 and var_426_4 or var_426_4 * (utf8.len(var_426_5) / 58)) > 0 and var_426_4 < var_426_7 then
					arg_423_1.talkMaxDuration = var_426_7

					if var_426_7 + var_426_3 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_7 + var_426_3
					end
				end

				arg_423_1.text_.text = var_426_5
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_8 = math.max(var_426_4, arg_423_1.talkMaxDuration)

			if var_426_3 <= arg_423_1.time_ and arg_423_1.time_ < var_426_3 + var_426_8 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_3) / var_426_8

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_3 + var_426_8 and arg_423_1.time_ < var_426_3 + var_426_8 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play322072102 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 322072102
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play322072103(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 1.075

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, false)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_1 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(322072102).content)

				arg_427_1.text_.text = var_430_1

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_3 = 43 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_1) / 43)

				if (43 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_1) / 43)) > 0 and var_430_0 < var_430_3 then
					arg_427_1.talkMaxDuration = var_430_3

					if var_430_3 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_3 + 0
					end
				end

				arg_427_1.text_.text = var_430_1
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_4 = math.max(var_430_0, arg_427_1.talkMaxDuration)

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_4 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - 0) / var_430_4

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= 0 + var_430_4 and arg_427_1.time_ < 0 + var_430_4 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play322072103 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 322072103
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play322072104(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0.3 < arg_431_1.time_ and arg_431_1.time_ <= 0.3 + arg_434_0 then
				arg_431_1:AudioAction("play", "effect", "se_story_145", "se_story_145_ding", "")
			end

			local var_434_1 = 0
			local var_434_2 = 1.125

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_3 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(322072103).content)

				arg_431_1.text_.text = var_434_3

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_5 = 45 <= 0 and var_434_2 or var_434_2 * (utf8.len(var_434_3) / 45)

				if (45 <= 0 and var_434_2 or var_434_2 * (utf8.len(var_434_3) / 45)) > 0 and var_434_2 < var_434_5 then
					arg_431_1.talkMaxDuration = var_434_5

					if var_434_5 + var_434_1 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_5 + var_434_1
					end
				end

				arg_431_1.text_.text = var_434_3
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_6 = math.max(var_434_2, arg_431_1.talkMaxDuration)

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_6 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_1) / var_434_6

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_1 + var_434_6 and arg_431_1.time_ < var_434_1 + var_434_6 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play322072104 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 322072104
		arg_435_1.duration_ = 3

		local var_435_0 = {
			zh = 2.266,
			ja = 3
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play322072105(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0.2

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061_split_1")

				arg_435_1.callingController_:SetSelectedState("calling")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_1 = arg_435_1:GetWordFromCfg(322072104)
				local var_438_2 = arg_435_1:FormatText(var_438_1.content)

				arg_435_1.text_.text = var_438_2

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_4 = 8 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_2) / 8)

				if (8 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_2) / 8)) > 0 and var_438_0 < var_438_4 then
					arg_435_1.talkMaxDuration = var_438_4

					if var_438_4 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_4 + 0
					end
				end

				arg_435_1.text_.text = var_438_2
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072104", "story_v_out_322072.awb") ~= 0 then
					local var_438_5 = manager.audio:GetVoiceLength("story_v_out_322072", "322072104", "story_v_out_322072.awb") / 1000

					if var_438_5 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_5 + 0
					end

					if var_438_1.prefab_name ~= "" and arg_435_1.actors_[var_438_1.prefab_name] ~= nil then
						local var_438_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_1.prefab_name].transform, "story_v_out_322072", "322072104", "story_v_out_322072.awb")

						arg_435_1:RecordAudio("322072104", var_438_6)
						arg_435_1:RecordAudio("322072104", var_438_6)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_322072", "322072104", "story_v_out_322072.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_322072", "322072104", "story_v_out_322072.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_7 = math.max(var_438_0, arg_435_1.talkMaxDuration)

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_7 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - 0) / var_438_7

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= 0 + var_438_7 and arg_435_1.time_ < 0 + var_438_7 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play322072105 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 322072105
		arg_439_1.duration_ = 7

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play322072106(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_9001
			local var_442_9000

			if arg_439_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_442_0 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_439_1.stage_.transform)

				var_442_0.name = "1061ui_story"
				var_442_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_439_1.actors_["1061ui_story"] = var_442_0

				local var_442_1 = var_442_0:GetComponentInChildren(typeof(CharacterEffect))

				var_442_1.enabled = true

				local var_442_2 = GameObjectTools.GetOrAddComponent(var_442_0, typeof(DynamicBoneHelper))

				if var_442_2 then
					var_442_2:EnableDynamicBone(false)
				end

				arg_439_1:ShowWeapon(var_442_1.transform, false)

				arg_439_1.var_["1061ui_story" .. "Animator"] = var_442_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_439_1.var_["1061ui_story" .. "Animator"].applyRootMotion = true
				arg_439_1.var_["1061ui_story" .. "LipSync"] = var_442_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_442_3 = arg_439_1.actors_["1061ui_story"].transform

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.var_.moveOldPos1061ui_story = var_442_3.localPosition
			end

			local var_442_4 = 0.001

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_4 then
				var_442_3.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_439_1.time_ - 0) / var_442_4)
				var_442_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_442_3.position).x, (manager.ui.mainCamera.transform.position - var_442_3.position).y, (manager.ui.mainCamera.transform.position - var_442_3.position).z)
				var_442_3.localEulerAngles.z = 0
				var_442_3.localEulerAngles.x = 0
				var_442_3.localEulerAngles = var_442_3.localEulerAngles
			end

			if arg_439_1.time_ >= 0 + var_442_4 and arg_439_1.time_ < 0 + var_442_4 + arg_442_0 then
				var_442_3.localPosition = Vector3.New(0, 100, 0)
				var_442_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_442_3.position).x, (manager.ui.mainCamera.transform.position - var_442_3.position).y, (manager.ui.mainCamera.transform.position - var_442_3.position).z)
				var_442_3.localEulerAngles.z = 0
				var_442_3.localEulerAngles.x = 0
				var_442_3.localEulerAngles = var_442_3.localEulerAngles
			end

			local var_442_5 = arg_439_1.actors_["1061ui_story"]

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(var_442_5) and arg_439_1.var_.characterEffect1061ui_story == nil then
				arg_439_1.var_.characterEffect1061ui_story = var_442_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_6 = 0.200000002980232

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_6 and not isNil(var_442_5) then
				if arg_439_1.var_.characterEffect1061ui_story and not isNil(var_442_5) then
					arg_439_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_439_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_439_1.time_ - 0) / var_442_6)
				end
			end

			if arg_439_1.time_ >= 0 + var_442_6 and arg_439_1.time_ < 0 + var_442_6 + arg_442_0 and not isNil(var_442_5) and arg_439_1.var_.characterEffect1061ui_story then
				arg_439_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_439_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0.200000002980232 < arg_439_1.time_ and arg_439_1.time_ <= 0.200000002980232 + arg_442_0 then
				arg_439_1:AudioAction("play", "effect", "se_story_140", "se_story_140_explosion04", "")
			end

			if 0.366666666666667 < arg_439_1.time_ and arg_439_1.time_ <= 0.366666666666667 + arg_442_0 then
				local var_442_8 = arg_439_1.var_.effect2105

				if not arg_439_1.var_.effect2105 then
					var_442_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boom"), manager.ui.mainCamera.transform)
					var_442_8.name = "2105"
					arg_439_1.var_.effect2105 = var_442_8
				else
					var_442_8.transform:SetParent(var_442_9001)
				end

				var_442_8.transform.localPosition = Vector3.New(0, 0, -2.64)
				var_442_8.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_442_10 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_442_11 = var_442_8.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_442_0, iter_442_1 in ipairs((var_442_11:ToTable())) do
					iter_442_1.transform.localScale = Vector3.New(iter_442_1.transform.localScale.x / var_442_10 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_442_11 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_442_1.transform.localScale.y / var_442_10, iter_442_1.transform.localScale.z)
				end
			end

			if 3.525 < arg_439_1.time_ and arg_439_1.time_ <= 3.525 + arg_442_0 then
				if arg_439_1.var_.effect2105 then
					Object.Destroy(arg_439_1.var_.effect2105)

					arg_439_1.var_.effect2105 = nil
				end
			end

			if 0.366666666666667 < arg_439_1.time_ and arg_439_1.time_ <= 0.366666666666667 + arg_442_0 then
				local var_442_14 = arg_439_1.var_.effect21051

				if not arg_439_1.var_.effect21051 then
					var_442_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_442_14.name = "21051"
					arg_439_1.var_.effect21051 = var_442_14
				else
					var_442_14.transform:SetParent(var_442_9000)
				end

				var_442_14.transform.localPosition = Vector3.New(0, 0, -10)
				var_442_14.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_442_16 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_442_17 = var_442_14.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_442_2, iter_442_3 in ipairs((var_442_17:ToTable())) do
					iter_442_3.transform.localScale = Vector3.New(iter_442_3.transform.localScale.x / var_442_16 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_442_17 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_442_3.transform.localScale.y / var_442_16, iter_442_3.transform.localScale.z)
				end
			end

			if 3.53333333333333 < arg_439_1.time_ and arg_439_1.time_ <= 3.53333333333333 + arg_442_0 then
				if arg_439_1.var_.effect21051 then
					Object.Destroy(arg_439_1.var_.effect21051)

					arg_439_1.var_.effect21051 = nil
				end
			end

			local var_442_20 = manager.ui.mainCamera.transform

			if 0.366666666666667 < arg_439_1.time_ and arg_439_1.time_ <= 0.366666666666667 + arg_442_0 then
				arg_439_1.var_.shakeOldPos = var_442_20.localPosition
			end

			local var_442_21 = 1.8

			if 0.366666666666667 <= arg_439_1.time_ and arg_439_1.time_ < 0.366666666666667 + var_442_21 then
				local var_442_22, var_442_23 = math.modf((arg_439_1.time_ - 0.366666666666667) / 0.066)

				var_442_20.localPosition = Vector3.New(var_442_23 * 0.13, var_442_23 * 0.13, var_442_23 * 0.13) + arg_439_1.var_.shakeOldPos
			end

			if arg_439_1.time_ >= 0.366666666666667 + var_442_21 and arg_439_1.time_ < 0.366666666666667 + var_442_21 + arg_442_0 then
				var_442_20.localPosition = arg_439_1.var_.shakeOldPos
			end

			if arg_439_1.frameCnt_ <= 1 then
				arg_439_1.dialog_:SetActive(false)
			end

			local var_442_24 = 2
			local var_442_25 = 1.525

			if 2 < arg_439_1.time_ and arg_439_1.time_ <= var_442_24 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0

				arg_439_1.dialog_:SetActive(true)

				arg_439_1.dialogCg_.alpha = 0

				local var_442_26 = LeanTween.value(arg_439_1.dialog_, 0, 1, 0.3)

				var_442_26:setOnUpdate(LuaHelper.FloatAction(function(arg_443_0)
					arg_439_1.dialogCg_.alpha = arg_443_0
				end))
				var_442_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_439_1.dialog_)
					var_442_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_439_1.duration_ = arg_439_1.duration_ + 0.3

				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_27 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(322072105).content)

				arg_439_1.text_.text = var_442_27

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_29 = 61 <= 0 and var_442_25 or var_442_25 * (utf8.len(var_442_27) / 61)

				if (61 <= 0 and var_442_25 or var_442_25 * (utf8.len(var_442_27) / 61)) > 0 and var_442_25 < var_442_29 then
					arg_439_1.talkMaxDuration = var_442_29
					var_442_24 = var_442_24 + 0.3

					if var_442_29 + var_442_24 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_29 + var_442_24
					end
				end

				arg_439_1.text_.text = var_442_27
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_30 = var_442_24 + 0.3
			local var_442_31 = math.max(var_442_25, arg_439_1.talkMaxDuration)

			if var_442_24 + 0.3 <= arg_439_1.time_ and arg_439_1.time_ < var_442_30 + var_442_31 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_30) / var_442_31

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_30 + var_442_31 and arg_439_1.time_ < var_442_30 + var_442_31 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_439_1:InitPlayNodeList()
	end,
	Play322072106 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 322072106
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play322072107(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				if arg_445_1.var_.effect2105 then
					Object.Destroy(arg_445_1.var_.effect2105)

					arg_445_1.var_.effect2105 = nil
				end
			end

			local var_448_1 = 0
			local var_448_2 = 1.125

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_3 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(322072106).content)

				arg_445_1.text_.text = var_448_3

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 45 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 45)

				if (45 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 45)) > 0 and var_448_2 < var_448_5 then
					arg_445_1.talkMaxDuration = var_448_5

					if var_448_5 + var_448_1 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_5 + var_448_1
					end
				end

				arg_445_1.text_.text = var_448_3
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_6 = math.max(var_448_2, arg_445_1.talkMaxDuration)

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_6 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_1) / var_448_6

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_1 + var_448_6 and arg_445_1.time_ < var_448_1 + var_448_6 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play322072107 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 322072107
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play322072108(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0.1 < arg_449_1.time_ and arg_449_1.time_ <= 0.1 + arg_452_0 then
				arg_449_1:AudioAction("play", "effect", "se_story_145", "se_story_145_monster_roar1", "")
			end

			local var_452_1 = manager.ui.mainCamera.transform

			if 0.1 < arg_449_1.time_ and arg_449_1.time_ <= 0.1 + arg_452_0 then
				arg_449_1.var_.shakeOldPos = var_452_1.localPosition
			end

			local var_452_2 = 0.6

			if 0.1 <= arg_449_1.time_ and arg_449_1.time_ < 0.1 + var_452_2 then
				local var_452_3, var_452_4 = math.modf((arg_449_1.time_ - 0.1) / 0.066)

				var_452_1.localPosition = Vector3.New(var_452_4 * 0.13, var_452_4 * 0.13, var_452_4 * 0.13) + arg_449_1.var_.shakeOldPos
			end

			if arg_449_1.time_ >= 0.1 + var_452_2 and arg_449_1.time_ < 0.1 + var_452_2 + arg_452_0 then
				var_452_1.localPosition = arg_449_1.var_.shakeOldPos
			end

			local var_452_5 = 0
			local var_452_6 = 0.1

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_5 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[1363].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4052")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_7 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(322072107).content)

				arg_449_1.text_.text = var_452_7

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_9 = 4 <= 0 and var_452_6 or var_452_6 * (utf8.len(var_452_7) / 4)

				if (4 <= 0 and var_452_6 or var_452_6 * (utf8.len(var_452_7) / 4)) > 0 and var_452_6 < var_452_9 then
					arg_449_1.talkMaxDuration = var_452_9

					if var_452_9 + var_452_5 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_9 + var_452_5
					end
				end

				arg_449_1.text_.text = var_452_7
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_10 = math.max(var_452_6, arg_449_1.talkMaxDuration)

			if var_452_5 <= arg_449_1.time_ and arg_449_1.time_ < var_452_5 + var_452_10 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_5) / var_452_10

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_5 + var_452_10 and arg_449_1.time_ < var_452_5 + var_452_10 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play322072108 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 322072108
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play322072109(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_9000

			if 0.233333333333333 < arg_453_1.time_ and arg_453_1.time_ <= 0.233333333333333 + arg_456_0 then
				arg_453_1:AudioAction("play", "effect", "se_story_140", "se_story_140_scythe4", "")
			end

			if 0.233333333333333 < arg_453_1.time_ and arg_453_1.time_ <= 0.233333333333333 + arg_456_0 then
				local var_456_1 = arg_453_1.var_.effect2108

				if not arg_453_1.var_.effect2108 then
					var_456_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), manager.ui.mainCamera.transform)
					var_456_1.name = "2108"
					arg_453_1.var_.effect2108 = var_456_1
				else
					var_456_1.transform:SetParent(var_456_9000)
				end

				var_456_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_456_1.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_456_3 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_456_4 = var_456_1.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_456_0, iter_456_1 in ipairs((var_456_4:ToTable())) do
					iter_456_1.transform.localScale = Vector3.New(iter_456_1.transform.localScale.x / var_456_3 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_456_4 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_456_1.transform.localScale.y / var_456_3, iter_456_1.transform.localScale.z)
				end
			end

			if 1.43333333333333 < arg_453_1.time_ and arg_453_1.time_ <= 1.43333333333333 + arg_456_0 then
				if arg_453_1.var_.effect2108 then
					Object.Destroy(arg_453_1.var_.effect2108)

					arg_453_1.var_.effect2108 = nil
				end
			end

			local var_456_7 = manager.ui.mainCamera.transform

			if 0.233333333333333 < arg_453_1.time_ and arg_453_1.time_ <= 0.233333333333333 + arg_456_0 then
				arg_453_1.var_.shakeOldPos = var_456_7.localPosition
			end

			local var_456_8 = 0.166666666666667

			if 0.233333333333333 <= arg_453_1.time_ and arg_453_1.time_ < 0.233333333333333 + var_456_8 then
				local var_456_9, var_456_10 = math.modf((arg_453_1.time_ - 0.233333333333333) / 0.066)

				var_456_7.localPosition = Vector3.New(var_456_10 * 0.13, var_456_10 * 0.13, var_456_10 * 0.13) + arg_453_1.var_.shakeOldPos
			end

			if arg_453_1.time_ >= 0.233333333333333 + var_456_8 and arg_453_1.time_ < 0.233333333333333 + var_456_8 + arg_456_0 then
				var_456_7.localPosition = arg_453_1.var_.shakeOldPos
			end

			local var_456_11 = 0
			local var_456_12 = 1.75

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_11 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_13 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(322072108).content)

				arg_453_1.text_.text = var_456_13

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_15 = 70 <= 0 and var_456_12 or var_456_12 * (utf8.len(var_456_13) / 70)

				if (70 <= 0 and var_456_12 or var_456_12 * (utf8.len(var_456_13) / 70)) > 0 and var_456_12 < var_456_15 then
					arg_453_1.talkMaxDuration = var_456_15

					if var_456_15 + var_456_11 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_15 + var_456_11
					end
				end

				arg_453_1.text_.text = var_456_13
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_16 = math.max(var_456_12, arg_453_1.talkMaxDuration)

			if var_456_11 <= arg_453_1.time_ and arg_453_1.time_ < var_456_11 + var_456_16 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_11) / var_456_16

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_11 + var_456_16 and arg_453_1.time_ < var_456_11 + var_456_16 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play322072109 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 322072109
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play322072110(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0.166666666666667 < arg_457_1.time_ and arg_457_1.time_ <= 0.166666666666667 + arg_460_0 then
				arg_457_1:AudioAction("play", "effect", "se_story_145", "se_story_145_drone_drop", "")
			end

			local var_460_1 = 0
			local var_460_2 = 1.1

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_3 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(322072109).content)

				arg_457_1.text_.text = var_460_3

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_5 = 44 <= 0 and var_460_2 or var_460_2 * (utf8.len(var_460_3) / 44)

				if (44 <= 0 and var_460_2 or var_460_2 * (utf8.len(var_460_3) / 44)) > 0 and var_460_2 < var_460_5 then
					arg_457_1.talkMaxDuration = var_460_5

					if var_460_5 + var_460_1 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_5 + var_460_1
					end
				end

				arg_457_1.text_.text = var_460_3
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_6 = math.max(var_460_2, arg_457_1.talkMaxDuration)

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_6 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_1) / var_460_6

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_1 + var_460_6 and arg_457_1.time_ < var_460_1 + var_460_6 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play322072110 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 322072110
		arg_461_1.duration_ = 6.97

		local var_461_0 = {
			zh = 6.166,
			ja = 6.966
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
				arg_461_0:Play322072111(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0.8

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_1 = arg_461_1:GetWordFromCfg(322072110)
				local var_464_2 = arg_461_1:FormatText(var_464_1.content)

				arg_461_1.text_.text = var_464_2

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_4 = 32 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_2) / 32)

				if (32 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_2) / 32)) > 0 and var_464_0 < var_464_4 then
					arg_461_1.talkMaxDuration = var_464_4

					if var_464_4 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_4 + 0
					end
				end

				arg_461_1.text_.text = var_464_2
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072110", "story_v_out_322072.awb") ~= 0 then
					local var_464_5 = manager.audio:GetVoiceLength("story_v_out_322072", "322072110", "story_v_out_322072.awb") / 1000

					if var_464_5 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_5 + 0
					end

					if var_464_1.prefab_name ~= "" and arg_461_1.actors_[var_464_1.prefab_name] ~= nil then
						local var_464_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_1.prefab_name].transform, "story_v_out_322072", "322072110", "story_v_out_322072.awb")

						arg_461_1:RecordAudio("322072110", var_464_6)
						arg_461_1:RecordAudio("322072110", var_464_6)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_322072", "322072110", "story_v_out_322072.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_322072", "322072110", "story_v_out_322072.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_7 = math.max(var_464_0, arg_461_1.talkMaxDuration)

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_7 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - 0) / var_464_7

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= 0 + var_464_7 and arg_461_1.time_ < 0 + var_464_7 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play322072111 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 322072111
		arg_465_1.duration_ = 4.8

		local var_465_0 = {
			zh = 3.2,
			ja = 4.8
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play322072112(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0.4

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1211")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_1 = arg_465_1:GetWordFromCfg(322072111)
				local var_468_2 = arg_465_1:FormatText(var_468_1.content)

				arg_465_1.text_.text = var_468_2

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_4 = 16 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_2) / 16)

				if (16 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_2) / 16)) > 0 and var_468_0 < var_468_4 then
					arg_465_1.talkMaxDuration = var_468_4

					if var_468_4 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_4 + 0
					end
				end

				arg_465_1.text_.text = var_468_2
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072111", "story_v_out_322072.awb") ~= 0 then
					local var_468_5 = manager.audio:GetVoiceLength("story_v_out_322072", "322072111", "story_v_out_322072.awb") / 1000

					if var_468_5 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_5 + 0
					end

					if var_468_1.prefab_name ~= "" and arg_465_1.actors_[var_468_1.prefab_name] ~= nil then
						local var_468_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_1.prefab_name].transform, "story_v_out_322072", "322072111", "story_v_out_322072.awb")

						arg_465_1:RecordAudio("322072111", var_468_6)
						arg_465_1:RecordAudio("322072111", var_468_6)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_322072", "322072111", "story_v_out_322072.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_322072", "322072111", "story_v_out_322072.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_7 = math.max(var_468_0, arg_465_1.talkMaxDuration)

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_7 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - 0) / var_468_7

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= 0 + var_468_7 and arg_465_1.time_ < 0 + var_468_7 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play322072112 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 322072112
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play322072113(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if arg_469_1.actors_["1211ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1211ui_story"))) then
				local var_472_0 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_469_1.stage_.transform)

				var_472_0.name = "1211ui_story"
				var_472_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_469_1.actors_["1211ui_story"] = var_472_0

				local var_472_1 = var_472_0:GetComponentInChildren(typeof(CharacterEffect))

				var_472_1.enabled = true

				local var_472_2 = GameObjectTools.GetOrAddComponent(var_472_0, typeof(DynamicBoneHelper))

				if var_472_2 then
					var_472_2:EnableDynamicBone(false)
				end

				arg_469_1:ShowWeapon(var_472_1.transform, false)

				arg_469_1.var_["1211ui_story" .. "Animator"] = var_472_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_469_1.var_["1211ui_story" .. "Animator"].applyRootMotion = true
				arg_469_1.var_["1211ui_story" .. "LipSync"] = var_472_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_472_3 = arg_469_1.actors_["1211ui_story"].transform

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.var_.moveOldPos1211ui_story = var_472_3.localPosition
			end

			local var_472_4 = 0.001

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_4 then
				var_472_3.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_469_1.time_ - 0) / var_472_4)
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

			local var_472_5 = arg_469_1.actors_["404001ui_story"].transform

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.var_.moveOldPos404001ui_story = var_472_5.localPosition
			end

			local var_472_6 = 0.001

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_6 then
				var_472_5.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_469_1.time_ - 0) / var_472_6)
				var_472_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_472_5.position).x, (manager.ui.mainCamera.transform.position - var_472_5.position).y, (manager.ui.mainCamera.transform.position - var_472_5.position).z)
				var_472_5.localEulerAngles.z = 0
				var_472_5.localEulerAngles.x = 0
				var_472_5.localEulerAngles = var_472_5.localEulerAngles
			end

			if arg_469_1.time_ >= 0 + var_472_6 and arg_469_1.time_ < 0 + var_472_6 + arg_472_0 then
				var_472_5.localPosition = Vector3.New(0, 100, 0)
				var_472_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_472_5.position).x, (manager.ui.mainCamera.transform.position - var_472_5.position).y, (manager.ui.mainCamera.transform.position - var_472_5.position).z)
				var_472_5.localEulerAngles.z = 0
				var_472_5.localEulerAngles.x = 0
				var_472_5.localEulerAngles = var_472_5.localEulerAngles
			end

			local var_472_7 = arg_469_1.actors_["1211ui_story"]

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(var_472_7) and arg_469_1.var_.characterEffect1211ui_story == nil then
				arg_469_1.var_.characterEffect1211ui_story = var_472_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_8 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_8 and not isNil(var_472_7) then
				if arg_469_1.var_.characterEffect1211ui_story and not isNil(var_472_7) then
					arg_469_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_469_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_469_1.time_ - 0) / var_472_8)
				end
			end

			if arg_469_1.time_ >= 0 + var_472_8 and arg_469_1.time_ < 0 + var_472_8 + arg_472_0 and not isNil(var_472_7) and arg_469_1.var_.characterEffect1211ui_story then
				arg_469_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_469_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0.566666666666667 < arg_469_1.time_ and arg_469_1.time_ <= 0.566666666666667 + arg_472_0 then
				arg_469_1:AudioAction("play", "effect", "se_story_145", "se_story_145_summon_stars", "")
			end

			local var_472_10 = 0
			local var_472_11 = 1.775

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_10 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_12 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(322072112).content)

				arg_469_1.text_.text = var_472_12

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_14 = 71 <= 0 and var_472_11 or var_472_11 * (utf8.len(var_472_12) / 71)

				if (71 <= 0 and var_472_11 or var_472_11 * (utf8.len(var_472_12) / 71)) > 0 and var_472_11 < var_472_14 then
					arg_469_1.talkMaxDuration = var_472_14

					if var_472_14 + var_472_10 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_14 + var_472_10
					end
				end

				arg_469_1.text_.text = var_472_12
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_15 = math.max(var_472_11, arg_469_1.talkMaxDuration)

			if var_472_10 <= arg_469_1.time_ and arg_469_1.time_ < var_472_10 + var_472_15 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_10) / var_472_15

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_10 + var_472_15 and arg_469_1.time_ < var_472_10 + var_472_15 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
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

		arg_469_1:InitPlayNodeList()
	end,
	Play322072113 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 322072113
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play322072114(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 1.275

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

				local var_476_1 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(322072113).content)

				arg_473_1.text_.text = var_476_1

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_3 = 51 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 51)

				if (51 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 51)) > 0 and var_476_0 < var_476_3 then
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
	Play322072114 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 322072114
		arg_477_1.duration_ = 2.27

		local var_477_0 = {
			zh = 1.9,
			ja = 2.266
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play322072115(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0.225

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_1 = arg_477_1:GetWordFromCfg(322072114)
				local var_480_2 = arg_477_1:FormatText(var_480_1.content)

				arg_477_1.text_.text = var_480_2

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_4 = 9 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_2) / 9)

				if (9 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_2) / 9)) > 0 and var_480_0 < var_480_4 then
					arg_477_1.talkMaxDuration = var_480_4

					if var_480_4 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_4 + 0
					end
				end

				arg_477_1.text_.text = var_480_2
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072114", "story_v_out_322072.awb") ~= 0 then
					local var_480_5 = manager.audio:GetVoiceLength("story_v_out_322072", "322072114", "story_v_out_322072.awb") / 1000

					if var_480_5 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_5 + 0
					end

					if var_480_1.prefab_name ~= "" and arg_477_1.actors_[var_480_1.prefab_name] ~= nil then
						local var_480_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_1.prefab_name].transform, "story_v_out_322072", "322072114", "story_v_out_322072.awb")

						arg_477_1:RecordAudio("322072114", var_480_6)
						arg_477_1:RecordAudio("322072114", var_480_6)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_322072", "322072114", "story_v_out_322072.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_322072", "322072114", "story_v_out_322072.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_7 = math.max(var_480_0, arg_477_1.talkMaxDuration)

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_7 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - 0) / var_480_7

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= 0 + var_480_7 and arg_477_1.time_ < 0 + var_480_7 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play322072115 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 322072115
		arg_481_1.duration_ = 6.43

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play322072116(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_9000

			if 0.433333333333333 < arg_481_1.time_ and arg_481_1.time_ <= 0.433333333333333 + arg_484_0 then
				arg_481_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_explosionfar", "")
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				local var_484_1 = arg_481_1.var_.effect2115

				if not arg_481_1.var_.effect2115 then
					var_484_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), manager.ui.mainCamera.transform)
					var_484_1.name = "2115"
					arg_481_1.var_.effect2115 = var_484_1
				else
					var_484_1.transform:SetParent(var_484_9000)
				end

				var_484_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_484_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.83333333333333 < arg_481_1.time_ and arg_481_1.time_ <= 2.83333333333333 + arg_484_0 then
				if arg_481_1.var_.effect2115 then
					Object.Destroy(arg_481_1.var_.effect2115)

					arg_481_1.var_.effect2115 = nil
				end
			end

			if arg_481_1.frameCnt_ <= 1 then
				arg_481_1.dialog_:SetActive(false)
			end

			local var_484_4 = 1.43333333333333
			local var_484_5 = 0.175

			if 1.43333333333333 < arg_481_1.time_ and arg_481_1.time_ <= var_484_4 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0

				arg_481_1.dialog_:SetActive(true)

				arg_481_1.dialogCg_.alpha = 0

				local var_484_6 = LeanTween.value(arg_481_1.dialog_, 0, 1, 0.3)

				var_484_6:setOnUpdate(LuaHelper.FloatAction(function(arg_485_0)
					arg_481_1.dialogCg_.alpha = arg_485_0
				end))
				var_484_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_481_1.dialog_)
					var_484_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_481_1.duration_ = arg_481_1.duration_ + 0.3

				SetActive(arg_481_1.leftNameGo_, false)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_7 = arg_481_1:FormatText(arg_481_1:GetWordFromCfg(322072115).content)

				arg_481_1.text_.text = var_484_7

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_9 = 7 <= 0 and var_484_5 or var_484_5 * (utf8.len(var_484_7) / 7)

				if (7 <= 0 and var_484_5 or var_484_5 * (utf8.len(var_484_7) / 7)) > 0 and var_484_5 < var_484_9 then
					arg_481_1.talkMaxDuration = var_484_9
					var_484_4 = var_484_4 + 0.3

					if var_484_9 + var_484_4 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_9 + var_484_4
					end
				end

				arg_481_1.text_.text = var_484_7
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_10 = var_484_4 + 0.3
			local var_484_11 = math.max(var_484_5, arg_481_1.talkMaxDuration)

			if var_484_4 + 0.3 <= arg_481_1.time_ and arg_481_1.time_ < var_484_10 + var_484_11 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_10) / var_484_11

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_10 + var_484_11 and arg_481_1.time_ < var_484_10 + var_484_11 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play322072116 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 322072116
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play322072117(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 1.025

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, false)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_1 = arg_487_1:FormatText(arg_487_1:GetWordFromCfg(322072116).content)

				arg_487_1.text_.text = var_490_1

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_3 = 41 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_1) / 41)

				if (41 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_1) / 41)) > 0 and var_490_0 < var_490_3 then
					arg_487_1.talkMaxDuration = var_490_3

					if var_490_3 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_3 + 0
					end
				end

				arg_487_1.text_.text = var_490_1
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_4 = math.max(var_490_0, arg_487_1.talkMaxDuration)

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_4 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - 0) / var_490_4

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= 0 + var_490_4 and arg_487_1.time_ < 0 + var_490_4 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play322072117 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 322072117
		arg_491_1.duration_ = 5

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play322072118(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0.85

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, false)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_1 = arg_491_1:FormatText(arg_491_1:GetWordFromCfg(322072117).content)

				arg_491_1.text_.text = var_494_1

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_3 = 34 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_1) / 34)

				if (34 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_1) / 34)) > 0 and var_494_0 < var_494_3 then
					arg_491_1.talkMaxDuration = var_494_3

					if var_494_3 + 0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_3 + 0
					end
				end

				arg_491_1.text_.text = var_494_1
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)
				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_4 = math.max(var_494_0, arg_491_1.talkMaxDuration)

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_4 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - 0) / var_494_4

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= 0 + var_494_4 and arg_491_1.time_ < 0 + var_494_4 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play322072118 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 322072118
		arg_495_1.duration_ = 3.7

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play322072119(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if arg_495_1.bgs_.STblack == nil then
				local var_498_0 = Object.Instantiate(arg_495_1.paintGo_)

				var_498_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_498_0.name = "STblack"
				var_498_0.transform.parent = arg_495_1.stage_.transform
				var_498_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_495_1.bgs_.STblack = var_498_0
			end

			if 1 < arg_495_1.time_ and arg_495_1.time_ <= 1 + arg_498_0 then
				local var_498_1 = arg_495_1.bgs_.STblack

				arg_495_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_498_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_498_2 = var_498_1:GetComponent("SpriteRenderer")

				if var_498_2 and var_498_2.sprite then
					local var_498_3 = 2 * (var_498_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_498_1.transform.localScale = Vector3.New(var_498_3 / var_498_2.sprite.bounds.size.y < var_498_3 * manager.ui.mainCameraCom_.aspect / var_498_2.sprite.bounds.size.x and var_498_3 * manager.ui.mainCameraCom_.aspect / var_498_2.sprite.bounds.size.x or var_498_3 / var_498_2.sprite.bounds.size.y, var_498_3 / var_498_2.sprite.bounds.size.y < var_498_3 * manager.ui.mainCameraCom_.aspect / var_498_2.sprite.bounds.size.x and var_498_3 * manager.ui.mainCameraCom_.aspect / var_498_2.sprite.bounds.size.x or var_498_3 / var_498_2.sprite.bounds.size.y, 0)
				end

				for iter_498_0, iter_498_1 in pairs(arg_495_1.bgs_) do
					if iter_498_0 ~= "STblack" then
						iter_498_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_498_4 = 1

			if 1 < arg_495_1.time_ and arg_495_1.time_ <= var_498_4 + arg_498_0 then
				arg_495_1.allBtn_.enabled = false
			end

			if arg_495_1.time_ >= var_498_4 + 0.933333333332 and arg_495_1.time_ < var_498_4 + 0.933333333332 + arg_498_0 then
				arg_495_1.allBtn_.enabled = true
			end

			local var_498_5 = 0

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_5 + arg_498_0 then
				arg_495_1.mask_.enabled = true
				arg_495_1.mask_.raycastTarget = true

				arg_495_1:SetGaussion(false)
			end

			local var_498_6 = 1

			if var_498_5 <= arg_495_1.time_ and arg_495_1.time_ < var_498_5 + var_498_6 then
				local var_498_7 = Color.New(1, 1, 1)

				var_498_7.a = Mathf.Lerp(1, 0, (arg_495_1.time_ - var_498_5) / var_498_6)
				arg_495_1.mask_.color = var_498_7
			end

			if arg_495_1.time_ >= var_498_5 + var_498_6 and arg_495_1.time_ < var_498_5 + var_498_6 + arg_498_0 then
				local var_498_8 = Color.New(1, 1, 1)

				arg_495_1.mask_.enabled = false
				var_498_8.a = 0
				arg_495_1.mask_.color = var_498_8
			end

			if 0.1 < arg_495_1.time_ and arg_495_1.time_ <= 0.1 + arg_498_0 then
				arg_495_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_cannon", "")
			end

			local var_498_10 = 1
			local var_498_11 = manager.audio:GetVoiceLength("story_v_out_322072", "322072118", "story_v_out_322072.awb") / 1000

			if var_498_11 > 0 and 2.7 < var_498_11 and var_498_11 + var_498_10 > arg_495_1.duration_ then
				arg_495_1.duration_ = var_498_11 + var_498_10
			end

			if var_498_10 < arg_495_1.time_ and arg_495_1.time_ <= var_498_10 + arg_498_0 then
				arg_495_1:AudioAction("play", "voice", "story_v_out_322072", "322072118", "story_v_out_322072.awb")
			end
		end

		arg_495_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322072118,
				charCount = 14,
				enableLayoutChange = true,
				duration = 0.933333333333333,
				groupID = "2118",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_495_1:InitPlayNodeList()
	end,
	Play322072119 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 322072119
		arg_499_1.duration_ = 1

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
			arg_499_1.auto_ = false
		end

		function arg_499_1.playNext_(arg_501_0)
			arg_499_1.onStoryFinished_()
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				local var_502_0 = arg_499_1.fswbg_.transform:Find("textbox/adapt/content") or arg_499_1.fswbg_.transform:Find("textbox/content")
				local var_502_1 = arg_499_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_502_2 = var_502_0:GetComponent("RectTransform")

				var_502_0:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_502_2.offsetMin = Vector2.New(0, 0)
				var_502_2.offsetMax = Vector2.New(0, 0)
			end

			local var_502_3 = 0
			local var_502_4 = manager.audio:GetVoiceLength("story_v_out_322072", "322072119", "story_v_out_322072.awb") / 1000

			if var_502_4 > 0 and 1 < var_502_4 and var_502_4 + var_502_3 > arg_499_1.duration_ then
				arg_499_1.duration_ = var_502_4 + var_502_3
			end

			if var_502_3 < arg_499_1.time_ and arg_499_1.time_ <= var_502_3 + arg_502_0 then
				arg_499_1:AudioAction("play", "voice", "story_v_out_322072", "322072119", "story_v_out_322072.awb")
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322072119,
				charCount = 7,
				enableLayoutChange = true,
				duration = 0.466666666666667,
				groupID = "2119",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "2118",
				duration = 0.933333333333333,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L17f",
		"TextureConfig/Background/L19f",
		"TextureConfig/Background/ST61a",
		"TextureConfig/Background/L15f",
		"TextureConfig/Background/ST0510",
		"TextureConfig/Background/MS2202",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_322072.awb"
	}
}
