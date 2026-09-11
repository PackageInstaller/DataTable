return {
	Play319251001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319251001
		arg_1_1.duration_ = 6.6

		local var_1_0 = {
			zh = 5.532999999999,
			ja = 6.599999999999
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
				arg_1_0:Play319251002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I11r == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11r")
				var_4_0.name = "I11r"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I11r = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I11r

				arg_1_1.bgs_.I11r.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I11r" then
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

			local var_4_8 = "10075ui_story"

			if arg_1_1.actors_["10075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10075ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "10075ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["10075ui_story"].transform

			if 1.94202421349473 < arg_1_1.time_ and arg_1_1.time_ <= 1.94202421349473 + arg_4_0 then
				arg_1_1.var_.moveOldPos10075ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1.94202421349473 <= arg_1_1.time_ and arg_1_1.time_ < 1.94202421349473 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10075ui_story, Vector3.New(0, -0.715, -6.15), (arg_1_1.time_ - 1.94202421349473) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.94202421349473 + var_4_13 and arg_1_1.time_ < 1.94202421349473 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -0.715, -6.15)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["10075ui_story"]

			if 1.94202421349473 < arg_1_1.time_ and arg_1_1.time_ <= 1.94202421349473 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect10075ui_story == nil then
				arg_1_1.var_.characterEffect10075ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 1.94202421349473 <= arg_1_1.time_ and arg_1_1.time_ < 1.94202421349473 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect10075ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.94202421349473 + var_4_15 and arg_1_1.time_ < 1.94202421349473 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect10075ui_story then
				arg_1_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 1.94202421349473 < arg_1_1.time_ and arg_1_1.time_ <= 1.94202421349473 + arg_4_0 then
				arg_1_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_1")
			end

			if 1.94202421349473 < arg_1_1.time_ and arg_1_1.time_ <= 1.94202421349473 + arg_4_0 then
				arg_1_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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

			if 0.233333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.233333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_23 = 1.999999999999
			local var_4_24 = 0.325

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(319251001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 13 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 13)

				if (13 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 13)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251001", "story_v_out_319251.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_319251", "319251001", "story_v_out_319251.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_319251", "319251001", "story_v_out_319251.awb")

						arg_1_1:RecordAudio("319251001", var_4_31)
						arg_1_1:RecordAudio("319251001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319251", "319251001", "story_v_out_319251.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319251", "319251001", "story_v_out_319251.awb")
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
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.94202421349473,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play319251002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319251002
		arg_9_1.duration_ = 3.7

		local var_9_0 = {
			zh = 1.999999999999,
			ja = 3.7
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
				arg_9_0:Play319251003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10079ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "10079ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["10079ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["10079ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["10079ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["10079ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["10079ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10079ui_story = var_12_3.localPosition

				arg_9_1:ShowWeapon(arg_9_1.var_["10079ui_story" .. "Animator"].transform, false)
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["10079ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10079ui_story == nil then
				arg_9_1.var_.characterEffect10079ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect10079ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10079ui_story then
				arg_9_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_8 = arg_9_1.actors_["10075ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10075ui_story = var_12_8.localPosition
			end

			local var_12_9 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 then
				var_12_8.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_9_1.time_ - 0) / var_12_9)
				var_12_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_8.position).x, (manager.ui.mainCamera.transform.position - var_12_8.position).y, (manager.ui.mainCamera.transform.position - var_12_8.position).z)
				var_12_8.localEulerAngles.z = 0
				var_12_8.localEulerAngles.x = 0
				var_12_8.localEulerAngles = var_12_8.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 then
				var_12_8.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				var_12_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_8.position).x, (manager.ui.mainCamera.transform.position - var_12_8.position).y, (manager.ui.mainCamera.transform.position - var_12_8.position).z)
				var_12_8.localEulerAngles.z = 0
				var_12_8.localEulerAngles.x = 0
				var_12_8.localEulerAngles = var_12_8.localEulerAngles
			end

			local var_12_10 = arg_9_1.actors_["10075ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect10075ui_story == nil then
				arg_9_1.var_.characterEffect10075ui_story = var_12_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_11 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_11 and not isNil(var_12_10) then
				if arg_9_1.var_.characterEffect10075ui_story and not isNil(var_12_10) then
					arg_9_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_11)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_11 and arg_9_1.time_ < 0 + var_12_11 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect10075ui_story then
				arg_9_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_12_12 = 0
			local var_12_13 = 0.175

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_14 = arg_9_1:GetWordFromCfg(319251002)
				local var_12_15 = arg_9_1:FormatText(var_12_14.content)

				arg_9_1.text_.text = var_12_15

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_17 = 7 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 7)

				if (7 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 7)) > 0 and var_12_13 < var_12_17 then
					arg_9_1.talkMaxDuration = var_12_17

					if var_12_17 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_17 + var_12_12
					end
				end

				arg_9_1.text_.text = var_12_15
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251002", "story_v_out_319251.awb") ~= 0 then
					local var_12_18 = manager.audio:GetVoiceLength("story_v_out_319251", "319251002", "story_v_out_319251.awb") / 1000

					if var_12_18 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_12
					end

					if var_12_14.prefab_name ~= "" and arg_9_1.actors_[var_12_14.prefab_name] ~= nil then
						local var_12_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_14.prefab_name].transform, "story_v_out_319251", "319251002", "story_v_out_319251.awb")

						arg_9_1:RecordAudio("319251002", var_12_19)
						arg_9_1:RecordAudio("319251002", var_12_19)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319251", "319251002", "story_v_out_319251.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319251", "319251002", "story_v_out_319251.awb")
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
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
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
	Play319251003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319251003
		arg_13_1.duration_ = 7.27

		local var_13_0 = {
			zh = 5.333,
			ja = 7.266
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
				arg_13_0:Play319251004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["10079ui_story"]) and arg_13_1.var_.characterEffect10079ui_story == nil then
				arg_13_1.var_.characterEffect10079ui_story = arg_13_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["10079ui_story"]) then
				if arg_13_1.var_.characterEffect10079ui_story and not isNil(arg_13_1.actors_["10079ui_story"]) then
					arg_13_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["10079ui_story"]) and arg_13_1.var_.characterEffect10079ui_story then
				arg_13_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_16_1 = arg_13_1.actors_["10075ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect10075ui_story == nil then
				arg_13_1.var_.characterEffect10075ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect10075ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect10075ui_story then
				arg_13_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_16_4 = 0
			local var_16_5 = 0.6

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(319251003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 24 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 24)

				if (24 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 24)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251003", "story_v_out_319251.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_319251", "319251003", "story_v_out_319251.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_out_319251", "319251003", "story_v_out_319251.awb")

						arg_13_1:RecordAudio("319251003", var_16_11)
						arg_13_1:RecordAudio("319251003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319251", "319251003", "story_v_out_319251.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319251", "319251003", "story_v_out_319251.awb")
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
	Play319251004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319251004
		arg_17_1.duration_ = 7.93

		local var_17_0 = {
			zh = 3.2,
			ja = 7.933
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
				arg_17_0:Play319251005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10079ui_story = arg_17_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10079ui_story"].transform.position).z)
				arg_17_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10079ui_story"].transform.localEulerAngles = arg_17_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_17_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10079ui_story"].transform.position).z)
				arg_17_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10079ui_story"].transform.localEulerAngles = arg_17_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_1 = arg_17_1.actors_["10079ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect10079ui_story == nil then
				arg_17_1.var_.characterEffect10079ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect10079ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect10079ui_story then
				arg_17_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_20_4 = arg_17_1.actors_["10075ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect10075ui_story == nil then
				arg_17_1.var_.characterEffect10075ui_story = var_20_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_5 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_5 and not isNil(var_20_4) then
				if arg_17_1.var_.characterEffect10075ui_story and not isNil(var_20_4) then
					arg_17_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_5)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_5 and arg_17_1.time_ < 0 + var_20_5 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect10075ui_story then
				arg_17_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_20_6 = 0
			local var_20_7 = 0.4

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
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

				local var_20_8 = arg_17_1:GetWordFromCfg(319251004)
				local var_20_9 = arg_17_1:FormatText(var_20_8.content)

				arg_17_1.text_.text = var_20_9

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 16 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_9) / 16)

				if (16 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_9) / 16)) > 0 and var_20_7 < var_20_11 then
					arg_17_1.talkMaxDuration = var_20_11

					if var_20_11 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_9
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251004", "story_v_out_319251.awb") ~= 0 then
					local var_20_12 = manager.audio:GetVoiceLength("story_v_out_319251", "319251004", "story_v_out_319251.awb") / 1000

					if var_20_12 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_6
					end

					if var_20_8.prefab_name ~= "" and arg_17_1.actors_[var_20_8.prefab_name] ~= nil then
						local var_20_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_8.prefab_name].transform, "story_v_out_319251", "319251004", "story_v_out_319251.awb")

						arg_17_1:RecordAudio("319251004", var_20_13)
						arg_17_1:RecordAudio("319251004", var_20_13)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319251", "319251004", "story_v_out_319251.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319251", "319251004", "story_v_out_319251.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_14 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_14 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_14

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_14 and arg_17_1.time_ < var_20_6 + var_20_14 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319251005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319251005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play319251006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10079ui_story"]) and arg_21_1.var_.characterEffect10079ui_story == nil then
				arg_21_1.var_.characterEffect10079ui_story = arg_21_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10079ui_story"]) then
				if arg_21_1.var_.characterEffect10079ui_story and not isNil(arg_21_1.actors_["10079ui_story"]) then
					arg_21_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10079ui_story"]) and arg_21_1.var_.characterEffect10079ui_story then
				arg_21_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.825

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(319251005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 33 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 33)

				if (33 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 33)) > 0 and var_24_2 < var_24_5 then
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
	Play319251006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319251006
		arg_25_1.duration_ = 8

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play319251007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				local var_28_0 = arg_25_1.bgs_.I11r

				arg_25_1.bgs_.I11r.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_28_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_1 = var_28_0:GetComponent("SpriteRenderer")

				if var_28_1 and var_28_1.sprite then
					local var_28_2 = 2 * (var_28_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_28_0.transform.localScale = Vector3.New(var_28_2 / var_28_1.sprite.bounds.size.y < var_28_2 * manager.ui.mainCameraCom_.aspect / var_28_1.sprite.bounds.size.x and var_28_2 * manager.ui.mainCameraCom_.aspect / var_28_1.sprite.bounds.size.x or var_28_2 / var_28_1.sprite.bounds.size.y, var_28_2 / var_28_1.sprite.bounds.size.y < var_28_2 * manager.ui.mainCameraCom_.aspect / var_28_1.sprite.bounds.size.x and var_28_2 * manager.ui.mainCameraCom_.aspect / var_28_1.sprite.bounds.size.x or var_28_2 / var_28_1.sprite.bounds.size.y, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "I11r" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= 2 + arg_28_0 then
				local var_28_3 = arg_25_1.bgs_.I11r

				arg_25_1.bgs_.I11r.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_28_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_4 = var_28_3:GetComponent("SpriteRenderer")

				if var_28_4 and var_28_4.sprite then
					local var_28_5 = 2 * (var_28_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_28_3.transform.localScale = Vector3.New(var_28_5 / var_28_4.sprite.bounds.size.y < var_28_5 * manager.ui.mainCameraCom_.aspect / var_28_4.sprite.bounds.size.x and var_28_5 * manager.ui.mainCameraCom_.aspect / var_28_4.sprite.bounds.size.x or var_28_5 / var_28_4.sprite.bounds.size.y, var_28_5 / var_28_4.sprite.bounds.size.y < var_28_5 * manager.ui.mainCameraCom_.aspect / var_28_4.sprite.bounds.size.x and var_28_5 * manager.ui.mainCameraCom_.aspect / var_28_4.sprite.bounds.size.x or var_28_5 / var_28_4.sprite.bounds.size.y, 0)
				end

				for iter_28_2, iter_28_3 in pairs(arg_25_1.bgs_) do
					if iter_28_2 ~= "I11r" then
						iter_28_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_6 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_7 = 2

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_7 then
				local var_28_8 = Color.New(0, 0, 0)

				var_28_8.a = Mathf.Lerp(0, 1, (arg_25_1.time_ - var_28_6) / var_28_7)
				arg_25_1.mask_.color = var_28_8
			end

			if arg_25_1.time_ >= var_28_6 + var_28_7 and arg_25_1.time_ < var_28_6 + var_28_7 + arg_28_0 then
				local var_28_9 = Color.New(0, 0, 0)

				var_28_9.a = 1
				arg_25_1.mask_.color = var_28_9
			end

			local var_28_10 = 2

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_11 = 1

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 then
				local var_28_12 = Color.New(0, 0, 0)

				var_28_12.a = Mathf.Lerp(1, 0, (arg_25_1.time_ - var_28_10) / var_28_11)
				arg_25_1.mask_.color = var_28_12
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 then
				local var_28_13 = Color.New(0, 0, 0)

				arg_25_1.mask_.enabled = false
				var_28_13.a = 0
				arg_25_1.mask_.color = var_28_13
			end

			local var_28_14 = arg_25_1.actors_["10079ui_story"].transform

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= 2 + arg_28_0 then
				arg_25_1.var_.moveOldPos10079ui_story = var_28_14.localPosition

				arg_25_1:ShowWeapon(arg_25_1.var_["10079ui_story" .. "Animator"].transform, false)
			end

			local var_28_15 = 0.001

			if 2 <= arg_25_1.time_ and arg_25_1.time_ < 2 + var_28_15 then
				var_28_14.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 2) / var_28_15)
				var_28_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_14.position).x, (manager.ui.mainCamera.transform.position - var_28_14.position).y, (manager.ui.mainCamera.transform.position - var_28_14.position).z)
				var_28_14.localEulerAngles.z = 0
				var_28_14.localEulerAngles.x = 0
				var_28_14.localEulerAngles = var_28_14.localEulerAngles
			end

			if arg_25_1.time_ >= 2 + var_28_15 and arg_25_1.time_ < 2 + var_28_15 + arg_28_0 then
				var_28_14.localPosition = Vector3.New(0, 100, 0)
				var_28_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_14.position).x, (manager.ui.mainCamera.transform.position - var_28_14.position).y, (manager.ui.mainCamera.transform.position - var_28_14.position).z)
				var_28_14.localEulerAngles.z = 0
				var_28_14.localEulerAngles.x = 0
				var_28_14.localEulerAngles = var_28_14.localEulerAngles
			end

			local var_28_16 = arg_25_1.actors_["10075ui_story"].transform

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= 2 + arg_28_0 then
				arg_25_1.var_.moveOldPos10075ui_story = var_28_16.localPosition
			end

			local var_28_17 = 0.001

			if 2 <= arg_25_1.time_ and arg_25_1.time_ < 2 + var_28_17 then
				var_28_16.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 2) / var_28_17)
				var_28_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_16.position).x, (manager.ui.mainCamera.transform.position - var_28_16.position).y, (manager.ui.mainCamera.transform.position - var_28_16.position).z)
				var_28_16.localEulerAngles.z = 0
				var_28_16.localEulerAngles.x = 0
				var_28_16.localEulerAngles = var_28_16.localEulerAngles
			end

			if arg_25_1.time_ >= 2 + var_28_17 and arg_25_1.time_ < 2 + var_28_17 + arg_28_0 then
				var_28_16.localPosition = Vector3.New(0, 100, 0)
				var_28_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_16.position).x, (manager.ui.mainCamera.transform.position - var_28_16.position).y, (manager.ui.mainCamera.transform.position - var_28_16.position).z)
				var_28_16.localEulerAngles.z = 0
				var_28_16.localEulerAngles.x = 0
				var_28_16.localEulerAngles = var_28_16.localEulerAngles
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_18 = 3
			local var_28_19 = 1.05

			if 3 < arg_25_1.time_ and arg_25_1.time_ <= var_28_18 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_20 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_20:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_21 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(319251006).content)

				arg_25_1.text_.text = var_28_21

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_23 = 42 <= 0 and var_28_19 or var_28_19 * (utf8.len(var_28_21) / 42)

				if (42 <= 0 and var_28_19 or var_28_19 * (utf8.len(var_28_21) / 42)) > 0 and var_28_19 < var_28_23 then
					arg_25_1.talkMaxDuration = var_28_23
					var_28_18 = var_28_18 + 0.3

					if var_28_23 + var_28_18 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_18
					end
				end

				arg_25_1.text_.text = var_28_21
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_24 = var_28_18 + 0.3
			local var_28_25 = math.max(var_28_19, arg_25_1.talkMaxDuration)

			if var_28_18 + 0.3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_24 + var_28_25 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_24) / var_28_25

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_24 + var_28_25 and arg_25_1.time_ < var_28_24 + var_28_25 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play319251007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 319251007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play319251008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 1.2

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_1 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(319251007).content)

				arg_31_1.text_.text = var_34_1

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_3 = 48 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 48)

				if (48 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 48)) > 0 and var_34_0 < var_34_3 then
					arg_31_1.talkMaxDuration = var_34_3

					if var_34_3 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_3 + 0
					end
				end

				arg_31_1.text_.text = var_34_1
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_4 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_4

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play319251008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 319251008
		arg_35_1.duration_ = 5.47

		local var_35_0 = {
			zh = 5.466,
			ja = 5
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play319251009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos10075ui_story = arg_35_1.actors_["10075ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["10075ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10075ui_story, Vector3.New(0, -0.715, -6.15), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["10075ui_story"].transform.position).z)
				arg_35_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["10075ui_story"].transform.localEulerAngles = arg_35_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["10075ui_story"].transform.localPosition = Vector3.New(0, -0.715, -6.15)
				arg_35_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["10075ui_story"].transform.position).z)
				arg_35_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["10075ui_story"].transform.localEulerAngles = arg_35_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["10075ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect10075ui_story == nil then
				arg_35_1.var_.characterEffect10075ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect10075ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect10075ui_story then
				arg_35_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_2")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_38_4 = 0
			local var_38_5 = 0.475

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_6 = arg_35_1:GetWordFromCfg(319251008)
				local var_38_7 = arg_35_1:FormatText(var_38_6.content)

				arg_35_1.text_.text = var_38_7

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_9 = 19 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 19)

				if (19 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 19)) > 0 and var_38_5 < var_38_9 then
					arg_35_1.talkMaxDuration = var_38_9

					if var_38_9 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_9 + var_38_4
					end
				end

				arg_35_1.text_.text = var_38_7
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251008", "story_v_out_319251.awb") ~= 0 then
					local var_38_10 = manager.audio:GetVoiceLength("story_v_out_319251", "319251008", "story_v_out_319251.awb") / 1000

					if var_38_10 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_4
					end

					if var_38_6.prefab_name ~= "" and arg_35_1.actors_[var_38_6.prefab_name] ~= nil then
						local var_38_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_6.prefab_name].transform, "story_v_out_319251", "319251008", "story_v_out_319251.awb")

						arg_35_1:RecordAudio("319251008", var_38_11)
						arg_35_1:RecordAudio("319251008", var_38_11)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_319251", "319251008", "story_v_out_319251.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_319251", "319251008", "story_v_out_319251.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_12 = math.max(var_38_5, arg_35_1.talkMaxDuration)

			if var_38_4 <= arg_35_1.time_ and arg_35_1.time_ < var_38_4 + var_38_12 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_4) / var_38_12

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_4 + var_38_12 and arg_35_1.time_ < var_38_4 + var_38_12 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
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
	Play319251009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 319251009
		arg_39_1.duration_ = 3.8

		local var_39_0 = {
			zh = 3.8,
			ja = 3.1
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
				arg_39_0:Play319251010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["10075ui_story"]) and arg_39_1.var_.characterEffect10075ui_story == nil then
				arg_39_1.var_.characterEffect10075ui_story = arg_39_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["10075ui_story"]) then
				if arg_39_1.var_.characterEffect10075ui_story and not isNil(arg_39_1.actors_["10075ui_story"]) then
					arg_39_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_39_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["10075ui_story"]) and arg_39_1.var_.characterEffect10075ui_story then
				arg_39_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_39_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_42_1 = arg_39_1.actors_["10079ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect10079ui_story == nil then
				arg_39_1.var_.characterEffect10079ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect10079ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect10079ui_story then
				arg_39_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_42_4 = arg_39_1.actors_["10079ui_story"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos10079ui_story = var_42_4.localPosition

				arg_39_1:ShowWeapon(arg_39_1.var_["10079ui_story" .. "Animator"].transform, false)
			end

			local var_42_5 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_5 then
				var_42_4.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_39_1.time_ - 0) / var_42_5)
				var_42_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_4.position).x, (manager.ui.mainCamera.transform.position - var_42_4.position).y, (manager.ui.mainCamera.transform.position - var_42_4.position).z)
				var_42_4.localEulerAngles.z = 0
				var_42_4.localEulerAngles.x = 0
				var_42_4.localEulerAngles = var_42_4.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_5 and arg_39_1.time_ < 0 + var_42_5 + arg_42_0 then
				var_42_4.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_42_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_4.position).x, (manager.ui.mainCamera.transform.position - var_42_4.position).y, (manager.ui.mainCamera.transform.position - var_42_4.position).z)
				var_42_4.localEulerAngles.z = 0
				var_42_4.localEulerAngles.x = 0
				var_42_4.localEulerAngles = var_42_4.localEulerAngles
			end

			local var_42_6 = arg_39_1.actors_["10075ui_story"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos10075ui_story = var_42_6.localPosition
			end

			local var_42_7 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 then
				var_42_6.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_39_1.time_ - 0) / var_42_7)
				var_42_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_6.position).x, (manager.ui.mainCamera.transform.position - var_42_6.position).y, (manager.ui.mainCamera.transform.position - var_42_6.position).z)
				var_42_6.localEulerAngles.z = 0
				var_42_6.localEulerAngles.x = 0
				var_42_6.localEulerAngles = var_42_6.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 then
				var_42_6.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				var_42_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_6.position).x, (manager.ui.mainCamera.transform.position - var_42_6.position).y, (manager.ui.mainCamera.transform.position - var_42_6.position).z)
				var_42_6.localEulerAngles.z = 0
				var_42_6.localEulerAngles.x = 0
				var_42_6.localEulerAngles = var_42_6.localEulerAngles
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_42_8 = 0
			local var_42_9 = 0.375

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_8 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_10 = arg_39_1:GetWordFromCfg(319251009)
				local var_42_11 = arg_39_1:FormatText(var_42_10.content)

				arg_39_1.text_.text = var_42_11

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_13 = 15 <= 0 and var_42_9 or var_42_9 * (utf8.len(var_42_11) / 15)

				if (15 <= 0 and var_42_9 or var_42_9 * (utf8.len(var_42_11) / 15)) > 0 and var_42_9 < var_42_13 then
					arg_39_1.talkMaxDuration = var_42_13

					if var_42_13 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_13 + var_42_8
					end
				end

				arg_39_1.text_.text = var_42_11
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251009", "story_v_out_319251.awb") ~= 0 then
					local var_42_14 = manager.audio:GetVoiceLength("story_v_out_319251", "319251009", "story_v_out_319251.awb") / 1000

					if var_42_14 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_14 + var_42_8
					end

					if var_42_10.prefab_name ~= "" and arg_39_1.actors_[var_42_10.prefab_name] ~= nil then
						local var_42_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_10.prefab_name].transform, "story_v_out_319251", "319251009", "story_v_out_319251.awb")

						arg_39_1:RecordAudio("319251009", var_42_15)
						arg_39_1:RecordAudio("319251009", var_42_15)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_319251", "319251009", "story_v_out_319251.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_319251", "319251009", "story_v_out_319251.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_16 = math.max(var_42_9, arg_39_1.talkMaxDuration)

			if var_42_8 <= arg_39_1.time_ and arg_39_1.time_ < var_42_8 + var_42_16 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_8) / var_42_16

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_8 + var_42_16 and arg_39_1.time_ < var_42_8 + var_42_16 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play319251010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 319251010
		arg_43_1.duration_ = 9.93

		local var_43_0 = {
			zh = 3.8,
			ja = 9.933
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
				arg_43_0:Play319251011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.475

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:GetWordFromCfg(319251010)
				local var_46_2 = arg_43_1:FormatText(var_46_1.content)

				arg_43_1.text_.text = var_46_2

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 19 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 19)

				if (19 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 19)) > 0 and var_46_0 < var_46_4 then
					arg_43_1.talkMaxDuration = var_46_4

					if var_46_4 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_4 + 0
					end
				end

				arg_43_1.text_.text = var_46_2
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251010", "story_v_out_319251.awb") ~= 0 then
					local var_46_5 = manager.audio:GetVoiceLength("story_v_out_319251", "319251010", "story_v_out_319251.awb") / 1000

					if var_46_5 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + 0
					end

					if var_46_1.prefab_name ~= "" and arg_43_1.actors_[var_46_1.prefab_name] ~= nil then
						local var_46_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_1.prefab_name].transform, "story_v_out_319251", "319251010", "story_v_out_319251.awb")

						arg_43_1:RecordAudio("319251010", var_46_6)
						arg_43_1:RecordAudio("319251010", var_46_6)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_319251", "319251010", "story_v_out_319251.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_319251", "319251010", "story_v_out_319251.awb")
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
	Play319251011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 319251011
		arg_47_1.duration_ = 3.13

		local var_47_0 = {
			zh = 3.133,
			ja = 2.9
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
				arg_47_0:Play319251012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos10075ui_story = arg_47_1.actors_["10075ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["10075ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10075ui_story"].transform.position).z)
				arg_47_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["10075ui_story"].transform.localEulerAngles = arg_47_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["10075ui_story"].transform.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				arg_47_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10075ui_story"].transform.position).z)
				arg_47_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["10075ui_story"].transform.localEulerAngles = arg_47_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			local var_50_1 = arg_47_1.actors_["10075ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect10075ui_story == nil then
				arg_47_1.var_.characterEffect10075ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect10075ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect10075ui_story then
				arg_47_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action11_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_50_4 = arg_47_1.actors_["10079ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect10079ui_story == nil then
				arg_47_1.var_.characterEffect10079ui_story = var_50_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_5 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_5 and not isNil(var_50_4) then
				if arg_47_1.var_.characterEffect10079ui_story and not isNil(var_50_4) then
					arg_47_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_47_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_5)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_5 and arg_47_1.time_ < 0 + var_50_5 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect10079ui_story then
				arg_47_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_47_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_50_6 = 0
			local var_50_7 = 0.2

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_8 = arg_47_1:GetWordFromCfg(319251011)
				local var_50_9 = arg_47_1:FormatText(var_50_8.content)

				arg_47_1.text_.text = var_50_9

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_11 = 8 <= 0 and var_50_7 or var_50_7 * (utf8.len(var_50_9) / 8)

				if (8 <= 0 and var_50_7 or var_50_7 * (utf8.len(var_50_9) / 8)) > 0 and var_50_7 < var_50_11 then
					arg_47_1.talkMaxDuration = var_50_11

					if var_50_11 + var_50_6 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_11 + var_50_6
					end
				end

				arg_47_1.text_.text = var_50_9
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251011", "story_v_out_319251.awb") ~= 0 then
					local var_50_12 = manager.audio:GetVoiceLength("story_v_out_319251", "319251011", "story_v_out_319251.awb") / 1000

					if var_50_12 + var_50_6 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_12 + var_50_6
					end

					if var_50_8.prefab_name ~= "" and arg_47_1.actors_[var_50_8.prefab_name] ~= nil then
						local var_50_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_8.prefab_name].transform, "story_v_out_319251", "319251011", "story_v_out_319251.awb")

						arg_47_1:RecordAudio("319251011", var_50_13)
						arg_47_1:RecordAudio("319251011", var_50_13)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_319251", "319251011", "story_v_out_319251.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_319251", "319251011", "story_v_out_319251.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_14 = math.max(var_50_7, arg_47_1.talkMaxDuration)

			if var_50_6 <= arg_47_1.time_ and arg_47_1.time_ < var_50_6 + var_50_14 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_6) / var_50_14

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_6 + var_50_14 and arg_47_1.time_ < var_50_6 + var_50_14 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play319251012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 319251012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play319251013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["10075ui_story"]) and arg_51_1.var_.characterEffect10075ui_story == nil then
				arg_51_1.var_.characterEffect10075ui_story = arg_51_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["10075ui_story"]) then
				if arg_51_1.var_.characterEffect10075ui_story and not isNil(arg_51_1.actors_["10075ui_story"]) then
					arg_51_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_51_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_0)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["10075ui_story"]) and arg_51_1.var_.characterEffect10075ui_story then
				arg_51_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_51_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_54_1 = 0
			local var_54_2 = 0.55

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_3 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(319251012).content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 22 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 22)

				if (22 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 22)) > 0 and var_54_2 < var_54_5 then
					arg_51_1.talkMaxDuration = var_54_5

					if var_54_5 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + var_54_1
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_6 = math.max(var_54_2, arg_51_1.talkMaxDuration)

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_6 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_1) / var_54_6

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_1 + var_54_6 and arg_51_1.time_ < var_54_1 + var_54_6 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play319251013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 319251013
		arg_55_1.duration_ = 5

		local var_55_0 = {
			zh = 2.266,
			ja = 5
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
				arg_55_0:Play319251014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["10079ui_story"]) and arg_55_1.var_.characterEffect10079ui_story == nil then
				arg_55_1.var_.characterEffect10079ui_story = arg_55_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["10079ui_story"]) then
				if arg_55_1.var_.characterEffect10079ui_story and not isNil(arg_55_1.actors_["10079ui_story"]) then
					arg_55_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["10079ui_story"]) and arg_55_1.var_.characterEffect10079ui_story then
				arg_55_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_58_2 = 0
			local var_58_3 = 0.25

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_2 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_4 = arg_55_1:GetWordFromCfg(319251013)
				local var_58_5 = arg_55_1:FormatText(var_58_4.content)

				arg_55_1.text_.text = var_58_5

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_7 = 10 <= 0 and var_58_3 or var_58_3 * (utf8.len(var_58_5) / 10)

				if (10 <= 0 and var_58_3 or var_58_3 * (utf8.len(var_58_5) / 10)) > 0 and var_58_3 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_2 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_2
					end
				end

				arg_55_1.text_.text = var_58_5
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251013", "story_v_out_319251.awb") ~= 0 then
					local var_58_8 = manager.audio:GetVoiceLength("story_v_out_319251", "319251013", "story_v_out_319251.awb") / 1000

					if var_58_8 + var_58_2 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_2
					end

					if var_58_4.prefab_name ~= "" and arg_55_1.actors_[var_58_4.prefab_name] ~= nil then
						local var_58_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_4.prefab_name].transform, "story_v_out_319251", "319251013", "story_v_out_319251.awb")

						arg_55_1:RecordAudio("319251013", var_58_9)
						arg_55_1:RecordAudio("319251013", var_58_9)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_319251", "319251013", "story_v_out_319251.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_319251", "319251013", "story_v_out_319251.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_10 = math.max(var_58_3, arg_55_1.talkMaxDuration)

			if var_58_2 <= arg_55_1.time_ and arg_55_1.time_ < var_58_2 + var_58_10 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_2) / var_58_10

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_2 + var_58_10 and arg_55_1.time_ < var_58_2 + var_58_10 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play319251014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 319251014
		arg_59_1.duration_ = 13.37

		local var_59_0 = {
			zh = 8.4,
			ja = 13.366
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play319251015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["10079ui_story"]) and arg_59_1.var_.characterEffect10079ui_story == nil then
				arg_59_1.var_.characterEffect10079ui_story = arg_59_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["10079ui_story"]) then
				if arg_59_1.var_.characterEffect10079ui_story and not isNil(arg_59_1.actors_["10079ui_story"]) then
					arg_59_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_59_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_0)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["10079ui_story"]) and arg_59_1.var_.characterEffect10079ui_story then
				arg_59_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_59_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_62_1 = arg_59_1.actors_["10075ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect10075ui_story == nil then
				arg_59_1.var_.characterEffect10075ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect10075ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect10075ui_story then
				arg_59_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_62_4 = 0
			local var_62_5 = 0.675

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_6 = arg_59_1:GetWordFromCfg(319251014)
				local var_62_7 = arg_59_1:FormatText(var_62_6.content)

				arg_59_1.text_.text = var_62_7

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_9 = 27 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 27)

				if (27 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 27)) > 0 and var_62_5 < var_62_9 then
					arg_59_1.talkMaxDuration = var_62_9

					if var_62_9 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_7
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251014", "story_v_out_319251.awb") ~= 0 then
					local var_62_10 = manager.audio:GetVoiceLength("story_v_out_319251", "319251014", "story_v_out_319251.awb") / 1000

					if var_62_10 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_4
					end

					if var_62_6.prefab_name ~= "" and arg_59_1.actors_[var_62_6.prefab_name] ~= nil then
						local var_62_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_6.prefab_name].transform, "story_v_out_319251", "319251014", "story_v_out_319251.awb")

						arg_59_1:RecordAudio("319251014", var_62_11)
						arg_59_1:RecordAudio("319251014", var_62_11)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_319251", "319251014", "story_v_out_319251.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_319251", "319251014", "story_v_out_319251.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_12 = math.max(var_62_5, arg_59_1.talkMaxDuration)

			if var_62_4 <= arg_59_1.time_ and arg_59_1.time_ < var_62_4 + var_62_12 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_4) / var_62_12

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_4 + var_62_12 and arg_59_1.time_ < var_62_4 + var_62_12 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play319251015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 319251015
		arg_63_1.duration_ = 2.63

		local var_63_0 = {
			zh = 1.999999999999,
			ja = 2.633
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
				arg_63_0:Play319251016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["10079ui_story"]) and arg_63_1.var_.characterEffect10079ui_story == nil then
				arg_63_1.var_.characterEffect10079ui_story = arg_63_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["10079ui_story"]) then
				if arg_63_1.var_.characterEffect10079ui_story and not isNil(arg_63_1.actors_["10079ui_story"]) then
					arg_63_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["10079ui_story"]) and arg_63_1.var_.characterEffect10079ui_story then
				arg_63_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_66_2 = arg_63_1.actors_["10075ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.characterEffect10075ui_story == nil then
				arg_63_1.var_.characterEffect10075ui_story = var_66_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_3 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_3 and not isNil(var_66_2) then
				if arg_63_1.var_.characterEffect10075ui_story and not isNil(var_66_2) then
					arg_63_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_3)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_3 and arg_63_1.time_ < 0 + var_66_3 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.characterEffect10075ui_story then
				arg_63_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_66_4 = 0
			local var_66_5 = 0.15

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_6 = arg_63_1:GetWordFromCfg(319251015)
				local var_66_7 = arg_63_1:FormatText(var_66_6.content)

				arg_63_1.text_.text = var_66_7

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_9 = 6 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 6)

				if (6 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 6)) > 0 and var_66_5 < var_66_9 then
					arg_63_1.talkMaxDuration = var_66_9

					if var_66_9 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_7
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251015", "story_v_out_319251.awb") ~= 0 then
					local var_66_10 = manager.audio:GetVoiceLength("story_v_out_319251", "319251015", "story_v_out_319251.awb") / 1000

					if var_66_10 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_4
					end

					if var_66_6.prefab_name ~= "" and arg_63_1.actors_[var_66_6.prefab_name] ~= nil then
						local var_66_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_6.prefab_name].transform, "story_v_out_319251", "319251015", "story_v_out_319251.awb")

						arg_63_1:RecordAudio("319251015", var_66_11)
						arg_63_1:RecordAudio("319251015", var_66_11)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_319251", "319251015", "story_v_out_319251.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_319251", "319251015", "story_v_out_319251.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_12 = math.max(var_66_5, arg_63_1.talkMaxDuration)

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_12 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_4) / var_66_12

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_4 + var_66_12 and arg_63_1.time_ < var_66_4 + var_66_12 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play319251016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 319251016
		arg_67_1.duration_ = 5

		local var_67_0 = {
			zh = 2.433,
			ja = 5
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
				arg_67_0:Play319251017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_70_0 = 0
			local var_70_1 = 0.325

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_2 = arg_67_1:GetWordFromCfg(319251016)
				local var_70_3 = arg_67_1:FormatText(var_70_2.content)

				arg_67_1.text_.text = var_70_3

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 13 <= 0 and var_70_1 or var_70_1 * (utf8.len(var_70_3) / 13)

				if (13 <= 0 and var_70_1 or var_70_1 * (utf8.len(var_70_3) / 13)) > 0 and var_70_1 < var_70_5 then
					arg_67_1.talkMaxDuration = var_70_5

					if var_70_5 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_3
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251016", "story_v_out_319251.awb") ~= 0 then
					local var_70_6 = manager.audio:GetVoiceLength("story_v_out_319251", "319251016", "story_v_out_319251.awb") / 1000

					if var_70_6 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_6 + var_70_0
					end

					if var_70_2.prefab_name ~= "" and arg_67_1.actors_[var_70_2.prefab_name] ~= nil then
						local var_70_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_2.prefab_name].transform, "story_v_out_319251", "319251016", "story_v_out_319251.awb")

						arg_67_1:RecordAudio("319251016", var_70_7)
						arg_67_1:RecordAudio("319251016", var_70_7)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_319251", "319251016", "story_v_out_319251.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_319251", "319251016", "story_v_out_319251.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_8 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_8 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_8

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_8 and arg_67_1.time_ < var_70_0 + var_70_8 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play319251017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 319251017
		arg_71_1.duration_ = 3.73

		local var_71_0 = {
			zh = 1.999999999999,
			ja = 3.733
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
				arg_71_0:Play319251018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["10075ui_story"]) and arg_71_1.var_.characterEffect10075ui_story == nil then
				arg_71_1.var_.characterEffect10075ui_story = arg_71_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["10075ui_story"]) then
				if arg_71_1.var_.characterEffect10075ui_story and not isNil(arg_71_1.actors_["10075ui_story"]) then
					arg_71_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["10075ui_story"]) and arg_71_1.var_.characterEffect10075ui_story then
				arg_71_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050actionlink/10050action4117")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_74_2 = arg_71_1.actors_["10079ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.characterEffect10079ui_story == nil then
				arg_71_1.var_.characterEffect10079ui_story = var_74_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_3 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_3 and not isNil(var_74_2) then
				if arg_71_1.var_.characterEffect10079ui_story and not isNil(var_74_2) then
					arg_71_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_71_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_3)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_3 and arg_71_1.time_ < 0 + var_74_3 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.characterEffect10079ui_story then
				arg_71_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_71_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_74_4 = 0
			local var_74_5 = 0.1

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(319251017)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 4 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 4)

				if (4 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 4)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251017", "story_v_out_319251.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_out_319251", "319251017", "story_v_out_319251.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_out_319251", "319251017", "story_v_out_319251.awb")

						arg_71_1:RecordAudio("319251017", var_74_11)
						arg_71_1:RecordAudio("319251017", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_319251", "319251017", "story_v_out_319251.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_319251", "319251017", "story_v_out_319251.awb")
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

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play319251018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 319251018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play319251019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["10075ui_story"]) and arg_75_1.var_.characterEffect10075ui_story == nil then
				arg_75_1.var_.characterEffect10075ui_story = arg_75_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["10075ui_story"]) then
				if arg_75_1.var_.characterEffect10075ui_story and not isNil(arg_75_1.actors_["10075ui_story"]) then
					arg_75_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["10075ui_story"]) and arg_75_1.var_.characterEffect10075ui_story then
				arg_75_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_78_1 = arg_75_1.actors_["10075ui_story"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10075ui_story = var_78_1.localPosition
			end

			local var_78_2 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_2 then
				var_78_1.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 0) / var_78_2)
				var_78_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_1.position).x, (manager.ui.mainCamera.transform.position - var_78_1.position).y, (manager.ui.mainCamera.transform.position - var_78_1.position).z)
				var_78_1.localEulerAngles.z = 0
				var_78_1.localEulerAngles.x = 0
				var_78_1.localEulerAngles = var_78_1.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_2 and arg_75_1.time_ < 0 + var_78_2 + arg_78_0 then
				var_78_1.localPosition = Vector3.New(0, 100, 0)
				var_78_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_1.position).x, (manager.ui.mainCamera.transform.position - var_78_1.position).y, (manager.ui.mainCamera.transform.position - var_78_1.position).z)
				var_78_1.localEulerAngles.z = 0
				var_78_1.localEulerAngles.x = 0
				var_78_1.localEulerAngles = var_78_1.localEulerAngles
			end

			local var_78_3 = arg_75_1.actors_["10079ui_story"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10079ui_story = var_78_3.localPosition
			end

			local var_78_4 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				var_78_3.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 0) / var_78_4)
				var_78_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_3.position).x, (manager.ui.mainCamera.transform.position - var_78_3.position).y, (manager.ui.mainCamera.transform.position - var_78_3.position).z)
				var_78_3.localEulerAngles.z = 0
				var_78_3.localEulerAngles.x = 0
				var_78_3.localEulerAngles = var_78_3.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				var_78_3.localPosition = Vector3.New(0, 100, 0)
				var_78_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_3.position).x, (manager.ui.mainCamera.transform.position - var_78_3.position).y, (manager.ui.mainCamera.transform.position - var_78_3.position).z)
				var_78_3.localEulerAngles.z = 0
				var_78_3.localEulerAngles.x = 0
				var_78_3.localEulerAngles = var_78_3.localEulerAngles
			end

			local var_78_5 = 0
			local var_78_6 = 0.925

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_7 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(319251018).content)

				arg_75_1.text_.text = var_78_7

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_9 = 37 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_7) / 37)

				if (37 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_7) / 37)) > 0 and var_78_6 < var_78_9 then
					arg_75_1.talkMaxDuration = var_78_9

					if var_78_9 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_9 + var_78_5
					end
				end

				arg_75_1.text_.text = var_78_7
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_6, arg_75_1.talkMaxDuration)

			if var_78_5 <= arg_75_1.time_ and arg_75_1.time_ < var_78_5 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_5) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_5 + var_78_10 and arg_75_1.time_ < var_78_5 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319251019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 319251019
		arg_79_1.duration_ = 6.13

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play319251020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:AudioAction("play", "effect", "se_story_130", "se_story_130_didi", "")
			end

			local var_82_1 = manager.ui.mainCamera.transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.shakeOldPos = var_82_1.localPosition
			end

			local var_82_2 = 0.6

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 then
				local var_82_3, var_82_4 = math.modf((arg_79_1.time_ - 0) / 0.066)

				var_82_1.localPosition = Vector3.New(var_82_4 * 0.13, var_82_4 * 0.13, var_82_4 * 0.13) + arg_79_1.var_.shakeOldPos
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 then
				var_82_1.localPosition = arg_79_1.var_.shakeOldPos
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_5 = 1.13333333333333
			local var_82_6 = 1.2

			if 1.13333333333333 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_7 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_7:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_8 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(319251019).content)

				arg_79_1.text_.text = var_82_8

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_10 = 48 <= 0 and var_82_6 or var_82_6 * (utf8.len(var_82_8) / 48)

				if (48 <= 0 and var_82_6 or var_82_6 * (utf8.len(var_82_8) / 48)) > 0 and var_82_6 < var_82_10 then
					arg_79_1.talkMaxDuration = var_82_10
					var_82_5 = var_82_5 + 0.3

					if var_82_10 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_5
					end
				end

				arg_79_1.text_.text = var_82_8
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_11 = var_82_5 + 0.3
			local var_82_12 = math.max(var_82_6, arg_79_1.talkMaxDuration)

			if var_82_5 + 0.3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_11 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_11) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_11 + var_82_12 and arg_79_1.time_ < var_82_11 + var_82_12 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play319251020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319251020
		arg_85_1.duration_ = 7.13

		local var_85_0 = {
			zh = 7.133,
			ja = 3.433
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
				arg_85_0:Play319251021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:AudioAction("stop", "effect", "se_story_130", "se_story_130_didi", "")
			end

			local var_88_1 = arg_85_1.actors_["10079ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect10079ui_story == nil then
				arg_85_1.var_.characterEffect10079ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect10079ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_2)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect10079ui_story then
				arg_85_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_88_3 = arg_85_1.actors_["10075ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_3) and arg_85_1.var_.characterEffect10075ui_story == nil then
				arg_85_1.var_.characterEffect10075ui_story = var_88_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_4 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 and not isNil(var_88_3) then
				if arg_85_1.var_.characterEffect10075ui_story and not isNil(var_88_3) then
					arg_85_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 and not isNil(var_88_3) and arg_85_1.var_.characterEffect10075ui_story then
				arg_85_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_88_6 = arg_85_1.actors_["10075ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10075ui_story = var_88_6.localPosition
			end

			local var_88_7 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				var_88_6.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10075ui_story, Vector3.New(0, -0.715, -6.15), (arg_85_1.time_ - 0) / var_88_7)
				var_88_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_6.position).x, (manager.ui.mainCamera.transform.position - var_88_6.position).y, (manager.ui.mainCamera.transform.position - var_88_6.position).z)
				var_88_6.localEulerAngles.z = 0
				var_88_6.localEulerAngles.x = 0
				var_88_6.localEulerAngles = var_88_6.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				var_88_6.localPosition = Vector3.New(0, -0.715, -6.15)
				var_88_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_6.position).x, (manager.ui.mainCamera.transform.position - var_88_6.position).y, (manager.ui.mainCamera.transform.position - var_88_6.position).z)
				var_88_6.localEulerAngles.z = 0
				var_88_6.localEulerAngles.x = 0
				var_88_6.localEulerAngles = var_88_6.localEulerAngles
			end

			local var_88_8 = arg_85_1.actors_["10079ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10079ui_story = var_88_8.localPosition
			end

			local var_88_9 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_9 then
				var_88_8.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_9)
				var_88_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_8.position).x, (manager.ui.mainCamera.transform.position - var_88_8.position).y, (manager.ui.mainCamera.transform.position - var_88_8.position).z)
				var_88_8.localEulerAngles.z = 0
				var_88_8.localEulerAngles.x = 0
				var_88_8.localEulerAngles = var_88_8.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_9 and arg_85_1.time_ < 0 + var_88_9 + arg_88_0 then
				var_88_8.localPosition = Vector3.New(0, 100, 0)
				var_88_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_8.position).x, (manager.ui.mainCamera.transform.position - var_88_8.position).y, (manager.ui.mainCamera.transform.position - var_88_8.position).z)
				var_88_8.localEulerAngles.z = 0
				var_88_8.localEulerAngles.x = 0
				var_88_8.localEulerAngles = var_88_8.localEulerAngles
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action7_2")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_88_10 = 0
			local var_88_11 = 0.8

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_12 = arg_85_1:GetWordFromCfg(319251020)
				local var_88_13 = arg_85_1:FormatText(var_88_12.content)

				arg_85_1.text_.text = var_88_13

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_15 = 32 <= 0 and var_88_11 or var_88_11 * (utf8.len(var_88_13) / 32)

				if (32 <= 0 and var_88_11 or var_88_11 * (utf8.len(var_88_13) / 32)) > 0 and var_88_11 < var_88_15 then
					arg_85_1.talkMaxDuration = var_88_15

					if var_88_15 + var_88_10 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_15 + var_88_10
					end
				end

				arg_85_1.text_.text = var_88_13
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251020", "story_v_out_319251.awb") ~= 0 then
					local var_88_16 = manager.audio:GetVoiceLength("story_v_out_319251", "319251020", "story_v_out_319251.awb") / 1000

					if var_88_16 + var_88_10 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_16 + var_88_10
					end

					if var_88_12.prefab_name ~= "" and arg_85_1.actors_[var_88_12.prefab_name] ~= nil then
						local var_88_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_12.prefab_name].transform, "story_v_out_319251", "319251020", "story_v_out_319251.awb")

						arg_85_1:RecordAudio("319251020", var_88_17)
						arg_85_1:RecordAudio("319251020", var_88_17)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_319251", "319251020", "story_v_out_319251.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_319251", "319251020", "story_v_out_319251.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_18 = math.max(var_88_11, arg_85_1.talkMaxDuration)

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_18 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_10) / var_88_18

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_10 + var_88_18 and arg_85_1.time_ < var_88_10 + var_88_18 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319251021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319251021
		arg_89_1.duration_ = 3.43

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play319251022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10079ui_story = arg_89_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10079ui_story"].transform.position).z)
				arg_89_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["10079ui_story"].transform.localEulerAngles = arg_89_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_89_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10079ui_story"].transform.position).z)
				arg_89_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["10079ui_story"].transform.localEulerAngles = arg_89_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["10079ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect10079ui_story == nil then
				arg_89_1.var_.characterEffect10079ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect10079ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect10079ui_story then
				arg_89_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_92_4 = arg_89_1.actors_["10075ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect10075ui_story == nil then
				arg_89_1.var_.characterEffect10075ui_story = var_92_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_5 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_5 and not isNil(var_92_4) then
				if arg_89_1.var_.characterEffect10075ui_story and not isNil(var_92_4) then
					arg_89_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_5)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_5 and arg_89_1.time_ < 0 + var_92_5 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect10075ui_story then
				arg_89_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_92_6 = arg_89_1.actors_["10075ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10075ui_story = var_92_6.localPosition
			end

			local var_92_7 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				var_92_6.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_89_1.time_ - 0) / var_92_7)
				var_92_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_6.position).x, (manager.ui.mainCamera.transform.position - var_92_6.position).y, (manager.ui.mainCamera.transform.position - var_92_6.position).z)
				var_92_6.localEulerAngles.z = 0
				var_92_6.localEulerAngles.x = 0
				var_92_6.localEulerAngles = var_92_6.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				var_92_6.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				var_92_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_6.position).x, (manager.ui.mainCamera.transform.position - var_92_6.position).y, (manager.ui.mainCamera.transform.position - var_92_6.position).z)
				var_92_6.localEulerAngles.z = 0
				var_92_6.localEulerAngles.x = 0
				var_92_6.localEulerAngles = var_92_6.localEulerAngles
			end

			local var_92_8 = 0
			local var_92_9 = 0.325

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_10 = arg_89_1:GetWordFromCfg(319251021)
				local var_92_11 = arg_89_1:FormatText(var_92_10.content)

				arg_89_1.text_.text = var_92_11

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_13 = 13 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 13)

				if (13 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 13)) > 0 and var_92_9 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_8
					end
				end

				arg_89_1.text_.text = var_92_11
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251021", "story_v_out_319251.awb") ~= 0 then
					local var_92_14 = manager.audio:GetVoiceLength("story_v_out_319251", "319251021", "story_v_out_319251.awb") / 1000

					if var_92_14 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_8
					end

					if var_92_10.prefab_name ~= "" and arg_89_1.actors_[var_92_10.prefab_name] ~= nil then
						local var_92_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_10.prefab_name].transform, "story_v_out_319251", "319251021", "story_v_out_319251.awb")

						arg_89_1:RecordAudio("319251021", var_92_15)
						arg_89_1:RecordAudio("319251021", var_92_15)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_319251", "319251021", "story_v_out_319251.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_319251", "319251021", "story_v_out_319251.awb")
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
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
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
	Play319251022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319251022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play319251023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["10079ui_story"]) and arg_93_1.var_.characterEffect10079ui_story == nil then
				arg_93_1.var_.characterEffect10079ui_story = arg_93_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["10079ui_story"]) then
				if arg_93_1.var_.characterEffect10079ui_story and not isNil(arg_93_1.actors_["10079ui_story"]) then
					arg_93_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["10079ui_story"]) and arg_93_1.var_.characterEffect10079ui_story then
				arg_93_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_96_1 = 0
			local var_96_2 = 0.925

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(319251022).content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 37 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 37)

				if (37 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 37)) > 0 and var_96_2 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_6 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_6 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_6

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_6 and arg_93_1.time_ < var_96_1 + var_96_6 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319251023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319251023
		arg_97_1.duration_ = 11.9

		local var_97_0 = {
			zh = 7.733,
			ja = 11.9
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
				arg_97_0:Play319251024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if arg_97_1.bgs_.ML0104 == nil then
				local var_100_0 = Object.Instantiate(arg_97_1.paintGo_)

				var_100_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ML0104")
				var_100_0.name = "ML0104"
				var_100_0.transform.parent = arg_97_1.stage_.transform
				var_100_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.bgs_.ML0104 = var_100_0
			end

			if 2 < arg_97_1.time_ and arg_97_1.time_ <= 2 + arg_100_0 then
				local var_100_1 = arg_97_1.bgs_.ML0104

				arg_97_1.bgs_.ML0104.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_100_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_100_2 = var_100_1:GetComponent("SpriteRenderer")

				if var_100_2 and var_100_2.sprite then
					local var_100_3 = 2 * (var_100_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_100_1.transform.localScale = Vector3.New(var_100_3 / var_100_2.sprite.bounds.size.y < var_100_3 * manager.ui.mainCameraCom_.aspect / var_100_2.sprite.bounds.size.x and var_100_3 * manager.ui.mainCameraCom_.aspect / var_100_2.sprite.bounds.size.x or var_100_3 / var_100_2.sprite.bounds.size.y, var_100_3 / var_100_2.sprite.bounds.size.y < var_100_3 * manager.ui.mainCameraCom_.aspect / var_100_2.sprite.bounds.size.x and var_100_3 * manager.ui.mainCameraCom_.aspect / var_100_2.sprite.bounds.size.x or var_100_3 / var_100_2.sprite.bounds.size.y, 0)
				end

				for iter_100_0, iter_100_1 in pairs(arg_97_1.bgs_) do
					if iter_100_0 ~= "ML0104" then
						iter_100_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_100_4 = 0

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_5 = 2

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_5 then
				local var_100_6 = Color.New(0, 0, 0)

				var_100_6.a = Mathf.Lerp(0, 1, (arg_97_1.time_ - var_100_4) / var_100_5)
				arg_97_1.mask_.color = var_100_6
			end

			if arg_97_1.time_ >= var_100_4 + var_100_5 and arg_97_1.time_ < var_100_4 + var_100_5 + arg_100_0 then
				local var_100_7 = Color.New(0, 0, 0)

				var_100_7.a = 1
				arg_97_1.mask_.color = var_100_7
			end

			local var_100_8 = 2

			if 2 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_9 = 2

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_9 then
				local var_100_10 = Color.New(0, 0, 0)

				var_100_10.a = Mathf.Lerp(1, 0, (arg_97_1.time_ - var_100_8) / var_100_9)
				arg_97_1.mask_.color = var_100_10
			end

			if arg_97_1.time_ >= var_100_8 + var_100_9 and arg_97_1.time_ < var_100_8 + var_100_9 + arg_100_0 then
				local var_100_11 = Color.New(0, 0, 0)

				arg_97_1.mask_.enabled = false
				var_100_11.a = 0
				arg_97_1.mask_.color = var_100_11
			end

			local var_100_12 = arg_97_1.actors_["10079ui_story"].transform

			if 1.96599999815226 < arg_97_1.time_ and arg_97_1.time_ <= 1.96599999815226 + arg_100_0 then
				arg_97_1.var_.moveOldPos10079ui_story = var_100_12.localPosition
			end

			local var_100_13 = 0.001

			if 1.96599999815226 <= arg_97_1.time_ and arg_97_1.time_ < 1.96599999815226 + var_100_13 then
				var_100_12.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 1.96599999815226) / var_100_13)
				var_100_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_12.position).x, (manager.ui.mainCamera.transform.position - var_100_12.position).y, (manager.ui.mainCamera.transform.position - var_100_12.position).z)
				var_100_12.localEulerAngles.z = 0
				var_100_12.localEulerAngles.x = 0
				var_100_12.localEulerAngles = var_100_12.localEulerAngles
			end

			if arg_97_1.time_ >= 1.96599999815226 + var_100_13 and arg_97_1.time_ < 1.96599999815226 + var_100_13 + arg_100_0 then
				var_100_12.localPosition = Vector3.New(0, 100, 0)
				var_100_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_12.position).x, (manager.ui.mainCamera.transform.position - var_100_12.position).y, (manager.ui.mainCamera.transform.position - var_100_12.position).z)
				var_100_12.localEulerAngles.z = 0
				var_100_12.localEulerAngles.x = 0
				var_100_12.localEulerAngles = var_100_12.localEulerAngles
			end

			local var_100_14 = arg_97_1.actors_["10075ui_story"].transform

			if 1.96599999815226 < arg_97_1.time_ and arg_97_1.time_ <= 1.96599999815226 + arg_100_0 then
				arg_97_1.var_.moveOldPos10075ui_story = var_100_14.localPosition
			end

			local var_100_15 = 0.001

			if 1.96599999815226 <= arg_97_1.time_ and arg_97_1.time_ < 1.96599999815226 + var_100_15 then
				var_100_14.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 1.96599999815226) / var_100_15)
				var_100_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_14.position).x, (manager.ui.mainCamera.transform.position - var_100_14.position).y, (manager.ui.mainCamera.transform.position - var_100_14.position).z)
				var_100_14.localEulerAngles.z = 0
				var_100_14.localEulerAngles.x = 0
				var_100_14.localEulerAngles = var_100_14.localEulerAngles
			end

			if arg_97_1.time_ >= 1.96599999815226 + var_100_15 and arg_97_1.time_ < 1.96599999815226 + var_100_15 + arg_100_0 then
				var_100_14.localPosition = Vector3.New(0, 100, 0)
				var_100_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_14.position).x, (manager.ui.mainCamera.transform.position - var_100_14.position).y, (manager.ui.mainCamera.transform.position - var_100_14.position).z)
				var_100_14.localEulerAngles.z = 0
				var_100_14.localEulerAngles.x = 0
				var_100_14.localEulerAngles = var_100_14.localEulerAngles
			end

			local var_100_16 = 1.96599999815226

			arg_97_1.isInRecall_ = false

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 then
				arg_97_1.screenFilterGo_:SetActive(true)

				arg_97_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_100_2, iter_100_3 in pairs(arg_97_1.actors_) do
					for iter_100_4, iter_100_5 in ipairs((iter_100_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_100_5.color = iter_100_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_100_17 = 0.034000001847744

			if var_100_16 <= arg_97_1.time_ and arg_97_1.time_ < var_100_16 + var_100_17 then
				arg_97_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_97_1.time_ - var_100_16) / var_100_17)
			end

			if arg_97_1.time_ >= var_100_16 + var_100_17 and arg_97_1.time_ < var_100_16 + var_100_17 + arg_100_0 then
				arg_97_1.screenFilterEffect_.weight = 1
			end

			if arg_97_1.frameCnt_ <= 1 then
				arg_97_1.dialog_:SetActive(false)
			end

			local var_100_18 = 3.7
			local var_100_19 = 0.5

			if 3.7 < arg_97_1.time_ and arg_97_1.time_ <= var_100_18 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0

				arg_97_1.dialog_:SetActive(true)

				arg_97_1.dialogCg_.alpha = 0

				local var_100_20 = LeanTween.value(arg_97_1.dialog_, 0, 1, 0.3)

				var_100_20:setOnUpdate(LuaHelper.FloatAction(function(arg_101_0)
					arg_97_1.dialogCg_.alpha = arg_101_0
				end))
				var_100_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_97_1.dialog_)
					var_100_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_97_1.duration_ = arg_97_1.duration_ + 0.3

				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_21 = arg_97_1:GetWordFromCfg(319251023)
				local var_100_22 = arg_97_1:FormatText(var_100_21.content)

				arg_97_1.text_.text = var_100_22

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_24 = 20 <= 0 and var_100_19 or var_100_19 * (utf8.len(var_100_22) / 20)

				if (20 <= 0 and var_100_19 or var_100_19 * (utf8.len(var_100_22) / 20)) > 0 and var_100_19 < var_100_24 then
					arg_97_1.talkMaxDuration = var_100_24
					var_100_18 = var_100_18 + 0.3

					if var_100_24 + var_100_18 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_24 + var_100_18
					end
				end

				arg_97_1.text_.text = var_100_22
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251023", "story_v_out_319251.awb") ~= 0 then
					local var_100_25 = manager.audio:GetVoiceLength("story_v_out_319251", "319251023", "story_v_out_319251.awb") / 1000

					if var_100_25 + var_100_18 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_25 + var_100_18
					end

					if var_100_21.prefab_name ~= "" and arg_97_1.actors_[var_100_21.prefab_name] ~= nil then
						local var_100_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_21.prefab_name].transform, "story_v_out_319251", "319251023", "story_v_out_319251.awb")

						arg_97_1:RecordAudio("319251023", var_100_26)
						arg_97_1:RecordAudio("319251023", var_100_26)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_319251", "319251023", "story_v_out_319251.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_319251", "319251023", "story_v_out_319251.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_27 = var_100_18 + 0.3
			local var_100_28 = math.max(var_100_19, arg_97_1.talkMaxDuration)

			if var_100_18 + 0.3 <= arg_97_1.time_ and arg_97_1.time_ < var_100_27 + var_100_28 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_27) / var_100_28

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_27 + var_100_28 and arg_97_1.time_ < var_100_27 + var_100_28 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play319251024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 319251024
		arg_103_1.duration_ = 9.03

		local var_103_0 = {
			zh = 8.7,
			ja = 9.033
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
				arg_103_0:Play319251025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if arg_103_1.bgs_.ST74 == nil then
				local var_106_0 = Object.Instantiate(arg_103_1.paintGo_)

				var_106_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST74")
				var_106_0.name = "ST74"
				var_106_0.transform.parent = arg_103_1.stage_.transform
				var_106_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_103_1.bgs_.ST74 = var_106_0
			end

			if 2 < arg_103_1.time_ and arg_103_1.time_ <= 2 + arg_106_0 then
				local var_106_1 = arg_103_1.bgs_.ST74

				arg_103_1.bgs_.ST74.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_106_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_106_2 = var_106_1:GetComponent("SpriteRenderer")

				if var_106_2 and var_106_2.sprite then
					local var_106_3 = 2 * (var_106_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_106_1.transform.localScale = Vector3.New(var_106_3 / var_106_2.sprite.bounds.size.y < var_106_3 * manager.ui.mainCameraCom_.aspect / var_106_2.sprite.bounds.size.x and var_106_3 * manager.ui.mainCameraCom_.aspect / var_106_2.sprite.bounds.size.x or var_106_3 / var_106_2.sprite.bounds.size.y, var_106_3 / var_106_2.sprite.bounds.size.y < var_106_3 * manager.ui.mainCameraCom_.aspect / var_106_2.sprite.bounds.size.x and var_106_3 * manager.ui.mainCameraCom_.aspect / var_106_2.sprite.bounds.size.x or var_106_3 / var_106_2.sprite.bounds.size.y, 0)
				end

				for iter_106_0, iter_106_1 in pairs(arg_103_1.bgs_) do
					if iter_106_0 ~= "ST74" then
						iter_106_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_106_4 = 0

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.allBtn_.enabled = false
			end

			if arg_103_1.time_ >= var_106_4 + 0.3 and arg_103_1.time_ < var_106_4 + 0.3 + arg_106_0 then
				arg_103_1.allBtn_.enabled = true
			end

			local var_106_5 = 0

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_6 = 2

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_6 then
				local var_106_7 = Color.New(0, 0, 0)

				var_106_7.a = Mathf.Lerp(0, 1, (arg_103_1.time_ - var_106_5) / var_106_6)
				arg_103_1.mask_.color = var_106_7
			end

			if arg_103_1.time_ >= var_106_5 + var_106_6 and arg_103_1.time_ < var_106_5 + var_106_6 + arg_106_0 then
				local var_106_8 = Color.New(0, 0, 0)

				var_106_8.a = 1
				arg_103_1.mask_.color = var_106_8
			end

			local var_106_9 = 2

			if 2 < arg_103_1.time_ and arg_103_1.time_ <= var_106_9 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_10 = 2

			if var_106_9 <= arg_103_1.time_ and arg_103_1.time_ < var_106_9 + var_106_10 then
				local var_106_11 = Color.New(0, 0, 0)

				var_106_11.a = Mathf.Lerp(1, 0, (arg_103_1.time_ - var_106_9) / var_106_10)
				arg_103_1.mask_.color = var_106_11
			end

			if arg_103_1.time_ >= var_106_9 + var_106_10 and arg_103_1.time_ < var_106_9 + var_106_10 + arg_106_0 then
				local var_106_12 = Color.New(0, 0, 0)

				arg_103_1.mask_.enabled = false
				var_106_12.a = 0
				arg_103_1.mask_.color = var_106_12
			end

			local var_106_13 = "4040ui_story"

			if arg_103_1.actors_["4040ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4040ui_story"))) then
				local var_106_14 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_103_1.stage_.transform)

				var_106_14.name = var_106_13
				var_106_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_103_1.actors_[var_106_13] = var_106_14

				local var_106_15 = var_106_14:GetComponentInChildren(typeof(CharacterEffect))

				var_106_15.enabled = true

				local var_106_16 = GameObjectTools.GetOrAddComponent(var_106_14, typeof(DynamicBoneHelper))

				if var_106_16 then
					var_106_16:EnableDynamicBone(false)
				end

				arg_103_1:ShowWeapon(var_106_15.transform, false)

				arg_103_1.var_[var_106_13 .. "Animator"] = var_106_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_103_1.var_[var_106_13 .. "Animator"].applyRootMotion = true
				arg_103_1.var_[var_106_13 .. "LipSync"] = var_106_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_106_17 = arg_103_1.actors_["4040ui_story"].transform

			if 3.9 < arg_103_1.time_ and arg_103_1.time_ <= 3.9 + arg_106_0 then
				arg_103_1.var_.moveOldPos4040ui_story = var_106_17.localPosition
			end

			local var_106_18 = 0.001

			if 3.9 <= arg_103_1.time_ and arg_103_1.time_ < 3.9 + var_106_18 then
				var_106_17.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_103_1.time_ - 3.9) / var_106_18)
				var_106_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_17.position).x, (manager.ui.mainCamera.transform.position - var_106_17.position).y, (manager.ui.mainCamera.transform.position - var_106_17.position).z)
				var_106_17.localEulerAngles.z = 0
				var_106_17.localEulerAngles.x = 0
				var_106_17.localEulerAngles = var_106_17.localEulerAngles
			end

			if arg_103_1.time_ >= 3.9 + var_106_18 and arg_103_1.time_ < 3.9 + var_106_18 + arg_106_0 then
				var_106_17.localPosition = Vector3.New(0, -1.55, -5.5)
				var_106_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_17.position).x, (manager.ui.mainCamera.transform.position - var_106_17.position).y, (manager.ui.mainCamera.transform.position - var_106_17.position).z)
				var_106_17.localEulerAngles.z = 0
				var_106_17.localEulerAngles.x = 0
				var_106_17.localEulerAngles = var_106_17.localEulerAngles
			end

			local var_106_19 = arg_103_1.actors_["4040ui_story"]

			if 3.9 < arg_103_1.time_ and arg_103_1.time_ <= 3.9 + arg_106_0 and not isNil(var_106_19) and arg_103_1.var_.characterEffect4040ui_story == nil then
				arg_103_1.var_.characterEffect4040ui_story = var_106_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_20 = 0.200000002980232

			if 3.9 <= arg_103_1.time_ and arg_103_1.time_ < 3.9 + var_106_20 and not isNil(var_106_19) then
				if arg_103_1.var_.characterEffect4040ui_story and not isNil(var_106_19) then
					arg_103_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 3.9 + var_106_20 and arg_103_1.time_ < 3.9 + var_106_20 + arg_106_0 and not isNil(var_106_19) and arg_103_1.var_.characterEffect4040ui_story then
				arg_103_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 3.9 < arg_103_1.time_ and arg_103_1.time_ <= 3.9 + arg_106_0 then
				arg_103_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			if 3.9 < arg_103_1.time_ and arg_103_1.time_ <= 3.9 + arg_106_0 then
				arg_103_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_103_1.frameCnt_ <= 1 then
				arg_103_1.dialog_:SetActive(false)
			end

			local var_106_22 = 4
			local var_106_23 = 0.6

			if 4 < arg_103_1.time_ and arg_103_1.time_ <= var_106_22 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				arg_103_1.dialog_:SetActive(true)

				arg_103_1.dialogCg_.alpha = 0

				local var_106_24 = LeanTween.value(arg_103_1.dialog_, 0, 1, 0.3)

				var_106_24:setOnUpdate(LuaHelper.FloatAction(function(arg_107_0)
					arg_103_1.dialogCg_.alpha = arg_107_0
				end))
				var_106_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_103_1.dialog_)
					var_106_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_103_1.duration_ = arg_103_1.duration_ + 0.3

				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_25 = arg_103_1:GetWordFromCfg(319251024)
				local var_106_26 = arg_103_1:FormatText(var_106_25.content)

				arg_103_1.text_.text = var_106_26

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_28 = 24 <= 0 and var_106_23 or var_106_23 * (utf8.len(var_106_26) / 24)

				if (24 <= 0 and var_106_23 or var_106_23 * (utf8.len(var_106_26) / 24)) > 0 and var_106_23 < var_106_28 then
					arg_103_1.talkMaxDuration = var_106_28
					var_106_22 = var_106_22 + 0.3

					if var_106_28 + var_106_22 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_28 + var_106_22
					end
				end

				arg_103_1.text_.text = var_106_26
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251024", "story_v_out_319251.awb") ~= 0 then
					local var_106_29 = manager.audio:GetVoiceLength("story_v_out_319251", "319251024", "story_v_out_319251.awb") / 1000

					if var_106_29 + var_106_22 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_29 + var_106_22
					end

					if var_106_25.prefab_name ~= "" and arg_103_1.actors_[var_106_25.prefab_name] ~= nil then
						local var_106_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_25.prefab_name].transform, "story_v_out_319251", "319251024", "story_v_out_319251.awb")

						arg_103_1:RecordAudio("319251024", var_106_30)
						arg_103_1:RecordAudio("319251024", var_106_30)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_319251", "319251024", "story_v_out_319251.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_319251", "319251024", "story_v_out_319251.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_31 = var_106_22 + 0.3
			local var_106_32 = math.max(var_106_23, arg_103_1.talkMaxDuration)

			if var_106_22 + 0.3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_31 + var_106_32 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_31) / var_106_32

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_31 + var_106_32 and arg_103_1.time_ < var_106_31 + var_106_32 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play319251025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319251025
		arg_109_1.duration_ = 9

		local var_109_0 = {
			zh = 9,
			ja = 8.533
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
				arg_109_0:Play319251026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 2 < arg_109_1.time_ and arg_109_1.time_ <= 2 + arg_112_0 then
				local var_112_0 = arg_109_1.bgs_.I11r

				arg_109_1.bgs_.I11r.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_112_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_1 = var_112_0:GetComponent("SpriteRenderer")

				if var_112_1 and var_112_1.sprite then
					local var_112_2 = 2 * (var_112_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_112_0.transform.localScale = Vector3.New(var_112_2 / var_112_1.sprite.bounds.size.y < var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x and var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x or var_112_2 / var_112_1.sprite.bounds.size.y, var_112_2 / var_112_1.sprite.bounds.size.y < var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x and var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x or var_112_2 / var_112_1.sprite.bounds.size.y, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "I11r" then
						iter_112_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_112_3 = 0

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_4 = 2

			if var_112_3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_3 + var_112_4 then
				local var_112_5 = Color.New(0, 0, 0)

				var_112_5.a = Mathf.Lerp(0, 1, (arg_109_1.time_ - var_112_3) / var_112_4)
				arg_109_1.mask_.color = var_112_5
			end

			if arg_109_1.time_ >= var_112_3 + var_112_4 and arg_109_1.time_ < var_112_3 + var_112_4 + arg_112_0 then
				local var_112_6 = Color.New(0, 0, 0)

				var_112_6.a = 1
				arg_109_1.mask_.color = var_112_6
			end

			local var_112_7 = 2

			if 2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_7 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_8 = 2

			if var_112_7 <= arg_109_1.time_ and arg_109_1.time_ < var_112_7 + var_112_8 then
				local var_112_9 = Color.New(0, 0, 0)

				var_112_9.a = Mathf.Lerp(1, 0, (arg_109_1.time_ - var_112_7) / var_112_8)
				arg_109_1.mask_.color = var_112_9
			end

			if arg_109_1.time_ >= var_112_7 + var_112_8 and arg_109_1.time_ < var_112_7 + var_112_8 + arg_112_0 then
				local var_112_10 = Color.New(0, 0, 0)

				arg_109_1.mask_.enabled = false
				var_112_10.a = 0
				arg_109_1.mask_.color = var_112_10
			end

			local var_112_11 = arg_109_1.actors_["10075ui_story"].transform

			if 3.86666666666667 < arg_109_1.time_ and arg_109_1.time_ <= 3.86666666666667 + arg_112_0 then
				arg_109_1.var_.moveOldPos10075ui_story = var_112_11.localPosition
			end

			local var_112_12 = 0.001

			if 3.86666666666667 <= arg_109_1.time_ and arg_109_1.time_ < 3.86666666666667 + var_112_12 then
				var_112_11.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10075ui_story, Vector3.New(0, -0.715, -6.15), (arg_109_1.time_ - 3.86666666666667) / var_112_12)
				var_112_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_11.position).x, (manager.ui.mainCamera.transform.position - var_112_11.position).y, (manager.ui.mainCamera.transform.position - var_112_11.position).z)
				var_112_11.localEulerAngles.z = 0
				var_112_11.localEulerAngles.x = 0
				var_112_11.localEulerAngles = var_112_11.localEulerAngles
			end

			if arg_109_1.time_ >= 3.86666666666667 + var_112_12 and arg_109_1.time_ < 3.86666666666667 + var_112_12 + arg_112_0 then
				var_112_11.localPosition = Vector3.New(0, -0.715, -6.15)
				var_112_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_11.position).x, (manager.ui.mainCamera.transform.position - var_112_11.position).y, (manager.ui.mainCamera.transform.position - var_112_11.position).z)
				var_112_11.localEulerAngles.z = 0
				var_112_11.localEulerAngles.x = 0
				var_112_11.localEulerAngles = var_112_11.localEulerAngles
			end

			local var_112_13 = arg_109_1.actors_["10075ui_story"]

			if 3.86666666666667 < arg_109_1.time_ and arg_109_1.time_ <= 3.86666666666667 + arg_112_0 and not isNil(var_112_13) and arg_109_1.var_.characterEffect10075ui_story == nil then
				arg_109_1.var_.characterEffect10075ui_story = var_112_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_14 = 0.200000002980232

			if 3.86666666666667 <= arg_109_1.time_ and arg_109_1.time_ < 3.86666666666667 + var_112_14 and not isNil(var_112_13) then
				if arg_109_1.var_.characterEffect10075ui_story and not isNil(var_112_13) then
					arg_109_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 3.86666666666667 + var_112_14 and arg_109_1.time_ < 3.86666666666667 + var_112_14 + arg_112_0 and not isNil(var_112_13) and arg_109_1.var_.characterEffect10075ui_story then
				arg_109_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 3.86666666666667 < arg_109_1.time_ and arg_109_1.time_ <= 3.86666666666667 + arg_112_0 then
				arg_109_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_1")
			end

			if 3.86666666666667 < arg_109_1.time_ and arg_109_1.time_ <= 3.86666666666667 + arg_112_0 then
				arg_109_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_16 = arg_109_1.actors_["4040ui_story"].transform

			if 2 < arg_109_1.time_ and arg_109_1.time_ <= 2 + arg_112_0 then
				arg_109_1.var_.moveOldPos4040ui_story = var_112_16.localPosition
			end

			local var_112_17 = 0.001

			if 2 <= arg_109_1.time_ and arg_109_1.time_ < 2 + var_112_17 then
				var_112_16.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 2) / var_112_17)
				var_112_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_16.position).x, (manager.ui.mainCamera.transform.position - var_112_16.position).y, (manager.ui.mainCamera.transform.position - var_112_16.position).z)
				var_112_16.localEulerAngles.z = 0
				var_112_16.localEulerAngles.x = 0
				var_112_16.localEulerAngles = var_112_16.localEulerAngles
			end

			if arg_109_1.time_ >= 2 + var_112_17 and arg_109_1.time_ < 2 + var_112_17 + arg_112_0 then
				var_112_16.localPosition = Vector3.New(0, 100, 0)
				var_112_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_16.position).x, (manager.ui.mainCamera.transform.position - var_112_16.position).y, (manager.ui.mainCamera.transform.position - var_112_16.position).z)
				var_112_16.localEulerAngles.z = 0
				var_112_16.localEulerAngles.x = 0
				var_112_16.localEulerAngles = var_112_16.localEulerAngles
			end

			local var_112_18 = 2

			arg_109_1.isInRecall_ = false

			if var_112_18 < arg_109_1.time_ and arg_109_1.time_ <= var_112_18 + arg_112_0 then
				arg_109_1.screenFilterGo_:SetActive(false)

				for iter_112_2, iter_112_3 in pairs(arg_109_1.actors_) do
					for iter_112_4, iter_112_5 in ipairs((iter_112_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_112_5.color = iter_112_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_112_19 = 0.034000001847744

			if var_112_18 <= arg_109_1.time_ and arg_109_1.time_ < var_112_18 + var_112_19 then
				arg_109_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_109_1.time_ - var_112_18) / var_112_19)
			end

			if arg_109_1.time_ >= var_112_18 + var_112_19 and arg_109_1.time_ < var_112_18 + var_112_19 + arg_112_0 then
				arg_109_1.screenFilterEffect_.weight = 0
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_20 = 4
			local var_112_21 = 0.575

			if 4 < arg_109_1.time_ and arg_109_1.time_ <= var_112_20 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_22 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_22:setOnUpdate(LuaHelper.FloatAction(function(arg_113_0)
					arg_109_1.dialogCg_.alpha = arg_113_0
				end))
				var_112_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_23 = arg_109_1:GetWordFromCfg(319251025)
				local var_112_24 = arg_109_1:FormatText(var_112_23.content)

				arg_109_1.text_.text = var_112_24

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_26 = 23 <= 0 and var_112_21 or var_112_21 * (utf8.len(var_112_24) / 23)

				if (23 <= 0 and var_112_21 or var_112_21 * (utf8.len(var_112_24) / 23)) > 0 and var_112_21 < var_112_26 then
					arg_109_1.talkMaxDuration = var_112_26
					var_112_20 = var_112_20 + 0.3

					if var_112_26 + var_112_20 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_26 + var_112_20
					end
				end

				arg_109_1.text_.text = var_112_24
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251025", "story_v_out_319251.awb") ~= 0 then
					local var_112_27 = manager.audio:GetVoiceLength("story_v_out_319251", "319251025", "story_v_out_319251.awb") / 1000

					if var_112_27 + var_112_20 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_27 + var_112_20
					end

					if var_112_23.prefab_name ~= "" and arg_109_1.actors_[var_112_23.prefab_name] ~= nil then
						local var_112_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_23.prefab_name].transform, "story_v_out_319251", "319251025", "story_v_out_319251.awb")

						arg_109_1:RecordAudio("319251025", var_112_28)
						arg_109_1:RecordAudio("319251025", var_112_28)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_319251", "319251025", "story_v_out_319251.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_319251", "319251025", "story_v_out_319251.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_29 = var_112_20 + 0.3
			local var_112_30 = math.max(var_112_21, arg_109_1.talkMaxDuration)

			if var_112_20 + 0.3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_29 + var_112_30 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_29) / var_112_30

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_29 + var_112_30 and arg_109_1.time_ < var_112_29 + var_112_30 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play319251026 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 319251026
		arg_115_1.duration_ = 6.73

		local var_115_0 = {
			zh = 6.733,
			ja = 4.6
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
				arg_115_0:Play319251027(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_118_0 = 0
			local var_118_1 = 0.725

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_2 = arg_115_1:GetWordFromCfg(319251026)
				local var_118_3 = arg_115_1:FormatText(var_118_2.content)

				arg_115_1.text_.text = var_118_3

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 29 <= 0 and var_118_1 or var_118_1 * (utf8.len(var_118_3) / 29)

				if (29 <= 0 and var_118_1 or var_118_1 * (utf8.len(var_118_3) / 29)) > 0 and var_118_1 < var_118_5 then
					arg_115_1.talkMaxDuration = var_118_5

					if var_118_5 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_3
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251026", "story_v_out_319251.awb") ~= 0 then
					local var_118_6 = manager.audio:GetVoiceLength("story_v_out_319251", "319251026", "story_v_out_319251.awb") / 1000

					if var_118_6 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_6 + var_118_0
					end

					if var_118_2.prefab_name ~= "" and arg_115_1.actors_[var_118_2.prefab_name] ~= nil then
						local var_118_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_2.prefab_name].transform, "story_v_out_319251", "319251026", "story_v_out_319251.awb")

						arg_115_1:RecordAudio("319251026", var_118_7)
						arg_115_1:RecordAudio("319251026", var_118_7)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_319251", "319251026", "story_v_out_319251.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_319251", "319251026", "story_v_out_319251.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_8 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_8 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_8

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_8 and arg_115_1.time_ < var_118_0 + var_118_8 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play319251027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 319251027
		arg_119_1.duration_ = 2.23

		local var_119_0 = {
			zh = 1.999999999999,
			ja = 2.233
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
				arg_119_0:Play319251028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10079ui_story = arg_119_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10079ui_story"].transform.position).z)
				arg_119_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["10079ui_story"].transform.localEulerAngles = arg_119_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_119_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10079ui_story"].transform.position).z)
				arg_119_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["10079ui_story"].transform.localEulerAngles = arg_119_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["10079ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect10079ui_story == nil then
				arg_119_1.var_.characterEffect10079ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect10079ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect10079ui_story then
				arg_119_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_122_4 = arg_119_1.actors_["10075ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10075ui_story = var_122_4.localPosition
			end

			local var_122_5 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_5 then
				var_122_4.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 0) / var_122_5)
				var_122_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_4.position).x, (manager.ui.mainCamera.transform.position - var_122_4.position).y, (manager.ui.mainCamera.transform.position - var_122_4.position).z)
				var_122_4.localEulerAngles.z = 0
				var_122_4.localEulerAngles.x = 0
				var_122_4.localEulerAngles = var_122_4.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_5 and arg_119_1.time_ < 0 + var_122_5 + arg_122_0 then
				var_122_4.localPosition = Vector3.New(0, 100, 0)
				var_122_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_4.position).x, (manager.ui.mainCamera.transform.position - var_122_4.position).y, (manager.ui.mainCamera.transform.position - var_122_4.position).z)
				var_122_4.localEulerAngles.z = 0
				var_122_4.localEulerAngles.x = 0
				var_122_4.localEulerAngles = var_122_4.localEulerAngles
			end

			local var_122_6 = arg_119_1.actors_["10075ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect10075ui_story == nil then
				arg_119_1.var_.characterEffect10075ui_story = var_122_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_7 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_7 and not isNil(var_122_6) then
				if arg_119_1.var_.characterEffect10075ui_story and not isNil(var_122_6) then
					arg_119_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_7)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_7 and arg_119_1.time_ < 0 + var_122_7 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect10075ui_story then
				arg_119_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_122_8 = 0
			local var_122_9 = 0.175

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				arg_119_1.dialog_:SetActive(true)

				arg_119_1.dialogCg_.alpha = 0

				local var_122_10 = LeanTween.value(arg_119_1.dialog_, 0, 1, 0.3)

				var_122_10:setOnUpdate(LuaHelper.FloatAction(function(arg_123_0)
					arg_119_1.dialogCg_.alpha = arg_123_0
				end))
				var_122_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_119_1.dialog_)
					var_122_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_119_1.duration_ = arg_119_1.duration_ + 0.3

				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_11 = arg_119_1:GetWordFromCfg(319251027)
				local var_122_12 = arg_119_1:FormatText(var_122_11.content)

				arg_119_1.text_.text = var_122_12

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_14 = 7 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_12) / 7)

				if (7 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_12) / 7)) > 0 and var_122_9 < var_122_14 then
					arg_119_1.talkMaxDuration = var_122_14
					var_122_8 = var_122_8 + 0.3

					if var_122_14 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_14 + var_122_8
					end
				end

				arg_119_1.text_.text = var_122_12
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251027", "story_v_out_319251.awb") ~= 0 then
					local var_122_15 = manager.audio:GetVoiceLength("story_v_out_319251", "319251027", "story_v_out_319251.awb") / 1000

					if var_122_15 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_15 + var_122_8
					end

					if var_122_11.prefab_name ~= "" and arg_119_1.actors_[var_122_11.prefab_name] ~= nil then
						local var_122_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_11.prefab_name].transform, "story_v_out_319251", "319251027", "story_v_out_319251.awb")

						arg_119_1:RecordAudio("319251027", var_122_16)
						arg_119_1:RecordAudio("319251027", var_122_16)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_319251", "319251027", "story_v_out_319251.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_319251", "319251027", "story_v_out_319251.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_17 = var_122_8 + 0.3
			local var_122_18 = math.max(var_122_9, arg_119_1.talkMaxDuration)

			if var_122_8 + 0.3 <= arg_119_1.time_ and arg_119_1.time_ < var_122_17 + var_122_18 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_17) / var_122_18

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_17 + var_122_18 and arg_119_1.time_ < var_122_17 + var_122_18 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
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
	Play319251028 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 319251028
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play319251029(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["10079ui_story"]) and arg_125_1.var_.characterEffect10079ui_story == nil then
				arg_125_1.var_.characterEffect10079ui_story = arg_125_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["10079ui_story"]) then
				if arg_125_1.var_.characterEffect10079ui_story and not isNil(arg_125_1.actors_["10079ui_story"]) then
					arg_125_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_0)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["10079ui_story"]) and arg_125_1.var_.characterEffect10079ui_story then
				arg_125_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_128_1 = 0
			local var_128_2 = 1.1

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(319251028).content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 44 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 44)

				if (44 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 44)) > 0 and var_128_2 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_1 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_1
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_6 = math.max(var_128_2, arg_125_1.talkMaxDuration)

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_6 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_1) / var_128_6

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_1 + var_128_6 and arg_125_1.time_ < var_128_1 + var_128_6 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play319251029 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 319251029
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play319251030(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if arg_129_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_132_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_129_1.stage_.transform)

				var_132_0.name = "1095ui_story"
				var_132_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.actors_["1095ui_story"] = var_132_0

				local var_132_1 = var_132_0:GetComponentInChildren(typeof(CharacterEffect))

				var_132_1.enabled = true

				local var_132_2 = GameObjectTools.GetOrAddComponent(var_132_0, typeof(DynamicBoneHelper))

				if var_132_2 then
					var_132_2:EnableDynamicBone(false)
				end

				arg_129_1:ShowWeapon(var_132_1.transform, false)

				arg_129_1.var_["1095ui_story" .. "Animator"] = var_132_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_129_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_129_1.var_["1095ui_story" .. "LipSync"] = var_132_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_132_3 = arg_129_1.actors_["1095ui_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1095ui_story = var_132_3.localPosition
			end

			local var_132_4 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				var_132_3.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_129_1.time_ - 0) / var_132_4)
				var_132_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_3.position).x, (manager.ui.mainCamera.transform.position - var_132_3.position).y, (manager.ui.mainCamera.transform.position - var_132_3.position).z)
				var_132_3.localEulerAngles.z = 0
				var_132_3.localEulerAngles.x = 0
				var_132_3.localEulerAngles = var_132_3.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				var_132_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_132_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_3.position).x, (manager.ui.mainCamera.transform.position - var_132_3.position).y, (manager.ui.mainCamera.transform.position - var_132_3.position).z)
				var_132_3.localEulerAngles.z = 0
				var_132_3.localEulerAngles.x = 0
				var_132_3.localEulerAngles = var_132_3.localEulerAngles
			end

			local var_132_5 = arg_129_1.actors_["1095ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.characterEffect1095ui_story == nil then
				arg_129_1.var_.characterEffect1095ui_story = var_132_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_6 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_6 and not isNil(var_132_5) then
				if arg_129_1.var_.characterEffect1095ui_story and not isNil(var_132_5) then
					arg_129_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_6 and arg_129_1.time_ < 0 + var_132_6 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.characterEffect1095ui_story then
				arg_129_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_132_8 = arg_129_1.actors_["10079ui_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10079ui_story = var_132_8.localPosition
			end

			local var_132_9 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_9 then
				var_132_8.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 0) / var_132_9)
				var_132_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_8.position).x, (manager.ui.mainCamera.transform.position - var_132_8.position).y, (manager.ui.mainCamera.transform.position - var_132_8.position).z)
				var_132_8.localEulerAngles.z = 0
				var_132_8.localEulerAngles.x = 0
				var_132_8.localEulerAngles = var_132_8.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_9 and arg_129_1.time_ < 0 + var_132_9 + arg_132_0 then
				var_132_8.localPosition = Vector3.New(0, 100, 0)
				var_132_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_8.position).x, (manager.ui.mainCamera.transform.position - var_132_8.position).y, (manager.ui.mainCamera.transform.position - var_132_8.position).z)
				var_132_8.localEulerAngles.z = 0
				var_132_8.localEulerAngles.x = 0
				var_132_8.localEulerAngles = var_132_8.localEulerAngles
			end

			local var_132_10 = arg_129_1.actors_["10079ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_10) and arg_129_1.var_.characterEffect10079ui_story == nil then
				arg_129_1.var_.characterEffect10079ui_story = var_132_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_11 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_11 and not isNil(var_132_10) then
				if arg_129_1.var_.characterEffect10079ui_story and not isNil(var_132_10) then
					arg_129_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_11)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_11 and arg_129_1.time_ < 0 + var_132_11 + arg_132_0 and not isNil(var_132_10) and arg_129_1.var_.characterEffect10079ui_story then
				arg_129_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_132_12 = arg_129_1.actors_["10075ui_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10075ui_story = var_132_12.localPosition
			end

			local var_132_13 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_13 then
				var_132_12.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 0) / var_132_13)
				var_132_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_12.position).x, (manager.ui.mainCamera.transform.position - var_132_12.position).y, (manager.ui.mainCamera.transform.position - var_132_12.position).z)
				var_132_12.localEulerAngles.z = 0
				var_132_12.localEulerAngles.x = 0
				var_132_12.localEulerAngles = var_132_12.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_13 and arg_129_1.time_ < 0 + var_132_13 + arg_132_0 then
				var_132_12.localPosition = Vector3.New(0, 100, 0)
				var_132_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_12.position).x, (manager.ui.mainCamera.transform.position - var_132_12.position).y, (manager.ui.mainCamera.transform.position - var_132_12.position).z)
				var_132_12.localEulerAngles.z = 0
				var_132_12.localEulerAngles.x = 0
				var_132_12.localEulerAngles = var_132_12.localEulerAngles
			end

			local var_132_14 = arg_129_1.actors_["10075ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_14) and arg_129_1.var_.characterEffect10075ui_story == nil then
				arg_129_1.var_.characterEffect10075ui_story = var_132_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_15 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_15 and not isNil(var_132_14) then
				if arg_129_1.var_.characterEffect10075ui_story and not isNil(var_132_14) then
					arg_129_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_15)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_15 and arg_129_1.time_ < 0 + var_132_15 + arg_132_0 and not isNil(var_132_14) and arg_129_1.var_.characterEffect10075ui_story then
				arg_129_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				if arg_129_1.var_.characterEffect1095ui_story == nil then
					arg_129_1.var_.characterEffect1095ui_story = arg_129_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_132_16 = arg_129_1.var_.characterEffect1095ui_story

				arg_129_1.var_.characterEffect1095ui_story.imageEffect:turnOff()

				var_132_16.interferenceEffect.enabled = true
				var_132_16.interferenceEffect.noise = 0.01
				var_132_16.interferenceEffect.simTimeScale = 1
				var_132_16.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				if arg_129_1.var_.characterEffect1095ui_story == nil then
					arg_129_1.var_.characterEffect1095ui_story = arg_129_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_129_1.var_.characterEffect1095ui_story.imageEffect:turnOn(false)
			end

			local var_132_18 = 0
			local var_132_19 = 0.225

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_18 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_20 = arg_129_1:GetWordFromCfg(319251029)
				local var_132_21 = arg_129_1:FormatText(var_132_20.content)

				arg_129_1.text_.text = var_132_21

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_23 = 9 <= 0 and var_132_19 or var_132_19 * (utf8.len(var_132_21) / 9)

				if (9 <= 0 and var_132_19 or var_132_19 * (utf8.len(var_132_21) / 9)) > 0 and var_132_19 < var_132_23 then
					arg_129_1.talkMaxDuration = var_132_23

					if var_132_23 + var_132_18 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_23 + var_132_18
					end
				end

				arg_129_1.text_.text = var_132_21
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251029", "story_v_out_319251.awb") ~= 0 then
					local var_132_24 = manager.audio:GetVoiceLength("story_v_out_319251", "319251029", "story_v_out_319251.awb") / 1000

					if var_132_24 + var_132_18 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_24 + var_132_18
					end

					if var_132_20.prefab_name ~= "" and arg_129_1.actors_[var_132_20.prefab_name] ~= nil then
						local var_132_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_20.prefab_name].transform, "story_v_out_319251", "319251029", "story_v_out_319251.awb")

						arg_129_1:RecordAudio("319251029", var_132_25)
						arg_129_1:RecordAudio("319251029", var_132_25)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_319251", "319251029", "story_v_out_319251.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_319251", "319251029", "story_v_out_319251.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_26 = math.max(var_132_19, arg_129_1.talkMaxDuration)

			if var_132_18 <= arg_129_1.time_ and arg_129_1.time_ < var_132_18 + var_132_26 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_18) / var_132_26

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_18 + var_132_26 and arg_129_1.time_ < var_132_18 + var_132_26 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
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
	Play319251030 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 319251030
		arg_133_1.duration_ = 5.9

		local var_133_0 = {
			zh = 4.7,
			ja = 5.9
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
				arg_133_0:Play319251031(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10079ui_story = arg_133_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10079ui_story"].transform.position).z)
				arg_133_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["10079ui_story"].transform.localEulerAngles = arg_133_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_133_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10079ui_story"].transform.position).z)
				arg_133_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["10079ui_story"].transform.localEulerAngles = arg_133_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["10079ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect10079ui_story == nil then
				arg_133_1.var_.characterEffect10079ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect10079ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect10079ui_story then
				arg_133_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_136_4 = arg_133_1.actors_["1095ui_story"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1095ui_story = var_136_4.localPosition
			end

			local var_136_5 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_5 then
				var_136_4.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_133_1.time_ - 0) / var_136_5)
				var_136_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_4.position).x, (manager.ui.mainCamera.transform.position - var_136_4.position).y, (manager.ui.mainCamera.transform.position - var_136_4.position).z)
				var_136_4.localEulerAngles.z = 0
				var_136_4.localEulerAngles.x = 0
				var_136_4.localEulerAngles = var_136_4.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_5 and arg_133_1.time_ < 0 + var_136_5 + arg_136_0 then
				var_136_4.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				var_136_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_4.position).x, (manager.ui.mainCamera.transform.position - var_136_4.position).y, (manager.ui.mainCamera.transform.position - var_136_4.position).z)
				var_136_4.localEulerAngles.z = 0
				var_136_4.localEulerAngles.x = 0
				var_136_4.localEulerAngles = var_136_4.localEulerAngles
			end

			local var_136_6 = arg_133_1.actors_["1095ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_6) and arg_133_1.var_.characterEffect1095ui_story == nil then
				arg_133_1.var_.characterEffect1095ui_story = var_136_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_7 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 and not isNil(var_136_6) then
				if arg_133_1.var_.characterEffect1095ui_story and not isNil(var_136_6) then
					arg_133_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_7)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 and not isNil(var_136_6) and arg_133_1.var_.characterEffect1095ui_story then
				arg_133_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_136_8 = 0
			local var_136_9 = 0.575

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_10 = arg_133_1:GetWordFromCfg(319251030)
				local var_136_11 = arg_133_1:FormatText(var_136_10.content)

				arg_133_1.text_.text = var_136_11

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_13 = 23 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 23)

				if (23 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 23)) > 0 and var_136_9 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_8
					end
				end

				arg_133_1.text_.text = var_136_11
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251030", "story_v_out_319251.awb") ~= 0 then
					local var_136_14 = manager.audio:GetVoiceLength("story_v_out_319251", "319251030", "story_v_out_319251.awb") / 1000

					if var_136_14 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_8
					end

					if var_136_10.prefab_name ~= "" and arg_133_1.actors_[var_136_10.prefab_name] ~= nil then
						local var_136_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_10.prefab_name].transform, "story_v_out_319251", "319251030", "story_v_out_319251.awb")

						arg_133_1:RecordAudio("319251030", var_136_15)
						arg_133_1:RecordAudio("319251030", var_136_15)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_319251", "319251030", "story_v_out_319251.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_319251", "319251030", "story_v_out_319251.awb")
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
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319251031 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 319251031
		arg_137_1.duration_ = 1.6

		local var_137_0 = {
			zh = 1.6,
			ja = 1.5
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
				arg_137_0:Play319251032(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["10079ui_story"]) and arg_137_1.var_.characterEffect10079ui_story == nil then
				arg_137_1.var_.characterEffect10079ui_story = arg_137_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["10079ui_story"]) then
				if arg_137_1.var_.characterEffect10079ui_story and not isNil(arg_137_1.actors_["10079ui_story"]) then
					arg_137_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["10079ui_story"]) and arg_137_1.var_.characterEffect10079ui_story then
				arg_137_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_140_1 = arg_137_1.actors_["1095ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1095ui_story == nil then
				arg_137_1.var_.characterEffect1095ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect1095ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1095ui_story then
				arg_137_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_140_4 = 0
			local var_140_5 = 0.175

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:GetWordFromCfg(319251031)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 7 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 7)

				if (7 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 7)) > 0 and var_140_5 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251031", "story_v_out_319251.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_out_319251", "319251031", "story_v_out_319251.awb") / 1000

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end

					if var_140_6.prefab_name ~= "" and arg_137_1.actors_[var_140_6.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_6.prefab_name].transform, "story_v_out_319251", "319251031", "story_v_out_319251.awb")

						arg_137_1:RecordAudio("319251031", var_140_11)
						arg_137_1:RecordAudio("319251031", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_319251", "319251031", "story_v_out_319251.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_319251", "319251031", "story_v_out_319251.awb")
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
	Play319251032 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 319251032
		arg_141_1.duration_ = 7.03

		local var_141_0 = {
			zh = 2.566,
			ja = 7.033
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
				arg_141_0:Play319251033(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_144_0 = arg_141_1.actors_["10079ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10079ui_story == nil then
				arg_141_1.var_.characterEffect10079ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_1 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 and not isNil(var_144_0) then
				if arg_141_1.var_.characterEffect10079ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10079ui_story then
				arg_141_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_144_3 = arg_141_1.actors_["1095ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_3) and arg_141_1.var_.characterEffect1095ui_story == nil then
				arg_141_1.var_.characterEffect1095ui_story = var_144_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_4 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 and not isNil(var_144_3) then
				if arg_141_1.var_.characterEffect1095ui_story and not isNil(var_144_3) then
					arg_141_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_4)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 and not isNil(var_144_3) and arg_141_1.var_.characterEffect1095ui_story then
				arg_141_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_144_5 = 0
			local var_144_6 = 0.3

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_7 = arg_141_1:GetWordFromCfg(319251032)
				local var_144_8 = arg_141_1:FormatText(var_144_7.content)

				arg_141_1.text_.text = var_144_8

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_10 = 12 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 12)

				if (12 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 12)) > 0 and var_144_6 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10

					if var_144_10 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_5
					end
				end

				arg_141_1.text_.text = var_144_8
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251032", "story_v_out_319251.awb") ~= 0 then
					local var_144_11 = manager.audio:GetVoiceLength("story_v_out_319251", "319251032", "story_v_out_319251.awb") / 1000

					if var_144_11 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_5
					end

					if var_144_7.prefab_name ~= "" and arg_141_1.actors_[var_144_7.prefab_name] ~= nil then
						local var_144_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_7.prefab_name].transform, "story_v_out_319251", "319251032", "story_v_out_319251.awb")

						arg_141_1:RecordAudio("319251032", var_144_12)
						arg_141_1:RecordAudio("319251032", var_144_12)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_319251", "319251032", "story_v_out_319251.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_319251", "319251032", "story_v_out_319251.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_13 = math.max(var_144_6, arg_141_1.talkMaxDuration)

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_13 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_5) / var_144_13

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_5 + var_144_13 and arg_141_1.time_ < var_144_5 + var_144_13 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play319251033 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 319251033
		arg_145_1.duration_ = 3.33

		local var_145_0 = {
			zh = 1.333,
			ja = 3.333
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
				arg_145_0:Play319251034(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1095ui_story = arg_145_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1095ui_story"].transform.position).z)
				arg_145_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1095ui_story"].transform.localEulerAngles = arg_145_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_145_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1095ui_story"].transform.position).z)
				arg_145_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1095ui_story"].transform.localEulerAngles = arg_145_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["1095ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1095ui_story == nil then
				arg_145_1.var_.characterEffect1095ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect1095ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1095ui_story then
				arg_145_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_148_4 = arg_145_1.actors_["10079ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect10079ui_story == nil then
				arg_145_1.var_.characterEffect10079ui_story = var_148_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_5 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_5 and not isNil(var_148_4) then
				if arg_145_1.var_.characterEffect10079ui_story and not isNil(var_148_4) then
					arg_145_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_5)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_5 and arg_145_1.time_ < 0 + var_148_5 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect10079ui_story then
				arg_145_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_148_6 = 0
			local var_148_7 = 0.2

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_8 = arg_145_1:GetWordFromCfg(319251033)
				local var_148_9 = arg_145_1:FormatText(var_148_8.content)

				arg_145_1.text_.text = var_148_9

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_11 = 8 <= 0 and var_148_7 or var_148_7 * (utf8.len(var_148_9) / 8)

				if (8 <= 0 and var_148_7 or var_148_7 * (utf8.len(var_148_9) / 8)) > 0 and var_148_7 < var_148_11 then
					arg_145_1.talkMaxDuration = var_148_11

					if var_148_11 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_11 + var_148_6
					end
				end

				arg_145_1.text_.text = var_148_9
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251033", "story_v_out_319251.awb") ~= 0 then
					local var_148_12 = manager.audio:GetVoiceLength("story_v_out_319251", "319251033", "story_v_out_319251.awb") / 1000

					if var_148_12 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_12 + var_148_6
					end

					if var_148_8.prefab_name ~= "" and arg_145_1.actors_[var_148_8.prefab_name] ~= nil then
						local var_148_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_8.prefab_name].transform, "story_v_out_319251", "319251033", "story_v_out_319251.awb")

						arg_145_1:RecordAudio("319251033", var_148_13)
						arg_145_1:RecordAudio("319251033", var_148_13)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_319251", "319251033", "story_v_out_319251.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_319251", "319251033", "story_v_out_319251.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_14 = math.max(var_148_7, arg_145_1.talkMaxDuration)

			if var_148_6 <= arg_145_1.time_ and arg_145_1.time_ < var_148_6 + var_148_14 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_6) / var_148_14

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_6 + var_148_14 and arg_145_1.time_ < var_148_6 + var_148_14 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play319251034 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 319251034
		arg_149_1.duration_ = 10.53

		local var_149_0 = {
			zh = 10.533,
			ja = 4.633
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
				arg_149_0:Play319251035(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_152_0 = 0
			local var_152_1 = 1.25

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_2 = arg_149_1:GetWordFromCfg(319251034)
				local var_152_3 = arg_149_1:FormatText(var_152_2.content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 50 <= 0 and var_152_1 or var_152_1 * (utf8.len(var_152_3) / 50)

				if (50 <= 0 and var_152_1 or var_152_1 * (utf8.len(var_152_3) / 50)) > 0 and var_152_1 < var_152_5 then
					arg_149_1.talkMaxDuration = var_152_5

					if var_152_5 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_3
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251034", "story_v_out_319251.awb") ~= 0 then
					local var_152_6 = manager.audio:GetVoiceLength("story_v_out_319251", "319251034", "story_v_out_319251.awb") / 1000

					if var_152_6 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_0
					end

					if var_152_2.prefab_name ~= "" and arg_149_1.actors_[var_152_2.prefab_name] ~= nil then
						local var_152_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_2.prefab_name].transform, "story_v_out_319251", "319251034", "story_v_out_319251.awb")

						arg_149_1:RecordAudio("319251034", var_152_7)
						arg_149_1:RecordAudio("319251034", var_152_7)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_319251", "319251034", "story_v_out_319251.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_319251", "319251034", "story_v_out_319251.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_8 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_8 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_8

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_8 and arg_149_1.time_ < var_152_0 + var_152_8 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play319251035 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 319251035
		arg_153_1.duration_ = 9.27

		local var_153_0 = {
			zh = 7.766,
			ja = 9.266
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
				arg_153_0:Play319251036(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 1

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(319251035)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 40 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 40)

				if (40 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 40)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251035", "story_v_out_319251.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_319251", "319251035", "story_v_out_319251.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_319251", "319251035", "story_v_out_319251.awb")

						arg_153_1:RecordAudio("319251035", var_156_6)
						arg_153_1:RecordAudio("319251035", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_319251", "319251035", "story_v_out_319251.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_319251", "319251035", "story_v_out_319251.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play319251036 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 319251036
		arg_157_1.duration_ = 5.7

		local var_157_0 = {
			zh = 3,
			ja = 5.7
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
				arg_157_0:Play319251037(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10079ui_story = arg_157_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10079ui_story"].transform.position).z)
				arg_157_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["10079ui_story"].transform.localEulerAngles = arg_157_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_157_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10079ui_story"].transform.position).z)
				arg_157_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["10079ui_story"].transform.localEulerAngles = arg_157_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["10079ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect10079ui_story == nil then
				arg_157_1.var_.characterEffect10079ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect10079ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect10079ui_story then
				arg_157_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_160_4 = arg_157_1.actors_["1095ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect1095ui_story == nil then
				arg_157_1.var_.characterEffect1095ui_story = var_160_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_5 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_5 and not isNil(var_160_4) then
				if arg_157_1.var_.characterEffect1095ui_story and not isNil(var_160_4) then
					arg_157_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_5)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_5 and arg_157_1.time_ < 0 + var_160_5 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect1095ui_story then
				arg_157_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_160_6 = 0
			local var_160_7 = 0.375

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_6 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_8 = arg_157_1:GetWordFromCfg(319251036)
				local var_160_9 = arg_157_1:FormatText(var_160_8.content)

				arg_157_1.text_.text = var_160_9

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_11 = 15 <= 0 and var_160_7 or var_160_7 * (utf8.len(var_160_9) / 15)

				if (15 <= 0 and var_160_7 or var_160_7 * (utf8.len(var_160_9) / 15)) > 0 and var_160_7 < var_160_11 then
					arg_157_1.talkMaxDuration = var_160_11

					if var_160_11 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_11 + var_160_6
					end
				end

				arg_157_1.text_.text = var_160_9
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251036", "story_v_out_319251.awb") ~= 0 then
					local var_160_12 = manager.audio:GetVoiceLength("story_v_out_319251", "319251036", "story_v_out_319251.awb") / 1000

					if var_160_12 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_12 + var_160_6
					end

					if var_160_8.prefab_name ~= "" and arg_157_1.actors_[var_160_8.prefab_name] ~= nil then
						local var_160_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_8.prefab_name].transform, "story_v_out_319251", "319251036", "story_v_out_319251.awb")

						arg_157_1:RecordAudio("319251036", var_160_13)
						arg_157_1:RecordAudio("319251036", var_160_13)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_319251", "319251036", "story_v_out_319251.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_319251", "319251036", "story_v_out_319251.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_14 = math.max(var_160_7, arg_157_1.talkMaxDuration)

			if var_160_6 <= arg_157_1.time_ and arg_157_1.time_ < var_160_6 + var_160_14 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_6) / var_160_14

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_6 + var_160_14 and arg_157_1.time_ < var_160_6 + var_160_14 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319251037 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 319251037
		arg_161_1.duration_ = 8.43

		local var_161_0 = {
			zh = 6.466,
			ja = 8.433
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
				arg_161_0:Play319251038(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.8

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(319251037)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 32 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 32)

				if (32 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 32)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251037", "story_v_out_319251.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_319251", "319251037", "story_v_out_319251.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_319251", "319251037", "story_v_out_319251.awb")

						arg_161_1:RecordAudio("319251037", var_164_6)
						arg_161_1:RecordAudio("319251037", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_319251", "319251037", "story_v_out_319251.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_319251", "319251037", "story_v_out_319251.awb")
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
	Play319251038 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 319251038
		arg_165_1.duration_ = 1.53

		local var_165_0 = {
			zh = 1.2,
			ja = 1.533
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
				arg_165_0:Play319251039(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["10079ui_story"]) and arg_165_1.var_.characterEffect10079ui_story == nil then
				arg_165_1.var_.characterEffect10079ui_story = arg_165_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["10079ui_story"]) then
				if arg_165_1.var_.characterEffect10079ui_story and not isNil(arg_165_1.actors_["10079ui_story"]) then
					arg_165_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["10079ui_story"]) and arg_165_1.var_.characterEffect10079ui_story then
				arg_165_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_168_1 = arg_165_1.actors_["1095ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1095ui_story == nil then
				arg_165_1.var_.characterEffect1095ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1095ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1095ui_story then
				arg_165_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_168_4 = 0
			local var_168_5 = 0.1

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(319251038)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 4 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 4)

				if (4 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 4)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251038", "story_v_out_319251.awb") ~= 0 then
					local var_168_10 = manager.audio:GetVoiceLength("story_v_out_319251", "319251038", "story_v_out_319251.awb") / 1000

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end

					if var_168_6.prefab_name ~= "" and arg_165_1.actors_[var_168_6.prefab_name] ~= nil then
						local var_168_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_6.prefab_name].transform, "story_v_out_319251", "319251038", "story_v_out_319251.awb")

						arg_165_1:RecordAudio("319251038", var_168_11)
						arg_165_1:RecordAudio("319251038", var_168_11)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_319251", "319251038", "story_v_out_319251.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_319251", "319251038", "story_v_out_319251.awb")
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
	Play319251039 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319251039
		arg_169_1.duration_ = 4

		local var_169_0 = {
			zh = 4,
			ja = 1.999999999999
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
				arg_169_0:Play319251040(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action41213")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_172_0 = arg_169_1.actors_["10079ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect10079ui_story == nil then
				arg_169_1.var_.characterEffect10079ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_1 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_1 and not isNil(var_172_0) then
				if arg_169_1.var_.characterEffect10079ui_story and not isNil(var_172_0) then
					arg_169_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_1 and arg_169_1.time_ < 0 + var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect10079ui_story then
				arg_169_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_172_3 = arg_169_1.actors_["1095ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_3) and arg_169_1.var_.characterEffect1095ui_story == nil then
				arg_169_1.var_.characterEffect1095ui_story = var_172_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_4 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 and not isNil(var_172_3) then
				if arg_169_1.var_.characterEffect1095ui_story and not isNil(var_172_3) then
					arg_169_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_4)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 and not isNil(var_172_3) and arg_169_1.var_.characterEffect1095ui_story then
				arg_169_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_172_5 = 0
			local var_172_6 = 0.45

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_7 = arg_169_1:GetWordFromCfg(319251039)
				local var_172_8 = arg_169_1:FormatText(var_172_7.content)

				arg_169_1.text_.text = var_172_8

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_10 = 18 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_8) / 18)

				if (18 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_8) / 18)) > 0 and var_172_6 < var_172_10 then
					arg_169_1.talkMaxDuration = var_172_10

					if var_172_10 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_5
					end
				end

				arg_169_1.text_.text = var_172_8
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251039", "story_v_out_319251.awb") ~= 0 then
					local var_172_11 = manager.audio:GetVoiceLength("story_v_out_319251", "319251039", "story_v_out_319251.awb") / 1000

					if var_172_11 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_11 + var_172_5
					end

					if var_172_7.prefab_name ~= "" and arg_169_1.actors_[var_172_7.prefab_name] ~= nil then
						local var_172_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_7.prefab_name].transform, "story_v_out_319251", "319251039", "story_v_out_319251.awb")

						arg_169_1:RecordAudio("319251039", var_172_12)
						arg_169_1:RecordAudio("319251039", var_172_12)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_319251", "319251039", "story_v_out_319251.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_319251", "319251039", "story_v_out_319251.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_13 = math.max(var_172_6, arg_169_1.talkMaxDuration)

			if var_172_5 <= arg_169_1.time_ and arg_169_1.time_ < var_172_5 + var_172_13 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_5) / var_172_13

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_5 + var_172_13 and arg_169_1.time_ < var_172_5 + var_172_13 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play319251040 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 319251040
		arg_173_1.duration_ = 3.53

		local var_173_0 = {
			zh = 2,
			ja = 3.533
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
				arg_173_0:Play319251041(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1095ui_story = arg_173_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1095ui_story"].transform.position).z)
				arg_173_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1095ui_story"].transform.localEulerAngles = arg_173_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_173_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1095ui_story"].transform.position).z)
				arg_173_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1095ui_story"].transform.localEulerAngles = arg_173_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1095ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1095ui_story == nil then
				arg_173_1.var_.characterEffect1095ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1095ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1095ui_story then
				arg_173_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_4 = arg_173_1.actors_["10079ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect10079ui_story == nil then
				arg_173_1.var_.characterEffect10079ui_story = var_176_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_5 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_5 and not isNil(var_176_4) then
				if arg_173_1.var_.characterEffect10079ui_story and not isNil(var_176_4) then
					arg_173_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_5)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_5 and arg_173_1.time_ < 0 + var_176_5 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect10079ui_story then
				arg_173_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_176_6 = 0
			local var_176_7 = 0.175

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_8 = arg_173_1:GetWordFromCfg(319251040)
				local var_176_9 = arg_173_1:FormatText(var_176_8.content)

				arg_173_1.text_.text = var_176_9

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 7 <= 0 and var_176_7 or var_176_7 * (utf8.len(var_176_9) / 7)

				if (7 <= 0 and var_176_7 or var_176_7 * (utf8.len(var_176_9) / 7)) > 0 and var_176_7 < var_176_11 then
					arg_173_1.talkMaxDuration = var_176_11

					if var_176_11 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_11 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_9
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251040", "story_v_out_319251.awb") ~= 0 then
					local var_176_12 = manager.audio:GetVoiceLength("story_v_out_319251", "319251040", "story_v_out_319251.awb") / 1000

					if var_176_12 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_12 + var_176_6
					end

					if var_176_8.prefab_name ~= "" and arg_173_1.actors_[var_176_8.prefab_name] ~= nil then
						local var_176_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_8.prefab_name].transform, "story_v_out_319251", "319251040", "story_v_out_319251.awb")

						arg_173_1:RecordAudio("319251040", var_176_13)
						arg_173_1:RecordAudio("319251040", var_176_13)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_319251", "319251040", "story_v_out_319251.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_319251", "319251040", "story_v_out_319251.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_14 = math.max(var_176_7, arg_173_1.talkMaxDuration)

			if var_176_6 <= arg_173_1.time_ and arg_173_1.time_ < var_176_6 + var_176_14 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_6) / var_176_14

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_6 + var_176_14 and arg_173_1.time_ < var_176_6 + var_176_14 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319251041 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 319251041
		arg_177_1.duration_ = 1

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play319251042(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10079ui_story = arg_177_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10079ui_story"].transform.position).z)
				arg_177_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["10079ui_story"].transform.localEulerAngles = arg_177_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_177_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10079ui_story"].transform.position).z)
				arg_177_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["10079ui_story"].transform.localEulerAngles = arg_177_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["10079ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect10079ui_story == nil then
				arg_177_1.var_.characterEffect10079ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect10079ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect10079ui_story then
				arg_177_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_180_4 = arg_177_1.actors_["1095ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect1095ui_story == nil then
				arg_177_1.var_.characterEffect1095ui_story = var_180_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_5 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_5 and not isNil(var_180_4) then
				if arg_177_1.var_.characterEffect1095ui_story and not isNil(var_180_4) then
					arg_177_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_5)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_5 and arg_177_1.time_ < 0 + var_180_5 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect1095ui_story then
				arg_177_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_180_6 = 0
			local var_180_7 = 0.075

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_8 = arg_177_1:GetWordFromCfg(319251041)
				local var_180_9 = arg_177_1:FormatText(var_180_8.content)

				arg_177_1.text_.text = var_180_9

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_11 = 3 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_9) / 3)

				if (3 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_9) / 3)) > 0 and var_180_7 < var_180_11 then
					arg_177_1.talkMaxDuration = var_180_11

					if var_180_11 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_11 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_9
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251041", "story_v_out_319251.awb") ~= 0 then
					local var_180_12 = manager.audio:GetVoiceLength("story_v_out_319251", "319251041", "story_v_out_319251.awb") / 1000

					if var_180_12 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_12 + var_180_6
					end

					if var_180_8.prefab_name ~= "" and arg_177_1.actors_[var_180_8.prefab_name] ~= nil then
						local var_180_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_8.prefab_name].transform, "story_v_out_319251", "319251041", "story_v_out_319251.awb")

						arg_177_1:RecordAudio("319251041", var_180_13)
						arg_177_1:RecordAudio("319251041", var_180_13)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_319251", "319251041", "story_v_out_319251.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_319251", "319251041", "story_v_out_319251.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_14 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_14 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_6) / var_180_14

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_6 + var_180_14 and arg_177_1.time_ < var_180_6 + var_180_14 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319251042 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 319251042
		arg_181_1.duration_ = 8

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play319251043(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 2 < arg_181_1.time_ and arg_181_1.time_ <= 2 + arg_184_0 then
				arg_181_1.var_.moveOldPos10079ui_story = arg_181_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 2 <= arg_181_1.time_ and arg_181_1.time_ < 2 + var_184_0 then
				arg_181_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 2) / var_184_0)
				arg_181_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["10079ui_story"].transform.position).z)
				arg_181_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["10079ui_story"].transform.localEulerAngles = arg_181_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 2 + var_184_0 and arg_181_1.time_ < 2 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_181_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["10079ui_story"].transform.position).z)
				arg_181_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["10079ui_story"].transform.localEulerAngles = arg_181_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["10079ui_story"]

			if 2 < arg_181_1.time_ and arg_181_1.time_ <= 2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect10079ui_story == nil then
				arg_181_1.var_.characterEffect10079ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 2 <= arg_181_1.time_ and arg_181_1.time_ < 2 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect10079ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_181_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 2) / var_184_2)
				end
			end

			if arg_181_1.time_ >= 2 + var_184_2 and arg_181_1.time_ < 2 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect10079ui_story then
				arg_181_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_181_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_184_3 = arg_181_1.actors_["1095ui_story"].transform

			if 2 < arg_181_1.time_ and arg_181_1.time_ <= 2 + arg_184_0 then
				arg_181_1.var_.moveOldPos1095ui_story = var_184_3.localPosition
			end

			local var_184_4 = 0.001

			if 2 <= arg_181_1.time_ and arg_181_1.time_ < 2 + var_184_4 then
				var_184_3.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 2) / var_184_4)
				var_184_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_3.position).x, (manager.ui.mainCamera.transform.position - var_184_3.position).y, (manager.ui.mainCamera.transform.position - var_184_3.position).z)
				var_184_3.localEulerAngles.z = 0
				var_184_3.localEulerAngles.x = 0
				var_184_3.localEulerAngles = var_184_3.localEulerAngles
			end

			if arg_181_1.time_ >= 2 + var_184_4 and arg_181_1.time_ < 2 + var_184_4 + arg_184_0 then
				var_184_3.localPosition = Vector3.New(0, 100, 0)
				var_184_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_3.position).x, (manager.ui.mainCamera.transform.position - var_184_3.position).y, (manager.ui.mainCamera.transform.position - var_184_3.position).z)
				var_184_3.localEulerAngles.z = 0
				var_184_3.localEulerAngles.x = 0
				var_184_3.localEulerAngles = var_184_3.localEulerAngles
			end

			local var_184_5 = arg_181_1.actors_["1095ui_story"]

			if 2 < arg_181_1.time_ and arg_181_1.time_ <= 2 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.characterEffect1095ui_story == nil then
				arg_181_1.var_.characterEffect1095ui_story = var_184_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_6 = 0.200000002980232

			if 2 <= arg_181_1.time_ and arg_181_1.time_ < 2 + var_184_6 and not isNil(var_184_5) then
				if arg_181_1.var_.characterEffect1095ui_story and not isNil(var_184_5) then
					arg_181_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 2) / var_184_6)
				end
			end

			if arg_181_1.time_ >= 2 + var_184_6 and arg_181_1.time_ < 2 + var_184_6 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.characterEffect1095ui_story then
				arg_181_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 2 < arg_181_1.time_ and arg_181_1.time_ <= 2 + arg_184_0 then
				if arg_181_1.var_.characterEffect1095ui_story == nil then
					arg_181_1.var_.characterEffect1095ui_story = arg_181_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_184_7 = arg_181_1.var_.characterEffect1095ui_story

				arg_181_1.var_.characterEffect1095ui_story.imageEffect:turnOff()

				var_184_7.interferenceEffect.enabled = false
				var_184_7.interferenceEffect.noise = 0.01
				var_184_7.interferenceEffect.simTimeScale = 1
				var_184_7.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 2 < arg_181_1.time_ and arg_181_1.time_ <= 2 + arg_184_0 then
				if arg_181_1.var_.characterEffect1095ui_story == nil then
					arg_181_1.var_.characterEffect1095ui_story = arg_181_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_181_1.var_.characterEffect1095ui_story.imageEffect:turnOff()
			end

			if 2 < arg_181_1.time_ and arg_181_1.time_ <= 2 + arg_184_0 then
				local var_184_9 = arg_181_1.bgs_.I11r

				arg_181_1.bgs_.I11r.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_184_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_184_10 = var_184_9:GetComponent("SpriteRenderer")

				if var_184_10 and var_184_10.sprite then
					local var_184_11 = 2 * (var_184_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_184_9.transform.localScale = Vector3.New(var_184_11 / var_184_10.sprite.bounds.size.y < var_184_11 * manager.ui.mainCameraCom_.aspect / var_184_10.sprite.bounds.size.x and var_184_11 * manager.ui.mainCameraCom_.aspect / var_184_10.sprite.bounds.size.x or var_184_11 / var_184_10.sprite.bounds.size.y, var_184_11 / var_184_10.sprite.bounds.size.y < var_184_11 * manager.ui.mainCameraCom_.aspect / var_184_10.sprite.bounds.size.x and var_184_11 * manager.ui.mainCameraCom_.aspect / var_184_10.sprite.bounds.size.x or var_184_11 / var_184_10.sprite.bounds.size.y, 0)
				end

				for iter_184_0, iter_184_1 in pairs(arg_181_1.bgs_) do
					if iter_184_0 ~= "I11r" then
						iter_184_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_184_12 = 0

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_12 + arg_184_0 then
				arg_181_1.mask_.enabled = true
				arg_181_1.mask_.raycastTarget = true

				arg_181_1:SetGaussion(false)
			end

			local var_184_13 = 2

			if var_184_12 <= arg_181_1.time_ and arg_181_1.time_ < var_184_12 + var_184_13 then
				local var_184_14 = Color.New(0, 0, 0)

				var_184_14.a = Mathf.Lerp(0, 1, (arg_181_1.time_ - var_184_12) / var_184_13)
				arg_181_1.mask_.color = var_184_14
			end

			if arg_181_1.time_ >= var_184_12 + var_184_13 and arg_181_1.time_ < var_184_12 + var_184_13 + arg_184_0 then
				local var_184_15 = Color.New(0, 0, 0)

				var_184_15.a = 1
				arg_181_1.mask_.color = var_184_15
			end

			local var_184_16 = 2

			if 2 < arg_181_1.time_ and arg_181_1.time_ <= var_184_16 + arg_184_0 then
				arg_181_1.mask_.enabled = true
				arg_181_1.mask_.raycastTarget = true

				arg_181_1:SetGaussion(false)
			end

			local var_184_17 = 1

			if var_184_16 <= arg_181_1.time_ and arg_181_1.time_ < var_184_16 + var_184_17 then
				local var_184_18 = Color.New(0, 0, 0)

				var_184_18.a = Mathf.Lerp(1, 0, (arg_181_1.time_ - var_184_16) / var_184_17)
				arg_181_1.mask_.color = var_184_18
			end

			if arg_181_1.time_ >= var_184_16 + var_184_17 and arg_181_1.time_ < var_184_16 + var_184_17 + arg_184_0 then
				local var_184_19 = Color.New(0, 0, 0)

				arg_181_1.mask_.enabled = false
				var_184_19.a = 0
				arg_181_1.mask_.color = var_184_19
			end

			if arg_181_1.frameCnt_ <= 1 then
				arg_181_1.dialog_:SetActive(false)
			end

			local var_184_20 = 3
			local var_184_21 = 0.775

			if 3 < arg_181_1.time_ and arg_181_1.time_ <= var_184_20 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0

				arg_181_1.dialog_:SetActive(true)

				arg_181_1.dialogCg_.alpha = 0

				local var_184_22 = LeanTween.value(arg_181_1.dialog_, 0, 1, 0.3)

				var_184_22:setOnUpdate(LuaHelper.FloatAction(function(arg_185_0)
					arg_181_1.dialogCg_.alpha = arg_185_0
				end))
				var_184_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_181_1.dialog_)
					var_184_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_181_1.duration_ = arg_181_1.duration_ + 0.3

				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_23 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(319251042).content)

				arg_181_1.text_.text = var_184_23

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_25 = 31 <= 0 and var_184_21 or var_184_21 * (utf8.len(var_184_23) / 31)

				if (31 <= 0 and var_184_21 or var_184_21 * (utf8.len(var_184_23) / 31)) > 0 and var_184_21 < var_184_25 then
					arg_181_1.talkMaxDuration = var_184_25
					var_184_20 = var_184_20 + 0.3

					if var_184_25 + var_184_20 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_25 + var_184_20
					end
				end

				arg_181_1.text_.text = var_184_23
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_26 = var_184_20 + 0.3
			local var_184_27 = math.max(var_184_21, arg_181_1.talkMaxDuration)

			if var_184_20 + 0.3 <= arg_181_1.time_ and arg_181_1.time_ < var_184_26 + var_184_27 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_26) / var_184_27

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_26 + var_184_27 and arg_181_1.time_ < var_184_26 + var_184_27 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play319251043 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 319251043
		arg_187_1.duration_ = 5.67

		local var_187_0 = {
			zh = 4.666,
			ja = 5.666
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play319251044(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos10079ui_story = arg_187_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10079ui_story"].transform.position).z)
				arg_187_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["10079ui_story"].transform.localEulerAngles = arg_187_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_187_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10079ui_story"].transform.position).z)
				arg_187_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["10079ui_story"].transform.localEulerAngles = arg_187_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_190_1 = arg_187_1.actors_["10079ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect10079ui_story == nil then
				arg_187_1.var_.characterEffect10079ui_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect10079ui_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect10079ui_story then
				arg_187_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_190_4 = 0
			local var_190_5 = 0.6

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_6 = arg_187_1:GetWordFromCfg(319251043)
				local var_190_7 = arg_187_1:FormatText(var_190_6.content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 24 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 24)

				if (24 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 24)) > 0 and var_190_5 < var_190_9 then
					arg_187_1.talkMaxDuration = var_190_9

					if var_190_9 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251043", "story_v_out_319251.awb") ~= 0 then
					local var_190_10 = manager.audio:GetVoiceLength("story_v_out_319251", "319251043", "story_v_out_319251.awb") / 1000

					if var_190_10 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_4
					end

					if var_190_6.prefab_name ~= "" and arg_187_1.actors_[var_190_6.prefab_name] ~= nil then
						local var_190_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_6.prefab_name].transform, "story_v_out_319251", "319251043", "story_v_out_319251.awb")

						arg_187_1:RecordAudio("319251043", var_190_11)
						arg_187_1:RecordAudio("319251043", var_190_11)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_319251", "319251043", "story_v_out_319251.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_319251", "319251043", "story_v_out_319251.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_12 = math.max(var_190_5, arg_187_1.talkMaxDuration)

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_12 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_4) / var_190_12

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_4 + var_190_12 and arg_187_1.time_ < var_190_4 + var_190_12 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play319251044 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 319251044
		arg_191_1.duration_ = 6.63

		local var_191_0 = {
			zh = 1.999999999999,
			ja = 6.633
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play319251045(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10075ui_story = arg_191_1.actors_["10075ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["10075ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10075ui_story, Vector3.New(0.7, -0.715, -6.15), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10075ui_story"].transform.position).z)
				arg_191_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["10075ui_story"].transform.localEulerAngles = arg_191_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["10075ui_story"].transform.localPosition = Vector3.New(0.7, -0.715, -6.15)
				arg_191_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10075ui_story"].transform.position).z)
				arg_191_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["10075ui_story"].transform.localEulerAngles = arg_191_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["10075ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect10075ui_story == nil then
				arg_191_1.var_.characterEffect10075ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect10075ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect10075ui_story then
				arg_191_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_2")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_194_4 = arg_191_1.actors_["10079ui_story"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10079ui_story = var_194_4.localPosition
			end

			local var_194_5 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_5 then
				var_194_4.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_191_1.time_ - 0) / var_194_5)
				var_194_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_4.position).x, (manager.ui.mainCamera.transform.position - var_194_4.position).y, (manager.ui.mainCamera.transform.position - var_194_4.position).z)
				var_194_4.localEulerAngles.z = 0
				var_194_4.localEulerAngles.x = 0
				var_194_4.localEulerAngles = var_194_4.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_5 and arg_191_1.time_ < 0 + var_194_5 + arg_194_0 then
				var_194_4.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_194_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_4.position).x, (manager.ui.mainCamera.transform.position - var_194_4.position).y, (manager.ui.mainCamera.transform.position - var_194_4.position).z)
				var_194_4.localEulerAngles.z = 0
				var_194_4.localEulerAngles.x = 0
				var_194_4.localEulerAngles = var_194_4.localEulerAngles
			end

			local var_194_6 = arg_191_1.actors_["10079ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_6) and arg_191_1.var_.characterEffect10079ui_story == nil then
				arg_191_1.var_.characterEffect10079ui_story = var_194_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_7 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 and not isNil(var_194_6) then
				if arg_191_1.var_.characterEffect10079ui_story and not isNil(var_194_6) then
					arg_191_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_191_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_7)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 and not isNil(var_194_6) and arg_191_1.var_.characterEffect10079ui_story then
				arg_191_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_191_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_194_8 = 0
			local var_194_9 = 0.2

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_8 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_10 = arg_191_1:GetWordFromCfg(319251044)
				local var_194_11 = arg_191_1:FormatText(var_194_10.content)

				arg_191_1.text_.text = var_194_11

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_13 = 8 <= 0 and var_194_9 or var_194_9 * (utf8.len(var_194_11) / 8)

				if (8 <= 0 and var_194_9 or var_194_9 * (utf8.len(var_194_11) / 8)) > 0 and var_194_9 < var_194_13 then
					arg_191_1.talkMaxDuration = var_194_13

					if var_194_13 + var_194_8 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_8
					end
				end

				arg_191_1.text_.text = var_194_11
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251044", "story_v_out_319251.awb") ~= 0 then
					local var_194_14 = manager.audio:GetVoiceLength("story_v_out_319251", "319251044", "story_v_out_319251.awb") / 1000

					if var_194_14 + var_194_8 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_14 + var_194_8
					end

					if var_194_10.prefab_name ~= "" and arg_191_1.actors_[var_194_10.prefab_name] ~= nil then
						local var_194_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_10.prefab_name].transform, "story_v_out_319251", "319251044", "story_v_out_319251.awb")

						arg_191_1:RecordAudio("319251044", var_194_15)
						arg_191_1:RecordAudio("319251044", var_194_15)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_319251", "319251044", "story_v_out_319251.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_319251", "319251044", "story_v_out_319251.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_16 = math.max(var_194_9, arg_191_1.talkMaxDuration)

			if var_194_8 <= arg_191_1.time_ and arg_191_1.time_ < var_194_8 + var_194_16 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_8) / var_194_16

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_8 + var_194_16 and arg_191_1.time_ < var_194_8 + var_194_16 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play319251045 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 319251045
		arg_195_1.duration_ = 5.93

		local var_195_0 = {
			zh = 3.3,
			ja = 5.933
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play319251046(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["10075ui_story"]) and arg_195_1.var_.characterEffect10075ui_story == nil then
				arg_195_1.var_.characterEffect10075ui_story = arg_195_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["10075ui_story"]) then
				if arg_195_1.var_.characterEffect10075ui_story and not isNil(arg_195_1.actors_["10075ui_story"]) then
					arg_195_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["10075ui_story"]) and arg_195_1.var_.characterEffect10075ui_story then
				arg_195_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_198_1 = arg_195_1.actors_["10079ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect10079ui_story == nil then
				arg_195_1.var_.characterEffect10079ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect10079ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect10079ui_story then
				arg_195_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_198_4 = 0
			local var_198_5 = 0.35

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_6 = arg_195_1:GetWordFromCfg(319251045)
				local var_198_7 = arg_195_1:FormatText(var_198_6.content)

				arg_195_1.text_.text = var_198_7

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_9 = 14 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 14)

				if (14 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 14)) > 0 and var_198_5 < var_198_9 then
					arg_195_1.talkMaxDuration = var_198_9

					if var_198_9 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_9 + var_198_4
					end
				end

				arg_195_1.text_.text = var_198_7
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251045", "story_v_out_319251.awb") ~= 0 then
					local var_198_10 = manager.audio:GetVoiceLength("story_v_out_319251", "319251045", "story_v_out_319251.awb") / 1000

					if var_198_10 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_10 + var_198_4
					end

					if var_198_6.prefab_name ~= "" and arg_195_1.actors_[var_198_6.prefab_name] ~= nil then
						local var_198_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_6.prefab_name].transform, "story_v_out_319251", "319251045", "story_v_out_319251.awb")

						arg_195_1:RecordAudio("319251045", var_198_11)
						arg_195_1:RecordAudio("319251045", var_198_11)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_319251", "319251045", "story_v_out_319251.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_319251", "319251045", "story_v_out_319251.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_12 = math.max(var_198_5, arg_195_1.talkMaxDuration)

			if var_198_4 <= arg_195_1.time_ and arg_195_1.time_ < var_198_4 + var_198_12 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_4) / var_198_12

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_4 + var_198_12 and arg_195_1.time_ < var_198_4 + var_198_12 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play319251046 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 319251046
		arg_199_1.duration_ = 7.93

		local var_199_0 = {
			zh = 5.933,
			ja = 7.933
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play319251047(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["10075ui_story"]) and arg_199_1.var_.characterEffect10075ui_story == nil then
				arg_199_1.var_.characterEffect10075ui_story = arg_199_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["10075ui_story"]) then
				if arg_199_1.var_.characterEffect10075ui_story and not isNil(arg_199_1.actors_["10075ui_story"]) then
					arg_199_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["10075ui_story"]) and arg_199_1.var_.characterEffect10075ui_story then
				arg_199_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_202_2 = arg_199_1.actors_["10079ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.characterEffect10079ui_story == nil then
				arg_199_1.var_.characterEffect10079ui_story = var_202_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_3 = 0.2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_3 and not isNil(var_202_2) then
				if arg_199_1.var_.characterEffect10079ui_story and not isNil(var_202_2) then
					arg_199_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_199_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_3)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_3 and arg_199_1.time_ < 0 + var_202_3 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.characterEffect10079ui_story then
				arg_199_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_199_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action5_1")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_202_4 = 0
			local var_202_5 = 0.675

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_6 = arg_199_1:GetWordFromCfg(319251046)
				local var_202_7 = arg_199_1:FormatText(var_202_6.content)

				arg_199_1.text_.text = var_202_7

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 27 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 27)

				if (27 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 27)) > 0 and var_202_5 < var_202_9 then
					arg_199_1.talkMaxDuration = var_202_9

					if var_202_9 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_7
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251046", "story_v_out_319251.awb") ~= 0 then
					local var_202_10 = manager.audio:GetVoiceLength("story_v_out_319251", "319251046", "story_v_out_319251.awb") / 1000

					if var_202_10 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_4
					end

					if var_202_6.prefab_name ~= "" and arg_199_1.actors_[var_202_6.prefab_name] ~= nil then
						local var_202_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_6.prefab_name].transform, "story_v_out_319251", "319251046", "story_v_out_319251.awb")

						arg_199_1:RecordAudio("319251046", var_202_11)
						arg_199_1:RecordAudio("319251046", var_202_11)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_319251", "319251046", "story_v_out_319251.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_319251", "319251046", "story_v_out_319251.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_12 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_12 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_12

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_12 and arg_199_1.time_ < var_202_4 + var_202_12 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play319251047 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 319251047
		arg_203_1.duration_ = 8.13

		local var_203_0 = {
			zh = 2.8,
			ja = 8.133
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play319251048(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos10079ui_story = arg_203_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10079ui_story"].transform.position).z)
				arg_203_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["10079ui_story"].transform.localEulerAngles = arg_203_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_203_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10079ui_story"].transform.position).z)
				arg_203_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["10079ui_story"].transform.localEulerAngles = arg_203_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["10079ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect10079ui_story == nil then
				arg_203_1.var_.characterEffect10079ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect10079ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect10079ui_story then
				arg_203_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4127")
			end

			local var_206_4 = arg_203_1.actors_["10075ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect10075ui_story == nil then
				arg_203_1.var_.characterEffect10075ui_story = var_206_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_5 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_5 and not isNil(var_206_4) then
				if arg_203_1.var_.characterEffect10075ui_story and not isNil(var_206_4) then
					arg_203_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_203_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_5)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_5 and arg_203_1.time_ < 0 + var_206_5 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect10075ui_story then
				arg_203_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_203_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_206_6 = 0
			local var_206_7 = 0.275

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_8 = arg_203_1:GetWordFromCfg(319251047)
				local var_206_9 = arg_203_1:FormatText(var_206_8.content)

				arg_203_1.text_.text = var_206_9

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_11 = 11 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_9) / 11)

				if (11 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_9) / 11)) > 0 and var_206_7 < var_206_11 then
					arg_203_1.talkMaxDuration = var_206_11

					if var_206_11 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_11 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_9
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251047", "story_v_out_319251.awb") ~= 0 then
					local var_206_12 = manager.audio:GetVoiceLength("story_v_out_319251", "319251047", "story_v_out_319251.awb") / 1000

					if var_206_12 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_12 + var_206_6
					end

					if var_206_8.prefab_name ~= "" and arg_203_1.actors_[var_206_8.prefab_name] ~= nil then
						local var_206_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_8.prefab_name].transform, "story_v_out_319251", "319251047", "story_v_out_319251.awb")

						arg_203_1:RecordAudio("319251047", var_206_13)
						arg_203_1:RecordAudio("319251047", var_206_13)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_319251", "319251047", "story_v_out_319251.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_319251", "319251047", "story_v_out_319251.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_14 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_14 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_14

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_14 and arg_203_1.time_ < var_206_6 + var_206_14 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play319251048 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 319251048
		arg_207_1.duration_ = 7.27

		local var_207_0 = {
			zh = 7.266,
			ja = 4.233
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play319251049(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["10075ui_story"]) and arg_207_1.var_.characterEffect10075ui_story == nil then
				arg_207_1.var_.characterEffect10075ui_story = arg_207_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["10075ui_story"]) then
				if arg_207_1.var_.characterEffect10075ui_story and not isNil(arg_207_1.actors_["10075ui_story"]) then
					arg_207_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["10075ui_story"]) and arg_207_1.var_.characterEffect10075ui_story then
				arg_207_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_210_2 = arg_207_1.actors_["10079ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.characterEffect10079ui_story == nil then
				arg_207_1.var_.characterEffect10079ui_story = var_210_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_3 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_3 and not isNil(var_210_2) then
				if arg_207_1.var_.characterEffect10079ui_story and not isNil(var_210_2) then
					arg_207_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_3)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_3 and arg_207_1.time_ < 0 + var_210_3 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.characterEffect10079ui_story then
				arg_207_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050actionlink/10050action453")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_210_4 = 0
			local var_210_5 = 0.875

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_6 = arg_207_1:GetWordFromCfg(319251048)
				local var_210_7 = arg_207_1:FormatText(var_210_6.content)

				arg_207_1.text_.text = var_210_7

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_9 = 35 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_7) / 35)

				if (35 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_7) / 35)) > 0 and var_210_5 < var_210_9 then
					arg_207_1.talkMaxDuration = var_210_9

					if var_210_9 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_9 + var_210_4
					end
				end

				arg_207_1.text_.text = var_210_7
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251048", "story_v_out_319251.awb") ~= 0 then
					local var_210_10 = manager.audio:GetVoiceLength("story_v_out_319251", "319251048", "story_v_out_319251.awb") / 1000

					if var_210_10 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_10 + var_210_4
					end

					if var_210_6.prefab_name ~= "" and arg_207_1.actors_[var_210_6.prefab_name] ~= nil then
						local var_210_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_6.prefab_name].transform, "story_v_out_319251", "319251048", "story_v_out_319251.awb")

						arg_207_1:RecordAudio("319251048", var_210_11)
						arg_207_1:RecordAudio("319251048", var_210_11)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_319251", "319251048", "story_v_out_319251.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_319251", "319251048", "story_v_out_319251.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_12 = math.max(var_210_5, arg_207_1.talkMaxDuration)

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_12 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_4) / var_210_12

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_4 + var_210_12 and arg_207_1.time_ < var_210_4 + var_210_12 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play319251049 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 319251049
		arg_211_1.duration_ = 6.87

		local var_211_0 = {
			zh = 6.233,
			ja = 6.866
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
			arg_211_1.auto_ = false
		end

		function arg_211_1.playNext_(arg_213_0)
			arg_211_1.onStoryFinished_()
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.75

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_1 = arg_211_1:GetWordFromCfg(319251049)
				local var_214_2 = arg_211_1:FormatText(var_214_1.content)

				arg_211_1.text_.text = var_214_2

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 30 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 30)

				if (30 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 30)) > 0 and var_214_0 < var_214_4 then
					arg_211_1.talkMaxDuration = var_214_4

					if var_214_4 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_4 + 0
					end
				end

				arg_211_1.text_.text = var_214_2
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319251", "319251049", "story_v_out_319251.awb") ~= 0 then
					local var_214_5 = manager.audio:GetVoiceLength("story_v_out_319251", "319251049", "story_v_out_319251.awb") / 1000

					if var_214_5 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + 0
					end

					if var_214_1.prefab_name ~= "" and arg_211_1.actors_[var_214_1.prefab_name] ~= nil then
						local var_214_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_1.prefab_name].transform, "story_v_out_319251", "319251049", "story_v_out_319251.awb")

						arg_211_1:RecordAudio("319251049", var_214_6)
						arg_211_1:RecordAudio("319251049", var_214_6)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_319251", "319251049", "story_v_out_319251.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_319251", "319251049", "story_v_out_319251.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_7 and arg_211_1.time_ < 0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11r",
		"TextureConfig/Background/ML0104",
		"TextureConfig/Background/ST74"
	},
	voices = {
		"story_v_out_319251.awb"
	}
}
