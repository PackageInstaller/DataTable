return {
	Play421051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 421051001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play421051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I11i == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11i")
				var_4_0.name = "I11i"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I11i = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I11i

				arg_1_1.bgs_.I11i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I11i" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.733333333333333 and arg_1_1.time_ < var_4_4 + 0.733333333333333 + arg_4_0 then
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_3_story_city", "bgm_activity_4_3_story_city", "bgm_activity_4_3_story_city.awb")

				local var_4_15 = manager.audio:GetAudioName("bgm_activity_4_3_story_city", "bgm_activity_4_3_story_city")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_15 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_15

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_15
						arg_1_1.bgmTxt2_.text = var_4_15
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

			local var_4_16 = 2
			local var_4_17 = 1.175

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(421051001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 47 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 47)

				if (47 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 47)) > 0 and var_4_17 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_16 = var_4_16 + 0.3

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_16 + 0.3
			local var_4_23 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play421051002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 421051002
		arg_9_1.duration_ = 3.37

		local var_9_0 = {
			zh = 2.766,
			ja = 3.366
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
				arg_9_0:Play421051003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "10102ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["10102ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["10102ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["10102ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["10102ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["10102ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10102ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -0.985, -6.275)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["10102ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10102ui_story == nil then
				arg_9_1.var_.characterEffect10102ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect10102ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10102ui_story then
				arg_9_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_12_8 = 0
			local var_12_9 = 0.325

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
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

				local var_12_10 = arg_9_1:GetWordFromCfg(421051002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 13 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 13)

				if (13 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 13)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051002", "story_v_out_421051.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_421051", "421051002", "story_v_out_421051.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_421051", "421051002", "story_v_out_421051.awb")

						arg_9_1:RecordAudio("421051002", var_12_15)
						arg_9_1:RecordAudio("421051002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_421051", "421051002", "story_v_out_421051.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_421051", "421051002", "story_v_out_421051.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_16 and arg_9_1.time_ < var_12_8 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421051003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 421051003
		arg_13_1.duration_ = 15.47

		local var_13_0 = {
			zh = 11.3,
			ja = 15.466
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
				arg_13_0:Play421051004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["10145ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10145ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "10145ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "10145ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["10145ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["10145ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["10145ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["10145ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["10145ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10145ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0.78, -1, -6.2)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["10102ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10102ui_story = var_16_5.localPosition
			end

			local var_16_6 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 then
				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_13_1.time_ - 0) / var_16_6)
				var_16_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_5.position).x, (manager.ui.mainCamera.transform.position - var_16_5.position).y, (manager.ui.mainCamera.transform.position - var_16_5.position).z)
				var_16_5.localEulerAngles.z = 0
				var_16_5.localEulerAngles.x = 0
				var_16_5.localEulerAngles = var_16_5.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				var_16_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_5.position).x, (manager.ui.mainCamera.transform.position - var_16_5.position).y, (manager.ui.mainCamera.transform.position - var_16_5.position).z)
				var_16_5.localEulerAngles.z = 0
				var_16_5.localEulerAngles.x = 0
				var_16_5.localEulerAngles = var_16_5.localEulerAngles
			end

			local var_16_7 = arg_13_1.actors_["10145ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.characterEffect10145ui_story == nil then
				arg_13_1.var_.characterEffect10145ui_story = var_16_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_8 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_8 and not isNil(var_16_7) then
				if arg_13_1.var_.characterEffect10145ui_story and not isNil(var_16_7) then
					arg_13_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_8 and arg_13_1.time_ < 0 + var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.characterEffect10145ui_story then
				arg_13_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_16_10 = arg_13_1.actors_["10102ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect10102ui_story == nil then
				arg_13_1.var_.characterEffect10102ui_story = var_16_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_11 and not isNil(var_16_10) then
				if arg_13_1.var_.characterEffect10102ui_story and not isNil(var_16_10) then
					arg_13_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_11)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_11 and arg_13_1.time_ < 0 + var_16_11 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect10102ui_story then
				arg_13_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action4_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_16_12 = 0
			local var_16_13 = 1.275

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_14 = arg_13_1:GetWordFromCfg(421051003)
				local var_16_15 = arg_13_1:FormatText(var_16_14.content)

				arg_13_1.text_.text = var_16_15

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 51 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 51)

				if (51 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 51)) > 0 and var_16_13 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17

					if var_16_17 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_15
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051003", "story_v_out_421051.awb") ~= 0 then
					local var_16_18 = manager.audio:GetVoiceLength("story_v_out_421051", "421051003", "story_v_out_421051.awb") / 1000

					if var_16_18 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_12
					end

					if var_16_14.prefab_name ~= "" and arg_13_1.actors_[var_16_14.prefab_name] ~= nil then
						local var_16_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_14.prefab_name].transform, "story_v_out_421051", "421051003", "story_v_out_421051.awb")

						arg_13_1:RecordAudio("421051003", var_16_19)
						arg_13_1:RecordAudio("421051003", var_16_19)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_421051", "421051003", "story_v_out_421051.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_421051", "421051003", "story_v_out_421051.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_20 = math.max(var_16_13, arg_13_1.talkMaxDuration)

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_20 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_12) / var_16_20

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_12 + var_16_20 and arg_13_1.time_ < var_16_12 + var_16_20 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421051004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 421051004
		arg_17_1.duration_ = 11

		local var_17_0 = {
			zh = 7.1,
			ja = 11
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
				arg_17_0:Play421051005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10102ui_story = arg_17_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10102ui_story"].transform.position).z)
				arg_17_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10102ui_story"].transform.localEulerAngles = arg_17_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_17_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10102ui_story"].transform.position).z)
				arg_17_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10102ui_story"].transform.localEulerAngles = arg_17_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["10102ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect10102ui_story == nil then
				arg_17_1.var_.characterEffect10102ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect10102ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect10102ui_story then
				arg_17_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_20_4 = arg_17_1.actors_["10145ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect10145ui_story == nil then
				arg_17_1.var_.characterEffect10145ui_story = var_20_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_5 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_5 and not isNil(var_20_4) then
				if arg_17_1.var_.characterEffect10145ui_story and not isNil(var_20_4) then
					arg_17_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_5)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_5 and arg_17_1.time_ < 0 + var_20_5 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect10145ui_story then
				arg_17_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_20_6 = 0
			local var_20_7 = 0.85

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

				local var_20_8 = arg_17_1:GetWordFromCfg(421051004)
				local var_20_9 = arg_17_1:FormatText(var_20_8.content)

				arg_17_1.text_.text = var_20_9

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 34 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_9) / 34)

				if (34 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_9) / 34)) > 0 and var_20_7 < var_20_11 then
					arg_17_1.talkMaxDuration = var_20_11

					if var_20_11 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_9
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051004", "story_v_out_421051.awb") ~= 0 then
					local var_20_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051004", "story_v_out_421051.awb") / 1000

					if var_20_12 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_6
					end

					if var_20_8.prefab_name ~= "" and arg_17_1.actors_[var_20_8.prefab_name] ~= nil then
						local var_20_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_8.prefab_name].transform, "story_v_out_421051", "421051004", "story_v_out_421051.awb")

						arg_17_1:RecordAudio("421051004", var_20_13)
						arg_17_1:RecordAudio("421051004", var_20_13)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_421051", "421051004", "story_v_out_421051.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_421051", "421051004", "story_v_out_421051.awb")
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
				actorName = "10102ui_story",
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
	Play421051005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 421051005
		arg_21_1.duration_ = 3.23

		local var_21_0 = {
			zh = 2,
			ja = 3.233
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
				arg_21_0:Play421051006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10145ui_story = arg_21_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10145ui_story"].transform.position).z)
				arg_21_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["10145ui_story"].transform.localEulerAngles = arg_21_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_21_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10145ui_story"].transform.position).z)
				arg_21_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["10145ui_story"].transform.localEulerAngles = arg_21_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["10145ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect10145ui_story == nil then
				arg_21_1.var_.characterEffect10145ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect10145ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect10145ui_story then
				arg_21_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_24_4 = arg_21_1.actors_["10102ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect10102ui_story == nil then
				arg_21_1.var_.characterEffect10102ui_story = var_24_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_5 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_5 and not isNil(var_24_4) then
				if arg_21_1.var_.characterEffect10102ui_story and not isNil(var_24_4) then
					arg_21_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_5)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_5 and arg_21_1.time_ < 0 + var_24_5 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect10102ui_story then
				arg_21_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action4_2")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_24_6 = 0
			local var_24_7 = 0.2

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_8 = arg_21_1:GetWordFromCfg(421051005)
				local var_24_9 = arg_21_1:FormatText(var_24_8.content)

				arg_21_1.text_.text = var_24_9

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 8 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_9) / 8)

				if (8 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_9) / 8)) > 0 and var_24_7 < var_24_11 then
					arg_21_1.talkMaxDuration = var_24_11

					if var_24_11 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_9
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051005", "story_v_out_421051.awb") ~= 0 then
					local var_24_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051005", "story_v_out_421051.awb") / 1000

					if var_24_12 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_6
					end

					if var_24_8.prefab_name ~= "" and arg_21_1.actors_[var_24_8.prefab_name] ~= nil then
						local var_24_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_8.prefab_name].transform, "story_v_out_421051", "421051005", "story_v_out_421051.awb")

						arg_21_1:RecordAudio("421051005", var_24_13)
						arg_21_1:RecordAudio("421051005", var_24_13)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_421051", "421051005", "story_v_out_421051.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_421051", "421051005", "story_v_out_421051.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_14 and arg_21_1.time_ < var_24_6 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421051006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 421051006
		arg_25_1.duration_ = 10.23

		local var_25_0 = {
			zh = 7.833,
			ja = 10.233
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
				arg_25_0:Play421051007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10102ui_story = arg_25_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10102ui_story"].transform.position).z)
				arg_25_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10102ui_story"].transform.localEulerAngles = arg_25_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_25_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10102ui_story"].transform.position).z)
				arg_25_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10102ui_story"].transform.localEulerAngles = arg_25_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["10102ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect10102ui_story == nil then
				arg_25_1.var_.characterEffect10102ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect10102ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect10102ui_story then
				arg_25_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_28_4 = arg_25_1.actors_["10145ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect10145ui_story == nil then
				arg_25_1.var_.characterEffect10145ui_story = var_28_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_5 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_5 and not isNil(var_28_4) then
				if arg_25_1.var_.characterEffect10145ui_story and not isNil(var_28_4) then
					arg_25_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_5)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_5 and arg_25_1.time_ < 0 + var_28_5 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect10145ui_story then
				arg_25_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_28_6 = 0
			local var_28_7 = 1.025

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_8 = arg_25_1:GetWordFromCfg(421051006)
				local var_28_9 = arg_25_1:FormatText(var_28_8.content)

				arg_25_1.text_.text = var_28_9

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 41 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_9) / 41)

				if (41 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_9) / 41)) > 0 and var_28_7 < var_28_11 then
					arg_25_1.talkMaxDuration = var_28_11

					if var_28_11 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_9
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051006", "story_v_out_421051.awb") ~= 0 then
					local var_28_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051006", "story_v_out_421051.awb") / 1000

					if var_28_12 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_6
					end

					if var_28_8.prefab_name ~= "" and arg_25_1.actors_[var_28_8.prefab_name] ~= nil then
						local var_28_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_8.prefab_name].transform, "story_v_out_421051", "421051006", "story_v_out_421051.awb")

						arg_25_1:RecordAudio("421051006", var_28_13)
						arg_25_1:RecordAudio("421051006", var_28_13)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_421051", "421051006", "story_v_out_421051.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_421051", "421051006", "story_v_out_421051.awb")
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
				actorName = "10102ui_story",
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
	Play421051007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 421051007
		arg_29_1.duration_ = 11.7

		local var_29_0 = {
			zh = 11.7,
			ja = 10.9
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
				arg_29_0:Play421051008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10102ui_story = arg_29_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10102ui_story"].transform.position).z)
				arg_29_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10102ui_story"].transform.localEulerAngles = arg_29_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_29_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10102ui_story"].transform.position).z)
				arg_29_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10102ui_story"].transform.localEulerAngles = arg_29_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_32_1 = 0
			local var_32_2 = 1.525

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
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

				local var_32_3 = arg_29_1:GetWordFromCfg(421051007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 61 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 61)

				if (61 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 61)) > 0 and var_32_2 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051007", "story_v_out_421051.awb") ~= 0 then
					local var_32_7 = manager.audio:GetVoiceLength("story_v_out_421051", "421051007", "story_v_out_421051.awb") / 1000

					if var_32_7 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_1
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_421051", "421051007", "story_v_out_421051.awb")

						arg_29_1:RecordAudio("421051007", var_32_8)
						arg_29_1:RecordAudio("421051007", var_32_8)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_421051", "421051007", "story_v_out_421051.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_421051", "421051007", "story_v_out_421051.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_9 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_9 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_9

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_9 and arg_29_1.time_ < var_32_1 + var_32_9 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play421051008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 421051008
		arg_33_1.duration_ = 2.4

		local var_33_0 = {
			zh = 2.066,
			ja = 2.4
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
				arg_33_0:Play421051009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10145ui_story = arg_33_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10145ui_story"].transform.position).z)
				arg_33_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["10145ui_story"].transform.localEulerAngles = arg_33_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_33_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10145ui_story"].transform.position).z)
				arg_33_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["10145ui_story"].transform.localEulerAngles = arg_33_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["10145ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect10145ui_story == nil then
				arg_33_1.var_.characterEffect10145ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect10145ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect10145ui_story then
				arg_33_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_36_4 = arg_33_1.actors_["10102ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect10102ui_story == nil then
				arg_33_1.var_.characterEffect10102ui_story = var_36_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_5 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_5 and not isNil(var_36_4) then
				if arg_33_1.var_.characterEffect10102ui_story and not isNil(var_36_4) then
					arg_33_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_5)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_5 and arg_33_1.time_ < 0 + var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect10102ui_story then
				arg_33_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_36_6 = 0
			local var_36_7 = 0.25

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(421051008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 10 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 10)

				if (10 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 10)) > 0 and var_36_7 < var_36_11 then
					arg_33_1.talkMaxDuration = var_36_11

					if var_36_11 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051008", "story_v_out_421051.awb") ~= 0 then
					local var_36_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051008", "story_v_out_421051.awb") / 1000

					if var_36_12 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_6
					end

					if var_36_8.prefab_name ~= "" and arg_33_1.actors_[var_36_8.prefab_name] ~= nil then
						local var_36_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_8.prefab_name].transform, "story_v_out_421051", "421051008", "story_v_out_421051.awb")

						arg_33_1:RecordAudio("421051008", var_36_13)
						arg_33_1:RecordAudio("421051008", var_36_13)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_421051", "421051008", "story_v_out_421051.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_421051", "421051008", "story_v_out_421051.awb")
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

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play421051009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 421051009
		arg_37_1.duration_ = 7.93

		local var_37_0 = {
			zh = 4.433,
			ja = 7.933
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
				arg_37_0:Play421051010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10102ui_story = arg_37_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10102ui_story"].transform.position).z)
				arg_37_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10102ui_story"].transform.localEulerAngles = arg_37_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_37_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10102ui_story"].transform.position).z)
				arg_37_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10102ui_story"].transform.localEulerAngles = arg_37_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["10102ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10102ui_story == nil then
				arg_37_1.var_.characterEffect10102ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect10102ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10102ui_story then
				arg_37_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_40_4 = arg_37_1.actors_["10145ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect10145ui_story == nil then
				arg_37_1.var_.characterEffect10145ui_story = var_40_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_5 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_5 and not isNil(var_40_4) then
				if arg_37_1.var_.characterEffect10145ui_story and not isNil(var_40_4) then
					arg_37_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_5)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_5 and arg_37_1.time_ < 0 + var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect10145ui_story then
				arg_37_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_40_6 = 0
			local var_40_7 = 0.65

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
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

				local var_40_8 = arg_37_1:GetWordFromCfg(421051009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 26 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 26)

				if (26 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 26)) > 0 and var_40_7 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051009", "story_v_out_421051.awb") ~= 0 then
					local var_40_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051009", "story_v_out_421051.awb") / 1000

					if var_40_12 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_6
					end

					if var_40_8.prefab_name ~= "" and arg_37_1.actors_[var_40_8.prefab_name] ~= nil then
						local var_40_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_8.prefab_name].transform, "story_v_out_421051", "421051009", "story_v_out_421051.awb")

						arg_37_1:RecordAudio("421051009", var_40_13)
						arg_37_1:RecordAudio("421051009", var_40_13)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_421051", "421051009", "story_v_out_421051.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_421051", "421051009", "story_v_out_421051.awb")
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
				actorName = "10102ui_story",
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
	Play421051010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 421051010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play421051011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["10102ui_story"]) and arg_41_1.var_.characterEffect10102ui_story == nil then
				arg_41_1.var_.characterEffect10102ui_story = arg_41_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["10102ui_story"]) then
				if arg_41_1.var_.characterEffect10102ui_story and not isNil(arg_41_1.actors_["10102ui_story"]) then
					arg_41_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["10102ui_story"]) and arg_41_1.var_.characterEffect10102ui_story then
				arg_41_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 0.3

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(421051010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 12 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 12)

				if (12 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 12)) > 0 and var_44_2 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_6 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_6 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_6

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_6 and arg_41_1.time_ < var_44_1 + var_44_6 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play421051011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 421051011
		arg_45_1.duration_ = 8.13

		local var_45_0 = {
			zh = 5.666,
			ja = 8.133
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
				arg_45_0:Play421051012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10102ui_story = arg_45_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10102ui_story"].transform.position).z)
				arg_45_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["10102ui_story"].transform.localEulerAngles = arg_45_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_45_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10102ui_story"].transform.position).z)
				arg_45_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["10102ui_story"].transform.localEulerAngles = arg_45_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["10102ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect10102ui_story == nil then
				arg_45_1.var_.characterEffect10102ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect10102ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect10102ui_story then
				arg_45_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_48_4 = 0
			local var_48_5 = 0.65

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(421051011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 26 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 26)

				if (26 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 26)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051011", "story_v_out_421051.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_421051", "421051011", "story_v_out_421051.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_out_421051", "421051011", "story_v_out_421051.awb")

						arg_45_1:RecordAudio("421051011", var_48_11)
						arg_45_1:RecordAudio("421051011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_421051", "421051011", "story_v_out_421051.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_421051", "421051011", "story_v_out_421051.awb")
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

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421051012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 421051012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play421051013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10102ui_story"]) and arg_49_1.var_.characterEffect10102ui_story == nil then
				arg_49_1.var_.characterEffect10102ui_story = arg_49_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10102ui_story"]) then
				if arg_49_1.var_.characterEffect10102ui_story and not isNil(arg_49_1.actors_["10102ui_story"]) then
					arg_49_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_49_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10102ui_story"]) and arg_49_1.var_.characterEffect10102ui_story then
				arg_49_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_49_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.175

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(421051012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 7 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 7)

				if (7 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 7)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play421051013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 421051013
		arg_53_1.duration_ = 5.93

		local var_53_0 = {
			zh = 2.866,
			ja = 5.933
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
				arg_53_0:Play421051014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10102ui_story = arg_53_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10102ui_story"].transform.position).z)
				arg_53_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["10102ui_story"].transform.localEulerAngles = arg_53_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_53_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10102ui_story"].transform.position).z)
				arg_53_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["10102ui_story"].transform.localEulerAngles = arg_53_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["10102ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect10102ui_story == nil then
				arg_53_1.var_.characterEffect10102ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect10102ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect10102ui_story then
				arg_53_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_2")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_56_4 = 0
			local var_56_5 = 0.3

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

				local var_56_6 = arg_53_1:GetWordFromCfg(421051013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 12 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 12)

				if (12 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 12)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051013", "story_v_out_421051.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_421051", "421051013", "story_v_out_421051.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_421051", "421051013", "story_v_out_421051.awb")

						arg_53_1:RecordAudio("421051013", var_56_11)
						arg_53_1:RecordAudio("421051013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_421051", "421051013", "story_v_out_421051.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_421051", "421051013", "story_v_out_421051.awb")
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

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play421051014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 421051014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play421051015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10102ui_story = arg_57_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10102ui_story"].transform.position).z)
				arg_57_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10102ui_story"].transform.localEulerAngles = arg_57_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10102ui_story"].transform.position).z)
				arg_57_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10102ui_story"].transform.localEulerAngles = arg_57_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["10145ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10145ui_story = var_60_1.localPosition
			end

			local var_60_2 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 then
				var_60_1.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_2)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 then
				var_60_1.localPosition = Vector3.New(0, 100, 0)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			local var_60_3 = 0
			local var_60_4 = 1.175

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_3 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_5 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(421051014).content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 47 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_5) / 47)

				if (47 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_5) / 47)) > 0 and var_60_4 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_3 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_3
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_4, arg_57_1.talkMaxDuration)

			if var_60_3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_3 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_3) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_3 + var_60_8 and arg_57_1.time_ < var_60_3 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421051015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 421051015
		arg_61_1.duration_ = 5.9

		local var_61_0 = {
			zh = 3.533,
			ja = 5.9
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
				arg_61_0:Play421051016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10102ui_story = arg_61_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10102ui_story"].transform.position).z)
				arg_61_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10102ui_story"].transform.localEulerAngles = arg_61_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_61_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10102ui_story"].transform.position).z)
				arg_61_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10102ui_story"].transform.localEulerAngles = arg_61_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["10102ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect10102ui_story == nil then
				arg_61_1.var_.characterEffect10102ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect10102ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect10102ui_story then
				arg_61_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_64_4 = 0
			local var_64_5 = 0.5

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(421051015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 19 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 19)

				if (19 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 19)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051015", "story_v_out_421051.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_421051", "421051015", "story_v_out_421051.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_421051", "421051015", "story_v_out_421051.awb")

						arg_61_1:RecordAudio("421051015", var_64_11)
						arg_61_1:RecordAudio("421051015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_421051", "421051015", "story_v_out_421051.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_421051", "421051015", "story_v_out_421051.awb")
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

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421051016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 421051016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play421051017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10102ui_story = arg_65_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10102ui_story"].transform.position).z)
				arg_65_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10102ui_story"].transform.localEulerAngles = arg_65_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10102ui_story"].transform.position).z)
				arg_65_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10102ui_story"].transform.localEulerAngles = arg_65_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if 0.233333333333333 < arg_65_1.time_ and arg_65_1.time_ <= 0.233333333333333 + arg_68_0 then
				arg_65_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_clap", "")
			end

			local var_68_2 = 0
			local var_68_3 = 0.475

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_4 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(421051016).content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_6 = 19 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_4) / 19)

				if (19 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_4) / 19)) > 0 and var_68_3 < var_68_6 then
					arg_65_1.talkMaxDuration = var_68_6

					if var_68_6 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_2
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_3, arg_65_1.talkMaxDuration)

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_2) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_2 + var_68_7 and arg_65_1.time_ < var_68_2 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421051017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 421051017
		arg_69_1.duration_ = 2.9

		local var_69_0 = {
			zh = 1.999999999999,
			ja = 2.9
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
				arg_69_0:Play421051018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10145ui_story = arg_69_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10145ui_story"].transform.position).z)
				arg_69_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["10145ui_story"].transform.localEulerAngles = arg_69_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_69_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10145ui_story"].transform.position).z)
				arg_69_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["10145ui_story"].transform.localEulerAngles = arg_69_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["10145ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect10145ui_story == nil then
				arg_69_1.var_.characterEffect10145ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect10145ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect10145ui_story then
				arg_69_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_72_4 = 0
			local var_72_5 = 0.125

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(421051017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 5 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 5)

				if (5 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 5)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051017", "story_v_out_421051.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_421051", "421051017", "story_v_out_421051.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_out_421051", "421051017", "story_v_out_421051.awb")

						arg_69_1:RecordAudio("421051017", var_72_11)
						arg_69_1:RecordAudio("421051017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_421051", "421051017", "story_v_out_421051.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_421051", "421051017", "story_v_out_421051.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_12 and arg_69_1.time_ < var_72_4 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421051018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 421051018
		arg_73_1.duration_ = 10.47

		local var_73_0 = {
			zh = 8.266,
			ja = 10.466
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play421051019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10102ui_story = arg_73_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10102ui_story"].transform.position).z)
				arg_73_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["10102ui_story"].transform.localEulerAngles = arg_73_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_73_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10102ui_story"].transform.position).z)
				arg_73_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["10102ui_story"].transform.localEulerAngles = arg_73_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["10102ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect10102ui_story == nil then
				arg_73_1.var_.characterEffect10102ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect10102ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect10102ui_story then
				arg_73_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_76_4 = arg_73_1.actors_["10145ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect10145ui_story == nil then
				arg_73_1.var_.characterEffect10145ui_story = var_76_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_5 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_5 and not isNil(var_76_4) then
				if arg_73_1.var_.characterEffect10145ui_story and not isNil(var_76_4) then
					arg_73_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_5)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_5 and arg_73_1.time_ < 0 + var_76_5 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect10145ui_story then
				arg_73_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_76_6 = 0
			local var_76_7 = 1.15

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_8 = arg_73_1:GetWordFromCfg(421051018)
				local var_76_9 = arg_73_1:FormatText(var_76_8.content)

				arg_73_1.text_.text = var_76_9

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 46 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_9) / 46)

				if (46 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_9) / 46)) > 0 and var_76_7 < var_76_11 then
					arg_73_1.talkMaxDuration = var_76_11

					if var_76_11 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_9
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051018", "story_v_out_421051.awb") ~= 0 then
					local var_76_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051018", "story_v_out_421051.awb") / 1000

					if var_76_12 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_12 + var_76_6
					end

					if var_76_8.prefab_name ~= "" and arg_73_1.actors_[var_76_8.prefab_name] ~= nil then
						local var_76_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_8.prefab_name].transform, "story_v_out_421051", "421051018", "story_v_out_421051.awb")

						arg_73_1:RecordAudio("421051018", var_76_13)
						arg_73_1:RecordAudio("421051018", var_76_13)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_421051", "421051018", "story_v_out_421051.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_421051", "421051018", "story_v_out_421051.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_14 and arg_73_1.time_ < var_76_6 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421051019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 421051019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play421051020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10102ui_story"]) and arg_77_1.var_.characterEffect10102ui_story == nil then
				arg_77_1.var_.characterEffect10102ui_story = arg_77_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10102ui_story"]) then
				if arg_77_1.var_.characterEffect10102ui_story and not isNil(arg_77_1.actors_["10102ui_story"]) then
					arg_77_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10102ui_story"]) and arg_77_1.var_.characterEffect10102ui_story then
				arg_77_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 0.775

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(421051019).content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 31 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 31)

				if (31 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 31)) > 0 and var_80_2 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_6 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_6 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_6

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_6 and arg_77_1.time_ < var_80_1 + var_80_6 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play421051020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 421051020
		arg_81_1.duration_ = 5.23

		local var_81_0 = {
			zh = 4.7,
			ja = 5.233
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
				arg_81_0:Play421051021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10145ui_story = arg_81_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10145ui_story"].transform.position).z)
				arg_81_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["10145ui_story"].transform.localEulerAngles = arg_81_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_81_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10145ui_story"].transform.position).z)
				arg_81_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["10145ui_story"].transform.localEulerAngles = arg_81_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["10145ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect10145ui_story == nil then
				arg_81_1.var_.characterEffect10145ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect10145ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect10145ui_story then
				arg_81_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action2_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_84_4 = 0
			local var_84_5 = 0.75

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(421051020)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 30 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 30)

				if (30 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 30)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051020", "story_v_out_421051.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_421051", "421051020", "story_v_out_421051.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_421051", "421051020", "story_v_out_421051.awb")

						arg_81_1:RecordAudio("421051020", var_84_11)
						arg_81_1:RecordAudio("421051020", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_421051", "421051020", "story_v_out_421051.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_421051", "421051020", "story_v_out_421051.awb")
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

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421051021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 421051021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play421051022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["10145ui_story"]) and arg_85_1.var_.characterEffect10145ui_story == nil then
				arg_85_1.var_.characterEffect10145ui_story = arg_85_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["10145ui_story"]) then
				if arg_85_1.var_.characterEffect10145ui_story and not isNil(arg_85_1.actors_["10145ui_story"]) then
					arg_85_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["10145ui_story"]) and arg_85_1.var_.characterEffect10145ui_story then
				arg_85_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.425

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(421051021).content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 17 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 17)

				if (17 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 17)) > 0 and var_88_2 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_6 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_6 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_6

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_6 and arg_85_1.time_ < var_88_1 + var_88_6 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play421051022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 421051022
		arg_89_1.duration_ = 6.03

		local var_89_0 = {
			zh = 3.533,
			ja = 6.033
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
				arg_89_0:Play421051023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10145ui_story = arg_89_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10145ui_story"].transform.position).z)
				arg_89_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["10145ui_story"].transform.localEulerAngles = arg_89_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_89_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10145ui_story"].transform.position).z)
				arg_89_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["10145ui_story"].transform.localEulerAngles = arg_89_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["10145ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect10145ui_story == nil then
				arg_89_1.var_.characterEffect10145ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect10145ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect10145ui_story then
				arg_89_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action2_2")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_92_4 = 0
			local var_92_5 = 0.275

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(421051022)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 11 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 11)

				if (11 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 11)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051022", "story_v_out_421051.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_421051", "421051022", "story_v_out_421051.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_421051", "421051022", "story_v_out_421051.awb")

						arg_89_1:RecordAudio("421051022", var_92_11)
						arg_89_1:RecordAudio("421051022", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_421051", "421051022", "story_v_out_421051.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_421051", "421051022", "story_v_out_421051.awb")
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

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421051023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 421051023
		arg_93_1.duration_ = 3.2

		local var_93_0 = {
			zh = 2.433,
			ja = 3.2
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
				arg_93_0:Play421051024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10102ui_story = arg_93_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10102ui_story"].transform.position).z)
				arg_93_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10102ui_story"].transform.localEulerAngles = arg_93_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_93_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10102ui_story"].transform.position).z)
				arg_93_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10102ui_story"].transform.localEulerAngles = arg_93_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["10102ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10102ui_story == nil then
				arg_93_1.var_.characterEffect10102ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect10102ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10102ui_story then
				arg_93_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_96_4 = arg_93_1.actors_["10145ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_4) and arg_93_1.var_.characterEffect10145ui_story == nil then
				arg_93_1.var_.characterEffect10145ui_story = var_96_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_5 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_5 and not isNil(var_96_4) then
				if arg_93_1.var_.characterEffect10145ui_story and not isNil(var_96_4) then
					arg_93_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_5)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_5 and arg_93_1.time_ < 0 + var_96_5 + arg_96_0 and not isNil(var_96_4) and arg_93_1.var_.characterEffect10145ui_story then
				arg_93_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_2")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_96_6 = 0
			local var_96_7 = 0.3

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_8 = arg_93_1:GetWordFromCfg(421051023)
				local var_96_9 = arg_93_1:FormatText(var_96_8.content)

				arg_93_1.text_.text = var_96_9

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_11 = 12 <= 0 and var_96_7 or var_96_7 * (utf8.len(var_96_9) / 12)

				if (12 <= 0 and var_96_7 or var_96_7 * (utf8.len(var_96_9) / 12)) > 0 and var_96_7 < var_96_11 then
					arg_93_1.talkMaxDuration = var_96_11

					if var_96_11 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_11 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_9
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051023", "story_v_out_421051.awb") ~= 0 then
					local var_96_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051023", "story_v_out_421051.awb") / 1000

					if var_96_12 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_12 + var_96_6
					end

					if var_96_8.prefab_name ~= "" and arg_93_1.actors_[var_96_8.prefab_name] ~= nil then
						local var_96_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_8.prefab_name].transform, "story_v_out_421051", "421051023", "story_v_out_421051.awb")

						arg_93_1:RecordAudio("421051023", var_96_13)
						arg_93_1:RecordAudio("421051023", var_96_13)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_421051", "421051023", "story_v_out_421051.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_421051", "421051023", "story_v_out_421051.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_14 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_14 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_14

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_14 and arg_93_1.time_ < var_96_6 + var_96_14 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421051024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 421051024
		arg_97_1.duration_ = 12.37

		local var_97_0 = {
			zh = 10.3,
			ja = 12.366
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
				arg_97_0:Play421051025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10145ui_story = arg_97_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10145ui_story"].transform.position).z)
				arg_97_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10145ui_story"].transform.localEulerAngles = arg_97_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_97_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10145ui_story"].transform.position).z)
				arg_97_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10145ui_story"].transform.localEulerAngles = arg_97_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["10145ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10145ui_story == nil then
				arg_97_1.var_.characterEffect10145ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect10145ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10145ui_story then
				arg_97_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_100_4 = arg_97_1.actors_["10102ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect10102ui_story == nil then
				arg_97_1.var_.characterEffect10102ui_story = var_100_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_5 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_5 and not isNil(var_100_4) then
				if arg_97_1.var_.characterEffect10102ui_story and not isNil(var_100_4) then
					arg_97_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_5)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_5 and arg_97_1.time_ < 0 + var_100_5 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect10102ui_story then
				arg_97_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_100_6 = 0
			local var_100_7 = 1.125

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_8 = arg_97_1:GetWordFromCfg(421051024)
				local var_100_9 = arg_97_1:FormatText(var_100_8.content)

				arg_97_1.text_.text = var_100_9

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 45 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_9) / 45)

				if (45 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_9) / 45)) > 0 and var_100_7 < var_100_11 then
					arg_97_1.talkMaxDuration = var_100_11

					if var_100_11 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_9
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051024", "story_v_out_421051.awb") ~= 0 then
					local var_100_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051024", "story_v_out_421051.awb") / 1000

					if var_100_12 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_12 + var_100_6
					end

					if var_100_8.prefab_name ~= "" and arg_97_1.actors_[var_100_8.prefab_name] ~= nil then
						local var_100_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_8.prefab_name].transform, "story_v_out_421051", "421051024", "story_v_out_421051.awb")

						arg_97_1:RecordAudio("421051024", var_100_13)
						arg_97_1:RecordAudio("421051024", var_100_13)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_421051", "421051024", "story_v_out_421051.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_421051", "421051024", "story_v_out_421051.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_14 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_14 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_14

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_14 and arg_97_1.time_ < var_100_6 + var_100_14 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421051025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 421051025
		arg_101_1.duration_ = 3.47

		local var_101_0 = {
			zh = 2.2,
			ja = 3.466
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
				arg_101_0:Play421051026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10102ui_story = arg_101_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10102ui_story"].transform.position).z)
				arg_101_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["10102ui_story"].transform.localEulerAngles = arg_101_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_101_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10102ui_story"].transform.position).z)
				arg_101_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["10102ui_story"].transform.localEulerAngles = arg_101_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["10102ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect10102ui_story == nil then
				arg_101_1.var_.characterEffect10102ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect10102ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect10102ui_story then
				arg_101_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_104_4 = arg_101_1.actors_["10145ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect10145ui_story == nil then
				arg_101_1.var_.characterEffect10145ui_story = var_104_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_5 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_5 and not isNil(var_104_4) then
				if arg_101_1.var_.characterEffect10145ui_story and not isNil(var_104_4) then
					arg_101_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_5)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_5 and arg_101_1.time_ < 0 + var_104_5 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect10145ui_story then
				arg_101_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_104_6 = 0
			local var_104_7 = 0.2

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_8 = arg_101_1:GetWordFromCfg(421051025)
				local var_104_9 = arg_101_1:FormatText(var_104_8.content)

				arg_101_1.text_.text = var_104_9

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 8 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_9) / 8)

				if (8 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_9) / 8)) > 0 and var_104_7 < var_104_11 then
					arg_101_1.talkMaxDuration = var_104_11

					if var_104_11 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_9
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051025", "story_v_out_421051.awb") ~= 0 then
					local var_104_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051025", "story_v_out_421051.awb") / 1000

					if var_104_12 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_12 + var_104_6
					end

					if var_104_8.prefab_name ~= "" and arg_101_1.actors_[var_104_8.prefab_name] ~= nil then
						local var_104_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_8.prefab_name].transform, "story_v_out_421051", "421051025", "story_v_out_421051.awb")

						arg_101_1:RecordAudio("421051025", var_104_13)
						arg_101_1:RecordAudio("421051025", var_104_13)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_421051", "421051025", "story_v_out_421051.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_421051", "421051025", "story_v_out_421051.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_14 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_14 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_14

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_14 and arg_101_1.time_ < var_104_6 + var_104_14 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421051026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 421051026
		arg_105_1.duration_ = 3.5

		local var_105_0 = {
			zh = 3.5,
			ja = 3.433
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
				arg_105_0:Play421051027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10145ui_story = arg_105_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10145ui_story"].transform.position).z)
				arg_105_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10145ui_story"].transform.localEulerAngles = arg_105_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_105_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10145ui_story"].transform.position).z)
				arg_105_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10145ui_story"].transform.localEulerAngles = arg_105_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["10145ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect10145ui_story == nil then
				arg_105_1.var_.characterEffect10145ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect10145ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect10145ui_story then
				arg_105_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_108_4 = arg_105_1.actors_["10102ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_4) and arg_105_1.var_.characterEffect10102ui_story == nil then
				arg_105_1.var_.characterEffect10102ui_story = var_108_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_5 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_5 and not isNil(var_108_4) then
				if arg_105_1.var_.characterEffect10102ui_story and not isNil(var_108_4) then
					arg_105_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_105_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_5)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_5 and arg_105_1.time_ < 0 + var_108_5 + arg_108_0 and not isNil(var_108_4) and arg_105_1.var_.characterEffect10102ui_story then
				arg_105_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_105_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_108_6 = 0
			local var_108_7 = 0.325

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_8 = arg_105_1:GetWordFromCfg(421051026)
				local var_108_9 = arg_105_1:FormatText(var_108_8.content)

				arg_105_1.text_.text = var_108_9

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 13 <= 0 and var_108_7 or var_108_7 * (utf8.len(var_108_9) / 13)

				if (13 <= 0 and var_108_7 or var_108_7 * (utf8.len(var_108_9) / 13)) > 0 and var_108_7 < var_108_11 then
					arg_105_1.talkMaxDuration = var_108_11

					if var_108_11 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_9
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051026", "story_v_out_421051.awb") ~= 0 then
					local var_108_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051026", "story_v_out_421051.awb") / 1000

					if var_108_12 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_6
					end

					if var_108_8.prefab_name ~= "" and arg_105_1.actors_[var_108_8.prefab_name] ~= nil then
						local var_108_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_8.prefab_name].transform, "story_v_out_421051", "421051026", "story_v_out_421051.awb")

						arg_105_1:RecordAudio("421051026", var_108_13)
						arg_105_1:RecordAudio("421051026", var_108_13)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_421051", "421051026", "story_v_out_421051.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_421051", "421051026", "story_v_out_421051.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_14 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_14 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_14

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_14 and arg_105_1.time_ < var_108_6 + var_108_14 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421051027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 421051027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play421051028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10102ui_story = arg_109_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10102ui_story"].transform.position).z)
				arg_109_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10102ui_story"].transform.localEulerAngles = arg_109_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10102ui_story"].transform.position).z)
				arg_109_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10102ui_story"].transform.localEulerAngles = arg_109_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["10145ui_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10145ui_story = var_112_1.localPosition
			end

			local var_112_2 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 then
				var_112_1.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_2)
				var_112_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_1.position).x, (manager.ui.mainCamera.transform.position - var_112_1.position).y, (manager.ui.mainCamera.transform.position - var_112_1.position).z)
				var_112_1.localEulerAngles.z = 0
				var_112_1.localEulerAngles.x = 0
				var_112_1.localEulerAngles = var_112_1.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 then
				var_112_1.localPosition = Vector3.New(0, 100, 0)
				var_112_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_1.position).x, (manager.ui.mainCamera.transform.position - var_112_1.position).y, (manager.ui.mainCamera.transform.position - var_112_1.position).z)
				var_112_1.localEulerAngles.z = 0
				var_112_1.localEulerAngles.x = 0
				var_112_1.localEulerAngles = var_112_1.localEulerAngles
			end

			local var_112_3 = 0
			local var_112_4 = 1

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

				local var_112_5 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(421051027).content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 40 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 40)

				if (40 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 40)) > 0 and var_112_4 < var_112_7 then
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
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421051028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 421051028
		arg_113_1.duration_ = 3.23

		local var_113_0 = {
			zh = 3.233,
			ja = 3.166
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
				arg_113_0:Play421051029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10102ui_story = arg_113_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10102ui_story"].transform.position).z)
				arg_113_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10102ui_story"].transform.localEulerAngles = arg_113_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_113_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10102ui_story"].transform.position).z)
				arg_113_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10102ui_story"].transform.localEulerAngles = arg_113_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["10102ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10102ui_story == nil then
				arg_113_1.var_.characterEffect10102ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect10102ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10102ui_story then
				arg_113_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_116_4 = 0
			local var_116_5 = 0.325

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(421051028)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 13 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 13)

				if (13 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 13)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051028", "story_v_out_421051.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_421051", "421051028", "story_v_out_421051.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_out_421051", "421051028", "story_v_out_421051.awb")

						arg_113_1:RecordAudio("421051028", var_116_11)
						arg_113_1:RecordAudio("421051028", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_421051", "421051028", "story_v_out_421051.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_421051", "421051028", "story_v_out_421051.awb")
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
				actorName = "10102ui_story",
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
	Play421051029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 421051029
		arg_117_1.duration_ = 2.5

		local var_117_0 = {
			zh = 2.5,
			ja = 2.133
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
				arg_117_0:Play421051030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10145ui_story = arg_117_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10145ui_story"].transform.position).z)
				arg_117_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10145ui_story"].transform.localEulerAngles = arg_117_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_117_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10145ui_story"].transform.position).z)
				arg_117_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10145ui_story"].transform.localEulerAngles = arg_117_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["10145ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect10145ui_story == nil then
				arg_117_1.var_.characterEffect10145ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect10145ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect10145ui_story then
				arg_117_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_120_4 = arg_117_1.actors_["10102ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect10102ui_story == nil then
				arg_117_1.var_.characterEffect10102ui_story = var_120_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_5 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_5 and not isNil(var_120_4) then
				if arg_117_1.var_.characterEffect10102ui_story and not isNil(var_120_4) then
					arg_117_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_5)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_5 and arg_117_1.time_ < 0 + var_120_5 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect10102ui_story then
				arg_117_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action8_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_120_6 = 0
			local var_120_7 = 0.225

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_8 = arg_117_1:GetWordFromCfg(421051029)
				local var_120_9 = arg_117_1:FormatText(var_120_8.content)

				arg_117_1.text_.text = var_120_9

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 9 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 9)

				if (9 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 9)) > 0 and var_120_7 < var_120_11 then
					arg_117_1.talkMaxDuration = var_120_11

					if var_120_11 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_9
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051029", "story_v_out_421051.awb") ~= 0 then
					local var_120_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051029", "story_v_out_421051.awb") / 1000

					if var_120_12 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_6
					end

					if var_120_8.prefab_name ~= "" and arg_117_1.actors_[var_120_8.prefab_name] ~= nil then
						local var_120_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_8.prefab_name].transform, "story_v_out_421051", "421051029", "story_v_out_421051.awb")

						arg_117_1:RecordAudio("421051029", var_120_13)
						arg_117_1:RecordAudio("421051029", var_120_13)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_421051", "421051029", "story_v_out_421051.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_421051", "421051029", "story_v_out_421051.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_14 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_14

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_14 and arg_117_1.time_ < var_120_6 + var_120_14 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play421051030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 421051030
		arg_121_1.duration_ = 5.23

		local var_121_0 = {
			zh = 3.7,
			ja = 5.233
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play421051031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10102ui_story = arg_121_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10102ui_story"].transform.position).z)
				arg_121_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10102ui_story"].transform.localEulerAngles = arg_121_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_121_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10102ui_story"].transform.position).z)
				arg_121_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10102ui_story"].transform.localEulerAngles = arg_121_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["10102ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10102ui_story == nil then
				arg_121_1.var_.characterEffect10102ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect10102ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10102ui_story then
				arg_121_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_124_4 = arg_121_1.actors_["10145ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect10145ui_story == nil then
				arg_121_1.var_.characterEffect10145ui_story = var_124_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_5 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_5 and not isNil(var_124_4) then
				if arg_121_1.var_.characterEffect10145ui_story and not isNil(var_124_4) then
					arg_121_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_5)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_5 and arg_121_1.time_ < 0 + var_124_5 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect10145ui_story then
				arg_121_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_124_6 = 0
			local var_124_7 = 0.5

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_8 = arg_121_1:GetWordFromCfg(421051030)
				local var_124_9 = arg_121_1:FormatText(var_124_8.content)

				arg_121_1.text_.text = var_124_9

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 20 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_9) / 20)

				if (20 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_9) / 20)) > 0 and var_124_7 < var_124_11 then
					arg_121_1.talkMaxDuration = var_124_11

					if var_124_11 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_9
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051030", "story_v_out_421051.awb") ~= 0 then
					local var_124_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051030", "story_v_out_421051.awb") / 1000

					if var_124_12 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_12 + var_124_6
					end

					if var_124_8.prefab_name ~= "" and arg_121_1.actors_[var_124_8.prefab_name] ~= nil then
						local var_124_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_8.prefab_name].transform, "story_v_out_421051", "421051030", "story_v_out_421051.awb")

						arg_121_1:RecordAudio("421051030", var_124_13)
						arg_121_1:RecordAudio("421051030", var_124_13)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_421051", "421051030", "story_v_out_421051.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_421051", "421051030", "story_v_out_421051.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_14 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_14 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_14

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_14 and arg_121_1.time_ < var_124_6 + var_124_14 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421051031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 421051031
		arg_125_1.duration_ = 9.63

		local var_125_0 = {
			zh = 6.466,
			ja = 9.633
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
				arg_125_0:Play421051032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10145ui_story = arg_125_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10145ui_story"].transform.position).z)
				arg_125_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["10145ui_story"].transform.localEulerAngles = arg_125_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_125_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10145ui_story"].transform.position).z)
				arg_125_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["10145ui_story"].transform.localEulerAngles = arg_125_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["10145ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect10145ui_story == nil then
				arg_125_1.var_.characterEffect10145ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect10145ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect10145ui_story then
				arg_125_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_128_4 = arg_125_1.actors_["10102ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect10102ui_story == nil then
				arg_125_1.var_.characterEffect10102ui_story = var_128_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_5 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_5 and not isNil(var_128_4) then
				if arg_125_1.var_.characterEffect10102ui_story and not isNil(var_128_4) then
					arg_125_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_5)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_5 and arg_125_1.time_ < 0 + var_128_5 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect10102ui_story then
				arg_125_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action8_2")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_128_6 = 0
			local var_128_7 = 0.55

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_8 = arg_125_1:GetWordFromCfg(421051031)
				local var_128_9 = arg_125_1:FormatText(var_128_8.content)

				arg_125_1.text_.text = var_128_9

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_11 = 22 <= 0 and var_128_7 or var_128_7 * (utf8.len(var_128_9) / 22)

				if (22 <= 0 and var_128_7 or var_128_7 * (utf8.len(var_128_9) / 22)) > 0 and var_128_7 < var_128_11 then
					arg_125_1.talkMaxDuration = var_128_11

					if var_128_11 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_11 + var_128_6
					end
				end

				arg_125_1.text_.text = var_128_9
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051031", "story_v_out_421051.awb") ~= 0 then
					local var_128_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051031", "story_v_out_421051.awb") / 1000

					if var_128_12 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_12 + var_128_6
					end

					if var_128_8.prefab_name ~= "" and arg_125_1.actors_[var_128_8.prefab_name] ~= nil then
						local var_128_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_8.prefab_name].transform, "story_v_out_421051", "421051031", "story_v_out_421051.awb")

						arg_125_1:RecordAudio("421051031", var_128_13)
						arg_125_1:RecordAudio("421051031", var_128_13)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_421051", "421051031", "story_v_out_421051.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_421051", "421051031", "story_v_out_421051.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_14 = math.max(var_128_7, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_14 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_6) / var_128_14

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_14 and arg_125_1.time_ < var_128_6 + var_128_14 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421051032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 421051032
		arg_129_1.duration_ = 6.13

		local var_129_0 = {
			zh = 3.833,
			ja = 6.133
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
				arg_129_0:Play421051033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10145ui_story = arg_129_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10145ui_story"].transform.position).z)
				arg_129_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["10145ui_story"].transform.localEulerAngles = arg_129_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_129_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10145ui_story"].transform.position).z)
				arg_129_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["10145ui_story"].transform.localEulerAngles = arg_129_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_132_1 = 0
			local var_132_2 = 0.525

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:GetWordFromCfg(421051032)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_6 = 21 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_4) / 21)

				if (21 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_4) / 21)) > 0 and var_132_2 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051032", "story_v_out_421051.awb") ~= 0 then
					local var_132_7 = manager.audio:GetVoiceLength("story_v_out_421051", "421051032", "story_v_out_421051.awb") / 1000

					if var_132_7 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_1
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_421051", "421051032", "story_v_out_421051.awb")

						arg_129_1:RecordAudio("421051032", var_132_8)
						arg_129_1:RecordAudio("421051032", var_132_8)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_421051", "421051032", "story_v_out_421051.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_421051", "421051032", "story_v_out_421051.awb")
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

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421051033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 421051033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play421051034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["10145ui_story"]) and arg_133_1.var_.characterEffect10145ui_story == nil then
				arg_133_1.var_.characterEffect10145ui_story = arg_133_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["10145ui_story"]) then
				if arg_133_1.var_.characterEffect10145ui_story and not isNil(arg_133_1.actors_["10145ui_story"]) then
					arg_133_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["10145ui_story"]) and arg_133_1.var_.characterEffect10145ui_story then
				arg_133_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_136_1 = 0
			local var_136_2 = 1.1

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_3 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(421051033).content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 44 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 44)

				if (44 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 44)) > 0 and var_136_2 < var_136_5 then
					arg_133_1.talkMaxDuration = var_136_5

					if var_136_5 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + var_136_1
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_6 = math.max(var_136_2, arg_133_1.talkMaxDuration)

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_6 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_1) / var_136_6

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_1 + var_136_6 and arg_133_1.time_ < var_136_1 + var_136_6 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play421051034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 421051034
		arg_137_1.duration_ = 10.97

		local var_137_0 = {
			zh = 10.2,
			ja = 10.966
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
				arg_137_0:Play421051035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10145ui_story = arg_137_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10145ui_story"].transform.position).z)
				arg_137_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["10145ui_story"].transform.localEulerAngles = arg_137_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_137_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10145ui_story"].transform.position).z)
				arg_137_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["10145ui_story"].transform.localEulerAngles = arg_137_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["10145ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect10145ui_story == nil then
				arg_137_1.var_.characterEffect10145ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect10145ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect10145ui_story then
				arg_137_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action6_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_140_4 = 0
			local var_140_5 = 1.175

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:GetWordFromCfg(421051034)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 47 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 47)

				if (47 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 47)) > 0 and var_140_5 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051034", "story_v_out_421051.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_out_421051", "421051034", "story_v_out_421051.awb") / 1000

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end

					if var_140_6.prefab_name ~= "" and arg_137_1.actors_[var_140_6.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_6.prefab_name].transform, "story_v_out_421051", "421051034", "story_v_out_421051.awb")

						arg_137_1:RecordAudio("421051034", var_140_11)
						arg_137_1:RecordAudio("421051034", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_421051", "421051034", "story_v_out_421051.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_421051", "421051034", "story_v_out_421051.awb")
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

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play421051035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 421051035
		arg_141_1.duration_ = 3

		local var_141_0 = {
			zh = 2.5,
			ja = 3
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
				arg_141_0:Play421051036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10102ui_story = arg_141_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10102ui_story"].transform.position).z)
				arg_141_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10102ui_story"].transform.localEulerAngles = arg_141_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_141_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10102ui_story"].transform.position).z)
				arg_141_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10102ui_story"].transform.localEulerAngles = arg_141_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["10102ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect10102ui_story == nil then
				arg_141_1.var_.characterEffect10102ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect10102ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect10102ui_story then
				arg_141_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_144_4 = arg_141_1.actors_["10145ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect10145ui_story == nil then
				arg_141_1.var_.characterEffect10145ui_story = var_144_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_5 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_5 and not isNil(var_144_4) then
				if arg_141_1.var_.characterEffect10145ui_story and not isNil(var_144_4) then
					arg_141_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_5)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_5 and arg_141_1.time_ < 0 + var_144_5 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect10145ui_story then
				arg_141_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_144_6 = 0
			local var_144_7 = 0.25

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
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

				local var_144_8 = arg_141_1:GetWordFromCfg(421051035)
				local var_144_9 = arg_141_1:FormatText(var_144_8.content)

				arg_141_1.text_.text = var_144_9

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 10 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_9) / 10)

				if (10 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_9) / 10)) > 0 and var_144_7 < var_144_11 then
					arg_141_1.talkMaxDuration = var_144_11

					if var_144_11 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_6
					end
				end

				arg_141_1.text_.text = var_144_9
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051035", "story_v_out_421051.awb") ~= 0 then
					local var_144_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051035", "story_v_out_421051.awb") / 1000

					if var_144_12 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_12 + var_144_6
					end

					if var_144_8.prefab_name ~= "" and arg_141_1.actors_[var_144_8.prefab_name] ~= nil then
						local var_144_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_8.prefab_name].transform, "story_v_out_421051", "421051035", "story_v_out_421051.awb")

						arg_141_1:RecordAudio("421051035", var_144_13)
						arg_141_1:RecordAudio("421051035", var_144_13)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_421051", "421051035", "story_v_out_421051.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_421051", "421051035", "story_v_out_421051.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_14 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_14 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_6) / var_144_14

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_6 + var_144_14 and arg_141_1.time_ < var_144_6 + var_144_14 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421051036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 421051036
		arg_145_1.duration_ = 10.5

		local var_145_0 = {
			zh = 10.5,
			ja = 9.466
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
				arg_145_0:Play421051037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10145ui_story = arg_145_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10145ui_story"].transform.position).z)
				arg_145_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10145ui_story"].transform.localEulerAngles = arg_145_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_145_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10145ui_story"].transform.position).z)
				arg_145_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10145ui_story"].transform.localEulerAngles = arg_145_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["10145ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect10145ui_story == nil then
				arg_145_1.var_.characterEffect10145ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect10145ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect10145ui_story then
				arg_145_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_148_4 = arg_145_1.actors_["10102ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect10102ui_story == nil then
				arg_145_1.var_.characterEffect10102ui_story = var_148_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_5 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_5 and not isNil(var_148_4) then
				if arg_145_1.var_.characterEffect10102ui_story and not isNil(var_148_4) then
					arg_145_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_5)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_5 and arg_145_1.time_ < 0 + var_148_5 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect10102ui_story then
				arg_145_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_148_6 = 0
			local var_148_7 = 1.3

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_8 = arg_145_1:GetWordFromCfg(421051036)
				local var_148_9 = arg_145_1:FormatText(var_148_8.content)

				arg_145_1.text_.text = var_148_9

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_11 = 52 <= 0 and var_148_7 or var_148_7 * (utf8.len(var_148_9) / 52)

				if (52 <= 0 and var_148_7 or var_148_7 * (utf8.len(var_148_9) / 52)) > 0 and var_148_7 < var_148_11 then
					arg_145_1.talkMaxDuration = var_148_11

					if var_148_11 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_11 + var_148_6
					end
				end

				arg_145_1.text_.text = var_148_9
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051036", "story_v_out_421051.awb") ~= 0 then
					local var_148_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051036", "story_v_out_421051.awb") / 1000

					if var_148_12 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_12 + var_148_6
					end

					if var_148_8.prefab_name ~= "" and arg_145_1.actors_[var_148_8.prefab_name] ~= nil then
						local var_148_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_8.prefab_name].transform, "story_v_out_421051", "421051036", "story_v_out_421051.awb")

						arg_145_1:RecordAudio("421051036", var_148_13)
						arg_145_1:RecordAudio("421051036", var_148_13)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_421051", "421051036", "story_v_out_421051.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_421051", "421051036", "story_v_out_421051.awb")
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
				actorName = "10145ui_story",
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
	Play421051037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 421051037
		arg_149_1.duration_ = 14.03

		local var_149_0 = {
			zh = 14.033,
			ja = 12.233
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
				arg_149_0:Play421051038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action6_2")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_152_0 = 0
			local var_152_1 = 1.725

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_2 = arg_149_1:GetWordFromCfg(421051037)
				local var_152_3 = arg_149_1:FormatText(var_152_2.content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 69 <= 0 and var_152_1 or var_152_1 * (utf8.len(var_152_3) / 69)

				if (69 <= 0 and var_152_1 or var_152_1 * (utf8.len(var_152_3) / 69)) > 0 and var_152_1 < var_152_5 then
					arg_149_1.talkMaxDuration = var_152_5

					if var_152_5 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_3
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051037", "story_v_out_421051.awb") ~= 0 then
					local var_152_6 = manager.audio:GetVoiceLength("story_v_out_421051", "421051037", "story_v_out_421051.awb") / 1000

					if var_152_6 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_0
					end

					if var_152_2.prefab_name ~= "" and arg_149_1.actors_[var_152_2.prefab_name] ~= nil then
						local var_152_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_2.prefab_name].transform, "story_v_out_421051", "421051037", "story_v_out_421051.awb")

						arg_149_1:RecordAudio("421051037", var_152_7)
						arg_149_1:RecordAudio("421051037", var_152_7)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_421051", "421051037", "story_v_out_421051.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_421051", "421051037", "story_v_out_421051.awb")
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
	Play421051038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 421051038
		arg_153_1.duration_ = 5.47

		local var_153_0 = {
			zh = 3.533,
			ja = 5.466
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
				arg_153_0:Play421051039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10102ui_story = arg_153_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10102ui_story"].transform.position).z)
				arg_153_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["10102ui_story"].transform.localEulerAngles = arg_153_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_153_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10102ui_story"].transform.position).z)
				arg_153_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["10102ui_story"].transform.localEulerAngles = arg_153_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["10102ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect10102ui_story == nil then
				arg_153_1.var_.characterEffect10102ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect10102ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect10102ui_story then
				arg_153_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_156_4 = arg_153_1.actors_["10145ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect10145ui_story == nil then
				arg_153_1.var_.characterEffect10145ui_story = var_156_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_5 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_5 and not isNil(var_156_4) then
				if arg_153_1.var_.characterEffect10145ui_story and not isNil(var_156_4) then
					arg_153_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_153_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_5)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_5 and arg_153_1.time_ < 0 + var_156_5 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect10145ui_story then
				arg_153_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_153_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_156_6 = 0
			local var_156_7 = 0.475

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_8 = arg_153_1:GetWordFromCfg(421051038)
				local var_156_9 = arg_153_1:FormatText(var_156_8.content)

				arg_153_1.text_.text = var_156_9

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_11 = 19 <= 0 and var_156_7 or var_156_7 * (utf8.len(var_156_9) / 19)

				if (19 <= 0 and var_156_7 or var_156_7 * (utf8.len(var_156_9) / 19)) > 0 and var_156_7 < var_156_11 then
					arg_153_1.talkMaxDuration = var_156_11

					if var_156_11 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_11 + var_156_6
					end
				end

				arg_153_1.text_.text = var_156_9
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051038", "story_v_out_421051.awb") ~= 0 then
					local var_156_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051038", "story_v_out_421051.awb") / 1000

					if var_156_12 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_12 + var_156_6
					end

					if var_156_8.prefab_name ~= "" and arg_153_1.actors_[var_156_8.prefab_name] ~= nil then
						local var_156_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_8.prefab_name].transform, "story_v_out_421051", "421051038", "story_v_out_421051.awb")

						arg_153_1:RecordAudio("421051038", var_156_13)
						arg_153_1:RecordAudio("421051038", var_156_13)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_421051", "421051038", "story_v_out_421051.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_421051", "421051038", "story_v_out_421051.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_14 = math.max(var_156_7, arg_153_1.talkMaxDuration)

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_14 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_6) / var_156_14

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_6 + var_156_14 and arg_153_1.time_ < var_156_6 + var_156_14 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421051039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 421051039
		arg_157_1.duration_ = 8.1

		local var_157_0 = {
			zh = 6.966,
			ja = 8.1
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
				arg_157_0:Play421051040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["10145ui_story"]) and arg_157_1.var_.characterEffect10145ui_story == nil then
				arg_157_1.var_.characterEffect10145ui_story = arg_157_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["10145ui_story"]) then
				if arg_157_1.var_.characterEffect10145ui_story and not isNil(arg_157_1.actors_["10145ui_story"]) then
					arg_157_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["10145ui_story"]) and arg_157_1.var_.characterEffect10145ui_story then
				arg_157_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_160_2 = arg_157_1.actors_["10102ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect10102ui_story == nil then
				arg_157_1.var_.characterEffect10102ui_story = var_160_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_3 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_3 and not isNil(var_160_2) then
				if arg_157_1.var_.characterEffect10102ui_story and not isNil(var_160_2) then
					arg_157_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_157_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_3)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_3 and arg_157_1.time_ < 0 + var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect10102ui_story then
				arg_157_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_157_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_160_4 = 0
			local var_160_5 = 0.875

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(421051039)
				local var_160_7 = arg_157_1:FormatText(var_160_6.content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_9 = 35 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 35)

				if (35 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 35)) > 0 and var_160_5 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051039", "story_v_out_421051.awb") ~= 0 then
					local var_160_10 = manager.audio:GetVoiceLength("story_v_out_421051", "421051039", "story_v_out_421051.awb") / 1000

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end

					if var_160_6.prefab_name ~= "" and arg_157_1.actors_[var_160_6.prefab_name] ~= nil then
						local var_160_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_6.prefab_name].transform, "story_v_out_421051", "421051039", "story_v_out_421051.awb")

						arg_157_1:RecordAudio("421051039", var_160_11)
						arg_157_1:RecordAudio("421051039", var_160_11)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_421051", "421051039", "story_v_out_421051.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_421051", "421051039", "story_v_out_421051.awb")
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
	Play421051040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 421051040
		arg_161_1.duration_ = 9.03

		local var_161_0 = {
			zh = 8.266,
			ja = 9.033
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
				arg_161_0:Play421051041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10145ui_story = arg_161_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10145ui_story"].transform.position).z)
				arg_161_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["10145ui_story"].transform.localEulerAngles = arg_161_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_161_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10145ui_story"].transform.position).z)
				arg_161_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["10145ui_story"].transform.localEulerAngles = arg_161_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_164_1 = 0
			local var_164_2 = 1.1

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:GetWordFromCfg(421051040)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_6 = 44 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_4) / 44)

				if (44 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_4) / 44)) > 0 and var_164_2 < var_164_6 then
					arg_161_1.talkMaxDuration = var_164_6

					if var_164_6 + var_164_1 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_6 + var_164_1
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051040", "story_v_out_421051.awb") ~= 0 then
					local var_164_7 = manager.audio:GetVoiceLength("story_v_out_421051", "421051040", "story_v_out_421051.awb") / 1000

					if var_164_7 + var_164_1 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_1
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_421051", "421051040", "story_v_out_421051.awb")

						arg_161_1:RecordAudio("421051040", var_164_8)
						arg_161_1:RecordAudio("421051040", var_164_8)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_421051", "421051040", "story_v_out_421051.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_421051", "421051040", "story_v_out_421051.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_9 = math.max(var_164_2, arg_161_1.talkMaxDuration)

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_9 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_1) / var_164_9

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_1 + var_164_9 and arg_161_1.time_ < var_164_1 + var_164_9 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421051041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 421051041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play421051042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["10145ui_story"]) and arg_165_1.var_.characterEffect10145ui_story == nil then
				arg_165_1.var_.characterEffect10145ui_story = arg_165_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["10145ui_story"]) then
				if arg_165_1.var_.characterEffect10145ui_story and not isNil(arg_165_1.actors_["10145ui_story"]) then
					arg_165_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["10145ui_story"]) and arg_165_1.var_.characterEffect10145ui_story then
				arg_165_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_168_1 = 0
			local var_168_2 = 0.575

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(421051041).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 23 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 23)

				if (23 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 23)) > 0 and var_168_2 < var_168_5 then
					arg_165_1.talkMaxDuration = var_168_5

					if var_168_5 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + var_168_1
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_6 = math.max(var_168_2, arg_165_1.talkMaxDuration)

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_6 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_1) / var_168_6

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_1 + var_168_6 and arg_165_1.time_ < var_168_1 + var_168_6 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play421051042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 421051042
		arg_169_1.duration_ = 7.1

		local var_169_0 = {
			zh = 4.6,
			ja = 7.1
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
				arg_169_0:Play421051043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10145ui_story = arg_169_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10145ui_story"].transform.position).z)
				arg_169_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10145ui_story"].transform.localEulerAngles = arg_169_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_169_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10145ui_story"].transform.position).z)
				arg_169_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10145ui_story"].transform.localEulerAngles = arg_169_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["10145ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect10145ui_story == nil then
				arg_169_1.var_.characterEffect10145ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect10145ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect10145ui_story then
				arg_169_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action5_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_172_4 = 0
			local var_172_5 = 0.5

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(421051042)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 20 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 20)

				if (20 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 20)) > 0 and var_172_5 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051042", "story_v_out_421051.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_out_421051", "421051042", "story_v_out_421051.awb") / 1000

					if var_172_10 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_4
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_out_421051", "421051042", "story_v_out_421051.awb")

						arg_169_1:RecordAudio("421051042", var_172_11)
						arg_169_1:RecordAudio("421051042", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_421051", "421051042", "story_v_out_421051.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_421051", "421051042", "story_v_out_421051.awb")
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

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421051043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 421051043
		arg_173_1.duration_ = 5

		local var_173_0 = {
			zh = 2.966,
			ja = 5
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
				arg_173_0:Play421051044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10102ui_story = arg_173_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10102ui_story"].transform.position).z)
				arg_173_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10102ui_story"].transform.localEulerAngles = arg_173_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_173_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10102ui_story"].transform.position).z)
				arg_173_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10102ui_story"].transform.localEulerAngles = arg_173_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["10102ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect10102ui_story == nil then
				arg_173_1.var_.characterEffect10102ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect10102ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect10102ui_story then
				arg_173_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_176_4 = arg_173_1.actors_["10145ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect10145ui_story == nil then
				arg_173_1.var_.characterEffect10145ui_story = var_176_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_5 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_5 and not isNil(var_176_4) then
				if arg_173_1.var_.characterEffect10145ui_story and not isNil(var_176_4) then
					arg_173_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_5)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_5 and arg_173_1.time_ < 0 + var_176_5 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect10145ui_story then
				arg_173_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_2")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_176_6 = 0
			local var_176_7 = 0.4

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
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

				local var_176_8 = arg_173_1:GetWordFromCfg(421051043)
				local var_176_9 = arg_173_1:FormatText(var_176_8.content)

				arg_173_1.text_.text = var_176_9

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 16 <= 0 and var_176_7 or var_176_7 * (utf8.len(var_176_9) / 16)

				if (16 <= 0 and var_176_7 or var_176_7 * (utf8.len(var_176_9) / 16)) > 0 and var_176_7 < var_176_11 then
					arg_173_1.talkMaxDuration = var_176_11

					if var_176_11 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_11 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_9
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051043", "story_v_out_421051.awb") ~= 0 then
					local var_176_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051043", "story_v_out_421051.awb") / 1000

					if var_176_12 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_12 + var_176_6
					end

					if var_176_8.prefab_name ~= "" and arg_173_1.actors_[var_176_8.prefab_name] ~= nil then
						local var_176_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_8.prefab_name].transform, "story_v_out_421051", "421051043", "story_v_out_421051.awb")

						arg_173_1:RecordAudio("421051043", var_176_13)
						arg_173_1:RecordAudio("421051043", var_176_13)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_421051", "421051043", "story_v_out_421051.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_421051", "421051043", "story_v_out_421051.awb")
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
				actorName = "10102ui_story",
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
	Play421051044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 421051044
		arg_177_1.duration_ = 4.87

		local var_177_0 = {
			zh = 2.8,
			ja = 4.866
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
				arg_177_0:Play421051045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10145ui_story = arg_177_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10145ui_story"].transform.position).z)
				arg_177_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["10145ui_story"].transform.localEulerAngles = arg_177_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_177_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["10145ui_story"].transform.position).z)
				arg_177_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["10145ui_story"].transform.localEulerAngles = arg_177_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["10145ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect10145ui_story == nil then
				arg_177_1.var_.characterEffect10145ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect10145ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect10145ui_story then
				arg_177_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_180_4 = arg_177_1.actors_["10102ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect10102ui_story == nil then
				arg_177_1.var_.characterEffect10102ui_story = var_180_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_5 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_5 and not isNil(var_180_4) then
				if arg_177_1.var_.characterEffect10102ui_story and not isNil(var_180_4) then
					arg_177_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_177_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_5)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_5 and arg_177_1.time_ < 0 + var_180_5 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect10102ui_story then
				arg_177_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_177_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action5_2")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_180_6 = 0
			local var_180_7 = 0.35

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_8 = arg_177_1:GetWordFromCfg(421051044)
				local var_180_9 = arg_177_1:FormatText(var_180_8.content)

				arg_177_1.text_.text = var_180_9

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_11 = 14 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_9) / 14)

				if (14 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_9) / 14)) > 0 and var_180_7 < var_180_11 then
					arg_177_1.talkMaxDuration = var_180_11

					if var_180_11 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_11 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_9
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051044", "story_v_out_421051.awb") ~= 0 then
					local var_180_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051044", "story_v_out_421051.awb") / 1000

					if var_180_12 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_12 + var_180_6
					end

					if var_180_8.prefab_name ~= "" and arg_177_1.actors_[var_180_8.prefab_name] ~= nil then
						local var_180_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_8.prefab_name].transform, "story_v_out_421051", "421051044", "story_v_out_421051.awb")

						arg_177_1:RecordAudio("421051044", var_180_13)
						arg_177_1:RecordAudio("421051044", var_180_13)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_421051", "421051044", "story_v_out_421051.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_421051", "421051044", "story_v_out_421051.awb")
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
				actorName = "10145ui_story",
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
	Play421051045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 421051045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play421051046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["10145ui_story"]) and arg_181_1.var_.characterEffect10145ui_story == nil then
				arg_181_1.var_.characterEffect10145ui_story = arg_181_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["10145ui_story"]) then
				if arg_181_1.var_.characterEffect10145ui_story and not isNil(arg_181_1.actors_["10145ui_story"]) then
					arg_181_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_181_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_0)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["10145ui_story"]) and arg_181_1.var_.characterEffect10145ui_story then
				arg_181_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_181_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_184_1 = 0
			local var_184_2 = 0.75

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(421051045).content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 30 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 30)

				if (30 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 30)) > 0 and var_184_2 < var_184_5 then
					arg_181_1.talkMaxDuration = var_184_5

					if var_184_5 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + var_184_1
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_6 = math.max(var_184_2, arg_181_1.talkMaxDuration)

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_6 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_1) / var_184_6

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_1 + var_184_6 and arg_181_1.time_ < var_184_1 + var_184_6 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play421051046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 421051046
		arg_185_1.duration_ = 13.2

		local var_185_0 = {
			zh = 11.8,
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
				arg_185_0:Play421051047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10145ui_story = arg_185_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10145ui_story"].transform.position).z)
				arg_185_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["10145ui_story"].transform.localEulerAngles = arg_185_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_185_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10145ui_story"].transform.position).z)
				arg_185_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["10145ui_story"].transform.localEulerAngles = arg_185_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["10145ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect10145ui_story == nil then
				arg_185_1.var_.characterEffect10145ui_story = var_188_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 and not isNil(var_188_1) then
				if arg_185_1.var_.characterEffect10145ui_story and not isNil(var_188_1) then
					arg_185_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect10145ui_story then
				arg_185_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_188_4 = 0
			local var_188_5 = 1.35

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_6 = arg_185_1:GetWordFromCfg(421051046)
				local var_188_7 = arg_185_1:FormatText(var_188_6.content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 54 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 54)

				if (54 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 54)) > 0 and var_188_5 < var_188_9 then
					arg_185_1.talkMaxDuration = var_188_9

					if var_188_9 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_4
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051046", "story_v_out_421051.awb") ~= 0 then
					local var_188_10 = manager.audio:GetVoiceLength("story_v_out_421051", "421051046", "story_v_out_421051.awb") / 1000

					if var_188_10 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_10 + var_188_4
					end

					if var_188_6.prefab_name ~= "" and arg_185_1.actors_[var_188_6.prefab_name] ~= nil then
						local var_188_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_6.prefab_name].transform, "story_v_out_421051", "421051046", "story_v_out_421051.awb")

						arg_185_1:RecordAudio("421051046", var_188_11)
						arg_185_1:RecordAudio("421051046", var_188_11)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_421051", "421051046", "story_v_out_421051.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_421051", "421051046", "story_v_out_421051.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_12 = math.max(var_188_5, arg_185_1.talkMaxDuration)

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_12 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_4) / var_188_12

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_4 + var_188_12 and arg_185_1.time_ < var_188_4 + var_188_12 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421051047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 421051047
		arg_189_1.duration_ = 11.03

		local var_189_0 = {
			zh = 9.433,
			ja = 11.033
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
				arg_189_0:Play421051048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.95

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:GetWordFromCfg(421051047)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 38 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 38)

				if (38 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 38)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051047", "story_v_out_421051.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_421051", "421051047", "story_v_out_421051.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_421051", "421051047", "story_v_out_421051.awb")

						arg_189_1:RecordAudio("421051047", var_192_6)
						arg_189_1:RecordAudio("421051047", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_421051", "421051047", "story_v_out_421051.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_421051", "421051047", "story_v_out_421051.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play421051048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 421051048
		arg_193_1.duration_ = 12.67

		local var_193_0 = {
			zh = 12.1,
			ja = 12.666
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
				arg_193_0:Play421051049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10145ui_story = arg_193_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10145ui_story"].transform.position).z)
				arg_193_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["10145ui_story"].transform.localEulerAngles = arg_193_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_193_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10145ui_story"].transform.position).z)
				arg_193_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["10145ui_story"].transform.localEulerAngles = arg_193_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_196_1 = 0
			local var_196_2 = 1.375

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:GetWordFromCfg(421051048)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_6 = 55 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_4) / 55)

				if (55 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_4) / 55)) > 0 and var_196_2 < var_196_6 then
					arg_193_1.talkMaxDuration = var_196_6

					if var_196_6 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_1
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051048", "story_v_out_421051.awb") ~= 0 then
					local var_196_7 = manager.audio:GetVoiceLength("story_v_out_421051", "421051048", "story_v_out_421051.awb") / 1000

					if var_196_7 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_1
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_out_421051", "421051048", "story_v_out_421051.awb")

						arg_193_1:RecordAudio("421051048", var_196_8)
						arg_193_1:RecordAudio("421051048", var_196_8)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_421051", "421051048", "story_v_out_421051.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_421051", "421051048", "story_v_out_421051.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_9 = math.max(var_196_2, arg_193_1.talkMaxDuration)

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_9 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_1) / var_196_9

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_1 + var_196_9 and arg_193_1.time_ < var_196_1 + var_196_9 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421051049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 421051049
		arg_197_1.duration_ = 9.47

		local var_197_0 = {
			zh = 5.5,
			ja = 9.466
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
				arg_197_0:Play421051050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos10102ui_story = arg_197_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["10102ui_story"].transform.position).z)
				arg_197_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["10102ui_story"].transform.localEulerAngles = arg_197_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_197_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["10102ui_story"].transform.position).z)
				arg_197_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["10102ui_story"].transform.localEulerAngles = arg_197_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["10102ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect10102ui_story == nil then
				arg_197_1.var_.characterEffect10102ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect10102ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect10102ui_story then
				arg_197_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_200_4 = arg_197_1.actors_["10145ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_4) and arg_197_1.var_.characterEffect10145ui_story == nil then
				arg_197_1.var_.characterEffect10145ui_story = var_200_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_5 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_5 and not isNil(var_200_4) then
				if arg_197_1.var_.characterEffect10145ui_story and not isNil(var_200_4) then
					arg_197_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_197_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_5)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_5 and arg_197_1.time_ < 0 + var_200_5 + arg_200_0 and not isNil(var_200_4) and arg_197_1.var_.characterEffect10145ui_story then
				arg_197_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_197_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_200_6 = 0
			local var_200_7 = 0.7

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
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

				local var_200_8 = arg_197_1:GetWordFromCfg(421051049)
				local var_200_9 = arg_197_1:FormatText(var_200_8.content)

				arg_197_1.text_.text = var_200_9

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 28 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_9) / 28)

				if (28 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_9) / 28)) > 0 and var_200_7 < var_200_11 then
					arg_197_1.talkMaxDuration = var_200_11

					if var_200_11 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_11 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_9
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051049", "story_v_out_421051.awb") ~= 0 then
					local var_200_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051049", "story_v_out_421051.awb") / 1000

					if var_200_12 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_12 + var_200_6
					end

					if var_200_8.prefab_name ~= "" and arg_197_1.actors_[var_200_8.prefab_name] ~= nil then
						local var_200_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_8.prefab_name].transform, "story_v_out_421051", "421051049", "story_v_out_421051.awb")

						arg_197_1:RecordAudio("421051049", var_200_13)
						arg_197_1:RecordAudio("421051049", var_200_13)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_421051", "421051049", "story_v_out_421051.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_421051", "421051049", "story_v_out_421051.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_14 = math.max(var_200_7, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_14 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_6) / var_200_14

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_14 and arg_197_1.time_ < var_200_6 + var_200_14 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421051050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 421051050
		arg_201_1.duration_ = 8.63

		local var_201_0 = {
			zh = 6.066,
			ja = 8.633
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
				arg_201_0:Play421051051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos10145ui_story = arg_201_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["10145ui_story"].transform.position).z)
				arg_201_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["10145ui_story"].transform.localEulerAngles = arg_201_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_201_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["10145ui_story"].transform.position).z)
				arg_201_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["10145ui_story"].transform.localEulerAngles = arg_201_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["10145ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect10145ui_story == nil then
				arg_201_1.var_.characterEffect10145ui_story = var_204_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 and not isNil(var_204_1) then
				if arg_201_1.var_.characterEffect10145ui_story and not isNil(var_204_1) then
					arg_201_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect10145ui_story then
				arg_201_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_204_4 = arg_201_1.actors_["10102ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect10102ui_story == nil then
				arg_201_1.var_.characterEffect10102ui_story = var_204_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_5 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_5 and not isNil(var_204_4) then
				if arg_201_1.var_.characterEffect10102ui_story and not isNil(var_204_4) then
					arg_201_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_201_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_5)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_5 and arg_201_1.time_ < 0 + var_204_5 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect10102ui_story then
				arg_201_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_201_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_2")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_204_6 = 0
			local var_204_7 = 0.775

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_8 = arg_201_1:GetWordFromCfg(421051050)
				local var_204_9 = arg_201_1:FormatText(var_204_8.content)

				arg_201_1.text_.text = var_204_9

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_11 = 31 <= 0 and var_204_7 or var_204_7 * (utf8.len(var_204_9) / 31)

				if (31 <= 0 and var_204_7 or var_204_7 * (utf8.len(var_204_9) / 31)) > 0 and var_204_7 < var_204_11 then
					arg_201_1.talkMaxDuration = var_204_11

					if var_204_11 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_11 + var_204_6
					end
				end

				arg_201_1.text_.text = var_204_9
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051050", "story_v_out_421051.awb") ~= 0 then
					local var_204_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051050", "story_v_out_421051.awb") / 1000

					if var_204_12 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_12 + var_204_6
					end

					if var_204_8.prefab_name ~= "" and arg_201_1.actors_[var_204_8.prefab_name] ~= nil then
						local var_204_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_8.prefab_name].transform, "story_v_out_421051", "421051050", "story_v_out_421051.awb")

						arg_201_1:RecordAudio("421051050", var_204_13)
						arg_201_1:RecordAudio("421051050", var_204_13)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_421051", "421051050", "story_v_out_421051.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_421051", "421051050", "story_v_out_421051.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_14 = math.max(var_204_7, arg_201_1.talkMaxDuration)

			if var_204_6 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_14 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_6) / var_204_14

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_6 + var_204_14 and arg_201_1.time_ < var_204_6 + var_204_14 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421051051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 421051051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play421051052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos10102ui_story = arg_205_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["10102ui_story"].transform.position).z)
				arg_205_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["10102ui_story"].transform.localEulerAngles = arg_205_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_205_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["10102ui_story"].transform.position).z)
				arg_205_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["10102ui_story"].transform.localEulerAngles = arg_205_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_208_1 = arg_205_1.actors_["10145ui_story"].transform

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos10145ui_story = var_208_1.localPosition
			end

			local var_208_2 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_2 then
				var_208_1.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_205_1.time_ - 0) / var_208_2)
				var_208_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_1.position).x, (manager.ui.mainCamera.transform.position - var_208_1.position).y, (manager.ui.mainCamera.transform.position - var_208_1.position).z)
				var_208_1.localEulerAngles.z = 0
				var_208_1.localEulerAngles.x = 0
				var_208_1.localEulerAngles = var_208_1.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_2 and arg_205_1.time_ < 0 + var_208_2 + arg_208_0 then
				var_208_1.localPosition = Vector3.New(0, 100, 0)
				var_208_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_1.position).x, (manager.ui.mainCamera.transform.position - var_208_1.position).y, (manager.ui.mainCamera.transform.position - var_208_1.position).z)
				var_208_1.localEulerAngles.z = 0
				var_208_1.localEulerAngles.x = 0
				var_208_1.localEulerAngles = var_208_1.localEulerAngles
			end

			if 0.1 < arg_205_1.time_ and arg_205_1.time_ <= 0.1 + arg_208_0 then
				arg_205_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car05", "")
			end

			local var_208_4 = 0
			local var_208_5 = 0.675

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_6 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(421051051).content)

				arg_205_1.text_.text = var_208_6

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_8 = 27 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_6) / 27)

				if (27 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_6) / 27)) > 0 and var_208_5 < var_208_8 then
					arg_205_1.talkMaxDuration = var_208_8

					if var_208_8 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_4
					end
				end

				arg_205_1.text_.text = var_208_6
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_9 = math.max(var_208_5, arg_205_1.talkMaxDuration)

			if var_208_4 <= arg_205_1.time_ and arg_205_1.time_ < var_208_4 + var_208_9 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_4) / var_208_9

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_4 + var_208_9 and arg_205_1.time_ < var_208_4 + var_208_9 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play421051052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 421051052
		arg_209_1.duration_ = 3.53

		local var_209_0 = {
			zh = 2.7,
			ja = 3.533
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
				arg_209_0:Play421051053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if arg_209_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_212_0 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_209_1.stage_.transform)

				var_212_0.name = "1047ui_story"
				var_212_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.actors_["1047ui_story"] = var_212_0

				local var_212_1 = var_212_0:GetComponentInChildren(typeof(CharacterEffect))

				var_212_1.enabled = true

				local var_212_2 = GameObjectTools.GetOrAddComponent(var_212_0, typeof(DynamicBoneHelper))

				if var_212_2 then
					var_212_2:EnableDynamicBone(false)
				end

				arg_209_1:ShowWeapon(var_212_1.transform, false)

				arg_209_1.var_["1047ui_story" .. "Animator"] = var_212_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_209_1.var_["1047ui_story" .. "Animator"].applyRootMotion = true
				arg_209_1.var_["1047ui_story" .. "LipSync"] = var_212_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_212_3 = arg_209_1.actors_["1047ui_story"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1047ui_story = var_212_3.localPosition
			end

			local var_212_4 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				var_212_3.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_209_1.time_ - 0) / var_212_4)
				var_212_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_3.position).x, (manager.ui.mainCamera.transform.position - var_212_3.position).y, (manager.ui.mainCamera.transform.position - var_212_3.position).z)
				var_212_3.localEulerAngles.z = 0
				var_212_3.localEulerAngles.x = 0
				var_212_3.localEulerAngles = var_212_3.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				var_212_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_212_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_3.position).x, (manager.ui.mainCamera.transform.position - var_212_3.position).y, (manager.ui.mainCamera.transform.position - var_212_3.position).z)
				var_212_3.localEulerAngles.z = 0
				var_212_3.localEulerAngles.x = 0
				var_212_3.localEulerAngles = var_212_3.localEulerAngles
			end

			local var_212_5 = arg_209_1.actors_["1047ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.characterEffect1047ui_story == nil then
				arg_209_1.var_.characterEffect1047ui_story = var_212_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_6 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_6 and not isNil(var_212_5) then
				if arg_209_1.var_.characterEffect1047ui_story and not isNil(var_212_5) then
					arg_209_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_6 and arg_209_1.time_ < 0 + var_212_6 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.characterEffect1047ui_story then
				arg_209_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_212_8 = 0
			local var_212_9 = 0.325

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_10 = arg_209_1:GetWordFromCfg(421051052)
				local var_212_11 = arg_209_1:FormatText(var_212_10.content)

				arg_209_1.text_.text = var_212_11

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 13 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 13)

				if (13 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 13)) > 0 and var_212_9 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_8
					end
				end

				arg_209_1.text_.text = var_212_11
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051052", "story_v_out_421051.awb") ~= 0 then
					local var_212_14 = manager.audio:GetVoiceLength("story_v_out_421051", "421051052", "story_v_out_421051.awb") / 1000

					if var_212_14 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_14 + var_212_8
					end

					if var_212_10.prefab_name ~= "" and arg_209_1.actors_[var_212_10.prefab_name] ~= nil then
						local var_212_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_10.prefab_name].transform, "story_v_out_421051", "421051052", "story_v_out_421051.awb")

						arg_209_1:RecordAudio("421051052", var_212_15)
						arg_209_1:RecordAudio("421051052", var_212_15)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_421051", "421051052", "story_v_out_421051.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_421051", "421051052", "story_v_out_421051.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_16 = math.max(var_212_9, arg_209_1.talkMaxDuration)

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_16 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_8) / var_212_16

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_8 + var_212_16 and arg_209_1.time_ < var_212_8 + var_212_16 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421051053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 421051053
		arg_213_1.duration_ = 15.03

		local var_213_0 = {
			zh = 13.433,
			ja = 15.033
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
				arg_213_0:Play421051054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if arg_213_1.bgs_.ST2401 == nil then
				local var_216_0 = Object.Instantiate(arg_213_1.paintGo_)

				var_216_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2401")
				var_216_0.name = "ST2401"
				var_216_0.transform.parent = arg_213_1.stage_.transform
				var_216_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.bgs_.ST2401 = var_216_0
			end

			if 2 < arg_213_1.time_ and arg_213_1.time_ <= 2 + arg_216_0 then
				local var_216_1 = arg_213_1.bgs_.ST2401

				arg_213_1.bgs_.ST2401.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_216_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_216_2 = var_216_1:GetComponent("SpriteRenderer")

				if var_216_2 and var_216_2.sprite then
					local var_216_3 = 2 * (var_216_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_216_1.transform.localScale = Vector3.New(var_216_3 / var_216_2.sprite.bounds.size.y < var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x and var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x or var_216_3 / var_216_2.sprite.bounds.size.y, var_216_3 / var_216_2.sprite.bounds.size.y < var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x and var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x or var_216_3 / var_216_2.sprite.bounds.size.y, 0)
				end

				for iter_216_0, iter_216_1 in pairs(arg_213_1.bgs_) do
					if iter_216_0 ~= "ST2401" then
						iter_216_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_216_4 = 4

			if 4 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.allBtn_.enabled = false
			end

			if arg_213_1.time_ >= var_216_4 + 0.6 and arg_213_1.time_ < var_216_4 + 0.6 + arg_216_0 then
				arg_213_1.allBtn_.enabled = true
			end

			local var_216_5 = 0

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_6 = 2

			if var_216_5 <= arg_213_1.time_ and arg_213_1.time_ < var_216_5 + var_216_6 then
				local var_216_7 = Color.New(0, 0, 0)

				var_216_7.a = Mathf.Lerp(0, 1, (arg_213_1.time_ - var_216_5) / var_216_6)
				arg_213_1.mask_.color = var_216_7
			end

			if arg_213_1.time_ >= var_216_5 + var_216_6 and arg_213_1.time_ < var_216_5 + var_216_6 + arg_216_0 then
				local var_216_8 = Color.New(0, 0, 0)

				var_216_8.a = 1
				arg_213_1.mask_.color = var_216_8
			end

			local var_216_9 = 2

			if 2 < arg_213_1.time_ and arg_213_1.time_ <= var_216_9 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_10 = 2

			if var_216_9 <= arg_213_1.time_ and arg_213_1.time_ < var_216_9 + var_216_10 then
				local var_216_11 = Color.New(0, 0, 0)

				var_216_11.a = Mathf.Lerp(1, 0, (arg_213_1.time_ - var_216_9) / var_216_10)
				arg_213_1.mask_.color = var_216_11
			end

			if arg_213_1.time_ >= var_216_9 + var_216_10 and arg_213_1.time_ < var_216_9 + var_216_10 + arg_216_0 then
				local var_216_12 = Color.New(0, 0, 0)

				arg_213_1.mask_.enabled = false
				var_216_12.a = 0
				arg_213_1.mask_.color = var_216_12
			end

			local var_216_13 = arg_213_1.actors_["1047ui_story"].transform

			if 1.96666666666667 < arg_213_1.time_ and arg_213_1.time_ <= 1.96666666666667 + arg_216_0 then
				arg_213_1.var_.moveOldPos1047ui_story = var_216_13.localPosition
			end

			local var_216_14 = 0.001

			if 1.96666666666667 <= arg_213_1.time_ and arg_213_1.time_ < 1.96666666666667 + var_216_14 then
				var_216_13.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_213_1.time_ - 1.96666666666667) / var_216_14)
				var_216_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_13.position).x, (manager.ui.mainCamera.transform.position - var_216_13.position).y, (manager.ui.mainCamera.transform.position - var_216_13.position).z)
				var_216_13.localEulerAngles.z = 0
				var_216_13.localEulerAngles.x = 0
				var_216_13.localEulerAngles = var_216_13.localEulerAngles
			end

			if arg_213_1.time_ >= 1.96666666666667 + var_216_14 and arg_213_1.time_ < 1.96666666666667 + var_216_14 + arg_216_0 then
				var_216_13.localPosition = Vector3.New(0, 100, 0)
				var_216_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_13.position).x, (manager.ui.mainCamera.transform.position - var_216_13.position).y, (manager.ui.mainCamera.transform.position - var_216_13.position).z)
				var_216_13.localEulerAngles.z = 0
				var_216_13.localEulerAngles.x = 0
				var_216_13.localEulerAngles = var_216_13.localEulerAngles
			end

			local var_216_15 = "10143ui_story"

			if arg_213_1.actors_["10143ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10143ui_story"))) then
				local var_216_16 = Object.Instantiate(Asset.Load("Char/" .. "10143ui_story"), arg_213_1.stage_.transform)

				var_216_16.name = var_216_15
				var_216_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.actors_[var_216_15] = var_216_16

				local var_216_17 = var_216_16:GetComponentInChildren(typeof(CharacterEffect))

				var_216_17.enabled = true

				local var_216_18 = GameObjectTools.GetOrAddComponent(var_216_16, typeof(DynamicBoneHelper))

				if var_216_18 then
					var_216_18:EnableDynamicBone(false)
				end

				arg_213_1:ShowWeapon(var_216_17.transform, false)

				arg_213_1.var_[var_216_15 .. "Animator"] = var_216_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_213_1.var_[var_216_15 .. "Animator"].applyRootMotion = true
				arg_213_1.var_[var_216_15 .. "LipSync"] = var_216_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_216_19 = arg_213_1.actors_["10143ui_story"].transform

			if 3.83333333333333 < arg_213_1.time_ and arg_213_1.time_ <= 3.83333333333333 + arg_216_0 then
				arg_213_1.var_.moveOldPos10143ui_story = var_216_19.localPosition
			end

			local var_216_20 = 0.001

			if 3.83333333333333 <= arg_213_1.time_ and arg_213_1.time_ < 3.83333333333333 + var_216_20 then
				var_216_19.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_213_1.time_ - 3.83333333333333) / var_216_20)
				var_216_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_19.position).x, (manager.ui.mainCamera.transform.position - var_216_19.position).y, (manager.ui.mainCamera.transform.position - var_216_19.position).z)
				var_216_19.localEulerAngles.z = 0
				var_216_19.localEulerAngles.x = 0
				var_216_19.localEulerAngles = var_216_19.localEulerAngles
			end

			if arg_213_1.time_ >= 3.83333333333333 + var_216_20 and arg_213_1.time_ < 3.83333333333333 + var_216_20 + arg_216_0 then
				var_216_19.localPosition = Vector3.New(-0.72, -1.06, -6)
				var_216_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_19.position).x, (manager.ui.mainCamera.transform.position - var_216_19.position).y, (manager.ui.mainCamera.transform.position - var_216_19.position).z)
				var_216_19.localEulerAngles.z = 0
				var_216_19.localEulerAngles.x = 0
				var_216_19.localEulerAngles = var_216_19.localEulerAngles
			end

			local var_216_21 = arg_213_1.actors_["10143ui_story"]

			if 3.83333333333333 < arg_213_1.time_ and arg_213_1.time_ <= 3.83333333333333 + arg_216_0 and not isNil(var_216_21) and arg_213_1.var_.characterEffect10143ui_story == nil then
				arg_213_1.var_.characterEffect10143ui_story = var_216_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_22 = 0.200000002980232

			if 3.83333333333333 <= arg_213_1.time_ and arg_213_1.time_ < 3.83333333333333 + var_216_22 and not isNil(var_216_21) then
				if arg_213_1.var_.characterEffect10143ui_story and not isNil(var_216_21) then
					arg_213_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 3.83333333333333 + var_216_22 and arg_213_1.time_ < 3.83333333333333 + var_216_22 + arg_216_0 and not isNil(var_216_21) and arg_213_1.var_.characterEffect10143ui_story then
				arg_213_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_216_24 = arg_213_1.actors_["1047ui_story"]

			if 3.83333333333333 < arg_213_1.time_ and arg_213_1.time_ <= 3.83333333333333 + arg_216_0 and not isNil(var_216_24) and arg_213_1.var_.characterEffect1047ui_story == nil then
				arg_213_1.var_.characterEffect1047ui_story = var_216_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_25 = 0.200000002980232

			if 3.83333333333333 <= arg_213_1.time_ and arg_213_1.time_ < 3.83333333333333 + var_216_25 and not isNil(var_216_24) then
				if arg_213_1.var_.characterEffect1047ui_story and not isNil(var_216_24) then
					arg_213_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 3.83333333333333) / var_216_25)
				end
			end

			if arg_213_1.time_ >= 3.83333333333333 + var_216_25 and arg_213_1.time_ < 3.83333333333333 + var_216_25 + arg_216_0 and not isNil(var_216_24) and arg_213_1.var_.characterEffect1047ui_story then
				arg_213_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 3.83333333333333 < arg_213_1.time_ and arg_213_1.time_ <= 3.83333333333333 + arg_216_0 then
				arg_213_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 3.83333333333333 < arg_213_1.time_ and arg_213_1.time_ <= 3.83333333333333 + arg_216_0 then
				arg_213_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_213_1.time_ and arg_213_1.time_ <= 0.1 + arg_216_0 then
				arg_213_1:AudioAction("stop", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if 1.53333333333333 < arg_213_1.time_ and arg_213_1.time_ <= 1.53333333333333 + arg_216_0 then
				arg_213_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			if arg_213_1.frameCnt_ <= 1 then
				arg_213_1.dialog_:SetActive(false)
			end

			local var_216_28 = 4
			local var_216_29 = 0.975

			if 4 < arg_213_1.time_ and arg_213_1.time_ <= var_216_28 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0

				arg_213_1.dialog_:SetActive(true)

				arg_213_1.dialogCg_.alpha = 0

				local var_216_30 = LeanTween.value(arg_213_1.dialog_, 0, 1, 0.3)

				var_216_30:setOnUpdate(LuaHelper.FloatAction(function(arg_217_0)
					arg_213_1.dialogCg_.alpha = arg_217_0
				end))
				var_216_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_213_1.dialog_)
					var_216_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_213_1.duration_ = arg_213_1.duration_ + 0.3

				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_31 = arg_213_1:GetWordFromCfg(421051053)
				local var_216_32 = arg_213_1:FormatText(var_216_31.content)

				arg_213_1.text_.text = var_216_32

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_34 = 39 <= 0 and var_216_29 or var_216_29 * (utf8.len(var_216_32) / 39)

				if (39 <= 0 and var_216_29 or var_216_29 * (utf8.len(var_216_32) / 39)) > 0 and var_216_29 < var_216_34 then
					arg_213_1.talkMaxDuration = var_216_34
					var_216_28 = var_216_28 + 0.3

					if var_216_34 + var_216_28 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_34 + var_216_28
					end
				end

				arg_213_1.text_.text = var_216_32
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051053", "story_v_out_421051.awb") ~= 0 then
					local var_216_35 = manager.audio:GetVoiceLength("story_v_out_421051", "421051053", "story_v_out_421051.awb") / 1000

					if var_216_35 + var_216_28 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_35 + var_216_28
					end

					if var_216_31.prefab_name ~= "" and arg_213_1.actors_[var_216_31.prefab_name] ~= nil then
						local var_216_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_31.prefab_name].transform, "story_v_out_421051", "421051053", "story_v_out_421051.awb")

						arg_213_1:RecordAudio("421051053", var_216_36)
						arg_213_1:RecordAudio("421051053", var_216_36)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_421051", "421051053", "story_v_out_421051.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_421051", "421051053", "story_v_out_421051.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_37 = var_216_28 + 0.3
			local var_216_38 = math.max(var_216_29, arg_213_1.talkMaxDuration)

			if var_216_28 + 0.3 <= arg_213_1.time_ and arg_213_1.time_ < var_216_37 + var_216_38 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_37) / var_216_38

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_37 + var_216_38 and arg_213_1.time_ < var_216_37 + var_216_38 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play421051054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 421051054
		arg_219_1.duration_ = 4.03

		local var_219_0 = {
			zh = 2.333,
			ja = 4.033
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
				arg_219_0:Play421051055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos10145ui_story = arg_219_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10145ui_story"].transform.position).z)
				arg_219_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["10145ui_story"].transform.localEulerAngles = arg_219_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_219_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10145ui_story"].transform.position).z)
				arg_219_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["10145ui_story"].transform.localEulerAngles = arg_219_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_222_1 = arg_219_1.actors_["10145ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect10145ui_story == nil then
				arg_219_1.var_.characterEffect10145ui_story = var_222_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 and not isNil(var_222_1) then
				if arg_219_1.var_.characterEffect10145ui_story and not isNil(var_222_1) then
					arg_219_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect10145ui_story then
				arg_219_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_222_4 = arg_219_1.actors_["10143ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_4) and arg_219_1.var_.characterEffect10143ui_story == nil then
				arg_219_1.var_.characterEffect10143ui_story = var_222_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_5 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_5 and not isNil(var_222_4) then
				if arg_219_1.var_.characterEffect10143ui_story and not isNil(var_222_4) then
					arg_219_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_219_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_5)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_5 and arg_219_1.time_ < 0 + var_222_5 + arg_222_0 and not isNil(var_222_4) and arg_219_1.var_.characterEffect10143ui_story then
				arg_219_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_219_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_222_6 = 0
			local var_222_7 = 0.325

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_6 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_8 = arg_219_1:GetWordFromCfg(421051054)
				local var_222_9 = arg_219_1:FormatText(var_222_8.content)

				arg_219_1.text_.text = var_222_9

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_11 = 13 <= 0 and var_222_7 or var_222_7 * (utf8.len(var_222_9) / 13)

				if (13 <= 0 and var_222_7 or var_222_7 * (utf8.len(var_222_9) / 13)) > 0 and var_222_7 < var_222_11 then
					arg_219_1.talkMaxDuration = var_222_11

					if var_222_11 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_11 + var_222_6
					end
				end

				arg_219_1.text_.text = var_222_9
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051054", "story_v_out_421051.awb") ~= 0 then
					local var_222_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051054", "story_v_out_421051.awb") / 1000

					if var_222_12 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_12 + var_222_6
					end

					if var_222_8.prefab_name ~= "" and arg_219_1.actors_[var_222_8.prefab_name] ~= nil then
						local var_222_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_8.prefab_name].transform, "story_v_out_421051", "421051054", "story_v_out_421051.awb")

						arg_219_1:RecordAudio("421051054", var_222_13)
						arg_219_1:RecordAudio("421051054", var_222_13)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_421051", "421051054", "story_v_out_421051.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_421051", "421051054", "story_v_out_421051.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_14 = math.max(var_222_7, arg_219_1.talkMaxDuration)

			if var_222_6 <= arg_219_1.time_ and arg_219_1.time_ < var_222_6 + var_222_14 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_6) / var_222_14

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_6 + var_222_14 and arg_219_1.time_ < var_222_6 + var_222_14 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421051055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 421051055
		arg_223_1.duration_ = 7.4

		local var_223_0 = {
			zh = 6.033,
			ja = 7.4
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
				arg_223_0:Play421051056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos10143ui_story = arg_223_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10143ui_story"].transform.position).z)
				arg_223_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["10143ui_story"].transform.localEulerAngles = arg_223_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_223_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10143ui_story"].transform.position).z)
				arg_223_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["10143ui_story"].transform.localEulerAngles = arg_223_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["10143ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect10143ui_story == nil then
				arg_223_1.var_.characterEffect10143ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect10143ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect10143ui_story then
				arg_223_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_226_4 = arg_223_1.actors_["10145ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_4) and arg_223_1.var_.characterEffect10145ui_story == nil then
				arg_223_1.var_.characterEffect10145ui_story = var_226_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_5 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_5 and not isNil(var_226_4) then
				if arg_223_1.var_.characterEffect10145ui_story and not isNil(var_226_4) then
					arg_223_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_223_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_5)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_5 and arg_223_1.time_ < 0 + var_226_5 + arg_226_0 and not isNil(var_226_4) and arg_223_1.var_.characterEffect10145ui_story then
				arg_223_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_223_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action4_1")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_226_6 = 0
			local var_226_7 = 0.675

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_8 = arg_223_1:GetWordFromCfg(421051055)
				local var_226_9 = arg_223_1:FormatText(var_226_8.content)

				arg_223_1.text_.text = var_226_9

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_11 = 27 <= 0 and var_226_7 or var_226_7 * (utf8.len(var_226_9) / 27)

				if (27 <= 0 and var_226_7 or var_226_7 * (utf8.len(var_226_9) / 27)) > 0 and var_226_7 < var_226_11 then
					arg_223_1.talkMaxDuration = var_226_11

					if var_226_11 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_11 + var_226_6
					end
				end

				arg_223_1.text_.text = var_226_9
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051055", "story_v_out_421051.awb") ~= 0 then
					local var_226_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051055", "story_v_out_421051.awb") / 1000

					if var_226_12 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_12 + var_226_6
					end

					if var_226_8.prefab_name ~= "" and arg_223_1.actors_[var_226_8.prefab_name] ~= nil then
						local var_226_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_8.prefab_name].transform, "story_v_out_421051", "421051055", "story_v_out_421051.awb")

						arg_223_1:RecordAudio("421051055", var_226_13)
						arg_223_1:RecordAudio("421051055", var_226_13)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_421051", "421051055", "story_v_out_421051.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_421051", "421051055", "story_v_out_421051.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_14 = math.max(var_226_7, arg_223_1.talkMaxDuration)

			if var_226_6 <= arg_223_1.time_ and arg_223_1.time_ < var_226_6 + var_226_14 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_6) / var_226_14

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_6 + var_226_14 and arg_223_1.time_ < var_226_6 + var_226_14 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
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
	Play421051056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 421051056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play421051057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["10143ui_story"]) and arg_227_1.var_.characterEffect10143ui_story == nil then
				arg_227_1.var_.characterEffect10143ui_story = arg_227_1.actors_["10143ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["10143ui_story"]) then
				if arg_227_1.var_.characterEffect10143ui_story and not isNil(arg_227_1.actors_["10143ui_story"]) then
					arg_227_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_227_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_0)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["10143ui_story"]) and arg_227_1.var_.characterEffect10143ui_story then
				arg_227_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_227_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			local var_230_1 = 0
			local var_230_2 = 0.175

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(421051056).content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 7 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 7)

				if (7 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 7)) > 0 and var_230_2 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_1 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_1
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_6 = math.max(var_230_2, arg_227_1.talkMaxDuration)

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_6 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_1) / var_230_6

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_1 + var_230_6 and arg_227_1.time_ < var_230_1 + var_230_6 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play421051057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 421051057
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play421051058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos10143ui_story = arg_231_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10143ui_story"].transform.position).z)
				arg_231_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["10143ui_story"].transform.localEulerAngles = arg_231_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10143ui_story"].transform.position).z)
				arg_231_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["10143ui_story"].transform.localEulerAngles = arg_231_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["10145ui_story"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos10145ui_story = var_234_1.localPosition
			end

			local var_234_2 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 then
				var_234_1.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 0) / var_234_2)
				var_234_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_1.position).x, (manager.ui.mainCamera.transform.position - var_234_1.position).y, (manager.ui.mainCamera.transform.position - var_234_1.position).z)
				var_234_1.localEulerAngles.z = 0
				var_234_1.localEulerAngles.x = 0
				var_234_1.localEulerAngles = var_234_1.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 then
				var_234_1.localPosition = Vector3.New(0, 100, 0)
				var_234_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_1.position).x, (manager.ui.mainCamera.transform.position - var_234_1.position).y, (manager.ui.mainCamera.transform.position - var_234_1.position).z)
				var_234_1.localEulerAngles.z = 0
				var_234_1.localEulerAngles.x = 0
				var_234_1.localEulerAngles = var_234_1.localEulerAngles
			end

			local var_234_3 = 0
			local var_234_4 = 0.55

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_3 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_5 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(421051057).content)

				arg_231_1.text_.text = var_234_5

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_7 = 22 <= 0 and var_234_4 or var_234_4 * (utf8.len(var_234_5) / 22)

				if (22 <= 0 and var_234_4 or var_234_4 * (utf8.len(var_234_5) / 22)) > 0 and var_234_4 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_3 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_3
					end
				end

				arg_231_1.text_.text = var_234_5
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_8 = math.max(var_234_4, arg_231_1.talkMaxDuration)

			if var_234_3 <= arg_231_1.time_ and arg_231_1.time_ < var_234_3 + var_234_8 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_3) / var_234_8

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_3 + var_234_8 and arg_231_1.time_ < var_234_3 + var_234_8 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play421051058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 421051058
		arg_235_1.duration_ = 2.73

		local var_235_0 = {
			zh = 1.999999999999,
			ja = 2.733
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
				arg_235_0:Play421051059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos10143ui_story = arg_235_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_238_0 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 then
				arg_235_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10143ui_story, Vector3.New(0, -1.06, -6), (arg_235_1.time_ - 0) / var_238_0)
				arg_235_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["10143ui_story"].transform.position).z)
				arg_235_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["10143ui_story"].transform.localEulerAngles = arg_235_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 then
				arg_235_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6)
				arg_235_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["10143ui_story"].transform.position).z)
				arg_235_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["10143ui_story"].transform.localEulerAngles = arg_235_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_238_1 = arg_235_1.actors_["10143ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect10143ui_story == nil then
				arg_235_1.var_.characterEffect10143ui_story = var_238_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_2 and not isNil(var_238_1) then
				if arg_235_1.var_.characterEffect10143ui_story and not isNil(var_238_1) then
					arg_235_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_2 and arg_235_1.time_ < 0 + var_238_2 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect10143ui_story then
				arg_235_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action4_2")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_238_4 = 0
			local var_238_5 = 0.25

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_6 = arg_235_1:GetWordFromCfg(421051058)
				local var_238_7 = arg_235_1:FormatText(var_238_6.content)

				arg_235_1.text_.text = var_238_7

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_9 = 10 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 10)

				if (10 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 10)) > 0 and var_238_5 < var_238_9 then
					arg_235_1.talkMaxDuration = var_238_9

					if var_238_9 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_9 + var_238_4
					end
				end

				arg_235_1.text_.text = var_238_7
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051058", "story_v_out_421051.awb") ~= 0 then
					local var_238_10 = manager.audio:GetVoiceLength("story_v_out_421051", "421051058", "story_v_out_421051.awb") / 1000

					if var_238_10 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_4
					end

					if var_238_6.prefab_name ~= "" and arg_235_1.actors_[var_238_6.prefab_name] ~= nil then
						local var_238_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_6.prefab_name].transform, "story_v_out_421051", "421051058", "story_v_out_421051.awb")

						arg_235_1:RecordAudio("421051058", var_238_11)
						arg_235_1:RecordAudio("421051058", var_238_11)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_421051", "421051058", "story_v_out_421051.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_421051", "421051058", "story_v_out_421051.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_12 = math.max(var_238_5, arg_235_1.talkMaxDuration)

			if var_238_4 <= arg_235_1.time_ and arg_235_1.time_ < var_238_4 + var_238_12 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_4) / var_238_12

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_4 + var_238_12 and arg_235_1.time_ < var_238_4 + var_238_12 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
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
	Play421051059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 421051059
		arg_239_1.duration_ = 9

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play421051060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if arg_239_1.bgs_.B10e == nil then
				local var_242_0 = Object.Instantiate(arg_239_1.paintGo_)

				var_242_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B10e")
				var_242_0.name = "B10e"
				var_242_0.transform.parent = arg_239_1.stage_.transform
				var_242_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_239_1.bgs_.B10e = var_242_0
			end

			if 2 < arg_239_1.time_ and arg_239_1.time_ <= 2 + arg_242_0 then
				local var_242_1 = arg_239_1.bgs_.B10e

				arg_239_1.bgs_.B10e.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_242_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_242_2 = var_242_1:GetComponent("SpriteRenderer")

				if var_242_2 and var_242_2.sprite then
					local var_242_3 = 2 * (var_242_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_242_1.transform.localScale = Vector3.New(var_242_3 / var_242_2.sprite.bounds.size.y < var_242_3 * manager.ui.mainCameraCom_.aspect / var_242_2.sprite.bounds.size.x and var_242_3 * manager.ui.mainCameraCom_.aspect / var_242_2.sprite.bounds.size.x or var_242_3 / var_242_2.sprite.bounds.size.y, var_242_3 / var_242_2.sprite.bounds.size.y < var_242_3 * manager.ui.mainCameraCom_.aspect / var_242_2.sprite.bounds.size.x and var_242_3 * manager.ui.mainCameraCom_.aspect / var_242_2.sprite.bounds.size.x or var_242_3 / var_242_2.sprite.bounds.size.y, 0)
				end

				for iter_242_0, iter_242_1 in pairs(arg_239_1.bgs_) do
					if iter_242_0 ~= "B10e" then
						iter_242_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_242_4 = 4

			if 4 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.allBtn_.enabled = false
			end

			if arg_239_1.time_ >= var_242_4 + 0.3 and arg_239_1.time_ < var_242_4 + 0.3 + arg_242_0 then
				arg_239_1.allBtn_.enabled = true
			end

			local var_242_5 = 0

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_5 + arg_242_0 then
				arg_239_1.mask_.enabled = true
				arg_239_1.mask_.raycastTarget = true

				arg_239_1:SetGaussion(false)
			end

			local var_242_6 = 2

			if var_242_5 <= arg_239_1.time_ and arg_239_1.time_ < var_242_5 + var_242_6 then
				local var_242_7 = Color.New(0, 0, 0)

				var_242_7.a = Mathf.Lerp(0, 1, (arg_239_1.time_ - var_242_5) / var_242_6)
				arg_239_1.mask_.color = var_242_7
			end

			if arg_239_1.time_ >= var_242_5 + var_242_6 and arg_239_1.time_ < var_242_5 + var_242_6 + arg_242_0 then
				local var_242_8 = Color.New(0, 0, 0)

				var_242_8.a = 1
				arg_239_1.mask_.color = var_242_8
			end

			local var_242_9 = 2

			if 2 < arg_239_1.time_ and arg_239_1.time_ <= var_242_9 + arg_242_0 then
				arg_239_1.mask_.enabled = true
				arg_239_1.mask_.raycastTarget = true

				arg_239_1:SetGaussion(false)
			end

			local var_242_10 = 2

			if var_242_9 <= arg_239_1.time_ and arg_239_1.time_ < var_242_9 + var_242_10 then
				local var_242_11 = Color.New(0, 0, 0)

				var_242_11.a = Mathf.Lerp(1, 0, (arg_239_1.time_ - var_242_9) / var_242_10)
				arg_239_1.mask_.color = var_242_11
			end

			if arg_239_1.time_ >= var_242_9 + var_242_10 and arg_239_1.time_ < var_242_9 + var_242_10 + arg_242_0 then
				local var_242_12 = Color.New(0, 0, 0)

				arg_239_1.mask_.enabled = false
				var_242_12.a = 0
				arg_239_1.mask_.color = var_242_12
			end

			local var_242_13 = arg_239_1.actors_["10143ui_story"].transform

			if 2 < arg_239_1.time_ and arg_239_1.time_ <= 2 + arg_242_0 then
				arg_239_1.var_.moveOldPos10143ui_story = var_242_13.localPosition
			end

			local var_242_14 = 0.001

			if 2 <= arg_239_1.time_ and arg_239_1.time_ < 2 + var_242_14 then
				var_242_13.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_239_1.time_ - 2) / var_242_14)
				var_242_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_242_13.position).x, (manager.ui.mainCamera.transform.position - var_242_13.position).y, (manager.ui.mainCamera.transform.position - var_242_13.position).z)
				var_242_13.localEulerAngles.z = 0
				var_242_13.localEulerAngles.x = 0
				var_242_13.localEulerAngles = var_242_13.localEulerAngles
			end

			if arg_239_1.time_ >= 2 + var_242_14 and arg_239_1.time_ < 2 + var_242_14 + arg_242_0 then
				var_242_13.localPosition = Vector3.New(0, 100, 0)
				var_242_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_242_13.position).x, (manager.ui.mainCamera.transform.position - var_242_13.position).y, (manager.ui.mainCamera.transform.position - var_242_13.position).z)
				var_242_13.localEulerAngles.z = 0
				var_242_13.localEulerAngles.x = 0
				var_242_13.localEulerAngles = var_242_13.localEulerAngles
			end

			if 0.1 < arg_239_1.time_ and arg_239_1.time_ <= 0.1 + arg_242_0 then
				arg_239_1:AudioAction("stop", "effect", "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			if 1.63333333333333 < arg_239_1.time_ and arg_239_1.time_ <= 1.63333333333333 + arg_242_0 then
				arg_239_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if arg_239_1.frameCnt_ <= 1 then
				arg_239_1.dialog_:SetActive(false)
			end

			local var_242_17 = 4
			local var_242_18 = 0.875

			if 4 < arg_239_1.time_ and arg_239_1.time_ <= var_242_17 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0

				arg_239_1.dialog_:SetActive(true)

				arg_239_1.dialogCg_.alpha = 0

				local var_242_19 = LeanTween.value(arg_239_1.dialog_, 0, 1, 0.3)

				var_242_19:setOnUpdate(LuaHelper.FloatAction(function(arg_243_0)
					arg_239_1.dialogCg_.alpha = arg_243_0
				end))
				var_242_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_239_1.dialog_)
					var_242_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_239_1.duration_ = arg_239_1.duration_ + 0.3

				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_20 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(421051059).content)

				arg_239_1.text_.text = var_242_20

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_22 = 35 <= 0 and var_242_18 or var_242_18 * (utf8.len(var_242_20) / 35)

				if (35 <= 0 and var_242_18 or var_242_18 * (utf8.len(var_242_20) / 35)) > 0 and var_242_18 < var_242_22 then
					arg_239_1.talkMaxDuration = var_242_22
					var_242_17 = var_242_17 + 0.3

					if var_242_22 + var_242_17 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_22 + var_242_17
					end
				end

				arg_239_1.text_.text = var_242_20
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_23 = var_242_17 + 0.3
			local var_242_24 = math.max(var_242_18, arg_239_1.talkMaxDuration)

			if var_242_17 + 0.3 <= arg_239_1.time_ and arg_239_1.time_ < var_242_23 + var_242_24 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_23) / var_242_24

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_23 + var_242_24 and arg_239_1.time_ < var_242_23 + var_242_24 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play421051060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 421051060
		arg_245_1.duration_ = 3.7

		local var_245_0 = {
			zh = 3.7,
			ja = 3.5
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
				arg_245_0:Play421051061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos10143ui_story = arg_245_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos10143ui_story, Vector3.New(-0.72, -1.06, -6), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["10143ui_story"].transform.position).z)
				arg_245_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["10143ui_story"].transform.localEulerAngles = arg_245_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(-0.72, -1.06, -6)
				arg_245_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["10143ui_story"].transform.position).z)
				arg_245_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["10143ui_story"].transform.localEulerAngles = arg_245_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_248_1 = arg_245_1.actors_["10143ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect10143ui_story == nil then
				arg_245_1.var_.characterEffect10143ui_story = var_248_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_2 and not isNil(var_248_1) then
				if arg_245_1.var_.characterEffect10143ui_story and not isNil(var_248_1) then
					arg_245_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_2 and arg_245_1.time_ < 0 + var_248_2 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect10143ui_story then
				arg_245_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_248_4 = 0
			local var_248_5 = 0.425

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_6 = arg_245_1:GetWordFromCfg(421051060)
				local var_248_7 = arg_245_1:FormatText(var_248_6.content)

				arg_245_1.text_.text = var_248_7

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_9 = 17 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 17)

				if (17 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 17)) > 0 and var_248_5 < var_248_9 then
					arg_245_1.talkMaxDuration = var_248_9

					if var_248_9 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_9 + var_248_4
					end
				end

				arg_245_1.text_.text = var_248_7
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051060", "story_v_out_421051.awb") ~= 0 then
					local var_248_10 = manager.audio:GetVoiceLength("story_v_out_421051", "421051060", "story_v_out_421051.awb") / 1000

					if var_248_10 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_4
					end

					if var_248_6.prefab_name ~= "" and arg_245_1.actors_[var_248_6.prefab_name] ~= nil then
						local var_248_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_6.prefab_name].transform, "story_v_out_421051", "421051060", "story_v_out_421051.awb")

						arg_245_1:RecordAudio("421051060", var_248_11)
						arg_245_1:RecordAudio("421051060", var_248_11)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_421051", "421051060", "story_v_out_421051.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_421051", "421051060", "story_v_out_421051.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_12 = math.max(var_248_5, arg_245_1.talkMaxDuration)

			if var_248_4 <= arg_245_1.time_ and arg_245_1.time_ < var_248_4 + var_248_12 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_4) / var_248_12

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_4 + var_248_12 and arg_245_1.time_ < var_248_4 + var_248_12 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play421051061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 421051061
		arg_249_1.duration_ = 4.33

		local var_249_0 = {
			zh = 2.433,
			ja = 4.333
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
				arg_249_0:Play421051062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos10145ui_story = arg_249_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10145ui_story"].transform.position).z)
				arg_249_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["10145ui_story"].transform.localEulerAngles = arg_249_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_249_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10145ui_story"].transform.position).z)
				arg_249_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["10145ui_story"].transform.localEulerAngles = arg_249_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["10145ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect10145ui_story == nil then
				arg_249_1.var_.characterEffect10145ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect10145ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect10145ui_story then
				arg_249_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_252_4 = arg_249_1.actors_["10143ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_4) and arg_249_1.var_.characterEffect10143ui_story == nil then
				arg_249_1.var_.characterEffect10143ui_story = var_252_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_5 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_5 and not isNil(var_252_4) then
				if arg_249_1.var_.characterEffect10143ui_story and not isNil(var_252_4) then
					arg_249_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_249_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_5)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_5 and arg_249_1.time_ < 0 + var_252_5 + arg_252_0 and not isNil(var_252_4) and arg_249_1.var_.characterEffect10143ui_story then
				arg_249_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_249_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_252_6 = 0
			local var_252_7 = 0.35

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_6 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_8 = arg_249_1:GetWordFromCfg(421051061)
				local var_252_9 = arg_249_1:FormatText(var_252_8.content)

				arg_249_1.text_.text = var_252_9

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_11 = 14 <= 0 and var_252_7 or var_252_7 * (utf8.len(var_252_9) / 14)

				if (14 <= 0 and var_252_7 or var_252_7 * (utf8.len(var_252_9) / 14)) > 0 and var_252_7 < var_252_11 then
					arg_249_1.talkMaxDuration = var_252_11

					if var_252_11 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_11 + var_252_6
					end
				end

				arg_249_1.text_.text = var_252_9
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051061", "story_v_out_421051.awb") ~= 0 then
					local var_252_12 = manager.audio:GetVoiceLength("story_v_out_421051", "421051061", "story_v_out_421051.awb") / 1000

					if var_252_12 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_12 + var_252_6
					end

					if var_252_8.prefab_name ~= "" and arg_249_1.actors_[var_252_8.prefab_name] ~= nil then
						local var_252_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_8.prefab_name].transform, "story_v_out_421051", "421051061", "story_v_out_421051.awb")

						arg_249_1:RecordAudio("421051061", var_252_13)
						arg_249_1:RecordAudio("421051061", var_252_13)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_421051", "421051061", "story_v_out_421051.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_421051", "421051061", "story_v_out_421051.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_14 = math.max(var_252_7, arg_249_1.talkMaxDuration)

			if var_252_6 <= arg_249_1.time_ and arg_249_1.time_ < var_252_6 + var_252_14 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_6) / var_252_14

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_6 + var_252_14 and arg_249_1.time_ < var_252_6 + var_252_14 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play421051062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 421051062
		arg_253_1.duration_ = 5.2

		local var_253_0 = {
			zh = 5,
			ja = 5.2
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
			arg_253_1.auto_ = false
		end

		function arg_253_1.playNext_(arg_255_0)
			arg_253_1.onStoryFinished_()
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1047ui_story = arg_253_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1047ui_story"].transform.position).z)
				arg_253_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1047ui_story"].transform.localEulerAngles = arg_253_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_253_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1047ui_story"].transform.position).z)
				arg_253_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1047ui_story"].transform.localEulerAngles = arg_253_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["10143ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos10143ui_story = var_256_1.localPosition
			end

			local var_256_2 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 then
				var_256_1.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0) / var_256_2)
				var_256_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_1.position).x, (manager.ui.mainCamera.transform.position - var_256_1.position).y, (manager.ui.mainCamera.transform.position - var_256_1.position).z)
				var_256_1.localEulerAngles.z = 0
				var_256_1.localEulerAngles.x = 0
				var_256_1.localEulerAngles = var_256_1.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 then
				var_256_1.localPosition = Vector3.New(0, 100, 0)
				var_256_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_1.position).x, (manager.ui.mainCamera.transform.position - var_256_1.position).y, (manager.ui.mainCamera.transform.position - var_256_1.position).z)
				var_256_1.localEulerAngles.z = 0
				var_256_1.localEulerAngles.x = 0
				var_256_1.localEulerAngles = var_256_1.localEulerAngles
			end

			local var_256_3 = arg_253_1.actors_["10145ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos10145ui_story = var_256_3.localPosition
			end

			local var_256_4 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				var_256_3.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0) / var_256_4)
				var_256_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_3.position).x, (manager.ui.mainCamera.transform.position - var_256_3.position).y, (manager.ui.mainCamera.transform.position - var_256_3.position).z)
				var_256_3.localEulerAngles.z = 0
				var_256_3.localEulerAngles.x = 0
				var_256_3.localEulerAngles = var_256_3.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				var_256_3.localPosition = Vector3.New(0, 100, 0)
				var_256_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_3.position).x, (manager.ui.mainCamera.transform.position - var_256_3.position).y, (manager.ui.mainCamera.transform.position - var_256_3.position).z)
				var_256_3.localEulerAngles.z = 0
				var_256_3.localEulerAngles.x = 0
				var_256_3.localEulerAngles = var_256_3.localEulerAngles
			end

			local var_256_5 = arg_253_1.actors_["1047ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_5) and arg_253_1.var_.characterEffect1047ui_story == nil then
				arg_253_1.var_.characterEffect1047ui_story = var_256_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_6 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_6 and not isNil(var_256_5) then
				if arg_253_1.var_.characterEffect1047ui_story and not isNil(var_256_5) then
					arg_253_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_6 and arg_253_1.time_ < 0 + var_256_6 + arg_256_0 and not isNil(var_256_5) and arg_253_1.var_.characterEffect1047ui_story then
				arg_253_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_256_8 = arg_253_1.actors_["10145ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.characterEffect10145ui_story == nil then
				arg_253_1.var_.characterEffect10145ui_story = var_256_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_9 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_9 and not isNil(var_256_8) then
				if arg_253_1.var_.characterEffect10145ui_story and not isNil(var_256_8) then
					arg_253_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_253_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_9)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_9 and arg_253_1.time_ < 0 + var_256_9 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.characterEffect10145ui_story then
				arg_253_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_253_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_256_10 = 0
			local var_256_11 = 0.525

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_10 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_12 = arg_253_1:GetWordFromCfg(421051062)
				local var_256_13 = arg_253_1:FormatText(var_256_12.content)

				arg_253_1.text_.text = var_256_13

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_15 = 21 <= 0 and var_256_11 or var_256_11 * (utf8.len(var_256_13) / 21)

				if (21 <= 0 and var_256_11 or var_256_11 * (utf8.len(var_256_13) / 21)) > 0 and var_256_11 < var_256_15 then
					arg_253_1.talkMaxDuration = var_256_15

					if var_256_15 + var_256_10 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_15 + var_256_10
					end
				end

				arg_253_1.text_.text = var_256_13
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421051", "421051062", "story_v_out_421051.awb") ~= 0 then
					local var_256_16 = manager.audio:GetVoiceLength("story_v_out_421051", "421051062", "story_v_out_421051.awb") / 1000

					if var_256_16 + var_256_10 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_16 + var_256_10
					end

					if var_256_12.prefab_name ~= "" and arg_253_1.actors_[var_256_12.prefab_name] ~= nil then
						local var_256_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_12.prefab_name].transform, "story_v_out_421051", "421051062", "story_v_out_421051.awb")

						arg_253_1:RecordAudio("421051062", var_256_17)
						arg_253_1:RecordAudio("421051062", var_256_17)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_421051", "421051062", "story_v_out_421051.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_421051", "421051062", "story_v_out_421051.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_18 = math.max(var_256_11, arg_253_1.talkMaxDuration)

			if var_256_10 <= arg_253_1.time_ and arg_253_1.time_ < var_256_10 + var_256_18 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_10) / var_256_18

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_10 + var_256_18 and arg_253_1.time_ < var_256_10 + var_256_18 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11i",
		"TextureConfig/Background/ST2401",
		"TextureConfig/Background/B10e"
	},
	voices = {
		"story_v_out_421051.awb"
	}
}
