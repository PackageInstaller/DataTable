return {
	Play322181001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322181001
		arg_1_1.duration_ = 4.87

		local var_1_0 = {
			zh = 4.832999999999,
			ja = 4.865999999999
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
				arg_1_0:Play322181002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L09g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L09g")
				var_4_0.name = "L09g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L09g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L09g

				arg_1_1.bgs_.L09g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L09g" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2.024999999999

			if 2.024999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "10131ui_story"

			if arg_1_1.actors_["10131ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10131ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["10131ui_story"].transform

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.999999999999 + arg_4_0 then
				arg_1_1.var_.moveOldPos10131ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.999999999999 <= arg_1_1.time_ and arg_1_1.time_ < 1.999999999999 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10131ui_story, Vector3.New(0.05, -0.96, -5.8), (arg_1_1.time_ - 1.999999999999) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.999999999999 + var_4_14 and arg_1_1.time_ < 1.999999999999 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0.05, -0.96, -5.8)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["10131ui_story"]

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.999999999999 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect10131ui_story == nil then
				arg_1_1.var_.characterEffect10131ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.999999999999 <= arg_1_1.time_ and arg_1_1.time_ < 1.999999999999 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect10131ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.999999999999 + var_4_16 and arg_1_1.time_ < 1.999999999999 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect10131ui_story then
				arg_1_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.999999999999 + arg_4_0 then
				arg_1_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action8_1")
			end

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.999999999999 + arg_4_0 then
				arg_1_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
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

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source")

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

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_dark_L09", "")
			end

			if 0.41 < arg_1_1.time_ and arg_1_1.time_ <= 0.41 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "init_story", "bgm_activity_4_5_story_serious.awb")

				local var_4_27 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "init_story")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_28 = 1.999999999999
			local var_4_29 = 0.325

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_30 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_30:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_31 = arg_1_1:GetWordFromCfg(322181001)
				local var_4_32 = arg_1_1:FormatText(var_4_31.content)

				arg_1_1.text_.text = var_4_32

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_34 = 13 <= 0 and var_4_29 or var_4_29 * (utf8.len(var_4_32) / 13)

				if (13 <= 0 and var_4_29 or var_4_29 * (utf8.len(var_4_32) / 13)) > 0 and var_4_29 < var_4_34 then
					arg_1_1.talkMaxDuration = var_4_34
					var_4_28 = var_4_28 + 0.3

					if var_4_34 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_34 + var_4_28
					end
				end

				arg_1_1.text_.text = var_4_32
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181001", "story_v_out_322181.awb") ~= 0 then
					local var_4_35 = manager.audio:GetVoiceLength("story_v_out_322181", "322181001", "story_v_out_322181.awb") / 1000

					if var_4_35 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_35 + var_4_28
					end

					if var_4_31.prefab_name ~= "" and arg_1_1.actors_[var_4_31.prefab_name] ~= nil then
						local var_4_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_31.prefab_name].transform, "story_v_out_322181", "322181001", "story_v_out_322181.awb")

						arg_1_1:RecordAudio("322181001", var_4_36)
						arg_1_1:RecordAudio("322181001", var_4_36)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322181", "322181001", "story_v_out_322181.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322181", "322181001", "story_v_out_322181.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_37 = var_4_28 + 0.3
			local var_4_38 = math.max(var_4_29, arg_1_1.talkMaxDuration)

			if var_4_28 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_37) / var_4_38

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play322181002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 322181002
		arg_10_1.duration_ = 2.7

		local var_10_0 = {
			zh = 2.6,
			ja = 2.7
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play322181003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.var_.moveOldPos10131ui_story = arg_10_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_13_0 = 0.001

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_0 then
				arg_10_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_10_1.time_ - 0) / var_13_0)
				arg_10_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_10_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_10_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_10_1.actors_["10131ui_story"].transform.position).z)
				arg_10_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_10_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_10_1.actors_["10131ui_story"].transform.localEulerAngles = arg_10_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_10_1.time_ >= 0 + var_13_0 and arg_10_1.time_ < 0 + var_13_0 + arg_13_0 then
				arg_10_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_10_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_10_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_10_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_10_1.actors_["10131ui_story"].transform.position).z)
				arg_10_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_10_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_10_1.actors_["10131ui_story"].transform.localEulerAngles = arg_10_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_13_1 = "1111ui_story"

			if arg_10_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_13_2 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_10_1.stage_.transform)

				var_13_2.name = var_13_1
				var_13_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_10_1.actors_[var_13_1] = var_13_2

				local var_13_3 = var_13_2:GetComponentInChildren(typeof(CharacterEffect))

				var_13_3.enabled = true

				local var_13_4 = GameObjectTools.GetOrAddComponent(var_13_2, typeof(DynamicBoneHelper))

				if var_13_4 then
					var_13_4:EnableDynamicBone(false)
				end

				arg_10_1:ShowWeapon(var_13_3.transform, false)

				arg_10_1.var_[var_13_1 .. "Animator"] = var_13_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_10_1.var_[var_13_1 .. "Animator"].applyRootMotion = true
				arg_10_1.var_[var_13_1 .. "LipSync"] = var_13_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_13_5 = arg_10_1.actors_["1111ui_story"].transform

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.var_.moveOldPos1111ui_story = var_13_5.localPosition
			end

			local var_13_6 = 0.001

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_6 then
				var_13_5.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_10_1.time_ - 0) / var_13_6)
				var_13_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_13_5.position).x, (manager.ui.mainCamera.transform.position - var_13_5.position).y, (manager.ui.mainCamera.transform.position - var_13_5.position).z)
				var_13_5.localEulerAngles.z = 0
				var_13_5.localEulerAngles.x = 0
				var_13_5.localEulerAngles = var_13_5.localEulerAngles
			end

			if arg_10_1.time_ >= 0 + var_13_6 and arg_10_1.time_ < 0 + var_13_6 + arg_13_0 then
				var_13_5.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				var_13_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_13_5.position).x, (manager.ui.mainCamera.transform.position - var_13_5.position).y, (manager.ui.mainCamera.transform.position - var_13_5.position).z)
				var_13_5.localEulerAngles.z = 0
				var_13_5.localEulerAngles.x = 0
				var_13_5.localEulerAngles = var_13_5.localEulerAngles
			end

			local var_13_7 = arg_10_1.actors_["1111ui_story"]

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 and not isNil(var_13_7) and arg_10_1.var_.characterEffect1111ui_story == nil then
				arg_10_1.var_.characterEffect1111ui_story = var_13_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_13_8 = 0.200000002980232

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_8 and not isNil(var_13_7) then
				if arg_10_1.var_.characterEffect1111ui_story and not isNil(var_13_7) then
					arg_10_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_10_1.time_ >= 0 + var_13_8 and arg_10_1.time_ < 0 + var_13_8 + arg_13_0 and not isNil(var_13_7) and arg_10_1.var_.characterEffect1111ui_story then
				arg_10_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_13_10 = arg_10_1.actors_["10131ui_story"]

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 and not isNil(var_13_10) and arg_10_1.var_.characterEffect10131ui_story == nil then
				arg_10_1.var_.characterEffect10131ui_story = var_13_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_13_11 = 0.200000002980232

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_11 and not isNil(var_13_10) then
				if arg_10_1.var_.characterEffect10131ui_story and not isNil(var_13_10) then
					arg_10_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_10_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_10_1.time_ - 0) / var_13_11)
				end
			end

			if arg_10_1.time_ >= 0 + var_13_11 and arg_10_1.time_ < 0 + var_13_11 + arg_13_0 and not isNil(var_13_10) and arg_10_1.var_.characterEffect10131ui_story then
				arg_10_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_10_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_13_12 = 0
			local var_13_13 = 0.225

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_12 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				arg_10_1.leftNameTxt_.text = arg_10_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_14 = arg_10_1:GetWordFromCfg(322181002)
				local var_13_15 = arg_10_1:FormatText(var_13_14.content)

				arg_10_1.text_.text = var_13_15

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_17 = 9 <= 0 and var_13_13 or var_13_13 * (utf8.len(var_13_15) / 9)

				if (9 <= 0 and var_13_13 or var_13_13 * (utf8.len(var_13_15) / 9)) > 0 and var_13_13 < var_13_17 then
					arg_10_1.talkMaxDuration = var_13_17

					if var_13_17 + var_13_12 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_17 + var_13_12
					end
				end

				arg_10_1.text_.text = var_13_15
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181002", "story_v_out_322181.awb") ~= 0 then
					local var_13_18 = manager.audio:GetVoiceLength("story_v_out_322181", "322181002", "story_v_out_322181.awb") / 1000

					if var_13_18 + var_13_12 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_18 + var_13_12
					end

					if var_13_14.prefab_name ~= "" and arg_10_1.actors_[var_13_14.prefab_name] ~= nil then
						local var_13_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_14.prefab_name].transform, "story_v_out_322181", "322181002", "story_v_out_322181.awb")

						arg_10_1:RecordAudio("322181002", var_13_19)
						arg_10_1:RecordAudio("322181002", var_13_19)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_322181", "322181002", "story_v_out_322181.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_322181", "322181002", "story_v_out_322181.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_20 = math.max(var_13_13, arg_10_1.talkMaxDuration)

			if var_13_12 <= arg_10_1.time_ and arg_10_1.time_ < var_13_12 + var_13_20 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_12) / var_13_20

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_12 + var_13_20 and arg_10_1.time_ < var_13_12 + var_13_20 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_10_1:InitPlayNodeList()
	end,
	Play322181003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 322181003
		arg_14_1.duration_ = 6.9

		local var_14_0 = {
			zh = 6.133,
			ja = 6.9
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play322181004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 and not isNil(arg_14_1.actors_["10131ui_story"]) and arg_14_1.var_.characterEffect10131ui_story == nil then
				arg_14_1.var_.characterEffect10131ui_story = arg_14_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_0 = 0.200000002980232

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_0 and not isNil(arg_14_1.actors_["10131ui_story"]) then
				if arg_14_1.var_.characterEffect10131ui_story and not isNil(arg_14_1.actors_["10131ui_story"]) then
					arg_14_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_14_1.time_ >= 0 + var_17_0 and arg_14_1.time_ < 0 + var_17_0 + arg_17_0 and not isNil(arg_14_1.actors_["10131ui_story"]) and arg_14_1.var_.characterEffect10131ui_story then
				arg_14_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_17_2 = arg_14_1.actors_["1111ui_story"]

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 and not isNil(var_17_2) and arg_14_1.var_.characterEffect1111ui_story == nil then
				arg_14_1.var_.characterEffect1111ui_story = var_17_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_3 = 0.200000002980232

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_3 and not isNil(var_17_2) then
				if arg_14_1.var_.characterEffect1111ui_story and not isNil(var_17_2) then
					arg_14_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_14_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_14_1.time_ - 0) / var_17_3)
				end
			end

			if arg_14_1.time_ >= 0 + var_17_3 and arg_14_1.time_ < 0 + var_17_3 + arg_17_0 and not isNil(var_17_2) and arg_14_1.var_.characterEffect1111ui_story then
				arg_14_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_14_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_17_4 = 0
			local var_17_5 = 0.675

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_4 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_6 = arg_14_1:GetWordFromCfg(322181003)
				local var_17_7 = arg_14_1:FormatText(var_17_6.content)

				arg_14_1.text_.text = var_17_7

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_9 = 27 <= 0 and var_17_5 or var_17_5 * (utf8.len(var_17_7) / 27)

				if (27 <= 0 and var_17_5 or var_17_5 * (utf8.len(var_17_7) / 27)) > 0 and var_17_5 < var_17_9 then
					arg_14_1.talkMaxDuration = var_17_9

					if var_17_9 + var_17_4 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_9 + var_17_4
					end
				end

				arg_14_1.text_.text = var_17_7
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181003", "story_v_out_322181.awb") ~= 0 then
					local var_17_10 = manager.audio:GetVoiceLength("story_v_out_322181", "322181003", "story_v_out_322181.awb") / 1000

					if var_17_10 + var_17_4 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_10 + var_17_4
					end

					if var_17_6.prefab_name ~= "" and arg_14_1.actors_[var_17_6.prefab_name] ~= nil then
						local var_17_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_6.prefab_name].transform, "story_v_out_322181", "322181003", "story_v_out_322181.awb")

						arg_14_1:RecordAudio("322181003", var_17_11)
						arg_14_1:RecordAudio("322181003", var_17_11)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_322181", "322181003", "story_v_out_322181.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_322181", "322181003", "story_v_out_322181.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_12 = math.max(var_17_5, arg_14_1.talkMaxDuration)

			if var_17_4 <= arg_14_1.time_ and arg_14_1.time_ < var_17_4 + var_17_12 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_4) / var_17_12

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_4 + var_17_12 and arg_14_1.time_ < var_17_4 + var_17_12 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play322181004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 322181004
		arg_18_1.duration_ = 3.2

		local var_18_0 = {
			zh = 3.2,
			ja = 3.1
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
				arg_18_0:Play322181005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(arg_18_1.actors_["1111ui_story"]) and arg_18_1.var_.characterEffect1111ui_story == nil then
				arg_18_1.var_.characterEffect1111ui_story = arg_18_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_0 = 0.200000002980232

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_0 and not isNil(arg_18_1.actors_["1111ui_story"]) then
				if arg_18_1.var_.characterEffect1111ui_story and not isNil(arg_18_1.actors_["1111ui_story"]) then
					arg_18_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= 0 + var_21_0 and arg_18_1.time_ < 0 + var_21_0 + arg_21_0 and not isNil(arg_18_1.actors_["1111ui_story"]) and arg_18_1.var_.characterEffect1111ui_story then
				arg_18_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_21_2 = arg_18_1.actors_["10131ui_story"]

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(var_21_2) and arg_18_1.var_.characterEffect10131ui_story == nil then
				arg_18_1.var_.characterEffect10131ui_story = var_21_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_3 = 0.200000002980232

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_3 and not isNil(var_21_2) then
				if arg_18_1.var_.characterEffect10131ui_story and not isNil(var_21_2) then
					arg_18_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_18_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_18_1.time_ - 0) / var_21_3)
				end
			end

			if arg_18_1.time_ >= 0 + var_21_3 and arg_18_1.time_ < 0 + var_21_3 + arg_21_0 and not isNil(var_21_2) and arg_18_1.var_.characterEffect10131ui_story then
				arg_18_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_18_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_21_4 = 0
			local var_21_5 = 0.35

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_4 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_6 = arg_18_1:GetWordFromCfg(322181004)
				local var_21_7 = arg_18_1:FormatText(var_21_6.content)

				arg_18_1.text_.text = var_21_7

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_9 = 14 <= 0 and var_21_5 or var_21_5 * (utf8.len(var_21_7) / 14)

				if (14 <= 0 and var_21_5 or var_21_5 * (utf8.len(var_21_7) / 14)) > 0 and var_21_5 < var_21_9 then
					arg_18_1.talkMaxDuration = var_21_9

					if var_21_9 + var_21_4 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_9 + var_21_4
					end
				end

				arg_18_1.text_.text = var_21_7
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181004", "story_v_out_322181.awb") ~= 0 then
					local var_21_10 = manager.audio:GetVoiceLength("story_v_out_322181", "322181004", "story_v_out_322181.awb") / 1000

					if var_21_10 + var_21_4 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_10 + var_21_4
					end

					if var_21_6.prefab_name ~= "" and arg_18_1.actors_[var_21_6.prefab_name] ~= nil then
						local var_21_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_6.prefab_name].transform, "story_v_out_322181", "322181004", "story_v_out_322181.awb")

						arg_18_1:RecordAudio("322181004", var_21_11)
						arg_18_1:RecordAudio("322181004", var_21_11)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_322181", "322181004", "story_v_out_322181.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_322181", "322181004", "story_v_out_322181.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_12 = math.max(var_21_5, arg_18_1.talkMaxDuration)

			if var_21_4 <= arg_18_1.time_ and arg_18_1.time_ < var_21_4 + var_21_12 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_4) / var_21_12

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_4 + var_21_12 and arg_18_1.time_ < var_21_4 + var_21_12 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play322181005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 322181005
		arg_22_1.duration_ = 5.57

		local var_22_0 = {
			zh = 3.633,
			ja = 5.566
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play322181006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(arg_22_1.actors_["10131ui_story"]) and arg_22_1.var_.characterEffect10131ui_story == nil then
				arg_22_1.var_.characterEffect10131ui_story = arg_22_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_0 = 0.200000002980232

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_0 and not isNil(arg_22_1.actors_["10131ui_story"]) then
				if arg_22_1.var_.characterEffect10131ui_story and not isNil(arg_22_1.actors_["10131ui_story"]) then
					arg_22_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_22_1.time_ >= 0 + var_25_0 and arg_22_1.time_ < 0 + var_25_0 + arg_25_0 and not isNil(arg_22_1.actors_["10131ui_story"]) and arg_22_1.var_.characterEffect10131ui_story then
				arg_22_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_25_2 = arg_22_1.actors_["1111ui_story"]

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(var_25_2) and arg_22_1.var_.characterEffect1111ui_story == nil then
				arg_22_1.var_.characterEffect1111ui_story = var_25_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_3 = 0.200000002980232

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_3 and not isNil(var_25_2) then
				if arg_22_1.var_.characterEffect1111ui_story and not isNil(var_25_2) then
					arg_22_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_22_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_22_1.time_ - 0) / var_25_3)
				end
			end

			if arg_22_1.time_ >= 0 + var_25_3 and arg_22_1.time_ < 0 + var_25_3 + arg_25_0 and not isNil(var_25_2) and arg_22_1.var_.characterEffect1111ui_story then
				arg_22_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_22_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action8_2")
			end

			local var_25_4 = 0
			local var_25_5 = 0.4

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_4 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_6 = arg_22_1:GetWordFromCfg(322181005)
				local var_25_7 = arg_22_1:FormatText(var_25_6.content)

				arg_22_1.text_.text = var_25_7

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_9 = 16 <= 0 and var_25_5 or var_25_5 * (utf8.len(var_25_7) / 16)

				if (16 <= 0 and var_25_5 or var_25_5 * (utf8.len(var_25_7) / 16)) > 0 and var_25_5 < var_25_9 then
					arg_22_1.talkMaxDuration = var_25_9

					if var_25_9 + var_25_4 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_9 + var_25_4
					end
				end

				arg_22_1.text_.text = var_25_7
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181005", "story_v_out_322181.awb") ~= 0 then
					local var_25_10 = manager.audio:GetVoiceLength("story_v_out_322181", "322181005", "story_v_out_322181.awb") / 1000

					if var_25_10 + var_25_4 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_10 + var_25_4
					end

					if var_25_6.prefab_name ~= "" and arg_22_1.actors_[var_25_6.prefab_name] ~= nil then
						local var_25_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_6.prefab_name].transform, "story_v_out_322181", "322181005", "story_v_out_322181.awb")

						arg_22_1:RecordAudio("322181005", var_25_11)
						arg_22_1:RecordAudio("322181005", var_25_11)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_322181", "322181005", "story_v_out_322181.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_322181", "322181005", "story_v_out_322181.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_12 = math.max(var_25_5, arg_22_1.talkMaxDuration)

			if var_25_4 <= arg_22_1.time_ and arg_22_1.time_ < var_25_4 + var_25_12 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_4) / var_25_12

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_4 + var_25_12 and arg_22_1.time_ < var_25_4 + var_25_12 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play322181006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 322181006
		arg_26_1.duration_ = 2.7

		local var_26_0 = {
			zh = 1.466,
			ja = 2.7
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
				arg_26_0:Play322181007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(arg_26_1.actors_["1111ui_story"]) and arg_26_1.var_.characterEffect1111ui_story == nil then
				arg_26_1.var_.characterEffect1111ui_story = arg_26_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_0 = 0.200000002980232

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 and not isNil(arg_26_1.actors_["1111ui_story"]) then
				if arg_26_1.var_.characterEffect1111ui_story and not isNil(arg_26_1.actors_["1111ui_story"]) then
					arg_26_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 and not isNil(arg_26_1.actors_["1111ui_story"]) and arg_26_1.var_.characterEffect1111ui_story then
				arg_26_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_29_2 = arg_26_1.actors_["10131ui_story"]

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(var_29_2) and arg_26_1.var_.characterEffect10131ui_story == nil then
				arg_26_1.var_.characterEffect10131ui_story = var_29_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_3 = 0.200000002980232

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_3 and not isNil(var_29_2) then
				if arg_26_1.var_.characterEffect10131ui_story and not isNil(var_29_2) then
					arg_26_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_26_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_26_1.time_ - 0) / var_29_3)
				end
			end

			if arg_26_1.time_ >= 0 + var_29_3 and arg_26_1.time_ < 0 + var_29_3 + arg_29_0 and not isNil(var_29_2) and arg_26_1.var_.characterEffect10131ui_story then
				arg_26_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_26_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_29_4 = 0
			local var_29_5 = 0.125

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_4 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_6 = arg_26_1:GetWordFromCfg(322181006)
				local var_29_7 = arg_26_1:FormatText(var_29_6.content)

				arg_26_1.text_.text = var_29_7

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_9 = 5 <= 0 and var_29_5 or var_29_5 * (utf8.len(var_29_7) / 5)

				if (5 <= 0 and var_29_5 or var_29_5 * (utf8.len(var_29_7) / 5)) > 0 and var_29_5 < var_29_9 then
					arg_26_1.talkMaxDuration = var_29_9

					if var_29_9 + var_29_4 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_9 + var_29_4
					end
				end

				arg_26_1.text_.text = var_29_7
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181006", "story_v_out_322181.awb") ~= 0 then
					local var_29_10 = manager.audio:GetVoiceLength("story_v_out_322181", "322181006", "story_v_out_322181.awb") / 1000

					if var_29_10 + var_29_4 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_10 + var_29_4
					end

					if var_29_6.prefab_name ~= "" and arg_26_1.actors_[var_29_6.prefab_name] ~= nil then
						local var_29_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_6.prefab_name].transform, "story_v_out_322181", "322181006", "story_v_out_322181.awb")

						arg_26_1:RecordAudio("322181006", var_29_11)
						arg_26_1:RecordAudio("322181006", var_29_11)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_322181", "322181006", "story_v_out_322181.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_322181", "322181006", "story_v_out_322181.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_12 = math.max(var_29_5, arg_26_1.talkMaxDuration)

			if var_29_4 <= arg_26_1.time_ and arg_26_1.time_ < var_29_4 + var_29_12 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_4) / var_29_12

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_4 + var_29_12 and arg_26_1.time_ < var_29_4 + var_29_12 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play322181007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 322181007
		arg_30_1.duration_ = 4.87

		local var_30_0 = {
			zh = 4.166,
			ja = 4.866
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play322181008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["10131ui_story"]) and arg_30_1.var_.characterEffect10131ui_story == nil then
				arg_30_1.var_.characterEffect10131ui_story = arg_30_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_0 = 0.200000002980232

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["10131ui_story"]) then
				if arg_30_1.var_.characterEffect10131ui_story and not isNil(arg_30_1.actors_["10131ui_story"]) then
					arg_30_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["10131ui_story"]) and arg_30_1.var_.characterEffect10131ui_story then
				arg_30_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_33_2 = arg_30_1.actors_["1111ui_story"]

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(var_33_2) and arg_30_1.var_.characterEffect1111ui_story == nil then
				arg_30_1.var_.characterEffect1111ui_story = var_33_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_3 = 0.200000002980232

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_3 and not isNil(var_33_2) then
				if arg_30_1.var_.characterEffect1111ui_story and not isNil(var_33_2) then
					arg_30_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_30_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_30_1.time_ - 0) / var_33_3)
				end
			end

			if arg_30_1.time_ >= 0 + var_33_3 and arg_30_1.time_ < 0 + var_33_3 + arg_33_0 and not isNil(var_33_2) and arg_30_1.var_.characterEffect1111ui_story then
				arg_30_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_30_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_33_4 = 0
			local var_33_5 = 0.375

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_4 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_6 = arg_30_1:GetWordFromCfg(322181007)
				local var_33_7 = arg_30_1:FormatText(var_33_6.content)

				arg_30_1.text_.text = var_33_7

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_9 = 15 <= 0 and var_33_5 or var_33_5 * (utf8.len(var_33_7) / 15)

				if (15 <= 0 and var_33_5 or var_33_5 * (utf8.len(var_33_7) / 15)) > 0 and var_33_5 < var_33_9 then
					arg_30_1.talkMaxDuration = var_33_9

					if var_33_9 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_9 + var_33_4
					end
				end

				arg_30_1.text_.text = var_33_7
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181007", "story_v_out_322181.awb") ~= 0 then
					local var_33_10 = manager.audio:GetVoiceLength("story_v_out_322181", "322181007", "story_v_out_322181.awb") / 1000

					if var_33_10 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_10 + var_33_4
					end

					if var_33_6.prefab_name ~= "" and arg_30_1.actors_[var_33_6.prefab_name] ~= nil then
						local var_33_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_6.prefab_name].transform, "story_v_out_322181", "322181007", "story_v_out_322181.awb")

						arg_30_1:RecordAudio("322181007", var_33_11)
						arg_30_1:RecordAudio("322181007", var_33_11)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_322181", "322181007", "story_v_out_322181.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_322181", "322181007", "story_v_out_322181.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_12 = math.max(var_33_5, arg_30_1.talkMaxDuration)

			if var_33_4 <= arg_30_1.time_ and arg_30_1.time_ < var_33_4 + var_33_12 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_4) / var_33_12

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_4 + var_33_12 and arg_30_1.time_ < var_33_4 + var_33_12 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play322181008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 322181008
		arg_34_1.duration_ = 2.57

		local var_34_0 = {
			zh = 1.999999999999,
			ja = 2.566
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
				arg_34_0:Play322181009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(arg_34_1.actors_["1111ui_story"]) and arg_34_1.var_.characterEffect1111ui_story == nil then
				arg_34_1.var_.characterEffect1111ui_story = arg_34_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_0 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 and not isNil(arg_34_1.actors_["1111ui_story"]) then
				if arg_34_1.var_.characterEffect1111ui_story and not isNil(arg_34_1.actors_["1111ui_story"]) then
					arg_34_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 and not isNil(arg_34_1.actors_["1111ui_story"]) and arg_34_1.var_.characterEffect1111ui_story then
				arg_34_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_37_2 = arg_34_1.actors_["10131ui_story"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_2) and arg_34_1.var_.characterEffect10131ui_story == nil then
				arg_34_1.var_.characterEffect10131ui_story = var_37_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_3 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_3 and not isNil(var_37_2) then
				if arg_34_1.var_.characterEffect10131ui_story and not isNil(var_37_2) then
					arg_34_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_34_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_34_1.time_ - 0) / var_37_3)
				end
			end

			if arg_34_1.time_ >= 0 + var_37_3 and arg_34_1.time_ < 0 + var_37_3 + arg_37_0 and not isNil(var_37_2) and arg_34_1.var_.characterEffect10131ui_story then
				arg_34_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_34_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_37_4 = 0
			local var_37_5 = 0.1

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_4 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_6 = arg_34_1:GetWordFromCfg(322181008)
				local var_37_7 = arg_34_1:FormatText(var_37_6.content)

				arg_34_1.text_.text = var_37_7

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_9 = 4 <= 0 and var_37_5 or var_37_5 * (utf8.len(var_37_7) / 4)

				if (4 <= 0 and var_37_5 or var_37_5 * (utf8.len(var_37_7) / 4)) > 0 and var_37_5 < var_37_9 then
					arg_34_1.talkMaxDuration = var_37_9

					if var_37_9 + var_37_4 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_9 + var_37_4
					end
				end

				arg_34_1.text_.text = var_37_7
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181008", "story_v_out_322181.awb") ~= 0 then
					local var_37_10 = manager.audio:GetVoiceLength("story_v_out_322181", "322181008", "story_v_out_322181.awb") / 1000

					if var_37_10 + var_37_4 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_10 + var_37_4
					end

					if var_37_6.prefab_name ~= "" and arg_34_1.actors_[var_37_6.prefab_name] ~= nil then
						local var_37_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_6.prefab_name].transform, "story_v_out_322181", "322181008", "story_v_out_322181.awb")

						arg_34_1:RecordAudio("322181008", var_37_11)
						arg_34_1:RecordAudio("322181008", var_37_11)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_322181", "322181008", "story_v_out_322181.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_322181", "322181008", "story_v_out_322181.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_12 = math.max(var_37_5, arg_34_1.talkMaxDuration)

			if var_37_4 <= arg_34_1.time_ and arg_34_1.time_ < var_37_4 + var_37_12 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_4) / var_37_12

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_4 + var_37_12 and arg_34_1.time_ < var_37_4 + var_37_12 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play322181009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 322181009
		arg_38_1.duration_ = 10.2

		local var_38_0 = {
			zh = 7.4,
			ja = 10.2
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play322181010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["10131ui_story"]) and arg_38_1.var_.characterEffect10131ui_story == nil then
				arg_38_1.var_.characterEffect10131ui_story = arg_38_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_0 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["10131ui_story"]) then
				if arg_38_1.var_.characterEffect10131ui_story and not isNil(arg_38_1.actors_["10131ui_story"]) then
					arg_38_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["10131ui_story"]) and arg_38_1.var_.characterEffect10131ui_story then
				arg_38_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_41_2 = arg_38_1.actors_["1111ui_story"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.characterEffect1111ui_story == nil then
				arg_38_1.var_.characterEffect1111ui_story = var_41_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_3 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_3 and not isNil(var_41_2) then
				if arg_38_1.var_.characterEffect1111ui_story and not isNil(var_41_2) then
					arg_38_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_38_1.time_ - 0) / var_41_3)
				end
			end

			if arg_38_1.time_ >= 0 + var_41_3 and arg_38_1.time_ < 0 + var_41_3 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.characterEffect1111ui_story then
				arg_38_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_1")
			end

			local var_41_4 = 0
			local var_41_5 = 0.8

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_4 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_6 = arg_38_1:GetWordFromCfg(322181009)
				local var_41_7 = arg_38_1:FormatText(var_41_6.content)

				arg_38_1.text_.text = var_41_7

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_9 = 32 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 32)

				if (32 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 32)) > 0 and var_41_5 < var_41_9 then
					arg_38_1.talkMaxDuration = var_41_9

					if var_41_9 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_9 + var_41_4
					end
				end

				arg_38_1.text_.text = var_41_7
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181009", "story_v_out_322181.awb") ~= 0 then
					local var_41_10 = manager.audio:GetVoiceLength("story_v_out_322181", "322181009", "story_v_out_322181.awb") / 1000

					if var_41_10 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_10 + var_41_4
					end

					if var_41_6.prefab_name ~= "" and arg_38_1.actors_[var_41_6.prefab_name] ~= nil then
						local var_41_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_6.prefab_name].transform, "story_v_out_322181", "322181009", "story_v_out_322181.awb")

						arg_38_1:RecordAudio("322181009", var_41_11)
						arg_38_1:RecordAudio("322181009", var_41_11)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_322181", "322181009", "story_v_out_322181.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_322181", "322181009", "story_v_out_322181.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_12 = math.max(var_41_5, arg_38_1.talkMaxDuration)

			if var_41_4 <= arg_38_1.time_ and arg_38_1.time_ < var_41_4 + var_41_12 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_4) / var_41_12

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_4 + var_41_12 and arg_38_1.time_ < var_41_4 + var_41_12 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play322181010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 322181010
		arg_42_1.duration_ = 6.73

		local var_42_0 = {
			zh = 5.166,
			ja = 6.733
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
				arg_42_0:Play322181011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["1111ui_story"]) and arg_42_1.var_.characterEffect1111ui_story == nil then
				arg_42_1.var_.characterEffect1111ui_story = arg_42_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_0 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["1111ui_story"]) then
				if arg_42_1.var_.characterEffect1111ui_story and not isNil(arg_42_1.actors_["1111ui_story"]) then
					arg_42_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["1111ui_story"]) and arg_42_1.var_.characterEffect1111ui_story then
				arg_42_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_45_2 = arg_42_1.actors_["10131ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.characterEffect10131ui_story == nil then
				arg_42_1.var_.characterEffect10131ui_story = var_45_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_3 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_3 and not isNil(var_45_2) then
				if arg_42_1.var_.characterEffect10131ui_story and not isNil(var_45_2) then
					arg_42_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_42_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_42_1.time_ - 0) / var_45_3)
				end
			end

			if arg_42_1.time_ >= 0 + var_45_3 and arg_42_1.time_ < 0 + var_45_3 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.characterEffect10131ui_story then
				arg_42_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_42_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_45_4 = 0
			local var_45_5 = 0.5

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_4 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_6 = arg_42_1:GetWordFromCfg(322181010)
				local var_45_7 = arg_42_1:FormatText(var_45_6.content)

				arg_42_1.text_.text = var_45_7

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_9 = 20 <= 0 and var_45_5 or var_45_5 * (utf8.len(var_45_7) / 20)

				if (20 <= 0 and var_45_5 or var_45_5 * (utf8.len(var_45_7) / 20)) > 0 and var_45_5 < var_45_9 then
					arg_42_1.talkMaxDuration = var_45_9

					if var_45_9 + var_45_4 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_9 + var_45_4
					end
				end

				arg_42_1.text_.text = var_45_7
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181010", "story_v_out_322181.awb") ~= 0 then
					local var_45_10 = manager.audio:GetVoiceLength("story_v_out_322181", "322181010", "story_v_out_322181.awb") / 1000

					if var_45_10 + var_45_4 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_10 + var_45_4
					end

					if var_45_6.prefab_name ~= "" and arg_42_1.actors_[var_45_6.prefab_name] ~= nil then
						local var_45_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_6.prefab_name].transform, "story_v_out_322181", "322181010", "story_v_out_322181.awb")

						arg_42_1:RecordAudio("322181010", var_45_11)
						arg_42_1:RecordAudio("322181010", var_45_11)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_322181", "322181010", "story_v_out_322181.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_322181", "322181010", "story_v_out_322181.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_12 = math.max(var_45_5, arg_42_1.talkMaxDuration)

			if var_45_4 <= arg_42_1.time_ and arg_42_1.time_ < var_45_4 + var_45_12 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_4) / var_45_12

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_4 + var_45_12 and arg_42_1.time_ < var_45_4 + var_45_12 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play322181011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 322181011
		arg_46_1.duration_ = 4.43

		local var_46_0 = {
			zh = 3.766,
			ja = 4.433
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
				arg_46_0:Play322181012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0.375

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_1 = arg_46_1:GetWordFromCfg(322181011)
				local var_49_2 = arg_46_1:FormatText(var_49_1.content)

				arg_46_1.text_.text = var_49_2

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_4 = 16 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 16)

				if (16 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 16)) > 0 and var_49_0 < var_49_4 then
					arg_46_1.talkMaxDuration = var_49_4

					if var_49_4 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_4 + 0
					end
				end

				arg_46_1.text_.text = var_49_2
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181011", "story_v_out_322181.awb") ~= 0 then
					local var_49_5 = manager.audio:GetVoiceLength("story_v_out_322181", "322181011", "story_v_out_322181.awb") / 1000

					if var_49_5 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + 0
					end

					if var_49_1.prefab_name ~= "" and arg_46_1.actors_[var_49_1.prefab_name] ~= nil then
						local var_49_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_1.prefab_name].transform, "story_v_out_322181", "322181011", "story_v_out_322181.awb")

						arg_46_1:RecordAudio("322181011", var_49_6)
						arg_46_1:RecordAudio("322181011", var_49_6)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_322181", "322181011", "story_v_out_322181.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_322181", "322181011", "story_v_out_322181.awb")
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
	Play322181012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 322181012
		arg_50_1.duration_ = 11

		local var_50_0 = {
			zh = 8.7,
			ja = 11
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
				arg_50_0:Play322181013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["10131ui_story"]) and arg_50_1.var_.characterEffect10131ui_story == nil then
				arg_50_1.var_.characterEffect10131ui_story = arg_50_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_0 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["10131ui_story"]) then
				if arg_50_1.var_.characterEffect10131ui_story and not isNil(arg_50_1.actors_["10131ui_story"]) then
					arg_50_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["10131ui_story"]) and arg_50_1.var_.characterEffect10131ui_story then
				arg_50_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_53_2 = arg_50_1.actors_["1111ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.characterEffect1111ui_story == nil then
				arg_50_1.var_.characterEffect1111ui_story = var_53_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_3 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_3 and not isNil(var_53_2) then
				if arg_50_1.var_.characterEffect1111ui_story and not isNil(var_53_2) then
					arg_50_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_50_1.time_ - 0) / var_53_3)
				end
			end

			if arg_50_1.time_ >= 0 + var_53_3 and arg_50_1.time_ < 0 + var_53_3 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.characterEffect1111ui_story then
				arg_50_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_53_4 = 0
			local var_53_5 = 0.9

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_4 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_6 = arg_50_1:GetWordFromCfg(322181012)
				local var_53_7 = arg_50_1:FormatText(var_53_6.content)

				arg_50_1.text_.text = var_53_7

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_9 = 36 <= 0 and var_53_5 or var_53_5 * (utf8.len(var_53_7) / 36)

				if (36 <= 0 and var_53_5 or var_53_5 * (utf8.len(var_53_7) / 36)) > 0 and var_53_5 < var_53_9 then
					arg_50_1.talkMaxDuration = var_53_9

					if var_53_9 + var_53_4 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_9 + var_53_4
					end
				end

				arg_50_1.text_.text = var_53_7
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181012", "story_v_out_322181.awb") ~= 0 then
					local var_53_10 = manager.audio:GetVoiceLength("story_v_out_322181", "322181012", "story_v_out_322181.awb") / 1000

					if var_53_10 + var_53_4 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_4
					end

					if var_53_6.prefab_name ~= "" and arg_50_1.actors_[var_53_6.prefab_name] ~= nil then
						local var_53_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_6.prefab_name].transform, "story_v_out_322181", "322181012", "story_v_out_322181.awb")

						arg_50_1:RecordAudio("322181012", var_53_11)
						arg_50_1:RecordAudio("322181012", var_53_11)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_322181", "322181012", "story_v_out_322181.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_322181", "322181012", "story_v_out_322181.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_12 = math.max(var_53_5, arg_50_1.talkMaxDuration)

			if var_53_4 <= arg_50_1.time_ and arg_50_1.time_ < var_53_4 + var_53_12 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_4) / var_53_12

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_4 + var_53_12 and arg_50_1.time_ < var_53_4 + var_53_12 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play322181013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 322181013
		arg_54_1.duration_ = 11.4

		local var_54_0 = {
			zh = 6.966,
			ja = 11.4
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
				arg_54_0:Play322181014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["1111ui_story"]) and arg_54_1.var_.characterEffect1111ui_story == nil then
				arg_54_1.var_.characterEffect1111ui_story = arg_54_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_0 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["1111ui_story"]) then
				if arg_54_1.var_.characterEffect1111ui_story and not isNil(arg_54_1.actors_["1111ui_story"]) then
					arg_54_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["1111ui_story"]) and arg_54_1.var_.characterEffect1111ui_story then
				arg_54_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_57_2 = arg_54_1.actors_["10131ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_2) and arg_54_1.var_.characterEffect10131ui_story == nil then
				arg_54_1.var_.characterEffect10131ui_story = var_57_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_3 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_3 and not isNil(var_57_2) then
				if arg_54_1.var_.characterEffect10131ui_story and not isNil(var_57_2) then
					arg_54_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_54_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_54_1.time_ - 0) / var_57_3)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_3 and arg_54_1.time_ < 0 + var_57_3 + arg_57_0 and not isNil(var_57_2) and arg_54_1.var_.characterEffect10131ui_story then
				arg_54_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_54_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_57_4 = 0
			local var_57_5 = 0.925

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_4 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_6 = arg_54_1:GetWordFromCfg(322181013)
				local var_57_7 = arg_54_1:FormatText(var_57_6.content)

				arg_54_1.text_.text = var_57_7

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_9 = 37 <= 0 and var_57_5 or var_57_5 * (utf8.len(var_57_7) / 37)

				if (37 <= 0 and var_57_5 or var_57_5 * (utf8.len(var_57_7) / 37)) > 0 and var_57_5 < var_57_9 then
					arg_54_1.talkMaxDuration = var_57_9

					if var_57_9 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_9 + var_57_4
					end
				end

				arg_54_1.text_.text = var_57_7
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181013", "story_v_out_322181.awb") ~= 0 then
					local var_57_10 = manager.audio:GetVoiceLength("story_v_out_322181", "322181013", "story_v_out_322181.awb") / 1000

					if var_57_10 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_10 + var_57_4
					end

					if var_57_6.prefab_name ~= "" and arg_54_1.actors_[var_57_6.prefab_name] ~= nil then
						local var_57_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_6.prefab_name].transform, "story_v_out_322181", "322181013", "story_v_out_322181.awb")

						arg_54_1:RecordAudio("322181013", var_57_11)
						arg_54_1:RecordAudio("322181013", var_57_11)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_322181", "322181013", "story_v_out_322181.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_322181", "322181013", "story_v_out_322181.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_12 = math.max(var_57_5, arg_54_1.talkMaxDuration)

			if var_57_4 <= arg_54_1.time_ and arg_54_1.time_ < var_57_4 + var_57_12 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_4) / var_57_12

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_4 + var_57_12 and arg_54_1.time_ < var_57_4 + var_57_12 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play322181014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 322181014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play322181015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos10131ui_story = arg_58_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_61_0 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 then
				arg_58_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_58_1.time_ - 0) / var_61_0)
				arg_58_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["10131ui_story"].transform.position).z)
				arg_58_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["10131ui_story"].transform.localEulerAngles = arg_58_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 then
				arg_58_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_58_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["10131ui_story"].transform.position).z)
				arg_58_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["10131ui_story"].transform.localEulerAngles = arg_58_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_61_1 = arg_58_1.actors_["1111ui_story"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos1111ui_story = var_61_1.localPosition
			end

			local var_61_2 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_2 then
				var_61_1.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_58_1.time_ - 0) / var_61_2)
				var_61_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_1.position).x, (manager.ui.mainCamera.transform.position - var_61_1.position).y, (manager.ui.mainCamera.transform.position - var_61_1.position).z)
				var_61_1.localEulerAngles.z = 0
				var_61_1.localEulerAngles.x = 0
				var_61_1.localEulerAngles = var_61_1.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_2 and arg_58_1.time_ < 0 + var_61_2 + arg_61_0 then
				var_61_1.localPosition = Vector3.New(0, 100, 0)
				var_61_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_1.position).x, (manager.ui.mainCamera.transform.position - var_61_1.position).y, (manager.ui.mainCamera.transform.position - var_61_1.position).z)
				var_61_1.localEulerAngles.z = 0
				var_61_1.localEulerAngles.x = 0
				var_61_1.localEulerAngles = var_61_1.localEulerAngles
			end

			if 0.3 < arg_58_1.time_ and arg_58_1.time_ <= 0.3 + arg_61_0 then
				arg_58_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_walk", "")
			end

			local var_61_4 = 0
			local var_61_5 = 1.5

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_4 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_6 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(322181014).content)

				arg_58_1.text_.text = var_61_6

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_8 = 60 <= 0 and var_61_5 or var_61_5 * (utf8.len(var_61_6) / 60)

				if (60 <= 0 and var_61_5 or var_61_5 * (utf8.len(var_61_6) / 60)) > 0 and var_61_5 < var_61_8 then
					arg_58_1.talkMaxDuration = var_61_8

					if var_61_8 + var_61_4 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_4
					end
				end

				arg_58_1.text_.text = var_61_6
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_9 = math.max(var_61_5, arg_58_1.talkMaxDuration)

			if var_61_4 <= arg_58_1.time_ and arg_58_1.time_ < var_61_4 + var_61_9 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_4) / var_61_9

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_4 + var_61_9 and arg_58_1.time_ < var_61_4 + var_61_9 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play322181015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 322181015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play322181016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.875

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

				local var_65_1 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(322181015).content)

				arg_62_1.text_.text = var_65_1

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_3 = 35 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 35)

				if (35 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 35)) > 0 and var_65_0 < var_65_3 then
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
	Play322181016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 322181016
		arg_66_1.duration_ = 8.03

		local var_66_0 = {
			zh = 6.266,
			ja = 8.033
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play322181017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1111ui_story = arg_66_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_69_0 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 then
				arg_66_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_66_1.time_ - 0) / var_69_0)
				arg_66_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_66_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["1111ui_story"].transform.position).z)
				arg_66_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_66_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_66_1.actors_["1111ui_story"].transform.localEulerAngles = arg_66_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 then
				arg_66_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_66_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_66_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["1111ui_story"].transform.position).z)
				arg_66_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_66_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_66_1.actors_["1111ui_story"].transform.localEulerAngles = arg_66_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_69_1 = arg_66_1.actors_["1111ui_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_1) and arg_66_1.var_.characterEffect1111ui_story == nil then
				arg_66_1.var_.characterEffect1111ui_story = var_69_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_2 and not isNil(var_69_1) then
				if arg_66_1.var_.characterEffect1111ui_story and not isNil(var_69_1) then
					arg_66_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_2 and arg_66_1.time_ < 0 + var_69_2 + arg_69_0 and not isNil(var_69_1) and arg_66_1.var_.characterEffect1111ui_story then
				arg_66_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_69_4 = 0
			local var_69_5 = 0.675

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_6 = arg_66_1:GetWordFromCfg(322181016)
				local var_69_7 = arg_66_1:FormatText(var_69_6.content)

				arg_66_1.text_.text = var_69_7

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_9 = 27 <= 0 and var_69_5 or var_69_5 * (utf8.len(var_69_7) / 27)

				if (27 <= 0 and var_69_5 or var_69_5 * (utf8.len(var_69_7) / 27)) > 0 and var_69_5 < var_69_9 then
					arg_66_1.talkMaxDuration = var_69_9

					if var_69_9 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_9 + var_69_4
					end
				end

				arg_66_1.text_.text = var_69_7
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181016", "story_v_out_322181.awb") ~= 0 then
					local var_69_10 = manager.audio:GetVoiceLength("story_v_out_322181", "322181016", "story_v_out_322181.awb") / 1000

					if var_69_10 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_10 + var_69_4
					end

					if var_69_6.prefab_name ~= "" and arg_66_1.actors_[var_69_6.prefab_name] ~= nil then
						local var_69_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_6.prefab_name].transform, "story_v_out_322181", "322181016", "story_v_out_322181.awb")

						arg_66_1:RecordAudio("322181016", var_69_11)
						arg_66_1:RecordAudio("322181016", var_69_11)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_322181", "322181016", "story_v_out_322181.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_322181", "322181016", "story_v_out_322181.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_12 = math.max(var_69_5, arg_66_1.talkMaxDuration)

			if var_69_4 <= arg_66_1.time_ and arg_66_1.time_ < var_69_4 + var_69_12 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_4) / var_69_12

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_4 + var_69_12 and arg_66_1.time_ < var_69_4 + var_69_12 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play322181017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 322181017
		arg_70_1.duration_ = 3.8

		local var_70_0 = {
			zh = 3.233,
			ja = 3.8
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
				arg_70_0:Play322181018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos10131ui_story = arg_70_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_73_0 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 then
				arg_70_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_70_1.time_ - 0) / var_73_0)
				arg_70_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["10131ui_story"].transform.position).z)
				arg_70_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["10131ui_story"].transform.localEulerAngles = arg_70_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 then
				arg_70_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_70_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["10131ui_story"].transform.position).z)
				arg_70_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["10131ui_story"].transform.localEulerAngles = arg_70_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_73_1 = arg_70_1.actors_["1111ui_story"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1111ui_story = var_73_1.localPosition
			end

			local var_73_2 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_2 then
				var_73_1.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_70_1.time_ - 0) / var_73_2)
				var_73_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_1.position).x, (manager.ui.mainCamera.transform.position - var_73_1.position).y, (manager.ui.mainCamera.transform.position - var_73_1.position).z)
				var_73_1.localEulerAngles.z = 0
				var_73_1.localEulerAngles.x = 0
				var_73_1.localEulerAngles = var_73_1.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_2 and arg_70_1.time_ < 0 + var_73_2 + arg_73_0 then
				var_73_1.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				var_73_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_1.position).x, (manager.ui.mainCamera.transform.position - var_73_1.position).y, (manager.ui.mainCamera.transform.position - var_73_1.position).z)
				var_73_1.localEulerAngles.z = 0
				var_73_1.localEulerAngles.x = 0
				var_73_1.localEulerAngles = var_73_1.localEulerAngles
			end

			local var_73_3 = arg_70_1.actors_["10131ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_3) and arg_70_1.var_.characterEffect10131ui_story == nil then
				arg_70_1.var_.characterEffect10131ui_story = var_73_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_4 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 and not isNil(var_73_3) then
				if arg_70_1.var_.characterEffect10131ui_story and not isNil(var_73_3) then
					arg_70_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 and not isNil(var_73_3) and arg_70_1.var_.characterEffect10131ui_story then
				arg_70_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_73_6 = arg_70_1.actors_["1111ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_6) and arg_70_1.var_.characterEffect1111ui_story == nil then
				arg_70_1.var_.characterEffect1111ui_story = var_73_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_7 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 and not isNil(var_73_6) then
				if arg_70_1.var_.characterEffect1111ui_story and not isNil(var_73_6) then
					arg_70_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_7)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 and not isNil(var_73_6) and arg_70_1.var_.characterEffect1111ui_story then
				arg_70_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_73_8 = 0
			local var_73_9 = 0.275

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_8 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_10 = arg_70_1:GetWordFromCfg(322181017)
				local var_73_11 = arg_70_1:FormatText(var_73_10.content)

				arg_70_1.text_.text = var_73_11

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_13 = 11 <= 0 and var_73_9 or var_73_9 * (utf8.len(var_73_11) / 11)

				if (11 <= 0 and var_73_9 or var_73_9 * (utf8.len(var_73_11) / 11)) > 0 and var_73_9 < var_73_13 then
					arg_70_1.talkMaxDuration = var_73_13

					if var_73_13 + var_73_8 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_13 + var_73_8
					end
				end

				arg_70_1.text_.text = var_73_11
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181017", "story_v_out_322181.awb") ~= 0 then
					local var_73_14 = manager.audio:GetVoiceLength("story_v_out_322181", "322181017", "story_v_out_322181.awb") / 1000

					if var_73_14 + var_73_8 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_14 + var_73_8
					end

					if var_73_10.prefab_name ~= "" and arg_70_1.actors_[var_73_10.prefab_name] ~= nil then
						local var_73_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_10.prefab_name].transform, "story_v_out_322181", "322181017", "story_v_out_322181.awb")

						arg_70_1:RecordAudio("322181017", var_73_15)
						arg_70_1:RecordAudio("322181017", var_73_15)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_322181", "322181017", "story_v_out_322181.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_322181", "322181017", "story_v_out_322181.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_16 = math.max(var_73_9, arg_70_1.talkMaxDuration)

			if var_73_8 <= arg_70_1.time_ and arg_70_1.time_ < var_73_8 + var_73_16 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_8) / var_73_16

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_8 + var_73_16 and arg_70_1.time_ < var_73_8 + var_73_16 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play322181018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 322181018
		arg_74_1.duration_ = 9.57

		local var_74_0 = {
			zh = 7.9,
			ja = 9.566
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
				arg_74_0:Play322181019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["1111ui_story"]) and arg_74_1.var_.characterEffect1111ui_story == nil then
				arg_74_1.var_.characterEffect1111ui_story = arg_74_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["1111ui_story"]) then
				if arg_74_1.var_.characterEffect1111ui_story and not isNil(arg_74_1.actors_["1111ui_story"]) then
					arg_74_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["1111ui_story"]) and arg_74_1.var_.characterEffect1111ui_story then
				arg_74_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_77_2 = arg_74_1.actors_["10131ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_2) and arg_74_1.var_.characterEffect10131ui_story == nil then
				arg_74_1.var_.characterEffect10131ui_story = var_77_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_3 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_3 and not isNil(var_77_2) then
				if arg_74_1.var_.characterEffect10131ui_story and not isNil(var_77_2) then
					arg_74_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_74_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_74_1.time_ - 0) / var_77_3)
				end
			end

			if arg_74_1.time_ >= 0 + var_77_3 and arg_74_1.time_ < 0 + var_77_3 + arg_77_0 and not isNil(var_77_2) and arg_74_1.var_.characterEffect10131ui_story then
				arg_74_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_74_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_77_4 = 0
			local var_77_5 = 0.95

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_6 = arg_74_1:GetWordFromCfg(322181018)
				local var_77_7 = arg_74_1:FormatText(var_77_6.content)

				arg_74_1.text_.text = var_77_7

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_9 = 38 <= 0 and var_77_5 or var_77_5 * (utf8.len(var_77_7) / 38)

				if (38 <= 0 and var_77_5 or var_77_5 * (utf8.len(var_77_7) / 38)) > 0 and var_77_5 < var_77_9 then
					arg_74_1.talkMaxDuration = var_77_9

					if var_77_9 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_9 + var_77_4
					end
				end

				arg_74_1.text_.text = var_77_7
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181018", "story_v_out_322181.awb") ~= 0 then
					local var_77_10 = manager.audio:GetVoiceLength("story_v_out_322181", "322181018", "story_v_out_322181.awb") / 1000

					if var_77_10 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_10 + var_77_4
					end

					if var_77_6.prefab_name ~= "" and arg_74_1.actors_[var_77_6.prefab_name] ~= nil then
						local var_77_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_6.prefab_name].transform, "story_v_out_322181", "322181018", "story_v_out_322181.awb")

						arg_74_1:RecordAudio("322181018", var_77_11)
						arg_74_1:RecordAudio("322181018", var_77_11)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_322181", "322181018", "story_v_out_322181.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_322181", "322181018", "story_v_out_322181.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_12 = math.max(var_77_5, arg_74_1.talkMaxDuration)

			if var_77_4 <= arg_74_1.time_ and arg_74_1.time_ < var_77_4 + var_77_12 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_4) / var_77_12

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_4 + var_77_12 and arg_74_1.time_ < var_77_4 + var_77_12 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play322181019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 322181019
		arg_78_1.duration_ = 11.23

		local var_78_0 = {
			zh = 11.233,
			ja = 10.933
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play322181020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 1.225

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_1 = arg_78_1:GetWordFromCfg(322181019)
				local var_81_2 = arg_78_1:FormatText(var_81_1.content)

				arg_78_1.text_.text = var_81_2

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_4 = 49 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 49)

				if (49 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 49)) > 0 and var_81_0 < var_81_4 then
					arg_78_1.talkMaxDuration = var_81_4

					if var_81_4 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_4 + 0
					end
				end

				arg_78_1.text_.text = var_81_2
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181019", "story_v_out_322181.awb") ~= 0 then
					local var_81_5 = manager.audio:GetVoiceLength("story_v_out_322181", "322181019", "story_v_out_322181.awb") / 1000

					if var_81_5 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + 0
					end

					if var_81_1.prefab_name ~= "" and arg_78_1.actors_[var_81_1.prefab_name] ~= nil then
						local var_81_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_1.prefab_name].transform, "story_v_out_322181", "322181019", "story_v_out_322181.awb")

						arg_78_1:RecordAudio("322181019", var_81_6)
						arg_78_1:RecordAudio("322181019", var_81_6)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_322181", "322181019", "story_v_out_322181.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_322181", "322181019", "story_v_out_322181.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_7 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_7 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_7

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_7 and arg_78_1.time_ < 0 + var_81_7 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play322181020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 322181020
		arg_82_1.duration_ = 4.37

		local var_82_0 = {
			zh = 3.2,
			ja = 4.366
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
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play322181021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.325

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_1 = arg_82_1:GetWordFromCfg(322181020)
				local var_85_2 = arg_82_1:FormatText(var_85_1.content)

				arg_82_1.text_.text = var_85_2

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 13 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 13)

				if (13 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 13)) > 0 and var_85_0 < var_85_4 then
					arg_82_1.talkMaxDuration = var_85_4

					if var_85_4 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_4 + 0
					end
				end

				arg_82_1.text_.text = var_85_2
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181020", "story_v_out_322181.awb") ~= 0 then
					local var_85_5 = manager.audio:GetVoiceLength("story_v_out_322181", "322181020", "story_v_out_322181.awb") / 1000

					if var_85_5 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + 0
					end

					if var_85_1.prefab_name ~= "" and arg_82_1.actors_[var_85_1.prefab_name] ~= nil then
						local var_85_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_1.prefab_name].transform, "story_v_out_322181", "322181020", "story_v_out_322181.awb")

						arg_82_1:RecordAudio("322181020", var_85_6)
						arg_82_1:RecordAudio("322181020", var_85_6)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_322181", "322181020", "story_v_out_322181.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_322181", "322181020", "story_v_out_322181.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_7 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_7 and arg_82_1.time_ < 0 + var_85_7 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play322181021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 322181021
		arg_86_1.duration_ = 8.8

		local var_86_0 = {
			zh = 7,
			ja = 8.8
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play322181022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["10131ui_story"]) and arg_86_1.var_.characterEffect10131ui_story == nil then
				arg_86_1.var_.characterEffect10131ui_story = arg_86_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_0 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["10131ui_story"]) then
				if arg_86_1.var_.characterEffect10131ui_story and not isNil(arg_86_1.actors_["10131ui_story"]) then
					arg_86_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["10131ui_story"]) and arg_86_1.var_.characterEffect10131ui_story then
				arg_86_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_89_2 = arg_86_1.actors_["1111ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_2) and arg_86_1.var_.characterEffect1111ui_story == nil then
				arg_86_1.var_.characterEffect1111ui_story = var_89_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_3 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_3 and not isNil(var_89_2) then
				if arg_86_1.var_.characterEffect1111ui_story and not isNil(var_89_2) then
					arg_86_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_3)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_3 and arg_86_1.time_ < 0 + var_89_3 + arg_89_0 and not isNil(var_89_2) and arg_86_1.var_.characterEffect1111ui_story then
				arg_86_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131actionlink/10131action462")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_89_4 = 0
			local var_89_5 = 0.6

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_6 = arg_86_1:GetWordFromCfg(322181021)
				local var_89_7 = arg_86_1:FormatText(var_89_6.content)

				arg_86_1.text_.text = var_89_7

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_9 = 24 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 24)

				if (24 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 24)) > 0 and var_89_5 < var_89_9 then
					arg_86_1.talkMaxDuration = var_89_9

					if var_89_9 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_9 + var_89_4
					end
				end

				arg_86_1.text_.text = var_89_7
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181021", "story_v_out_322181.awb") ~= 0 then
					local var_89_10 = manager.audio:GetVoiceLength("story_v_out_322181", "322181021", "story_v_out_322181.awb") / 1000

					if var_89_10 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_10 + var_89_4
					end

					if var_89_6.prefab_name ~= "" and arg_86_1.actors_[var_89_6.prefab_name] ~= nil then
						local var_89_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_6.prefab_name].transform, "story_v_out_322181", "322181021", "story_v_out_322181.awb")

						arg_86_1:RecordAudio("322181021", var_89_11)
						arg_86_1:RecordAudio("322181021", var_89_11)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_322181", "322181021", "story_v_out_322181.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_322181", "322181021", "story_v_out_322181.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_12 = math.max(var_89_5, arg_86_1.talkMaxDuration)

			if var_89_4 <= arg_86_1.time_ and arg_86_1.time_ < var_89_4 + var_89_12 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_4) / var_89_12

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_4 + var_89_12 and arg_86_1.time_ < var_89_4 + var_89_12 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play322181022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 322181022
		arg_90_1.duration_ = 6.13

		local var_90_0 = {
			zh = 4.866,
			ja = 6.133
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play322181023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1111ui_story"]) and arg_90_1.var_.characterEffect1111ui_story == nil then
				arg_90_1.var_.characterEffect1111ui_story = arg_90_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1111ui_story"]) then
				if arg_90_1.var_.characterEffect1111ui_story and not isNil(arg_90_1.actors_["1111ui_story"]) then
					arg_90_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1111ui_story"]) and arg_90_1.var_.characterEffect1111ui_story then
				arg_90_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_93_2 = arg_90_1.actors_["10131ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.characterEffect10131ui_story == nil then
				arg_90_1.var_.characterEffect10131ui_story = var_93_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_3 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_3 and not isNil(var_93_2) then
				if arg_90_1.var_.characterEffect10131ui_story and not isNil(var_93_2) then
					arg_90_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_90_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_3)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_3 and arg_90_1.time_ < 0 + var_93_3 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.characterEffect10131ui_story then
				arg_90_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_90_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			local var_93_4 = 0
			local var_93_5 = 0.575

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_6 = arg_90_1:GetWordFromCfg(322181022)
				local var_93_7 = arg_90_1:FormatText(var_93_6.content)

				arg_90_1.text_.text = var_93_7

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_9 = 23 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 23)

				if (23 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 23)) > 0 and var_93_5 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9

					if var_93_9 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_4
					end
				end

				arg_90_1.text_.text = var_93_7
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181022", "story_v_out_322181.awb") ~= 0 then
					local var_93_10 = manager.audio:GetVoiceLength("story_v_out_322181", "322181022", "story_v_out_322181.awb") / 1000

					if var_93_10 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_10 + var_93_4
					end

					if var_93_6.prefab_name ~= "" and arg_90_1.actors_[var_93_6.prefab_name] ~= nil then
						local var_93_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_6.prefab_name].transform, "story_v_out_322181", "322181022", "story_v_out_322181.awb")

						arg_90_1:RecordAudio("322181022", var_93_11)
						arg_90_1:RecordAudio("322181022", var_93_11)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_322181", "322181022", "story_v_out_322181.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_322181", "322181022", "story_v_out_322181.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_12 = math.max(var_93_5, arg_90_1.talkMaxDuration)

			if var_93_4 <= arg_90_1.time_ and arg_90_1.time_ < var_93_4 + var_93_12 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_4) / var_93_12

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_4 + var_93_12 and arg_90_1.time_ < var_93_4 + var_93_12 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play322181023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 322181023
		arg_94_1.duration_ = 4.53

		local var_94_0 = {
			zh = 3.733,
			ja = 4.533
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play322181024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["10131ui_story"]) and arg_94_1.var_.characterEffect10131ui_story == nil then
				arg_94_1.var_.characterEffect10131ui_story = arg_94_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["10131ui_story"]) then
				if arg_94_1.var_.characterEffect10131ui_story and not isNil(arg_94_1.actors_["10131ui_story"]) then
					arg_94_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["10131ui_story"]) and arg_94_1.var_.characterEffect10131ui_story then
				arg_94_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_97_2 = arg_94_1.actors_["1111ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect1111ui_story == nil then
				arg_94_1.var_.characterEffect1111ui_story = var_97_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_3 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_3 and not isNil(var_97_2) then
				if arg_94_1.var_.characterEffect1111ui_story and not isNil(var_97_2) then
					arg_94_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_3)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_3 and arg_94_1.time_ < 0 + var_97_3 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect1111ui_story then
				arg_94_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_2")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_97_4 = 0
			local var_97_5 = 0.375

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_6 = arg_94_1:GetWordFromCfg(322181023)
				local var_97_7 = arg_94_1:FormatText(var_97_6.content)

				arg_94_1.text_.text = var_97_7

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_9 = 15 <= 0 and var_97_5 or var_97_5 * (utf8.len(var_97_7) / 15)

				if (15 <= 0 and var_97_5 or var_97_5 * (utf8.len(var_97_7) / 15)) > 0 and var_97_5 < var_97_9 then
					arg_94_1.talkMaxDuration = var_97_9

					if var_97_9 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_9 + var_97_4
					end
				end

				arg_94_1.text_.text = var_97_7
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181023", "story_v_out_322181.awb") ~= 0 then
					local var_97_10 = manager.audio:GetVoiceLength("story_v_out_322181", "322181023", "story_v_out_322181.awb") / 1000

					if var_97_10 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_10 + var_97_4
					end

					if var_97_6.prefab_name ~= "" and arg_94_1.actors_[var_97_6.prefab_name] ~= nil then
						local var_97_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_6.prefab_name].transform, "story_v_out_322181", "322181023", "story_v_out_322181.awb")

						arg_94_1:RecordAudio("322181023", var_97_11)
						arg_94_1:RecordAudio("322181023", var_97_11)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_322181", "322181023", "story_v_out_322181.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_322181", "322181023", "story_v_out_322181.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_12 = math.max(var_97_5, arg_94_1.talkMaxDuration)

			if var_97_4 <= arg_94_1.time_ and arg_94_1.time_ < var_97_4 + var_97_12 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_4) / var_97_12

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_4 + var_97_12 and arg_94_1.time_ < var_97_4 + var_97_12 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play322181024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 322181024
		arg_98_1.duration_ = 10.8

		local var_98_0 = {
			zh = 10.3,
			ja = 10.8
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play322181025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1111ui_story"]) and arg_98_1.var_.characterEffect1111ui_story == nil then
				arg_98_1.var_.characterEffect1111ui_story = arg_98_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1111ui_story"]) then
				if arg_98_1.var_.characterEffect1111ui_story and not isNil(arg_98_1.actors_["1111ui_story"]) then
					arg_98_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1111ui_story"]) and arg_98_1.var_.characterEffect1111ui_story then
				arg_98_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_101_2 = arg_98_1.actors_["10131ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect10131ui_story == nil then
				arg_98_1.var_.characterEffect10131ui_story = var_101_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_3 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_3 and not isNil(var_101_2) then
				if arg_98_1.var_.characterEffect10131ui_story and not isNil(var_101_2) then
					arg_98_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_98_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_3)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_3 and arg_98_1.time_ < 0 + var_101_3 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect10131ui_story then
				arg_98_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_98_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_101_4 = 0
			local var_101_5 = 1.275

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_6 = arg_98_1:GetWordFromCfg(322181024)
				local var_101_7 = arg_98_1:FormatText(var_101_6.content)

				arg_98_1.text_.text = var_101_7

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_9 = 52 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 52)

				if (52 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 52)) > 0 and var_101_5 < var_101_9 then
					arg_98_1.talkMaxDuration = var_101_9

					if var_101_9 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_4
					end
				end

				arg_98_1.text_.text = var_101_7
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181024", "story_v_out_322181.awb") ~= 0 then
					local var_101_10 = manager.audio:GetVoiceLength("story_v_out_322181", "322181024", "story_v_out_322181.awb") / 1000

					if var_101_10 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_4
					end

					if var_101_6.prefab_name ~= "" and arg_98_1.actors_[var_101_6.prefab_name] ~= nil then
						local var_101_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_6.prefab_name].transform, "story_v_out_322181", "322181024", "story_v_out_322181.awb")

						arg_98_1:RecordAudio("322181024", var_101_11)
						arg_98_1:RecordAudio("322181024", var_101_11)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_322181", "322181024", "story_v_out_322181.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_322181", "322181024", "story_v_out_322181.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_12 = math.max(var_101_5, arg_98_1.talkMaxDuration)

			if var_101_4 <= arg_98_1.time_ and arg_98_1.time_ < var_101_4 + var_101_12 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_4) / var_101_12

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_4 + var_101_12 and arg_98_1.time_ < var_101_4 + var_101_12 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play322181025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 322181025
		arg_102_1.duration_ = 11.87

		local var_102_0 = {
			zh = 7.833,
			ja = 11.866
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play322181026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0.825

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_1 = arg_102_1:GetWordFromCfg(322181025)
				local var_105_2 = arg_102_1:FormatText(var_105_1.content)

				arg_102_1.text_.text = var_105_2

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 33 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 33)

				if (33 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 33)) > 0 and var_105_0 < var_105_4 then
					arg_102_1.talkMaxDuration = var_105_4

					if var_105_4 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_4 + 0
					end
				end

				arg_102_1.text_.text = var_105_2
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181025", "story_v_out_322181.awb") ~= 0 then
					local var_105_5 = manager.audio:GetVoiceLength("story_v_out_322181", "322181025", "story_v_out_322181.awb") / 1000

					if var_105_5 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + 0
					end

					if var_105_1.prefab_name ~= "" and arg_102_1.actors_[var_105_1.prefab_name] ~= nil then
						local var_105_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_1.prefab_name].transform, "story_v_out_322181", "322181025", "story_v_out_322181.awb")

						arg_102_1:RecordAudio("322181025", var_105_6)
						arg_102_1:RecordAudio("322181025", var_105_6)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_322181", "322181025", "story_v_out_322181.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_322181", "322181025", "story_v_out_322181.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_7 and arg_102_1.time_ < 0 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play322181026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 322181026
		arg_106_1.duration_ = 7.17

		local var_106_0 = {
			zh = 5.9,
			ja = 7.166
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play322181027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_109_0 = 0
			local var_109_1 = 0.675

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_2 = arg_106_1:GetWordFromCfg(322181026)
				local var_109_3 = arg_106_1:FormatText(var_109_2.content)

				arg_106_1.text_.text = var_109_3

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 27 <= 0 and var_109_1 or var_109_1 * (utf8.len(var_109_3) / 27)

				if (27 <= 0 and var_109_1 or var_109_1 * (utf8.len(var_109_3) / 27)) > 0 and var_109_1 < var_109_5 then
					arg_106_1.talkMaxDuration = var_109_5

					if var_109_5 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_3
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181026", "story_v_out_322181.awb") ~= 0 then
					local var_109_6 = manager.audio:GetVoiceLength("story_v_out_322181", "322181026", "story_v_out_322181.awb") / 1000

					if var_109_6 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_6 + var_109_0
					end

					if var_109_2.prefab_name ~= "" and arg_106_1.actors_[var_109_2.prefab_name] ~= nil then
						local var_109_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_2.prefab_name].transform, "story_v_out_322181", "322181026", "story_v_out_322181.awb")

						arg_106_1:RecordAudio("322181026", var_109_7)
						arg_106_1:RecordAudio("322181026", var_109_7)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_322181", "322181026", "story_v_out_322181.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_322181", "322181026", "story_v_out_322181.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_8 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_8 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_8

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_8 and arg_106_1.time_ < var_109_0 + var_109_8 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play322181027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 322181027
		arg_110_1.duration_ = 10.9

		local var_110_0 = {
			zh = 7.5,
			ja = 10.9
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play322181028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["10131ui_story"]) and arg_110_1.var_.characterEffect10131ui_story == nil then
				arg_110_1.var_.characterEffect10131ui_story = arg_110_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["10131ui_story"]) then
				if arg_110_1.var_.characterEffect10131ui_story and not isNil(arg_110_1.actors_["10131ui_story"]) then
					arg_110_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["10131ui_story"]) and arg_110_1.var_.characterEffect10131ui_story then
				arg_110_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_113_2 = arg_110_1.actors_["1111ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.characterEffect1111ui_story == nil then
				arg_110_1.var_.characterEffect1111ui_story = var_113_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_3 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_3 and not isNil(var_113_2) then
				if arg_110_1.var_.characterEffect1111ui_story and not isNil(var_113_2) then
					arg_110_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_3)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_3 and arg_110_1.time_ < 0 + var_113_3 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.characterEffect1111ui_story then
				arg_110_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_1")
			end

			local var_113_4 = 0
			local var_113_5 = 0.575

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_6 = arg_110_1:GetWordFromCfg(322181027)
				local var_113_7 = arg_110_1:FormatText(var_113_6.content)

				arg_110_1.text_.text = var_113_7

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_9 = 23 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 23)

				if (23 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 23)) > 0 and var_113_5 < var_113_9 then
					arg_110_1.talkMaxDuration = var_113_9

					if var_113_9 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_9 + var_113_4
					end
				end

				arg_110_1.text_.text = var_113_7
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181027", "story_v_out_322181.awb") ~= 0 then
					local var_113_10 = manager.audio:GetVoiceLength("story_v_out_322181", "322181027", "story_v_out_322181.awb") / 1000

					if var_113_10 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_10 + var_113_4
					end

					if var_113_6.prefab_name ~= "" and arg_110_1.actors_[var_113_6.prefab_name] ~= nil then
						local var_113_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_6.prefab_name].transform, "story_v_out_322181", "322181027", "story_v_out_322181.awb")

						arg_110_1:RecordAudio("322181027", var_113_11)
						arg_110_1:RecordAudio("322181027", var_113_11)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_322181", "322181027", "story_v_out_322181.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_322181", "322181027", "story_v_out_322181.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_12 = math.max(var_113_5, arg_110_1.talkMaxDuration)

			if var_113_4 <= arg_110_1.time_ and arg_110_1.time_ < var_113_4 + var_113_12 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_4) / var_113_12

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_4 + var_113_12 and arg_110_1.time_ < var_113_4 + var_113_12 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play322181028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 322181028
		arg_114_1.duration_ = 6.37

		local var_114_0 = {
			zh = 5.566,
			ja = 6.366
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play322181029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if arg_114_1.bgs_.L09f == nil then
				local var_117_0 = Object.Instantiate(arg_114_1.paintGo_)

				var_117_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L09f")
				var_117_0.name = "L09f"
				var_117_0.transform.parent = arg_114_1.stage_.transform
				var_117_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_114_1.bgs_.L09f = var_117_0
			end

			if 2 < arg_114_1.time_ and arg_114_1.time_ <= 2 + arg_117_0 then
				local var_117_1 = arg_114_1.bgs_.L09f

				arg_114_1.bgs_.L09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_117_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_117_2 = var_117_1:GetComponent("SpriteRenderer")

				if var_117_2 and var_117_2.sprite then
					local var_117_3 = 2 * (var_117_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_117_1.transform.localScale = Vector3.New(var_117_3 / var_117_2.sprite.bounds.size.y < var_117_3 * manager.ui.mainCameraCom_.aspect / var_117_2.sprite.bounds.size.x and var_117_3 * manager.ui.mainCameraCom_.aspect / var_117_2.sprite.bounds.size.x or var_117_3 / var_117_2.sprite.bounds.size.y, var_117_3 / var_117_2.sprite.bounds.size.y < var_117_3 * manager.ui.mainCameraCom_.aspect / var_117_2.sprite.bounds.size.x and var_117_3 * manager.ui.mainCameraCom_.aspect / var_117_2.sprite.bounds.size.x or var_117_3 / var_117_2.sprite.bounds.size.y, 0)
				end

				for iter_117_0, iter_117_1 in pairs(arg_114_1.bgs_) do
					if iter_117_0 ~= "L09f" then
						iter_117_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_117_4 = 4

			if 4 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.allBtn_.enabled = false
			end

			if arg_114_1.time_ >= var_117_4 + 0.125 and arg_114_1.time_ < var_117_4 + 0.125 + arg_117_0 then
				arg_114_1.allBtn_.enabled = true
			end

			local var_117_5 = 0

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_6 = 2

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_6 then
				local var_117_7 = Color.New(0, 0, 0)

				var_117_7.a = Mathf.Lerp(0, 1, (arg_114_1.time_ - var_117_5) / var_117_6)
				arg_114_1.mask_.color = var_117_7
			end

			if arg_114_1.time_ >= var_117_5 + var_117_6 and arg_114_1.time_ < var_117_5 + var_117_6 + arg_117_0 then
				local var_117_8 = Color.New(0, 0, 0)

				var_117_8.a = 1
				arg_114_1.mask_.color = var_117_8
			end

			local var_117_9 = 2

			if 2 < arg_114_1.time_ and arg_114_1.time_ <= var_117_9 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_10 = 2

			if var_117_9 <= arg_114_1.time_ and arg_114_1.time_ < var_117_9 + var_117_10 then
				local var_117_11 = Color.New(0, 0, 0)

				var_117_11.a = Mathf.Lerp(1, 0, (arg_114_1.time_ - var_117_9) / var_117_10)
				arg_114_1.mask_.color = var_117_11
			end

			if arg_114_1.time_ >= var_117_9 + var_117_10 and arg_114_1.time_ < var_117_9 + var_117_10 + arg_117_0 then
				local var_117_12 = Color.New(0, 0, 0)

				arg_114_1.mask_.enabled = false
				var_117_12.a = 0
				arg_114_1.mask_.color = var_117_12
			end

			local var_117_13 = arg_114_1.actors_["1111ui_story"].transform

			if 2 < arg_114_1.time_ and arg_114_1.time_ <= 2 + arg_117_0 then
				arg_114_1.var_.moveOldPos1111ui_story = var_117_13.localPosition
			end

			local var_117_14 = 0.001

			if 2 <= arg_114_1.time_ and arg_114_1.time_ < 2 + var_117_14 then
				var_117_13.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_114_1.time_ - 2) / var_117_14)
				var_117_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_13.position).x, (manager.ui.mainCamera.transform.position - var_117_13.position).y, (manager.ui.mainCamera.transform.position - var_117_13.position).z)
				var_117_13.localEulerAngles.z = 0
				var_117_13.localEulerAngles.x = 0
				var_117_13.localEulerAngles = var_117_13.localEulerAngles
			end

			if arg_114_1.time_ >= 2 + var_117_14 and arg_114_1.time_ < 2 + var_117_14 + arg_117_0 then
				var_117_13.localPosition = Vector3.New(0, 100, 0)
				var_117_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_13.position).x, (manager.ui.mainCamera.transform.position - var_117_13.position).y, (manager.ui.mainCamera.transform.position - var_117_13.position).z)
				var_117_13.localEulerAngles.z = 0
				var_117_13.localEulerAngles.x = 0
				var_117_13.localEulerAngles = var_117_13.localEulerAngles
			end

			local var_117_15 = arg_114_1.actors_["10131ui_story"].transform

			if 2 < arg_114_1.time_ and arg_114_1.time_ <= 2 + arg_117_0 then
				arg_114_1.var_.moveOldPos10131ui_story = var_117_15.localPosition
			end

			local var_117_16 = 0.001

			if 2 <= arg_114_1.time_ and arg_114_1.time_ < 2 + var_117_16 then
				var_117_15.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_114_1.time_ - 2) / var_117_16)
				var_117_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_15.position).x, (manager.ui.mainCamera.transform.position - var_117_15.position).y, (manager.ui.mainCamera.transform.position - var_117_15.position).z)
				var_117_15.localEulerAngles.z = 0
				var_117_15.localEulerAngles.x = 0
				var_117_15.localEulerAngles = var_117_15.localEulerAngles
			end

			if arg_114_1.time_ >= 2 + var_117_16 and arg_114_1.time_ < 2 + var_117_16 + arg_117_0 then
				var_117_15.localPosition = Vector3.New(0, 100, 0)
				var_117_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_15.position).x, (manager.ui.mainCamera.transform.position - var_117_15.position).y, (manager.ui.mainCamera.transform.position - var_117_15.position).z)
				var_117_15.localEulerAngles.z = 0
				var_117_15.localEulerAngles.x = 0
				var_117_15.localEulerAngles = var_117_15.localEulerAngles
			end

			if arg_114_1.frameCnt_ <= 1 then
				arg_114_1.dialog_:SetActive(false)
			end

			local var_117_17 = 4
			local var_117_18 = 0.125

			if 4 < arg_114_1.time_ and arg_114_1.time_ <= var_117_17 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0

				arg_114_1.dialog_:SetActive(true)

				arg_114_1.dialogCg_.alpha = 0

				local var_117_19 = LeanTween.value(arg_114_1.dialog_, 0, 1, 0.3)

				var_117_19:setOnUpdate(LuaHelper.FloatAction(function(arg_118_0)
					arg_114_1.dialogCg_.alpha = arg_118_0
				end))
				var_117_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_114_1.dialog_)
					var_117_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_114_1.duration_ = arg_114_1.duration_ + 0.3

				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10061")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_20 = arg_114_1:GetWordFromCfg(322181028)
				local var_117_21 = arg_114_1:FormatText(var_117_20.content)

				arg_114_1.text_.text = var_117_21

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_23 = 5 <= 0 and var_117_18 or var_117_18 * (utf8.len(var_117_21) / 5)

				if (5 <= 0 and var_117_18 or var_117_18 * (utf8.len(var_117_21) / 5)) > 0 and var_117_18 < var_117_23 then
					arg_114_1.talkMaxDuration = var_117_23
					var_117_17 = var_117_17 + 0.3

					if var_117_23 + var_117_17 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_23 + var_117_17
					end
				end

				arg_114_1.text_.text = var_117_21
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181028", "story_v_out_322181.awb") ~= 0 then
					local var_117_24 = manager.audio:GetVoiceLength("story_v_out_322181", "322181028", "story_v_out_322181.awb") / 1000

					if var_117_24 + var_117_17 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_24 + var_117_17
					end

					if var_117_20.prefab_name ~= "" and arg_114_1.actors_[var_117_20.prefab_name] ~= nil then
						local var_117_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_20.prefab_name].transform, "story_v_out_322181", "322181028", "story_v_out_322181.awb")

						arg_114_1:RecordAudio("322181028", var_117_25)
						arg_114_1:RecordAudio("322181028", var_117_25)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_322181", "322181028", "story_v_out_322181.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_322181", "322181028", "story_v_out_322181.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_26 = var_117_17 + 0.3
			local var_117_27 = math.max(var_117_18, arg_114_1.talkMaxDuration)

			if var_117_17 + 0.3 <= arg_114_1.time_ and arg_114_1.time_ < var_117_26 + var_117_27 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_26) / var_117_27

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_26 + var_117_27 and arg_114_1.time_ < var_117_26 + var_117_27 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play322181029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 322181029
		arg_120_1.duration_ = 2.4

		local var_120_0 = {
			zh = 2.4,
			ja = 2.233
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
				arg_120_0:Play322181030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1111ui_story = arg_120_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_123_0 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 then
				arg_120_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_120_1.time_ - 0) / var_123_0)
				arg_120_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1111ui_story"].transform.position).z)
				arg_120_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["1111ui_story"].transform.localEulerAngles = arg_120_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 then
				arg_120_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_120_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1111ui_story"].transform.position).z)
				arg_120_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["1111ui_story"].transform.localEulerAngles = arg_120_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_123_1 = arg_120_1.actors_["1111ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_1) and arg_120_1.var_.characterEffect1111ui_story == nil then
				arg_120_1.var_.characterEffect1111ui_story = var_123_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_2 and not isNil(var_123_1) then
				if arg_120_1.var_.characterEffect1111ui_story and not isNil(var_123_1) then
					arg_120_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_2 and arg_120_1.time_ < 0 + var_123_2 + arg_123_0 and not isNil(var_123_1) and arg_120_1.var_.characterEffect1111ui_story then
				arg_120_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_123_4 = 0
			local var_123_5 = 0.15

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_6 = arg_120_1:GetWordFromCfg(322181029)
				local var_123_7 = arg_120_1:FormatText(var_123_6.content)

				arg_120_1.text_.text = var_123_7

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_9 = 6 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 6)

				if (6 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 6)) > 0 and var_123_5 < var_123_9 then
					arg_120_1.talkMaxDuration = var_123_9

					if var_123_9 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_9 + var_123_4
					end
				end

				arg_120_1.text_.text = var_123_7
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181029", "story_v_out_322181.awb") ~= 0 then
					local var_123_10 = manager.audio:GetVoiceLength("story_v_out_322181", "322181029", "story_v_out_322181.awb") / 1000

					if var_123_10 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_4
					end

					if var_123_6.prefab_name ~= "" and arg_120_1.actors_[var_123_6.prefab_name] ~= nil then
						local var_123_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_6.prefab_name].transform, "story_v_out_322181", "322181029", "story_v_out_322181.awb")

						arg_120_1:RecordAudio("322181029", var_123_11)
						arg_120_1:RecordAudio("322181029", var_123_11)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_322181", "322181029", "story_v_out_322181.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_322181", "322181029", "story_v_out_322181.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_12 = math.max(var_123_5, arg_120_1.talkMaxDuration)

			if var_123_4 <= arg_120_1.time_ and arg_120_1.time_ < var_123_4 + var_123_12 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_4) / var_123_12

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_4 + var_123_12 and arg_120_1.time_ < var_123_4 + var_123_12 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play322181030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 322181030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play322181031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1111ui_story = arg_124_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_127_0 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 then
				arg_124_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_124_1.time_ - 0) / var_127_0)
				arg_124_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1111ui_story"].transform.position).z)
				arg_124_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1111ui_story"].transform.localEulerAngles = arg_124_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 then
				arg_124_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_124_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1111ui_story"].transform.position).z)
				arg_124_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1111ui_story"].transform.localEulerAngles = arg_124_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if 0.666666666666667 < arg_124_1.time_ and arg_124_1.time_ <= 0.666666666666667 + arg_127_0 then
				arg_124_1:AudioAction("play", "effect", "se_story_145", "se_story_145_hit", "")
			end

			local var_127_2 = 0
			local var_127_3 = 1.175

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_2 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_4 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(322181030).content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_6 = 47 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_4) / 47)

				if (47 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_4) / 47)) > 0 and var_127_3 < var_127_6 then
					arg_124_1.talkMaxDuration = var_127_6

					if var_127_6 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_6 + var_127_2
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_3, arg_124_1.talkMaxDuration)

			if var_127_2 <= arg_124_1.time_ and arg_124_1.time_ < var_127_2 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_2) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_2 + var_127_7 and arg_124_1.time_ < var_127_2 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play322181031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 322181031
		arg_128_1.duration_ = 5.1

		local var_128_0 = {
			zh = 4.133,
			ja = 5.1
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
				arg_128_0:Play322181032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1111ui_story = arg_128_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_131_0 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 then
				arg_128_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_128_1.time_ - 0) / var_131_0)
				arg_128_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1111ui_story"].transform.position).z)
				arg_128_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1111ui_story"].transform.localEulerAngles = arg_128_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 then
				arg_128_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_128_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1111ui_story"].transform.position).z)
				arg_128_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1111ui_story"].transform.localEulerAngles = arg_128_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_131_1 = arg_128_1.actors_["1111ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect1111ui_story == nil then
				arg_128_1.var_.characterEffect1111ui_story = var_131_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_2 and not isNil(var_131_1) then
				if arg_128_1.var_.characterEffect1111ui_story and not isNil(var_131_1) then
					arg_128_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_2 and arg_128_1.time_ < 0 + var_131_2 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect1111ui_story then
				arg_128_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action3_1")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_131_4 = 0
			local var_131_5 = 0.475

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_6 = arg_128_1:GetWordFromCfg(322181031)
				local var_131_7 = arg_128_1:FormatText(var_131_6.content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 19 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 19)

				if (19 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 19)) > 0 and var_131_5 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181031", "story_v_out_322181.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_out_322181", "322181031", "story_v_out_322181.awb") / 1000

					if var_131_10 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_4
					end

					if var_131_6.prefab_name ~= "" and arg_128_1.actors_[var_131_6.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_6.prefab_name].transform, "story_v_out_322181", "322181031", "story_v_out_322181.awb")

						arg_128_1:RecordAudio("322181031", var_131_11)
						arg_128_1:RecordAudio("322181031", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_322181", "322181031", "story_v_out_322181.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_322181", "322181031", "story_v_out_322181.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_12 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_12 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_12

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_12 and arg_128_1.time_ < var_131_4 + var_131_12 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play322181032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 322181032
		arg_132_1.duration_ = 5.8

		local var_132_0 = {
			zh = 5.8,
			ja = 5.666
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
				arg_132_0:Play322181033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0.725

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_1 = arg_132_1:GetWordFromCfg(322181032)
				local var_135_2 = arg_132_1:FormatText(var_135_1.content)

				arg_132_1.text_.text = var_135_2

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_4 = 29 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 29)

				if (29 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 29)) > 0 and var_135_0 < var_135_4 then
					arg_132_1.talkMaxDuration = var_135_4

					if var_135_4 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_4 + 0
					end
				end

				arg_132_1.text_.text = var_135_2
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181032", "story_v_out_322181.awb") ~= 0 then
					local var_135_5 = manager.audio:GetVoiceLength("story_v_out_322181", "322181032", "story_v_out_322181.awb") / 1000

					if var_135_5 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + 0
					end

					if var_135_1.prefab_name ~= "" and arg_132_1.actors_[var_135_1.prefab_name] ~= nil then
						local var_135_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_1.prefab_name].transform, "story_v_out_322181", "322181032", "story_v_out_322181.awb")

						arg_132_1:RecordAudio("322181032", var_135_6)
						arg_132_1:RecordAudio("322181032", var_135_6)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_322181", "322181032", "story_v_out_322181.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_322181", "322181032", "story_v_out_322181.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play322181033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 322181033
		arg_136_1.duration_ = 8.9

		local var_136_0 = {
			zh = 6.333,
			ja = 8.9
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
				arg_136_0:Play322181034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1111ui_story"]) and arg_136_1.var_.characterEffect1111ui_story == nil then
				arg_136_1.var_.characterEffect1111ui_story = arg_136_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1111ui_story"]) then
				if arg_136_1.var_.characterEffect1111ui_story and not isNil(arg_136_1.actors_["1111ui_story"]) then
					arg_136_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_0)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1111ui_story"]) and arg_136_1.var_.characterEffect1111ui_story then
				arg_136_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_139_1 = 0
			local var_139_2 = 0.65

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Goyle")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_3 = arg_136_1:GetWordFromCfg(322181033)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_6 = 26 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_4) / 26)

				if (26 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_4) / 26)) > 0 and var_139_2 < var_139_6 then
					arg_136_1.talkMaxDuration = var_139_6

					if var_139_6 + var_139_1 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_6 + var_139_1
					end
				end

				arg_136_1.text_.text = var_139_4
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181033", "story_v_out_322181.awb") ~= 0 then
					local var_139_7 = manager.audio:GetVoiceLength("story_v_out_322181", "322181033", "story_v_out_322181.awb") / 1000

					if var_139_7 + var_139_1 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_1
					end

					if var_139_3.prefab_name ~= "" and arg_136_1.actors_[var_139_3.prefab_name] ~= nil then
						local var_139_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_3.prefab_name].transform, "story_v_out_322181", "322181033", "story_v_out_322181.awb")

						arg_136_1:RecordAudio("322181033", var_139_8)
						arg_136_1:RecordAudio("322181033", var_139_8)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_322181", "322181033", "story_v_out_322181.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_322181", "322181033", "story_v_out_322181.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_9 = math.max(var_139_2, arg_136_1.talkMaxDuration)

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_9 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_1) / var_139_9

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_1 + var_139_9 and arg_136_1.time_ < var_139_1 + var_139_9 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play322181034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 322181034
		arg_140_1.duration_ = 7.83

		local var_140_0 = {
			zh = 6.866,
			ja = 7.833
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
				arg_140_0:Play322181035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1111ui_story"]) and arg_140_1.var_.characterEffect1111ui_story == nil then
				arg_140_1.var_.characterEffect1111ui_story = arg_140_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1111ui_story"]) then
				if arg_140_1.var_.characterEffect1111ui_story and not isNil(arg_140_1.actors_["1111ui_story"]) then
					arg_140_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1111ui_story"]) and arg_140_1.var_.characterEffect1111ui_story then
				arg_140_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action3_2")
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_143_2 = 0
			local var_143_3 = 0.75

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_2 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_4 = arg_140_1:GetWordFromCfg(322181034)
				local var_143_5 = arg_140_1:FormatText(var_143_4.content)

				arg_140_1.text_.text = var_143_5

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_7 = 30 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 30)

				if (30 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 30)) > 0 and var_143_3 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_2
					end
				end

				arg_140_1.text_.text = var_143_5
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181034", "story_v_out_322181.awb") ~= 0 then
					local var_143_8 = manager.audio:GetVoiceLength("story_v_out_322181", "322181034", "story_v_out_322181.awb") / 1000

					if var_143_8 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_2
					end

					if var_143_4.prefab_name ~= "" and arg_140_1.actors_[var_143_4.prefab_name] ~= nil then
						local var_143_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_4.prefab_name].transform, "story_v_out_322181", "322181034", "story_v_out_322181.awb")

						arg_140_1:RecordAudio("322181034", var_143_9)
						arg_140_1:RecordAudio("322181034", var_143_9)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_322181", "322181034", "story_v_out_322181.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_322181", "322181034", "story_v_out_322181.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_3, arg_140_1.talkMaxDuration)

			if var_143_2 <= arg_140_1.time_ and arg_140_1.time_ < var_143_2 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_2) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_2 + var_143_10 and arg_140_1.time_ < var_143_2 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play322181035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 322181035
		arg_144_1.duration_ = 2.43

		local var_144_0 = {
			zh = 0.999999999999,
			ja = 2.433
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
				arg_144_0:Play322181036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1111ui_story"]) and arg_144_1.var_.characterEffect1111ui_story == nil then
				arg_144_1.var_.characterEffect1111ui_story = arg_144_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1111ui_story"]) then
				if arg_144_1.var_.characterEffect1111ui_story and not isNil(arg_144_1.actors_["1111ui_story"]) then
					arg_144_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_0)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1111ui_story"]) and arg_144_1.var_.characterEffect1111ui_story then
				arg_144_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_147_1 = 0
			local var_147_2 = 0.075

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Goyle")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:GetWordFromCfg(322181035)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_6 = 3 <= 0 and var_147_2 or var_147_2 * (utf8.len(var_147_4) / 3)

				if (3 <= 0 and var_147_2 or var_147_2 * (utf8.len(var_147_4) / 3)) > 0 and var_147_2 < var_147_6 then
					arg_144_1.talkMaxDuration = var_147_6

					if var_147_6 + var_147_1 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_6 + var_147_1
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181035", "story_v_out_322181.awb") ~= 0 then
					local var_147_7 = manager.audio:GetVoiceLength("story_v_out_322181", "322181035", "story_v_out_322181.awb") / 1000

					if var_147_7 + var_147_1 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_1
					end

					if var_147_3.prefab_name ~= "" and arg_144_1.actors_[var_147_3.prefab_name] ~= nil then
						local var_147_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_3.prefab_name].transform, "story_v_out_322181", "322181035", "story_v_out_322181.awb")

						arg_144_1:RecordAudio("322181035", var_147_8)
						arg_144_1:RecordAudio("322181035", var_147_8)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_322181", "322181035", "story_v_out_322181.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_322181", "322181035", "story_v_out_322181.awb")
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
	Play322181036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 322181036
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play322181037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1111ui_story = arg_148_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_151_0 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 then
				arg_148_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_0)
				arg_148_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1111ui_story"].transform.position).z)
				arg_148_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1111ui_story"].transform.localEulerAngles = arg_148_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 then
				arg_148_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1111ui_story"].transform.position).z)
				arg_148_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1111ui_story"].transform.localEulerAngles = arg_148_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_151_1 = 0
			local var_151_2 = 1.525

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_3 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(322181036).content)

				arg_148_1.text_.text = var_151_3

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 61 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_3) / 61)

				if (61 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_3) / 61)) > 0 and var_151_2 < var_151_5 then
					arg_148_1.talkMaxDuration = var_151_5

					if var_151_5 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + var_151_1
					end
				end

				arg_148_1.text_.text = var_151_3
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_6 = math.max(var_151_2, arg_148_1.talkMaxDuration)

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_6 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_1) / var_151_6

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_1 + var_151_6 and arg_148_1.time_ < var_151_1 + var_151_6 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play322181037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 322181037
		arg_152_1.duration_ = 10.47

		local var_152_0 = {
			zh = 8.433,
			ja = 10.466
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
				arg_152_0:Play322181038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 1

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Goyle")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_1 = arg_152_1:GetWordFromCfg(322181037)
				local var_155_2 = arg_152_1:FormatText(var_155_1.content)

				arg_152_1.text_.text = var_155_2

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_4 = 40 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 40)

				if (40 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 40)) > 0 and var_155_0 < var_155_4 then
					arg_152_1.talkMaxDuration = var_155_4

					if var_155_4 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_4 + 0
					end
				end

				arg_152_1.text_.text = var_155_2
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181037", "story_v_out_322181.awb") ~= 0 then
					local var_155_5 = manager.audio:GetVoiceLength("story_v_out_322181", "322181037", "story_v_out_322181.awb") / 1000

					if var_155_5 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + 0
					end

					if var_155_1.prefab_name ~= "" and arg_152_1.actors_[var_155_1.prefab_name] ~= nil then
						local var_155_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_1.prefab_name].transform, "story_v_out_322181", "322181037", "story_v_out_322181.awb")

						arg_152_1:RecordAudio("322181037", var_155_6)
						arg_152_1:RecordAudio("322181037", var_155_6)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_322181", "322181037", "story_v_out_322181.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_322181", "322181037", "story_v_out_322181.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_7 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_7 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_7

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_7 and arg_152_1.time_ < 0 + var_155_7 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play322181038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 322181038
		arg_156_1.duration_ = 14.67

		local var_156_0 = {
			zh = 6.1,
			ja = 14.666
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
				arg_156_0:Play322181039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0.925

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Goyle")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_1 = arg_156_1:GetWordFromCfg(322181038)
				local var_159_2 = arg_156_1:FormatText(var_159_1.content)

				arg_156_1.text_.text = var_159_2

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_4 = 37 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 37)

				if (37 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 37)) > 0 and var_159_0 < var_159_4 then
					arg_156_1.talkMaxDuration = var_159_4

					if var_159_4 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_4 + 0
					end
				end

				arg_156_1.text_.text = var_159_2
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181038", "story_v_out_322181.awb") ~= 0 then
					local var_159_5 = manager.audio:GetVoiceLength("story_v_out_322181", "322181038", "story_v_out_322181.awb") / 1000

					if var_159_5 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + 0
					end

					if var_159_1.prefab_name ~= "" and arg_156_1.actors_[var_159_1.prefab_name] ~= nil then
						local var_159_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_1.prefab_name].transform, "story_v_out_322181", "322181038", "story_v_out_322181.awb")

						arg_156_1:RecordAudio("322181038", var_159_6)
						arg_156_1:RecordAudio("322181038", var_159_6)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_322181", "322181038", "story_v_out_322181.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_322181", "322181038", "story_v_out_322181.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_7 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_7 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_7

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_7 and arg_156_1.time_ < 0 + var_159_7 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play322181039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 322181039
		arg_160_1.duration_ = 18.7

		local var_160_0 = {
			zh = 10.633,
			ja = 18.7
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
				arg_160_0:Play322181040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 1.125

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10061")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_1 = arg_160_1:GetWordFromCfg(322181039)
				local var_163_2 = arg_160_1:FormatText(var_163_1.content)

				arg_160_1.text_.text = var_163_2

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_4 = 45 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 45)

				if (45 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 45)) > 0 and var_163_0 < var_163_4 then
					arg_160_1.talkMaxDuration = var_163_4

					if var_163_4 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_4 + 0
					end
				end

				arg_160_1.text_.text = var_163_2
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181039", "story_v_out_322181.awb") ~= 0 then
					local var_163_5 = manager.audio:GetVoiceLength("story_v_out_322181", "322181039", "story_v_out_322181.awb") / 1000

					if var_163_5 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + 0
					end

					if var_163_1.prefab_name ~= "" and arg_160_1.actors_[var_163_1.prefab_name] ~= nil then
						local var_163_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_1.prefab_name].transform, "story_v_out_322181", "322181039", "story_v_out_322181.awb")

						arg_160_1:RecordAudio("322181039", var_163_6)
						arg_160_1:RecordAudio("322181039", var_163_6)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_322181", "322181039", "story_v_out_322181.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_322181", "322181039", "story_v_out_322181.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_7 = math.max(var_163_0, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_7 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - 0) / var_163_7

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_7 and arg_160_1.time_ < 0 + var_163_7 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play322181040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 322181040
		arg_164_1.duration_ = 7.5

		local var_164_0 = {
			zh = 7.033,
			ja = 7.5
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
				arg_164_0:Play322181041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0.875

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10061")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_1 = arg_164_1:GetWordFromCfg(322181040)
				local var_167_2 = arg_164_1:FormatText(var_167_1.content)

				arg_164_1.text_.text = var_167_2

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_4 = 35 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 35)

				if (35 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 35)) > 0 and var_167_0 < var_167_4 then
					arg_164_1.talkMaxDuration = var_167_4

					if var_167_4 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_4 + 0
					end
				end

				arg_164_1.text_.text = var_167_2
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181040", "story_v_out_322181.awb") ~= 0 then
					local var_167_5 = manager.audio:GetVoiceLength("story_v_out_322181", "322181040", "story_v_out_322181.awb") / 1000

					if var_167_5 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + 0
					end

					if var_167_1.prefab_name ~= "" and arg_164_1.actors_[var_167_1.prefab_name] ~= nil then
						local var_167_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_1.prefab_name].transform, "story_v_out_322181", "322181040", "story_v_out_322181.awb")

						arg_164_1:RecordAudio("322181040", var_167_6)
						arg_164_1:RecordAudio("322181040", var_167_6)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_322181", "322181040", "story_v_out_322181.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_322181", "322181040", "story_v_out_322181.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_7 = math.max(var_167_0, arg_164_1.talkMaxDuration)

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_7 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - 0) / var_167_7

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= 0 + var_167_7 and arg_164_1.time_ < 0 + var_167_7 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play322181041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 322181041
		arg_168_1.duration_ = 7.03

		local var_168_0 = {
			zh = 6.3,
			ja = 7.033
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play322181042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1111ui_story = arg_168_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_171_0 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 then
				arg_168_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_168_1.time_ - 0) / var_171_0)
				arg_168_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1111ui_story"].transform.position).z)
				arg_168_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1111ui_story"].transform.localEulerAngles = arg_168_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 then
				arg_168_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_168_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1111ui_story"].transform.position).z)
				arg_168_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1111ui_story"].transform.localEulerAngles = arg_168_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_171_1 = arg_168_1.actors_["1111ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect1111ui_story == nil then
				arg_168_1.var_.characterEffect1111ui_story = var_171_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_2 and not isNil(var_171_1) then
				if arg_168_1.var_.characterEffect1111ui_story and not isNil(var_171_1) then
					arg_168_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_2 and arg_168_1.time_ < 0 + var_171_2 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect1111ui_story then
				arg_168_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_171_4 = 0
			local var_171_5 = 0.55

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_6 = arg_168_1:GetWordFromCfg(322181041)
				local var_171_7 = arg_168_1:FormatText(var_171_6.content)

				arg_168_1.text_.text = var_171_7

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_9 = 22 <= 0 and var_171_5 or var_171_5 * (utf8.len(var_171_7) / 22)

				if (22 <= 0 and var_171_5 or var_171_5 * (utf8.len(var_171_7) / 22)) > 0 and var_171_5 < var_171_9 then
					arg_168_1.talkMaxDuration = var_171_9

					if var_171_9 + var_171_4 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_9 + var_171_4
					end
				end

				arg_168_1.text_.text = var_171_7
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181041", "story_v_out_322181.awb") ~= 0 then
					local var_171_10 = manager.audio:GetVoiceLength("story_v_out_322181", "322181041", "story_v_out_322181.awb") / 1000

					if var_171_10 + var_171_4 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_10 + var_171_4
					end

					if var_171_6.prefab_name ~= "" and arg_168_1.actors_[var_171_6.prefab_name] ~= nil then
						local var_171_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_6.prefab_name].transform, "story_v_out_322181", "322181041", "story_v_out_322181.awb")

						arg_168_1:RecordAudio("322181041", var_171_11)
						arg_168_1:RecordAudio("322181041", var_171_11)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_322181", "322181041", "story_v_out_322181.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_322181", "322181041", "story_v_out_322181.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_12 = math.max(var_171_5, arg_168_1.talkMaxDuration)

			if var_171_4 <= arg_168_1.time_ and arg_168_1.time_ < var_171_4 + var_171_12 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_4) / var_171_12

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_4 + var_171_12 and arg_168_1.time_ < var_171_4 + var_171_12 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play322181042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 322181042
		arg_172_1.duration_ = 2.37

		local var_172_0 = {
			zh = 1.6,
			ja = 2.366
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play322181043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["1111ui_story"]) and arg_172_1.var_.characterEffect1111ui_story == nil then
				arg_172_1.var_.characterEffect1111ui_story = arg_172_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["1111ui_story"]) then
				if arg_172_1.var_.characterEffect1111ui_story and not isNil(arg_172_1.actors_["1111ui_story"]) then
					arg_172_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_0)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["1111ui_story"]) and arg_172_1.var_.characterEffect1111ui_story then
				arg_172_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_175_1 = 0
			local var_175_2 = 0.075

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Goyle")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_3 = arg_172_1:GetWordFromCfg(322181042)
				local var_175_4 = arg_172_1:FormatText(var_175_3.content)

				arg_172_1.text_.text = var_175_4

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_6 = 3 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_4) / 3)

				if (3 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_4) / 3)) > 0 and var_175_2 < var_175_6 then
					arg_172_1.talkMaxDuration = var_175_6

					if var_175_6 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_6 + var_175_1
					end
				end

				arg_172_1.text_.text = var_175_4
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181042", "story_v_out_322181.awb") ~= 0 then
					local var_175_7 = manager.audio:GetVoiceLength("story_v_out_322181", "322181042", "story_v_out_322181.awb") / 1000

					if var_175_7 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_7 + var_175_1
					end

					if var_175_3.prefab_name ~= "" and arg_172_1.actors_[var_175_3.prefab_name] ~= nil then
						local var_175_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_3.prefab_name].transform, "story_v_out_322181", "322181042", "story_v_out_322181.awb")

						arg_172_1:RecordAudio("322181042", var_175_8)
						arg_172_1:RecordAudio("322181042", var_175_8)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_322181", "322181042", "story_v_out_322181.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_322181", "322181042", "story_v_out_322181.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_9 = math.max(var_175_2, arg_172_1.talkMaxDuration)

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_9 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_1) / var_175_9

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_1 + var_175_9 and arg_172_1.time_ < var_175_1 + var_175_9 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play322181043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 322181043
		arg_176_1.duration_ = 5.57

		local var_176_0 = {
			zh = 4.366,
			ja = 5.566
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play322181044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["1111ui_story"]) and arg_176_1.var_.characterEffect1111ui_story == nil then
				arg_176_1.var_.characterEffect1111ui_story = arg_176_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["1111ui_story"]) then
				if arg_176_1.var_.characterEffect1111ui_story and not isNil(arg_176_1.actors_["1111ui_story"]) then
					arg_176_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["1111ui_story"]) and arg_176_1.var_.characterEffect1111ui_story then
				arg_176_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			local var_179_2 = 0
			local var_179_3 = 0.4

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_2 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_4 = arg_176_1:GetWordFromCfg(322181043)
				local var_179_5 = arg_176_1:FormatText(var_179_4.content)

				arg_176_1.text_.text = var_179_5

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_7 = 16 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_5) / 16)

				if (16 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_5) / 16)) > 0 and var_179_3 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_2
					end
				end

				arg_176_1.text_.text = var_179_5
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181043", "story_v_out_322181.awb") ~= 0 then
					local var_179_8 = manager.audio:GetVoiceLength("story_v_out_322181", "322181043", "story_v_out_322181.awb") / 1000

					if var_179_8 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_8 + var_179_2
					end

					if var_179_4.prefab_name ~= "" and arg_176_1.actors_[var_179_4.prefab_name] ~= nil then
						local var_179_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_4.prefab_name].transform, "story_v_out_322181", "322181043", "story_v_out_322181.awb")

						arg_176_1:RecordAudio("322181043", var_179_9)
						arg_176_1:RecordAudio("322181043", var_179_9)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_322181", "322181043", "story_v_out_322181.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_322181", "322181043", "story_v_out_322181.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_3, arg_176_1.talkMaxDuration)

			if var_179_2 <= arg_176_1.time_ and arg_176_1.time_ < var_179_2 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_2) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_2 + var_179_10 and arg_176_1.time_ < var_179_2 + var_179_10 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play322181044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 322181044
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play322181045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["1111ui_story"]) and arg_180_1.var_.characterEffect1111ui_story == nil then
				arg_180_1.var_.characterEffect1111ui_story = arg_180_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_0 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["1111ui_story"]) then
				if arg_180_1.var_.characterEffect1111ui_story and not isNil(arg_180_1.actors_["1111ui_story"]) then
					arg_180_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_180_1.time_ - 0) / var_183_0)
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["1111ui_story"]) and arg_180_1.var_.characterEffect1111ui_story then
				arg_180_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_180_1.time_ and arg_180_1.time_ <= 0.1 + arg_183_0 then
				arg_180_1:AudioAction("play", "effect", "se_story_side_1022", "se_story_side_1022_crowd", "")
			end

			if 0.766666666666667 < arg_180_1.time_ and arg_180_1.time_ <= 0.766666666666667 + arg_183_0 then
				arg_180_1:AudioAction("play", "effect", "se_story_145", "se_story_145_hit", "")
			end

			local var_183_3 = 0
			local var_183_4 = 1.225

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_3 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_5 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(322181044).content)

				arg_180_1.text_.text = var_183_5

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_7 = 49 <= 0 and var_183_4 or var_183_4 * (utf8.len(var_183_5) / 49)

				if (49 <= 0 and var_183_4 or var_183_4 * (utf8.len(var_183_5) / 49)) > 0 and var_183_4 < var_183_7 then
					arg_180_1.talkMaxDuration = var_183_7

					if var_183_7 + var_183_3 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_7 + var_183_3
					end
				end

				arg_180_1.text_.text = var_183_5
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_8 = math.max(var_183_4, arg_180_1.talkMaxDuration)

			if var_183_3 <= arg_180_1.time_ and arg_180_1.time_ < var_183_3 + var_183_8 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_3) / var_183_8

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_3 + var_183_8 and arg_180_1.time_ < var_183_3 + var_183_8 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play322181045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 322181045
		arg_184_1.duration_ = 8.77

		local var_184_0 = {
			zh = 7.2,
			ja = 8.766
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play322181046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1111ui_story"]) and arg_184_1.var_.characterEffect1111ui_story == nil then
				arg_184_1.var_.characterEffect1111ui_story = arg_184_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1111ui_story"]) then
				if arg_184_1.var_.characterEffect1111ui_story and not isNil(arg_184_1.actors_["1111ui_story"]) then
					arg_184_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1111ui_story"]) and arg_184_1.var_.characterEffect1111ui_story then
				arg_184_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_187_2 = 0
			local var_187_3 = 0.725

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_2 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_4 = arg_184_1:GetWordFromCfg(322181045)
				local var_187_5 = arg_184_1:FormatText(var_187_4.content)

				arg_184_1.text_.text = var_187_5

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_7 = 29 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 29)

				if (29 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 29)) > 0 and var_187_3 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_2
					end
				end

				arg_184_1.text_.text = var_187_5
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181045", "story_v_out_322181.awb") ~= 0 then
					local var_187_8 = manager.audio:GetVoiceLength("story_v_out_322181", "322181045", "story_v_out_322181.awb") / 1000

					if var_187_8 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_2
					end

					if var_187_4.prefab_name ~= "" and arg_184_1.actors_[var_187_4.prefab_name] ~= nil then
						local var_187_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_4.prefab_name].transform, "story_v_out_322181", "322181045", "story_v_out_322181.awb")

						arg_184_1:RecordAudio("322181045", var_187_9)
						arg_184_1:RecordAudio("322181045", var_187_9)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_322181", "322181045", "story_v_out_322181.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_322181", "322181045", "story_v_out_322181.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = math.max(var_187_3, arg_184_1.talkMaxDuration)

			if var_187_2 <= arg_184_1.time_ and arg_184_1.time_ < var_187_2 + var_187_10 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_2) / var_187_10

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_2 + var_187_10 and arg_184_1.time_ < var_187_2 + var_187_10 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play322181046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 322181046
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
			arg_188_1.auto_ = false
		end

		function arg_188_1.playNext_(arg_190_0)
			arg_188_1.onStoryFinished_()
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1111ui_story = arg_188_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_191_0 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 then
				arg_188_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_188_1.time_ - 0) / var_191_0)
				arg_188_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1111ui_story"].transform.position).z)
				arg_188_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["1111ui_story"].transform.localEulerAngles = arg_188_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 then
				arg_188_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_188_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1111ui_story"].transform.position).z)
				arg_188_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["1111ui_story"].transform.localEulerAngles = arg_188_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_191_1 = 0
			local var_191_2 = 1.4

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_3 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(322181046).content)

				arg_188_1.text_.text = var_191_3

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_5 = 56 <= 0 and var_191_2 or var_191_2 * (utf8.len(var_191_3) / 56)

				if (56 <= 0 and var_191_2 or var_191_2 * (utf8.len(var_191_3) / 56)) > 0 and var_191_2 < var_191_5 then
					arg_188_1.talkMaxDuration = var_191_5

					if var_191_5 + var_191_1 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_5 + var_191_1
					end
				end

				arg_188_1.text_.text = var_191_3
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_6 = math.max(var_191_2, arg_188_1.talkMaxDuration)

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_6 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_1) / var_191_6

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_1 + var_191_6 and arg_188_1.time_ < var_191_1 + var_191_6 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	assets = {
		"TextureConfig/Background/L09g",
		"TextureConfig/Background/L09f"
	},
	voices = {
		"story_v_out_322181.awb"
	}
}
