return {
	Play321102001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321102001
		arg_1_1.duration_ = 7

		local var_1_0 = {
			zh = 4.50000000298023,
			ja = 7.00000000298023
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
				arg_1_0:Play321102002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L10f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L10f")
				var_4_0.name = "L10f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L10f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L10f

				arg_1_1.bgs_.L10f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L10f" then
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

			local var_4_9 = "1156ui_story"

			if arg_1_1.actors_["1156ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1156ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1156ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1156ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1.1, -6.18)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1156ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1156ui_story == nil then
				arg_1_1.var_.characterEffect1156ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1156ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1156ui_story then
				arg_1_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_quake_daily", "bgm_activity_4_0_story_quake_daily", "bgm_activity_4_0_story_quake_daily.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_daily", "bgm_activity_4_0_story_quake_daily")

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
			local var_4_25 = 0.4

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(321102001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 16 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 16)

				if (16 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 16)) > 0 and var_4_25 < var_4_30 then
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

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102001", "story_v_out_321102.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_321102", "321102001", "story_v_out_321102.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_321102", "321102001", "story_v_out_321102.awb")

						arg_1_1:RecordAudio("321102001", var_4_32)
						arg_1_1:RecordAudio("321102001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_321102", "321102001", "story_v_out_321102.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_321102", "321102001", "story_v_out_321102.awb")
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
				actorName = "1156ui_story",
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
	Play321102002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321102002
		arg_9_1.duration_ = 22

		local var_9_0 = {
			zh = 8.533,
			ja = 22
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
				arg_9_0:Play321102003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1156ui_story"]) and arg_9_1.var_.characterEffect1156ui_story == nil then
				arg_9_1.var_.characterEffect1156ui_story = arg_9_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1156ui_story"]) then
				if arg_9_1.var_.characterEffect1156ui_story and not isNil(arg_9_1.actors_["1156ui_story"]) then
					arg_9_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1156ui_story"]) and arg_9_1.var_.characterEffect1156ui_story then
				arg_9_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_12_1 = arg_9_1.actors_["1156ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1156ui_story = var_12_1.localPosition
			end

			local var_12_2 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 then
				var_12_1.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_2)
				var_12_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_1.position).x, (manager.ui.mainCamera.transform.position - var_12_1.position).y, (manager.ui.mainCamera.transform.position - var_12_1.position).z)
				var_12_1.localEulerAngles.z = 0
				var_12_1.localEulerAngles.x = 0
				var_12_1.localEulerAngles = var_12_1.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 then
				var_12_1.localPosition = Vector3.New(0, 100, 0)
				var_12_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_1.position).x, (manager.ui.mainCamera.transform.position - var_12_1.position).y, (manager.ui.mainCamera.transform.position - var_12_1.position).z)
				var_12_1.localEulerAngles.z = 0
				var_12_1.localEulerAngles.x = 0
				var_12_1.localEulerAngles = var_12_1.localEulerAngles
			end

			local var_12_3 = 0
			local var_12_4 = 0.9

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_3 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_5 = arg_9_1:GetWordFromCfg(321102002)
				local var_12_6 = arg_9_1:FormatText(var_12_5.content)

				arg_9_1.text_.text = var_12_6

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_8 = 36 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_6) / 36)

				if (36 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_6) / 36)) > 0 and var_12_4 < var_12_8 then
					arg_9_1.talkMaxDuration = var_12_8

					if var_12_8 + var_12_3 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_3
					end
				end

				arg_9_1.text_.text = var_12_6
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102002", "story_v_out_321102.awb") ~= 0 then
					local var_12_9 = manager.audio:GetVoiceLength("story_v_out_321102", "321102002", "story_v_out_321102.awb") / 1000

					if var_12_9 + var_12_3 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_9 + var_12_3
					end

					if var_12_5.prefab_name ~= "" and arg_9_1.actors_[var_12_5.prefab_name] ~= nil then
						local var_12_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_5.prefab_name].transform, "story_v_out_321102", "321102002", "story_v_out_321102.awb")

						arg_9_1:RecordAudio("321102002", var_12_10)
						arg_9_1:RecordAudio("321102002", var_12_10)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_321102", "321102002", "story_v_out_321102.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_321102", "321102002", "story_v_out_321102.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_11 = math.max(var_12_4, arg_9_1.talkMaxDuration)

			if var_12_3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_3 + var_12_11 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_3) / var_12_11

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_3 + var_12_11 and arg_9_1.time_ < var_12_3 + var_12_11 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play321102003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321102003
		arg_13_1.duration_ = 8

		local var_13_0 = {
			zh = 4.333,
			ja = 8
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
				arg_13_0:Play321102004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.525

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1174].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10061")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(321102003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 21 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 21)

				if (21 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 21)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102003", "story_v_out_321102.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_321102", "321102003", "story_v_out_321102.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_321102", "321102003", "story_v_out_321102.awb")

						arg_13_1:RecordAudio("321102003", var_16_6)
						arg_13_1:RecordAudio("321102003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_321102", "321102003", "story_v_out_321102.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_321102", "321102003", "story_v_out_321102.awb")
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
	Play321102004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321102004
		arg_17_1.duration_ = 5.1

		local var_17_0 = {
			zh = 3.5,
			ja = 5.1
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
				arg_17_0:Play321102005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.275

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(321102004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 11 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 11)

				if (11 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 11)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102004", "story_v_out_321102.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_321102", "321102004", "story_v_out_321102.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_321102", "321102004", "story_v_out_321102.awb")

						arg_17_1:RecordAudio("321102004", var_20_6)
						arg_17_1:RecordAudio("321102004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_321102", "321102004", "story_v_out_321102.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_321102", "321102004", "story_v_out_321102.awb")
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
	Play321102005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321102005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play321102006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1156ui_story = arg_21_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1156ui_story"].transform.position).z)
				arg_21_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1156ui_story"].transform.localEulerAngles = arg_21_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1156ui_story"].transform.position).z)
				arg_21_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1156ui_story"].transform.localEulerAngles = arg_21_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_24_1 = 0
			local var_24_2 = 1.35

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

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(321102005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 54 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 54)

				if (54 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 54)) > 0 and var_24_2 < var_24_5 then
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

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play321102006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321102006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play321102007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0.05 < arg_25_1.time_ and arg_25_1.time_ <= 0.05 + arg_28_0 then
				arg_25_1:AudioAction("play", "effect", "se_story_139", "se_story_139_thunderenergy", "")
			end

			local var_28_1 = 0
			local var_28_2 = 1.1

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(321102006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 44 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 44)

				if (44 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 44)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play321102007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321102007
		arg_29_1.duration_ = 4.2

		local var_29_0 = {
			zh = 3,
			ja = 4.2
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
				arg_29_0:Play321102008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.325

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1175].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:GetWordFromCfg(321102007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 13 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 13)

				if (13 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 13)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102007", "story_v_out_321102.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_321102", "321102007", "story_v_out_321102.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_321102", "321102007", "story_v_out_321102.awb")

						arg_29_1:RecordAudio("321102007", var_32_6)
						arg_29_1:RecordAudio("321102007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_321102", "321102007", "story_v_out_321102.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_321102", "321102007", "story_v_out_321102.awb")
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
	Play321102008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321102008
		arg_33_1.duration_ = 6

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play321102009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_9000

			if arg_33_1.actors_["2078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2078ui_story"))) then
				local var_36_0 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_33_1.stage_.transform)

				var_36_0.name = "2078ui_story"
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["2078ui_story"] = var_36_0

				local var_36_1 = var_36_0:GetComponentInChildren(typeof(CharacterEffect))

				var_36_1.enabled = true

				local var_36_2 = GameObjectTools.GetOrAddComponent(var_36_0, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_1.transform, false)

				arg_33_1.var_["2078ui_story" .. "Animator"] = var_36_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_["2078ui_story" .. "Animator"].applyRootMotion = true
				arg_33_1.var_["2078ui_story" .. "LipSync"] = var_36_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_3 = arg_33_1.actors_["2078ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos2078ui_story = var_36_3.localPosition
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_3.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_4)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_3.localPosition = Vector3.New(0, 100, 0)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			local var_36_5 = arg_33_1.actors_["2078ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect2078ui_story == nil then
				arg_33_1.var_.characterEffect2078ui_story = var_36_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_6 and not isNil(var_36_5) then
				if arg_33_1.var_.characterEffect2078ui_story and not isNil(var_36_5) then
					arg_33_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_33_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_6)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_6 and arg_33_1.time_ < 0 + var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect2078ui_story then
				arg_33_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_33_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_36_7 = manager.ui.mainCamera.transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.shakeOldPos = var_36_7.localPosition
			end

			local var_36_8 = 0.642580199241638

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_8 then
				local var_36_9, var_36_10 = math.modf((arg_33_1.time_ - 0) / 0.066)

				var_36_7.localPosition = Vector3.New(var_36_10 * 0.13, var_36_10 * 0.13, var_36_10 * 0.13) + arg_33_1.var_.shakeOldPos
			end

			if arg_33_1.time_ >= 0 + var_36_8 and arg_33_1.time_ < 0 + var_36_8 + arg_36_0 then
				var_36_7.localPosition = arg_33_1.var_.shakeOldPos
			end

			if 0.034 < arg_33_1.time_ and arg_33_1.time_ <= 0.034 + arg_36_0 then
				local var_36_11 = arg_33_1.var_.effect244

				if not arg_33_1.var_.effect244 then
					var_36_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), manager.ui.mainCamera.transform)
					var_36_11.name = "244"
					arg_33_1.var_.effect244 = var_36_11
				else
					var_36_11.transform:SetParent(var_36_9000)
				end

				var_36_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_36_11.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_36_13 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_36_0, iter_36_1 in ipairs((var_36_11.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_36_1.transform.localScale = Vector3.New(iter_36_1.transform.localScale.x / var_36_13 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_36_1.transform.localScale.y / var_36_13, iter_36_1.transform.localScale.z)
				end
			end

			if 0.534 < arg_33_1.time_ and arg_33_1.time_ <= 0.534 + arg_36_0 then
				if arg_33_1.var_.effect245 then
					Object.Destroy(arg_33_1.var_.effect245)

					arg_33_1.var_.effect245 = nil
				end
			end

			local var_36_16 = 0

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_17 = 0.333333333333333

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_17 then
				local var_36_18 = Color.New(1, 1, 1)

				var_36_18.a = Mathf.Lerp(1, 0, (arg_33_1.time_ - var_36_16) / var_36_17)
				arg_33_1.mask_.color = var_36_18
			end

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 then
				local var_36_19 = Color.New(1, 1, 1)

				arg_33_1.mask_.enabled = false
				var_36_19.a = 0
				arg_33_1.mask_.color = var_36_19
			end

			local var_36_20 = manager.ui.mainCamera.transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.shakeOldPos = var_36_20.localPosition
			end

			local var_36_21 = 0.466666666666667

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_21 then
				local var_36_22, var_36_23 = math.modf((arg_33_1.time_ - 0) / 0.066)

				var_36_20.localPosition = Vector3.New(var_36_23 * 0.13, var_36_23 * 0.13, var_36_23 * 0.13) + arg_33_1.var_.shakeOldPos
			end

			if arg_33_1.time_ >= 0 + var_36_21 and arg_33_1.time_ < 0 + var_36_21 + arg_36_0 then
				var_36_20.localPosition = arg_33_1.var_.shakeOldPos
			end

			if 0.05 < arg_33_1.time_ and arg_33_1.time_ <= 0.05 + arg_36_0 then
				arg_33_1:AudioAction("play", "effect", "se_story_138", "se_story_138_thunderhit", "")
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_25 = 1
			local var_36_26 = 1.275

			if 1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_25 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_27 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_27:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_28 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(321102008).content)

				arg_33_1.text_.text = var_36_28

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_30 = 51 <= 0 and var_36_26 or var_36_26 * (utf8.len(var_36_28) / 51)

				if (51 <= 0 and var_36_26 or var_36_26 * (utf8.len(var_36_28) / 51)) > 0 and var_36_26 < var_36_30 then
					arg_33_1.talkMaxDuration = var_36_30
					var_36_25 = var_36_25 + 0.3

					if var_36_30 + var_36_25 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_30 + var_36_25
					end
				end

				arg_33_1.text_.text = var_36_28
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_31 = var_36_25 + 0.3
			local var_36_32 = math.max(var_36_26, arg_33_1.talkMaxDuration)

			if var_36_25 + 0.3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_31 + var_36_32 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_31) / var_36_32

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_31 + var_36_32 and arg_33_1.time_ < var_36_31 + var_36_32 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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
	Play321102009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 321102009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play321102010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0.05 < arg_39_1.time_ and arg_39_1.time_ <= 0.05 + arg_42_0 then
				arg_39_1:AudioAction("play", "effect", "se_story_139", "se_story_139_thunderskill", "")
			end

			local var_42_1 = 0
			local var_42_2 = 1.525

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(321102009).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 61 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 61)

				if (61 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 61)) > 0 and var_42_2 < var_42_5 then
					arg_39_1.talkMaxDuration = var_42_5

					if var_42_5 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + var_42_1
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_6 = math.max(var_42_2, arg_39_1.talkMaxDuration)

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_6 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_1) / var_42_6

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_1 + var_42_6 and arg_39_1.time_ < var_42_1 + var_42_6 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play321102010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 321102010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play321102011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0.05 < arg_43_1.time_ and arg_43_1.time_ <= 0.05 + arg_46_0 then
				arg_43_1:AudioAction("play", "effect", "se_story_140", "se_story_140_scythe1", "")
			end

			local var_46_1 = 0
			local var_46_2 = 0.675

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_3 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(321102010).content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 27 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 27)

				if (27 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 27)) > 0 and var_46_2 < var_46_5 then
					arg_43_1.talkMaxDuration = var_46_5

					if var_46_5 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + var_46_1
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_6 = math.max(var_46_2, arg_43_1.talkMaxDuration)

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_6 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_1) / var_46_6

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_1 + var_46_6 and arg_43_1.time_ < var_46_1 + var_46_6 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play321102011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 321102011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play321102012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 1.225

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_1 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(321102011).content)

				arg_47_1.text_.text = var_50_1

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_3 = 49 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 49)

				if (49 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 49)) > 0 and var_50_0 < var_50_3 then
					arg_47_1.talkMaxDuration = var_50_3

					if var_50_3 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_3 + 0
					end
				end

				arg_47_1.text_.text = var_50_1
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_4 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_4

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play321102012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 321102012
		arg_51_1.duration_ = 13.93

		local var_51_0 = {
			zh = 6.033,
			ja = 13.933
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
				arg_51_0:Play321102013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.475

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_1 = arg_51_1:GetWordFromCfg(321102012)
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

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102012", "story_v_out_321102.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_321102", "321102012", "story_v_out_321102.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_321102", "321102012", "story_v_out_321102.awb")

						arg_51_1:RecordAudio("321102012", var_54_6)
						arg_51_1:RecordAudio("321102012", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_321102", "321102012", "story_v_out_321102.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_321102", "321102012", "story_v_out_321102.awb")
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
	Play321102013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 321102013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play321102014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.975

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(321102013).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 39 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 39)

				if (39 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 39)) > 0 and var_58_0 < var_58_3 then
					arg_55_1.talkMaxDuration = var_58_3

					if var_58_3 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_3 + 0
					end
				end

				arg_55_1.text_.text = var_58_1
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_4 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_4

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play321102014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 321102014
		arg_59_1.duration_ = 9.07

		local var_59_0 = {
			zh = 5.6,
			ja = 9.066
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
				arg_59_0:Play321102015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1156ui_story = arg_59_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1156ui_story"].transform.position).z)
				arg_59_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1156ui_story"].transform.localEulerAngles = arg_59_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.18)
				arg_59_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1156ui_story"].transform.position).z)
				arg_59_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1156ui_story"].transform.localEulerAngles = arg_59_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_62_1 = arg_59_1.actors_["1156ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1156ui_story == nil then
				arg_59_1.var_.characterEffect1156ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect1156ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1156ui_story then
				arg_59_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action11_1")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_62_4 = 0
			local var_62_5 = 0.625

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_6 = arg_59_1:GetWordFromCfg(321102014)
				local var_62_7 = arg_59_1:FormatText(var_62_6.content)

				arg_59_1.text_.text = var_62_7

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_9 = 25 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 25)

				if (25 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 25)) > 0 and var_62_5 < var_62_9 then
					arg_59_1.talkMaxDuration = var_62_9

					if var_62_9 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_7
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102014", "story_v_out_321102.awb") ~= 0 then
					local var_62_10 = manager.audio:GetVoiceLength("story_v_out_321102", "321102014", "story_v_out_321102.awb") / 1000

					if var_62_10 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_4
					end

					if var_62_6.prefab_name ~= "" and arg_59_1.actors_[var_62_6.prefab_name] ~= nil then
						local var_62_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_6.prefab_name].transform, "story_v_out_321102", "321102014", "story_v_out_321102.awb")

						arg_59_1:RecordAudio("321102014", var_62_11)
						arg_59_1:RecordAudio("321102014", var_62_11)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_321102", "321102014", "story_v_out_321102.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_321102", "321102014", "story_v_out_321102.awb")
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

		arg_59_1.nodeConfigList_ = {
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

		arg_59_1:InitPlayNodeList()
	end,
	Play321102015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 321102015
		arg_63_1.duration_ = 8.47

		local var_63_0 = {
			zh = 4.866,
			ja = 8.466
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
				arg_63_0:Play321102016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1156ui_story"]) and arg_63_1.var_.characterEffect1156ui_story == nil then
				arg_63_1.var_.characterEffect1156ui_story = arg_63_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1156ui_story"]) then
				if arg_63_1.var_.characterEffect1156ui_story and not isNil(arg_63_1.actors_["1156ui_story"]) then
					arg_63_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1156ui_story"]) and arg_63_1.var_.characterEffect1156ui_story then
				arg_63_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_66_1 = 0
			local var_66_2 = 0.35

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(321102015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_6 = 14 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_4) / 14)

				if (14 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_4) / 14)) > 0 and var_66_2 < var_66_6 then
					arg_63_1.talkMaxDuration = var_66_6

					if var_66_6 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_6 + var_66_1
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102015", "story_v_out_321102.awb") ~= 0 then
					local var_66_7 = manager.audio:GetVoiceLength("story_v_out_321102", "321102015", "story_v_out_321102.awb") / 1000

					if var_66_7 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_1
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_321102", "321102015", "story_v_out_321102.awb")

						arg_63_1:RecordAudio("321102015", var_66_8)
						arg_63_1:RecordAudio("321102015", var_66_8)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_321102", "321102015", "story_v_out_321102.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_321102", "321102015", "story_v_out_321102.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_9 = math.max(var_66_2, arg_63_1.talkMaxDuration)

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_9 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_1) / var_66_9

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_1 + var_66_9 and arg_63_1.time_ < var_66_1 + var_66_9 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play321102016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 321102016
		arg_67_1.duration_ = 2

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play321102017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1156ui_story = arg_67_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1156ui_story"].transform.position).z)
				arg_67_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1156ui_story"].transform.localEulerAngles = arg_67_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.18)
				arg_67_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1156ui_story"].transform.position).z)
				arg_67_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1156ui_story"].transform.localEulerAngles = arg_67_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_70_1 = arg_67_1.actors_["1156ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1156ui_story == nil then
				arg_67_1.var_.characterEffect1156ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect1156ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1156ui_story then
				arg_67_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action11_2")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_70_4 = 0
			local var_70_5 = 0.125

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_6 = arg_67_1:GetWordFromCfg(321102016)
				local var_70_7 = arg_67_1:FormatText(var_70_6.content)

				arg_67_1.text_.text = var_70_7

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_9 = 5 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 5)

				if (5 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 5)) > 0 and var_70_5 < var_70_9 then
					arg_67_1.talkMaxDuration = var_70_9

					if var_70_9 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_4
					end
				end

				arg_67_1.text_.text = var_70_7
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102016", "story_v_out_321102.awb") ~= 0 then
					local var_70_10 = manager.audio:GetVoiceLength("story_v_out_321102", "321102016", "story_v_out_321102.awb") / 1000

					if var_70_10 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_4
					end

					if var_70_6.prefab_name ~= "" and arg_67_1.actors_[var_70_6.prefab_name] ~= nil then
						local var_70_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_6.prefab_name].transform, "story_v_out_321102", "321102016", "story_v_out_321102.awb")

						arg_67_1:RecordAudio("321102016", var_70_11)
						arg_67_1:RecordAudio("321102016", var_70_11)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_321102", "321102016", "story_v_out_321102.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_321102", "321102016", "story_v_out_321102.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_12 = math.max(var_70_5, arg_67_1.talkMaxDuration)

			if var_70_4 <= arg_67_1.time_ and arg_67_1.time_ < var_70_4 + var_70_12 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_4) / var_70_12

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_4 + var_70_12 and arg_67_1.time_ < var_70_4 + var_70_12 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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

		arg_67_1:InitPlayNodeList()
	end,
	Play321102017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 321102017
		arg_71_1.duration_ = 9.33

		local var_71_0 = {
			zh = 6.033,
			ja = 9.333
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
				arg_71_0:Play321102018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1156ui_story"]) and arg_71_1.var_.characterEffect1156ui_story == nil then
				arg_71_1.var_.characterEffect1156ui_story = arg_71_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["1156ui_story"]) then
				if arg_71_1.var_.characterEffect1156ui_story and not isNil(arg_71_1.actors_["1156ui_story"]) then
					arg_71_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_0)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["1156ui_story"]) and arg_71_1.var_.characterEffect1156ui_story then
				arg_71_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_74_1 = 0
			local var_74_2 = 0.55

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_3 = arg_71_1:GetWordFromCfg(321102017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_6 = 22 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_4) / 22)

				if (22 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_4) / 22)) > 0 and var_74_2 < var_74_6 then
					arg_71_1.talkMaxDuration = var_74_6

					if var_74_6 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_6 + var_74_1
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102017", "story_v_out_321102.awb") ~= 0 then
					local var_74_7 = manager.audio:GetVoiceLength("story_v_out_321102", "321102017", "story_v_out_321102.awb") / 1000

					if var_74_7 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_1
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_321102", "321102017", "story_v_out_321102.awb")

						arg_71_1:RecordAudio("321102017", var_74_8)
						arg_71_1:RecordAudio("321102017", var_74_8)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_321102", "321102017", "story_v_out_321102.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_321102", "321102017", "story_v_out_321102.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_9 = math.max(var_74_2, arg_71_1.talkMaxDuration)

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_9 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_1) / var_74_9

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_1 + var_74_9 and arg_71_1.time_ < var_74_1 + var_74_9 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play321102018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 321102018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play321102019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1156ui_story = arg_75_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1156ui_story"].transform.position).z)
				arg_75_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1156ui_story"].transform.localEulerAngles = arg_75_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1156ui_story"].transform.position).z)
				arg_75_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1156ui_story"].transform.localEulerAngles = arg_75_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if 1.18210370047018 < arg_75_1.time_ and arg_75_1.time_ <= 1.18210370047018 + arg_78_0 then
				arg_75_1:AudioAction("play", "effect", "se_story_140", "se_story_140_punch", "")
			end

			local var_78_2 = 0
			local var_78_3 = 1.525

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

				local var_78_4 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(321102018).content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_6 = 61 <= 0 and var_78_3 or var_78_3 * (utf8.len(var_78_4) / 61)

				if (61 <= 0 and var_78_3 or var_78_3 * (utf8.len(var_78_4) / 61)) > 0 and var_78_3 < var_78_6 then
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
	Play321102019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 321102019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play321102020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 1.025

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(321102019).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 41 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 41)

				if (41 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 41)) > 0 and var_82_0 < var_82_3 then
					arg_79_1.talkMaxDuration = var_82_3

					if var_82_3 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_3 + 0
					end
				end

				arg_79_1.text_.text = var_82_1
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_4 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_4

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play321102020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 321102020
		arg_83_1.duration_ = 2

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play321102021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if arg_83_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_86_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_83_1.stage_.transform)

				var_86_0.name = "1011ui_story"
				var_86_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.actors_["1011ui_story"] = var_86_0

				local var_86_1 = var_86_0:GetComponentInChildren(typeof(CharacterEffect))

				var_86_1.enabled = true

				local var_86_2 = GameObjectTools.GetOrAddComponent(var_86_0, typeof(DynamicBoneHelper))

				if var_86_2 then
					var_86_2:EnableDynamicBone(false)
				end

				arg_83_1:ShowWeapon(var_86_1.transform, false)

				arg_83_1.var_["1011ui_story" .. "Animator"] = var_86_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_83_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_83_1.var_["1011ui_story" .. "LipSync"] = var_86_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_86_3 = arg_83_1.actors_["1011ui_story"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1011ui_story = var_86_3.localPosition
			end

			local var_86_4 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				var_86_3.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_83_1.time_ - 0) / var_86_4)
				var_86_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_3.position).x, (manager.ui.mainCamera.transform.position - var_86_3.position).y, (manager.ui.mainCamera.transform.position - var_86_3.position).z)
				var_86_3.localEulerAngles.z = 0
				var_86_3.localEulerAngles.x = 0
				var_86_3.localEulerAngles = var_86_3.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				var_86_3.localPosition = Vector3.New(0, -0.71, -6)
				var_86_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_3.position).x, (manager.ui.mainCamera.transform.position - var_86_3.position).y, (manager.ui.mainCamera.transform.position - var_86_3.position).z)
				var_86_3.localEulerAngles.z = 0
				var_86_3.localEulerAngles.x = 0
				var_86_3.localEulerAngles = var_86_3.localEulerAngles
			end

			local var_86_5 = arg_83_1.actors_["1011ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.characterEffect1011ui_story == nil then
				arg_83_1.var_.characterEffect1011ui_story = var_86_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_6 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_6 and not isNil(var_86_5) then
				if arg_83_1.var_.characterEffect1011ui_story and not isNil(var_86_5) then
					arg_83_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_6 and arg_83_1.time_ < 0 + var_86_6 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.characterEffect1011ui_story then
				arg_83_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_86_8 = 0
			local var_86_9 = 0.1

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_8 + arg_86_0 then
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

				local var_86_10 = arg_83_1:GetWordFromCfg(321102020)
				local var_86_11 = arg_83_1:FormatText(var_86_10.content)

				arg_83_1.text_.text = var_86_11

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_13 = 4 <= 0 and var_86_9 or var_86_9 * (utf8.len(var_86_11) / 4)

				if (4 <= 0 and var_86_9 or var_86_9 * (utf8.len(var_86_11) / 4)) > 0 and var_86_9 < var_86_13 then
					arg_83_1.talkMaxDuration = var_86_13

					if var_86_13 + var_86_8 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_13 + var_86_8
					end
				end

				arg_83_1.text_.text = var_86_11
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102020", "story_v_out_321102.awb") ~= 0 then
					local var_86_14 = manager.audio:GetVoiceLength("story_v_out_321102", "321102020", "story_v_out_321102.awb") / 1000

					if var_86_14 + var_86_8 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_14 + var_86_8
					end

					if var_86_10.prefab_name ~= "" and arg_83_1.actors_[var_86_10.prefab_name] ~= nil then
						local var_86_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_10.prefab_name].transform, "story_v_out_321102", "321102020", "story_v_out_321102.awb")

						arg_83_1:RecordAudio("321102020", var_86_15)
						arg_83_1:RecordAudio("321102020", var_86_15)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_321102", "321102020", "story_v_out_321102.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_321102", "321102020", "story_v_out_321102.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_16 = math.max(var_86_9, arg_83_1.talkMaxDuration)

			if var_86_8 <= arg_83_1.time_ and arg_83_1.time_ < var_86_8 + var_86_16 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_8) / var_86_16

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_8 + var_86_16 and arg_83_1.time_ < var_86_8 + var_86_16 + arg_86_0 then
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
	Play321102021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 321102021
		arg_87_1.duration_ = 3.1

		local var_87_0 = {
			zh = 2.466,
			ja = 3.1
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
				arg_87_0:Play321102022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["1011ui_story"]) and arg_87_1.var_.characterEffect1011ui_story == nil then
				arg_87_1.var_.characterEffect1011ui_story = arg_87_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["1011ui_story"]) then
				if arg_87_1.var_.characterEffect1011ui_story and not isNil(arg_87_1.actors_["1011ui_story"]) then
					arg_87_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_0)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["1011ui_story"]) and arg_87_1.var_.characterEffect1011ui_story then
				arg_87_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_90_1 = 0
			local var_90_2 = 0.25

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:GetWordFromCfg(321102021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_6 = 10 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_4) / 10)

				if (10 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_4) / 10)) > 0 and var_90_2 < var_90_6 then
					arg_87_1.talkMaxDuration = var_90_6

					if var_90_6 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_6 + var_90_1
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102021", "story_v_out_321102.awb") ~= 0 then
					local var_90_7 = manager.audio:GetVoiceLength("story_v_out_321102", "321102021", "story_v_out_321102.awb") / 1000

					if var_90_7 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_1
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_out_321102", "321102021", "story_v_out_321102.awb")

						arg_87_1:RecordAudio("321102021", var_90_8)
						arg_87_1:RecordAudio("321102021", var_90_8)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_321102", "321102021", "story_v_out_321102.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_321102", "321102021", "story_v_out_321102.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_9 = math.max(var_90_2, arg_87_1.talkMaxDuration)

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_9 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_1) / var_90_9

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_1 + var_90_9 and arg_87_1.time_ < var_90_1 + var_90_9 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play321102022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 321102022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play321102023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1011ui_story = arg_91_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1011ui_story"].transform.position).z)
				arg_91_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1011ui_story"].transform.localEulerAngles = arg_91_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1011ui_story"].transform.position).z)
				arg_91_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1011ui_story"].transform.localEulerAngles = arg_91_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_94_1 = arg_91_1.actors_["1156ui_story"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1156ui_story = var_94_1.localPosition
			end

			local var_94_2 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 then
				var_94_1.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_2)
				var_94_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_1.position).x, (manager.ui.mainCamera.transform.position - var_94_1.position).y, (manager.ui.mainCamera.transform.position - var_94_1.position).z)
				var_94_1.localEulerAngles.z = 0
				var_94_1.localEulerAngles.x = 0
				var_94_1.localEulerAngles = var_94_1.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 then
				var_94_1.localPosition = Vector3.New(0, 100, 0)
				var_94_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_1.position).x, (manager.ui.mainCamera.transform.position - var_94_1.position).y, (manager.ui.mainCamera.transform.position - var_94_1.position).z)
				var_94_1.localEulerAngles.z = 0
				var_94_1.localEulerAngles.x = 0
				var_94_1.localEulerAngles = var_94_1.localEulerAngles
			end

			local var_94_3 = arg_91_1.actors_["1156ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_3) and arg_91_1.var_.characterEffect1156ui_story == nil then
				arg_91_1.var_.characterEffect1156ui_story = var_94_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_4 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 and not isNil(var_94_3) then
				if arg_91_1.var_.characterEffect1156ui_story and not isNil(var_94_3) then
					arg_91_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_4)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 and not isNil(var_94_3) and arg_91_1.var_.characterEffect1156ui_story then
				arg_91_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_94_5 = 0
			local var_94_6 = 0.975

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_7 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(321102022).content)

				arg_91_1.text_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 39 <= 0 and var_94_6 or var_94_6 * (utf8.len(var_94_7) / 39)

				if (39 <= 0 and var_94_6 or var_94_6 * (utf8.len(var_94_7) / 39)) > 0 and var_94_6 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9

					if var_94_9 + var_94_5 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_5
					end
				end

				arg_91_1.text_.text = var_94_7
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_6, arg_91_1.talkMaxDuration)

			if var_94_5 <= arg_91_1.time_ and arg_91_1.time_ < var_94_5 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_5) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_5 + var_94_10 and arg_91_1.time_ < var_94_5 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
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
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play321102023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 321102023
		arg_95_1.duration_ = 14.13

		local var_95_0 = {
			zh = 5.6,
			ja = 14.133
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
				arg_95_0:Play321102024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.575

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_1 = arg_95_1:GetWordFromCfg(321102023)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.text_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 23 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 23)

				if (23 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 23)) > 0 and var_98_0 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end

				arg_95_1.text_.text = var_98_2
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102023", "story_v_out_321102.awb") ~= 0 then
					local var_98_5 = manager.audio:GetVoiceLength("story_v_out_321102", "321102023", "story_v_out_321102.awb") / 1000

					if var_98_5 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + 0
					end

					if var_98_1.prefab_name ~= "" and arg_95_1.actors_[var_98_1.prefab_name] ~= nil then
						local var_98_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_1.prefab_name].transform, "story_v_out_321102", "321102023", "story_v_out_321102.awb")

						arg_95_1:RecordAudio("321102023", var_98_6)
						arg_95_1:RecordAudio("321102023", var_98_6)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_321102", "321102023", "story_v_out_321102.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_321102", "321102023", "story_v_out_321102.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_7 and arg_95_1.time_ < 0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play321102024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 321102024
		arg_99_1.duration_ = 2

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play321102025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1011ui_story = arg_99_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1011ui_story"].transform.position).z)
				arg_99_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1011ui_story"].transform.localEulerAngles = arg_99_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_99_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1011ui_story"].transform.position).z)
				arg_99_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1011ui_story"].transform.localEulerAngles = arg_99_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["1011ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1011ui_story == nil then
				arg_99_1.var_.characterEffect1011ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect1011ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1011ui_story then
				arg_99_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_2")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_102_4 = 0
			local var_102_5 = 0.05

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_6 = arg_99_1:GetWordFromCfg(321102024)
				local var_102_7 = arg_99_1:FormatText(var_102_6.content)

				arg_99_1.text_.text = var_102_7

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_9 = 2 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 2)

				if (2 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 2)) > 0 and var_102_5 < var_102_9 then
					arg_99_1.talkMaxDuration = var_102_9

					if var_102_9 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_9 + var_102_4
					end
				end

				arg_99_1.text_.text = var_102_7
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102024", "story_v_out_321102.awb") ~= 0 then
					local var_102_10 = manager.audio:GetVoiceLength("story_v_out_321102", "321102024", "story_v_out_321102.awb") / 1000

					if var_102_10 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_4
					end

					if var_102_6.prefab_name ~= "" and arg_99_1.actors_[var_102_6.prefab_name] ~= nil then
						local var_102_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_6.prefab_name].transform, "story_v_out_321102", "321102024", "story_v_out_321102.awb")

						arg_99_1:RecordAudio("321102024", var_102_11)
						arg_99_1:RecordAudio("321102024", var_102_11)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_321102", "321102024", "story_v_out_321102.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_321102", "321102024", "story_v_out_321102.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_12 = math.max(var_102_5, arg_99_1.talkMaxDuration)

			if var_102_4 <= arg_99_1.time_ and arg_99_1.time_ < var_102_4 + var_102_12 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_4) / var_102_12

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_4 + var_102_12 and arg_99_1.time_ < var_102_4 + var_102_12 + arg_102_0 then
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
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play321102025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 321102025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play321102026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1011ui_story = arg_103_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_106_0 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				arg_103_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1011ui_story"].transform.position).z)
				arg_103_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1011ui_story"].transform.localEulerAngles = arg_103_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				arg_103_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
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
					arg_103_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_2)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1011ui_story then
				arg_103_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_106_3 = 0
			local var_106_4 = 1.075

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_3 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_5 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(321102025).content)

				arg_103_1.text_.text = var_106_5

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_7 = 43 <= 0 and var_106_4 or var_106_4 * (utf8.len(var_106_5) / 43)

				if (43 <= 0 and var_106_4 or var_106_4 * (utf8.len(var_106_5) / 43)) > 0 and var_106_4 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_3 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_3
					end
				end

				arg_103_1.text_.text = var_106_5
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_8 = math.max(var_106_4, arg_103_1.talkMaxDuration)

			if var_106_3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_3 + var_106_8 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_3) / var_106_8

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_3 + var_106_8 and arg_103_1.time_ < var_106_3 + var_106_8 + arg_106_0 then
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
	Play321102026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 321102026
		arg_107_1.duration_ = 6.7

		local var_107_0 = {
			zh = 4.166,
			ja = 6.7
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
				arg_107_0:Play321102027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.35

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_1 = arg_107_1:GetWordFromCfg(321102026)
				local var_110_2 = arg_107_1:FormatText(var_110_1.content)

				arg_107_1.text_.text = var_110_2

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 14 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 14)

				if (14 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 14)) > 0 and var_110_0 < var_110_4 then
					arg_107_1.talkMaxDuration = var_110_4

					if var_110_4 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_4 + 0
					end
				end

				arg_107_1.text_.text = var_110_2
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102026", "story_v_out_321102.awb") ~= 0 then
					local var_110_5 = manager.audio:GetVoiceLength("story_v_out_321102", "321102026", "story_v_out_321102.awb") / 1000

					if var_110_5 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + 0
					end

					if var_110_1.prefab_name ~= "" and arg_107_1.actors_[var_110_1.prefab_name] ~= nil then
						local var_110_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_1.prefab_name].transform, "story_v_out_321102", "321102026", "story_v_out_321102.awb")

						arg_107_1:RecordAudio("321102026", var_110_6)
						arg_107_1:RecordAudio("321102026", var_110_6)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_321102", "321102026", "story_v_out_321102.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_321102", "321102026", "story_v_out_321102.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_7 and arg_107_1.time_ < 0 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play321102027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 321102027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play321102028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.875

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(321102027).content)

				arg_111_1.text_.text = var_114_1

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_3 = 35 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 35)

				if (35 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 35)) > 0 and var_114_0 < var_114_3 then
					arg_111_1.talkMaxDuration = var_114_3

					if var_114_3 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_3 + 0
					end
				end

				arg_111_1.text_.text = var_114_1
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_4 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_4

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play321102028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 321102028
		arg_115_1.duration_ = 1.07

		local var_115_0 = {
			zh = 1.066,
			ja = 1
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
				arg_115_0:Play321102029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["1011ui_story"]) and arg_115_1.var_.characterEffect1011ui_story == nil then
				arg_115_1.var_.characterEffect1011ui_story = arg_115_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["1011ui_story"]) then
				if arg_115_1.var_.characterEffect1011ui_story and not isNil(arg_115_1.actors_["1011ui_story"]) then
					arg_115_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["1011ui_story"]) and arg_115_1.var_.characterEffect1011ui_story then
				arg_115_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_118_2 = 0
			local var_118_3 = 0.075

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_4 = arg_115_1:GetWordFromCfg(321102028)
				local var_118_5 = arg_115_1:FormatText(var_118_4.content)

				arg_115_1.text_.text = var_118_5

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_7 = 3 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 3)

				if (3 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 3)) > 0 and var_118_3 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_2
					end
				end

				arg_115_1.text_.text = var_118_5
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102028", "story_v_out_321102.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_321102", "321102028", "story_v_out_321102.awb") / 1000

					if var_118_8 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_2
					end

					if var_118_4.prefab_name ~= "" and arg_115_1.actors_[var_118_4.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_4.prefab_name].transform, "story_v_out_321102", "321102028", "story_v_out_321102.awb")

						arg_115_1:RecordAudio("321102028", var_118_9)
						arg_115_1:RecordAudio("321102028", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_321102", "321102028", "story_v_out_321102.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_321102", "321102028", "story_v_out_321102.awb")
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
	Play321102029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 321102029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play321102030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["1011ui_story"]) and arg_119_1.var_.characterEffect1011ui_story == nil then
				arg_119_1.var_.characterEffect1011ui_story = arg_119_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["1011ui_story"]) then
				if arg_119_1.var_.characterEffect1011ui_story and not isNil(arg_119_1.actors_["1011ui_story"]) then
					arg_119_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_0)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["1011ui_story"]) and arg_119_1.var_.characterEffect1011ui_story then
				arg_119_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0.200000002980232 < arg_119_1.time_ and arg_119_1.time_ <= 0.200000002980232 + arg_122_0 then
				arg_119_1:AudioAction("play", "effect", "se_story_140", "se_story_140_light", "")
			end

			local var_122_2 = 0
			local var_122_3 = 1.1

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_4 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(321102029).content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_6 = 44 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_4) / 44)

				if (44 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_4) / 44)) > 0 and var_122_3 < var_122_6 then
					arg_119_1.talkMaxDuration = var_122_6

					if var_122_6 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_6 + var_122_2
					end
				end

				arg_119_1.text_.text = var_122_4
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_3, arg_119_1.talkMaxDuration)

			if var_122_2 <= arg_119_1.time_ and arg_119_1.time_ < var_122_2 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_2) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_2 + var_122_7 and arg_119_1.time_ < var_122_2 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play321102030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 321102030
		arg_123_1.duration_ = 7.83

		local var_123_0 = {
			zh = 7.83300000297923,
			ja = 6.80000000297923
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
				arg_123_0:Play321102031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if arg_123_1.bgs_.L10g == nil then
				local var_126_0 = Object.Instantiate(arg_123_1.paintGo_)

				var_126_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L10g")
				var_126_0.name = "L10g"
				var_126_0.transform.parent = arg_123_1.stage_.transform
				var_126_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.bgs_.L10g = var_126_0
			end

			if 1.80000000298023 < arg_123_1.time_ and arg_123_1.time_ <= 1.80000000298023 + arg_126_0 then
				local var_126_1 = arg_123_1.bgs_.L10g

				arg_123_1.bgs_.L10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_126_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_126_2 = var_126_1:GetComponent("SpriteRenderer")

				if var_126_2 and var_126_2.sprite then
					local var_126_3 = 2 * (var_126_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_126_1.transform.localScale = Vector3.New(var_126_3 / var_126_2.sprite.bounds.size.y < var_126_3 * manager.ui.mainCameraCom_.aspect / var_126_2.sprite.bounds.size.x and var_126_3 * manager.ui.mainCameraCom_.aspect / var_126_2.sprite.bounds.size.x or var_126_3 / var_126_2.sprite.bounds.size.y, var_126_3 / var_126_2.sprite.bounds.size.y < var_126_3 * manager.ui.mainCameraCom_.aspect / var_126_2.sprite.bounds.size.x and var_126_3 * manager.ui.mainCameraCom_.aspect / var_126_2.sprite.bounds.size.x or var_126_3 / var_126_2.sprite.bounds.size.y, 0)
				end

				for iter_126_0, iter_126_1 in pairs(arg_123_1.bgs_) do
					if iter_126_0 ~= "L10g" then
						iter_126_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_126_4 = 3.80000000297923

			if 3.80000000297923 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.allBtn_.enabled = false
			end

			if arg_123_1.time_ >= var_126_4 + 0.3 and arg_123_1.time_ < var_126_4 + 0.3 + arg_126_0 then
				arg_123_1.allBtn_.enabled = true
			end

			local var_126_5 = 0

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_6 = 1.79999999701977

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_6 then
				local var_126_7 = Color.New(1, 1, 1)

				var_126_7.a = Mathf.Lerp(0, 1, (arg_123_1.time_ - var_126_5) / var_126_6)
				arg_123_1.mask_.color = var_126_7
			end

			if arg_123_1.time_ >= var_126_5 + var_126_6 and arg_123_1.time_ < var_126_5 + var_126_6 + arg_126_0 then
				local var_126_8 = Color.New(1, 1, 1)

				var_126_8.a = 1
				arg_123_1.mask_.color = var_126_8
			end

			local var_126_9 = 1.80000000297923

			if 1.80000000297923 < arg_123_1.time_ and arg_123_1.time_ <= var_126_9 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_10 = 2

			if var_126_9 <= arg_123_1.time_ and arg_123_1.time_ < var_126_9 + var_126_10 then
				local var_126_11 = Color.New(1, 1, 1)

				var_126_11.a = Mathf.Lerp(1, 0, (arg_123_1.time_ - var_126_9) / var_126_10)
				arg_123_1.mask_.color = var_126_11
			end

			if arg_123_1.time_ >= var_126_9 + var_126_10 and arg_123_1.time_ < var_126_9 + var_126_10 + arg_126_0 then
				local var_126_12 = Color.New(1, 1, 1)

				arg_123_1.mask_.enabled = false
				var_126_12.a = 0
				arg_123_1.mask_.color = var_126_12
			end

			local var_126_13 = arg_123_1.actors_["1156ui_story"]

			if 1.6 < arg_123_1.time_ and arg_123_1.time_ <= 1.6 + arg_126_0 and not isNil(var_126_13) and arg_123_1.var_.characterEffect1156ui_story == nil then
				arg_123_1.var_.characterEffect1156ui_story = var_126_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_14 = 0.200000002980232

			if 1.6 <= arg_123_1.time_ and arg_123_1.time_ < 1.6 + var_126_14 and not isNil(var_126_13) then
				if arg_123_1.var_.characterEffect1156ui_story and not isNil(var_126_13) then
					arg_123_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 1.6 + var_126_14 and arg_123_1.time_ < 1.6 + var_126_14 + arg_126_0 and not isNil(var_126_13) and arg_123_1.var_.characterEffect1156ui_story then
				arg_123_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if arg_123_1.frameCnt_ <= 1 then
				arg_123_1.dialog_:SetActive(false)
			end

			local var_126_16 = 3.80000000297923
			local var_126_17 = 0.25

			if 3.80000000297923 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				arg_123_1.dialog_:SetActive(true)

				arg_123_1.dialogCg_.alpha = 0

				local var_126_18 = LeanTween.value(arg_123_1.dialog_, 0, 1, 0.3)

				var_126_18:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_123_1.dialogCg_.alpha = arg_127_0
				end))
				var_126_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_123_1.dialog_)
					var_126_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_123_1.duration_ = arg_123_1.duration_ + 0.3

				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_19 = arg_123_1:GetWordFromCfg(321102030)
				local var_126_20 = arg_123_1:FormatText(var_126_19.content)

				arg_123_1.text_.text = var_126_20

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_22 = 10 <= 0 and var_126_17 or var_126_17 * (utf8.len(var_126_20) / 10)

				if (10 <= 0 and var_126_17 or var_126_17 * (utf8.len(var_126_20) / 10)) > 0 and var_126_17 < var_126_22 then
					arg_123_1.talkMaxDuration = var_126_22
					var_126_16 = var_126_16 + 0.3

					if var_126_22 + var_126_16 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_22 + var_126_16
					end
				end

				arg_123_1.text_.text = var_126_20
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102030", "story_v_out_321102.awb") ~= 0 then
					local var_126_23 = manager.audio:GetVoiceLength("story_v_out_321102", "321102030", "story_v_out_321102.awb") / 1000

					if var_126_23 + var_126_16 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_23 + var_126_16
					end

					if var_126_19.prefab_name ~= "" and arg_123_1.actors_[var_126_19.prefab_name] ~= nil then
						local var_126_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_19.prefab_name].transform, "story_v_out_321102", "321102030", "story_v_out_321102.awb")

						arg_123_1:RecordAudio("321102030", var_126_24)
						arg_123_1:RecordAudio("321102030", var_126_24)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_321102", "321102030", "story_v_out_321102.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_321102", "321102030", "story_v_out_321102.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_25 = var_126_16 + 0.3
			local var_126_26 = math.max(var_126_17, arg_123_1.talkMaxDuration)

			if var_126_16 + 0.3 <= arg_123_1.time_ and arg_123_1.time_ < var_126_25 + var_126_26 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_25) / var_126_26

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_25 + var_126_26 and arg_123_1.time_ < var_126_25 + var_126_26 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play321102031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 321102031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play321102032(arg_129_1)
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
			local var_132_2 = 1.15

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(321102031).content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 46 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 46)

				if (46 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 46)) > 0 and var_132_2 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_6 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_6 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_6

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_6 and arg_129_1.time_ < var_132_1 + var_132_6 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play321102032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 321102032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play321102033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 1.3

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(321102032).content)

				arg_133_1.text_.text = var_136_1

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_3 = 52 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 52)

				if (52 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 52)) > 0 and var_136_0 < var_136_3 then
					arg_133_1.talkMaxDuration = var_136_3

					if var_136_3 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_3 + 0
					end
				end

				arg_133_1.text_.text = var_136_1
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_4 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_4

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play321102033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 321102033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play321102034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 1.1

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

				local var_140_1 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(321102033).content)

				arg_137_1.text_.text = var_140_1

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_3 = 44 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 44)

				if (44 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 44)) > 0 and var_140_0 < var_140_3 then
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
	Play321102034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 321102034
		arg_141_1.duration_ = 10.67

		local var_141_0 = {
			zh = 7.366,
			ja = 10.666
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
				arg_141_0:Play321102035(arg_141_1)
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
				arg_141_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action8_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_144_4 = 0
			local var_144_5 = 0.875

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

				local var_144_6 = arg_141_1:GetWordFromCfg(321102034)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 35 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 35)

				if (35 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 35)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102034", "story_v_out_321102.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_321102", "321102034", "story_v_out_321102.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_out_321102", "321102034", "story_v_out_321102.awb")

						arg_141_1:RecordAudio("321102034", var_144_11)
						arg_141_1:RecordAudio("321102034", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_321102", "321102034", "story_v_out_321102.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_321102", "321102034", "story_v_out_321102.awb")
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
	Play321102035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 321102035
		arg_145_1.duration_ = 12

		local var_145_0 = {
			zh = 10,
			ja = 12
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
				arg_145_0:Play321102036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1011ui_story = arg_145_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1011ui_story"].transform.position).z)
				arg_145_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1011ui_story"].transform.localEulerAngles = arg_145_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_145_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1011ui_story"].transform.position).z)
				arg_145_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1011ui_story"].transform.localEulerAngles = arg_145_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["1156ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1156ui_story = var_148_1.localPosition
			end

			local var_148_2 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 then
				var_148_1.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1156ui_story, Vector3.New(-0.9, -1.1, -6.18), (arg_145_1.time_ - 0) / var_148_2)
				var_148_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_1.position).x, (manager.ui.mainCamera.transform.position - var_148_1.position).y, (manager.ui.mainCamera.transform.position - var_148_1.position).z)
				var_148_1.localEulerAngles.z = 0
				var_148_1.localEulerAngles.x = 0
				var_148_1.localEulerAngles = var_148_1.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 then
				var_148_1.localPosition = Vector3.New(-0.9, -1.1, -6.18)
				var_148_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_1.position).x, (manager.ui.mainCamera.transform.position - var_148_1.position).y, (manager.ui.mainCamera.transform.position - var_148_1.position).z)
				var_148_1.localEulerAngles.z = 0
				var_148_1.localEulerAngles.x = 0
				var_148_1.localEulerAngles = var_148_1.localEulerAngles
			end

			local var_148_3 = arg_145_1.actors_["1011ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_3) and arg_145_1.var_.characterEffect1011ui_story == nil then
				arg_145_1.var_.characterEffect1011ui_story = var_148_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_4 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 and not isNil(var_148_3) then
				if arg_145_1.var_.characterEffect1011ui_story and not isNil(var_148_3) then
					arg_145_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 and not isNil(var_148_3) and arg_145_1.var_.characterEffect1011ui_story then
				arg_145_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_148_6 = arg_145_1.actors_["1156ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_6) and arg_145_1.var_.characterEffect1156ui_story == nil then
				arg_145_1.var_.characterEffect1156ui_story = var_148_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_7 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 and not isNil(var_148_6) then
				if arg_145_1.var_.characterEffect1156ui_story and not isNil(var_148_6) then
					arg_145_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_7)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 and not isNil(var_148_6) and arg_145_1.var_.characterEffect1156ui_story then
				arg_145_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_148_8 = 0
			local var_148_9 = 1.075

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_10 = arg_145_1:GetWordFromCfg(321102035)
				local var_148_11 = arg_145_1:FormatText(var_148_10.content)

				arg_145_1.text_.text = var_148_11

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 43 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 43)

				if (43 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 43)) > 0 and var_148_9 < var_148_13 then
					arg_145_1.talkMaxDuration = var_148_13

					if var_148_13 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_13 + var_148_8
					end
				end

				arg_145_1.text_.text = var_148_11
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102035", "story_v_out_321102.awb") ~= 0 then
					local var_148_14 = manager.audio:GetVoiceLength("story_v_out_321102", "321102035", "story_v_out_321102.awb") / 1000

					if var_148_14 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_14 + var_148_8
					end

					if var_148_10.prefab_name ~= "" and arg_145_1.actors_[var_148_10.prefab_name] ~= nil then
						local var_148_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_10.prefab_name].transform, "story_v_out_321102", "321102035", "story_v_out_321102.awb")

						arg_145_1:RecordAudio("321102035", var_148_15)
						arg_145_1:RecordAudio("321102035", var_148_15)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_321102", "321102035", "story_v_out_321102.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_321102", "321102035", "story_v_out_321102.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_16 = math.max(var_148_9, arg_145_1.talkMaxDuration)

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_16 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_8) / var_148_16

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_8 + var_148_16 and arg_145_1.time_ < var_148_8 + var_148_16 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
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
				actorName = "1156ui_story",
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
	Play321102036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 321102036
		arg_149_1.duration_ = 7.73

		local var_149_0 = {
			zh = 5,
			ja = 7.733
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
				arg_149_0:Play321102037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1156ui_story = arg_149_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1156ui_story, Vector3.New(-0.9, -1.1, -6.18), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1156ui_story"].transform.position).z)
				arg_149_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1156ui_story"].transform.localEulerAngles = arg_149_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(-0.9, -1.1, -6.18)
				arg_149_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1156ui_story"].transform.position).z)
				arg_149_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1156ui_story"].transform.localEulerAngles = arg_149_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["1156ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1156ui_story == nil then
				arg_149_1.var_.characterEffect1156ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1156ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1156ui_story then
				arg_149_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_152_4 = arg_149_1.actors_["1011ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1011ui_story == nil then
				arg_149_1.var_.characterEffect1011ui_story = var_152_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_5 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_5 and not isNil(var_152_4) then
				if arg_149_1.var_.characterEffect1011ui_story and not isNil(var_152_4) then
					arg_149_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_5)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_5 and arg_149_1.time_ < 0 + var_152_5 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1011ui_story then
				arg_149_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action8_2")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_152_6 = 0
			local var_152_7 = 0.6

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_8 = arg_149_1:GetWordFromCfg(321102036)
				local var_152_9 = arg_149_1:FormatText(var_152_8.content)

				arg_149_1.text_.text = var_152_9

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 24 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 24)

				if (24 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 24)) > 0 and var_152_7 < var_152_11 then
					arg_149_1.talkMaxDuration = var_152_11

					if var_152_11 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_9
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102036", "story_v_out_321102.awb") ~= 0 then
					local var_152_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102036", "story_v_out_321102.awb") / 1000

					if var_152_12 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_12 + var_152_6
					end

					if var_152_8.prefab_name ~= "" and arg_149_1.actors_[var_152_8.prefab_name] ~= nil then
						local var_152_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_8.prefab_name].transform, "story_v_out_321102", "321102036", "story_v_out_321102.awb")

						arg_149_1:RecordAudio("321102036", var_152_13)
						arg_149_1:RecordAudio("321102036", var_152_13)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_321102", "321102036", "story_v_out_321102.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_321102", "321102036", "story_v_out_321102.awb")
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
	Play321102037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 321102037
		arg_153_1.duration_ = 9.9

		local var_153_0 = {
			zh = 6.9,
			ja = 9.9
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
				arg_153_0:Play321102038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1011ui_story = arg_153_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).z)
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles = arg_153_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_153_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).z)
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles = arg_153_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["1011ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1011ui_story == nil then
				arg_153_1.var_.characterEffect1011ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect1011ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1011ui_story then
				arg_153_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_156_4 = arg_153_1.actors_["1156ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect1156ui_story == nil then
				arg_153_1.var_.characterEffect1156ui_story = var_156_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_5 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_5 and not isNil(var_156_4) then
				if arg_153_1.var_.characterEffect1156ui_story and not isNil(var_156_4) then
					arg_153_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_5)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_5 and arg_153_1.time_ < 0 + var_156_5 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect1156ui_story then
				arg_153_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_156_6 = 0
			local var_156_7 = 0.825

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_8 = arg_153_1:GetWordFromCfg(321102037)
				local var_156_9 = arg_153_1:FormatText(var_156_8.content)

				arg_153_1.text_.text = var_156_9

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_11 = 33 <= 0 and var_156_7 or var_156_7 * (utf8.len(var_156_9) / 33)

				if (33 <= 0 and var_156_7 or var_156_7 * (utf8.len(var_156_9) / 33)) > 0 and var_156_7 < var_156_11 then
					arg_153_1.talkMaxDuration = var_156_11

					if var_156_11 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_11 + var_156_6
					end
				end

				arg_153_1.text_.text = var_156_9
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102037", "story_v_out_321102.awb") ~= 0 then
					local var_156_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102037", "story_v_out_321102.awb") / 1000

					if var_156_12 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_12 + var_156_6
					end

					if var_156_8.prefab_name ~= "" and arg_153_1.actors_[var_156_8.prefab_name] ~= nil then
						local var_156_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_8.prefab_name].transform, "story_v_out_321102", "321102037", "story_v_out_321102.awb")

						arg_153_1:RecordAudio("321102037", var_156_13)
						arg_153_1:RecordAudio("321102037", var_156_13)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_321102", "321102037", "story_v_out_321102.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_321102", "321102037", "story_v_out_321102.awb")
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
				actorName = "1011ui_story",
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
	Play321102038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 321102038
		arg_157_1.duration_ = 5.47

		local var_157_0 = {
			zh = 4.4,
			ja = 5.466
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
				arg_157_0:Play321102039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1156ui_story = arg_157_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1156ui_story, Vector3.New(-0.9, -1.1, -6.18), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1156ui_story"].transform.position).z)
				arg_157_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1156ui_story"].transform.localEulerAngles = arg_157_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(-0.9, -1.1, -6.18)
				arg_157_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1156ui_story"].transform.position).z)
				arg_157_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1156ui_story"].transform.localEulerAngles = arg_157_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["1156ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1156ui_story == nil then
				arg_157_1.var_.characterEffect1156ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect1156ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1156ui_story then
				arg_157_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_160_4 = arg_157_1.actors_["1011ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect1011ui_story == nil then
				arg_157_1.var_.characterEffect1011ui_story = var_160_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_5 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_5 and not isNil(var_160_4) then
				if arg_157_1.var_.characterEffect1011ui_story and not isNil(var_160_4) then
					arg_157_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_5)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_5 and arg_157_1.time_ < 0 + var_160_5 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect1011ui_story then
				arg_157_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action6_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_160_6 = 0
			local var_160_7 = 0.625

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_6 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_8 = arg_157_1:GetWordFromCfg(321102038)
				local var_160_9 = arg_157_1:FormatText(var_160_8.content)

				arg_157_1.text_.text = var_160_9

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_11 = 25 <= 0 and var_160_7 or var_160_7 * (utf8.len(var_160_9) / 25)

				if (25 <= 0 and var_160_7 or var_160_7 * (utf8.len(var_160_9) / 25)) > 0 and var_160_7 < var_160_11 then
					arg_157_1.talkMaxDuration = var_160_11

					if var_160_11 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_11 + var_160_6
					end
				end

				arg_157_1.text_.text = var_160_9
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102038", "story_v_out_321102.awb") ~= 0 then
					local var_160_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102038", "story_v_out_321102.awb") / 1000

					if var_160_12 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_12 + var_160_6
					end

					if var_160_8.prefab_name ~= "" and arg_157_1.actors_[var_160_8.prefab_name] ~= nil then
						local var_160_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_8.prefab_name].transform, "story_v_out_321102", "321102038", "story_v_out_321102.awb")

						arg_157_1:RecordAudio("321102038", var_160_13)
						arg_157_1:RecordAudio("321102038", var_160_13)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_321102", "321102038", "story_v_out_321102.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_321102", "321102038", "story_v_out_321102.awb")
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
				actorName = "1156ui_story",
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
	Play321102039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 321102039
		arg_161_1.duration_ = 8.6

		local var_161_0 = {
			zh = 6,
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
				arg_161_0:Play321102040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1011ui_story = arg_161_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1011ui_story"].transform.position).z)
				arg_161_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1011ui_story"].transform.localEulerAngles = arg_161_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_161_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1011ui_story"].transform.position).z)
				arg_161_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1011ui_story"].transform.localEulerAngles = arg_161_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1011ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1011ui_story == nil then
				arg_161_1.var_.characterEffect1011ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1011ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1011ui_story then
				arg_161_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_164_4 = arg_161_1.actors_["1156ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_4) and arg_161_1.var_.characterEffect1156ui_story == nil then
				arg_161_1.var_.characterEffect1156ui_story = var_164_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_5 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_5 and not isNil(var_164_4) then
				if arg_161_1.var_.characterEffect1156ui_story and not isNil(var_164_4) then
					arg_161_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_5)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_5 and arg_161_1.time_ < 0 + var_164_5 + arg_164_0 and not isNil(var_164_4) and arg_161_1.var_.characterEffect1156ui_story then
				arg_161_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_164_6 = 0
			local var_164_7 = 0.575

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_8 = arg_161_1:GetWordFromCfg(321102039)
				local var_164_9 = arg_161_1:FormatText(var_164_8.content)

				arg_161_1.text_.text = var_164_9

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_11 = 23 <= 0 and var_164_7 or var_164_7 * (utf8.len(var_164_9) / 23)

				if (23 <= 0 and var_164_7 or var_164_7 * (utf8.len(var_164_9) / 23)) > 0 and var_164_7 < var_164_11 then
					arg_161_1.talkMaxDuration = var_164_11

					if var_164_11 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_11 + var_164_6
					end
				end

				arg_161_1.text_.text = var_164_9
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102039", "story_v_out_321102.awb") ~= 0 then
					local var_164_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102039", "story_v_out_321102.awb") / 1000

					if var_164_12 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_12 + var_164_6
					end

					if var_164_8.prefab_name ~= "" and arg_161_1.actors_[var_164_8.prefab_name] ~= nil then
						local var_164_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_8.prefab_name].transform, "story_v_out_321102", "321102039", "story_v_out_321102.awb")

						arg_161_1:RecordAudio("321102039", var_164_13)
						arg_161_1:RecordAudio("321102039", var_164_13)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_321102", "321102039", "story_v_out_321102.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_321102", "321102039", "story_v_out_321102.awb")
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
				actorName = "1011ui_story",
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
	Play321102040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 321102040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play321102041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1011ui_story"]) and arg_165_1.var_.characterEffect1011ui_story == nil then
				arg_165_1.var_.characterEffect1011ui_story = arg_165_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1011ui_story"]) then
				if arg_165_1.var_.characterEffect1011ui_story and not isNil(arg_165_1.actors_["1011ui_story"]) then
					arg_165_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1011ui_story"]) and arg_165_1.var_.characterEffect1011ui_story then
				arg_165_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_168_1 = 0
			local var_168_2 = 1.175

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(321102040).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 47 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 47)

				if (47 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 47)) > 0 and var_168_2 < var_168_5 then
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
	Play321102041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 321102041
		arg_169_1.duration_ = 2.27

		local var_169_0 = {
			zh = 1.999999999999,
			ja = 2.266
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
				arg_169_0:Play321102042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1011ui_story = arg_169_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1011ui_story"].transform.position).z)
				arg_169_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1011ui_story"].transform.localEulerAngles = arg_169_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_169_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1011ui_story"].transform.position).z)
				arg_169_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1011ui_story"].transform.localEulerAngles = arg_169_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["1011ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1011ui_story == nil then
				arg_169_1.var_.characterEffect1011ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect1011ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1011ui_story then
				arg_169_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_2")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_172_4 = 0
			local var_172_5 = 0.15

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(321102041)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 6 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 6)

				if (6 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 6)) > 0 and var_172_5 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102041", "story_v_out_321102.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_out_321102", "321102041", "story_v_out_321102.awb") / 1000

					if var_172_10 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_4
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_out_321102", "321102041", "story_v_out_321102.awb")

						arg_169_1:RecordAudio("321102041", var_172_11)
						arg_169_1:RecordAudio("321102041", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_321102", "321102041", "story_v_out_321102.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_321102", "321102041", "story_v_out_321102.awb")
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
				actorName = "1011ui_story",
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
	Play321102042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 321102042
		arg_173_1.duration_ = 9.43

		local var_173_0 = {
			zh = 6.7,
			ja = 9.433
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
				arg_173_0:Play321102043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1156ui_story = arg_173_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1156ui_story, Vector3.New(-0.9, -1.1, -6.18), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1156ui_story"].transform.position).z)
				arg_173_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1156ui_story"].transform.localEulerAngles = arg_173_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(-0.9, -1.1, -6.18)
				arg_173_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1156ui_story"].transform.position).z)
				arg_173_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1156ui_story"].transform.localEulerAngles = arg_173_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1156ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1156ui_story == nil then
				arg_173_1.var_.characterEffect1156ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1156ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1156ui_story then
				arg_173_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_176_4 = arg_173_1.actors_["1011ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect1011ui_story == nil then
				arg_173_1.var_.characterEffect1011ui_story = var_176_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_5 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_5 and not isNil(var_176_4) then
				if arg_173_1.var_.characterEffect1011ui_story and not isNil(var_176_4) then
					arg_173_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_5)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_5 and arg_173_1.time_ < 0 + var_176_5 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect1011ui_story then
				arg_173_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action6_2")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_176_6 = 0
			local var_176_7 = 0.875

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_8 = arg_173_1:GetWordFromCfg(321102042)
				local var_176_9 = arg_173_1:FormatText(var_176_8.content)

				arg_173_1.text_.text = var_176_9

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 35 <= 0 and var_176_7 or var_176_7 * (utf8.len(var_176_9) / 35)

				if (35 <= 0 and var_176_7 or var_176_7 * (utf8.len(var_176_9) / 35)) > 0 and var_176_7 < var_176_11 then
					arg_173_1.talkMaxDuration = var_176_11

					if var_176_11 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_11 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_9
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102042", "story_v_out_321102.awb") ~= 0 then
					local var_176_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102042", "story_v_out_321102.awb") / 1000

					if var_176_12 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_12 + var_176_6
					end

					if var_176_8.prefab_name ~= "" and arg_173_1.actors_[var_176_8.prefab_name] ~= nil then
						local var_176_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_8.prefab_name].transform, "story_v_out_321102", "321102042", "story_v_out_321102.awb")

						arg_173_1:RecordAudio("321102042", var_176_13)
						arg_173_1:RecordAudio("321102042", var_176_13)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_321102", "321102042", "story_v_out_321102.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_321102", "321102042", "story_v_out_321102.awb")
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
	Play321102043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 321102043
		arg_177_1.duration_ = 10.43

		local var_177_0 = {
			zh = 6.633,
			ja = 10.433
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
				arg_177_0:Play321102044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1011ui_story = arg_177_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1011ui_story"].transform.position).z)
				arg_177_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1011ui_story"].transform.localEulerAngles = arg_177_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_177_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1011ui_story"].transform.position).z)
				arg_177_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1011ui_story"].transform.localEulerAngles = arg_177_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["1011ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1011ui_story == nil then
				arg_177_1.var_.characterEffect1011ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect1011ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1011ui_story then
				arg_177_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_180_4 = arg_177_1.actors_["1156ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect1156ui_story == nil then
				arg_177_1.var_.characterEffect1156ui_story = var_180_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_5 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_5 and not isNil(var_180_4) then
				if arg_177_1.var_.characterEffect1156ui_story and not isNil(var_180_4) then
					arg_177_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_5)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_5 and arg_177_1.time_ < 0 + var_180_5 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect1156ui_story then
				arg_177_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_180_6 = 0
			local var_180_7 = 0.7

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_8 = arg_177_1:GetWordFromCfg(321102043)
				local var_180_9 = arg_177_1:FormatText(var_180_8.content)

				arg_177_1.text_.text = var_180_9

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_11 = 28 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_9) / 28)

				if (28 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_9) / 28)) > 0 and var_180_7 < var_180_11 then
					arg_177_1.talkMaxDuration = var_180_11

					if var_180_11 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_11 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_9
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102043", "story_v_out_321102.awb") ~= 0 then
					local var_180_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102043", "story_v_out_321102.awb") / 1000

					if var_180_12 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_12 + var_180_6
					end

					if var_180_8.prefab_name ~= "" and arg_177_1.actors_[var_180_8.prefab_name] ~= nil then
						local var_180_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_8.prefab_name].transform, "story_v_out_321102", "321102043", "story_v_out_321102.awb")

						arg_177_1:RecordAudio("321102043", var_180_13)
						arg_177_1:RecordAudio("321102043", var_180_13)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_321102", "321102043", "story_v_out_321102.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_321102", "321102043", "story_v_out_321102.awb")
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
				actorName = "1011ui_story",
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
	Play321102044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 321102044
		arg_181_1.duration_ = 6.63

		local var_181_0 = {
			zh = 4.266,
			ja = 6.633
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
				arg_181_0:Play321102045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1156ui_story = arg_181_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1156ui_story, Vector3.New(-0.9, -1.1, -6.18), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1156ui_story"].transform.position).z)
				arg_181_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1156ui_story"].transform.localEulerAngles = arg_181_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(-0.9, -1.1, -6.18)
				arg_181_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1156ui_story"].transform.position).z)
				arg_181_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1156ui_story"].transform.localEulerAngles = arg_181_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1156ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1156ui_story == nil then
				arg_181_1.var_.characterEffect1156ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1156ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1156ui_story then
				arg_181_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_184_4 = arg_181_1.actors_["1011ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect1011ui_story == nil then
				arg_181_1.var_.characterEffect1011ui_story = var_184_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_5 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_5 and not isNil(var_184_4) then
				if arg_181_1.var_.characterEffect1011ui_story and not isNil(var_184_4) then
					arg_181_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_5)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_5 and arg_181_1.time_ < 0 + var_184_5 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect1011ui_story then
				arg_181_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action5_1")
			end

			local var_184_6 = 0
			local var_184_7 = 0.525

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_8 = arg_181_1:GetWordFromCfg(321102044)
				local var_184_9 = arg_181_1:FormatText(var_184_8.content)

				arg_181_1.text_.text = var_184_9

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 21 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_9) / 21)

				if (21 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_9) / 21)) > 0 and var_184_7 < var_184_11 then
					arg_181_1.talkMaxDuration = var_184_11

					if var_184_11 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_11 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_9
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102044", "story_v_out_321102.awb") ~= 0 then
					local var_184_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102044", "story_v_out_321102.awb") / 1000

					if var_184_12 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_12 + var_184_6
					end

					if var_184_8.prefab_name ~= "" and arg_181_1.actors_[var_184_8.prefab_name] ~= nil then
						local var_184_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_8.prefab_name].transform, "story_v_out_321102", "321102044", "story_v_out_321102.awb")

						arg_181_1:RecordAudio("321102044", var_184_13)
						arg_181_1:RecordAudio("321102044", var_184_13)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_321102", "321102044", "story_v_out_321102.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_321102", "321102044", "story_v_out_321102.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_14 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_14 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_14

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_14 and arg_181_1.time_ < var_184_6 + var_184_14 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
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

		arg_181_1:InitPlayNodeList()
	end,
	Play321102045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 321102045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play321102046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1011ui_story = arg_185_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1011ui_story"].transform.position).z)
				arg_185_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1011ui_story"].transform.localEulerAngles = arg_185_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_185_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1011ui_story"].transform.position).z)
				arg_185_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1011ui_story"].transform.localEulerAngles = arg_185_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["1156ui_story"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1156ui_story = var_188_1.localPosition
			end

			local var_188_2 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 then
				var_188_1.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 0) / var_188_2)
				var_188_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_1.position).x, (manager.ui.mainCamera.transform.position - var_188_1.position).y, (manager.ui.mainCamera.transform.position - var_188_1.position).z)
				var_188_1.localEulerAngles.z = 0
				var_188_1.localEulerAngles.x = 0
				var_188_1.localEulerAngles = var_188_1.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 then
				var_188_1.localPosition = Vector3.New(0, 100, 0)
				var_188_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_1.position).x, (manager.ui.mainCamera.transform.position - var_188_1.position).y, (manager.ui.mainCamera.transform.position - var_188_1.position).z)
				var_188_1.localEulerAngles.z = 0
				var_188_1.localEulerAngles.x = 0
				var_188_1.localEulerAngles = var_188_1.localEulerAngles
			end

			local var_188_3 = arg_185_1.actors_["1156ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_3) and arg_185_1.var_.characterEffect1156ui_story == nil then
				arg_185_1.var_.characterEffect1156ui_story = var_188_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_4 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 and not isNil(var_188_3) then
				if arg_185_1.var_.characterEffect1156ui_story and not isNil(var_188_3) then
					arg_185_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_4)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 and not isNil(var_188_3) and arg_185_1.var_.characterEffect1156ui_story then
				arg_185_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_188_5 = 0
			local var_188_6 = 1.4

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_7 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(321102045).content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 56 <= 0 and var_188_6 or var_188_6 * (utf8.len(var_188_7) / 56)

				if (56 <= 0 and var_188_6 or var_188_6 * (utf8.len(var_188_7) / 56)) > 0 and var_188_6 < var_188_9 then
					arg_185_1.talkMaxDuration = var_188_9

					if var_188_9 + var_188_5 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_5
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_6, arg_185_1.talkMaxDuration)

			if var_188_5 <= arg_185_1.time_ and arg_185_1.time_ < var_188_5 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_5) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_5 + var_188_10 and arg_185_1.time_ < var_188_5 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
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
				actorName = "1156ui_story",
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
	Play321102046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 321102046
		arg_189_1.duration_ = 6.87

		local var_189_0 = {
			zh = 5.8,
			ja = 6.866
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
				arg_189_0:Play321102047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1011ui_story = arg_189_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1011ui_story"].transform.position).z)
				arg_189_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1011ui_story"].transform.localEulerAngles = arg_189_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_189_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1011ui_story"].transform.position).z)
				arg_189_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1011ui_story"].transform.localEulerAngles = arg_189_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_192_1 = arg_189_1.actors_["1156ui_story"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1156ui_story = var_192_1.localPosition
			end

			local var_192_2 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 then
				var_192_1.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1156ui_story, Vector3.New(-0.9, -1.1, -6.18), (arg_189_1.time_ - 0) / var_192_2)
				var_192_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_1.position).x, (manager.ui.mainCamera.transform.position - var_192_1.position).y, (manager.ui.mainCamera.transform.position - var_192_1.position).z)
				var_192_1.localEulerAngles.z = 0
				var_192_1.localEulerAngles.x = 0
				var_192_1.localEulerAngles = var_192_1.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 then
				var_192_1.localPosition = Vector3.New(-0.9, -1.1, -6.18)
				var_192_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_1.position).x, (manager.ui.mainCamera.transform.position - var_192_1.position).y, (manager.ui.mainCamera.transform.position - var_192_1.position).z)
				var_192_1.localEulerAngles.z = 0
				var_192_1.localEulerAngles.x = 0
				var_192_1.localEulerAngles = var_192_1.localEulerAngles
			end

			local var_192_3 = arg_189_1.actors_["1156ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_3) and arg_189_1.var_.characterEffect1156ui_story == nil then
				arg_189_1.var_.characterEffect1156ui_story = var_192_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_4 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 and not isNil(var_192_3) then
				if arg_189_1.var_.characterEffect1156ui_story and not isNil(var_192_3) then
					arg_189_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 and not isNil(var_192_3) and arg_189_1.var_.characterEffect1156ui_story then
				arg_189_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_192_6 = 0
			local var_192_7 = 0.775

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_8 = arg_189_1:GetWordFromCfg(321102046)
				local var_192_9 = arg_189_1:FormatText(var_192_8.content)

				arg_189_1.text_.text = var_192_9

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_11 = 31 <= 0 and var_192_7 or var_192_7 * (utf8.len(var_192_9) / 31)

				if (31 <= 0 and var_192_7 or var_192_7 * (utf8.len(var_192_9) / 31)) > 0 and var_192_7 < var_192_11 then
					arg_189_1.talkMaxDuration = var_192_11

					if var_192_11 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_11 + var_192_6
					end
				end

				arg_189_1.text_.text = var_192_9
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102046", "story_v_out_321102.awb") ~= 0 then
					local var_192_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102046", "story_v_out_321102.awb") / 1000

					if var_192_12 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_12 + var_192_6
					end

					if var_192_8.prefab_name ~= "" and arg_189_1.actors_[var_192_8.prefab_name] ~= nil then
						local var_192_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_8.prefab_name].transform, "story_v_out_321102", "321102046", "story_v_out_321102.awb")

						arg_189_1:RecordAudio("321102046", var_192_13)
						arg_189_1:RecordAudio("321102046", var_192_13)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_321102", "321102046", "story_v_out_321102.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_321102", "321102046", "story_v_out_321102.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_14 = math.max(var_192_7, arg_189_1.talkMaxDuration)

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_14 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_6) / var_192_14

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_6 + var_192_14 and arg_189_1.time_ < var_192_6 + var_192_14 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
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
				actorName = "1156ui_story",
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
	Play321102047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 321102047
		arg_193_1.duration_ = 14.6

		local var_193_0 = {
			zh = 8.866,
			ja = 14.6
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
				arg_193_0:Play321102048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1156ui_story = arg_193_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1156ui_story, Vector3.New(-0.9, -1.1, -6.18), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1156ui_story"].transform.position).z)
				arg_193_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1156ui_story"].transform.localEulerAngles = arg_193_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(-0.9, -1.1, -6.18)
				arg_193_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1156ui_story"].transform.position).z)
				arg_193_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1156ui_story"].transform.localEulerAngles = arg_193_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action5_2")
			end

			local var_196_1 = 0
			local var_196_2 = 1.225

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:GetWordFromCfg(321102047)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_6 = 49 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_4) / 49)

				if (49 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_4) / 49)) > 0 and var_196_2 < var_196_6 then
					arg_193_1.talkMaxDuration = var_196_6

					if var_196_6 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_1
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102047", "story_v_out_321102.awb") ~= 0 then
					local var_196_7 = manager.audio:GetVoiceLength("story_v_out_321102", "321102047", "story_v_out_321102.awb") / 1000

					if var_196_7 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_1
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_out_321102", "321102047", "story_v_out_321102.awb")

						arg_193_1:RecordAudio("321102047", var_196_8)
						arg_193_1:RecordAudio("321102047", var_196_8)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_321102", "321102047", "story_v_out_321102.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_321102", "321102047", "story_v_out_321102.awb")
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
				actorName = "1156ui_story",
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
	Play321102048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 321102048
		arg_197_1.duration_ = 9.8

		local var_197_0 = {
			zh = 7.9,
			ja = 9.8
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
				arg_197_0:Play321102049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1011ui_story = arg_197_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1011ui_story"].transform.position).z)
				arg_197_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1011ui_story"].transform.localEulerAngles = arg_197_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_197_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1011ui_story"].transform.position).z)
				arg_197_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1011ui_story"].transform.localEulerAngles = arg_197_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["1011ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1011ui_story == nil then
				arg_197_1.var_.characterEffect1011ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect1011ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1011ui_story then
				arg_197_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_200_4 = arg_197_1.actors_["1156ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_4) and arg_197_1.var_.characterEffect1156ui_story == nil then
				arg_197_1.var_.characterEffect1156ui_story = var_200_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_5 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_5 and not isNil(var_200_4) then
				if arg_197_1.var_.characterEffect1156ui_story and not isNil(var_200_4) then
					arg_197_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_5)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_5 and arg_197_1.time_ < 0 + var_200_5 + arg_200_0 and not isNil(var_200_4) and arg_197_1.var_.characterEffect1156ui_story then
				arg_197_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_200_6 = 0
			local var_200_7 = 0.9

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_8 = arg_197_1:GetWordFromCfg(321102048)
				local var_200_9 = arg_197_1:FormatText(var_200_8.content)

				arg_197_1.text_.text = var_200_9

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 36 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_9) / 36)

				if (36 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_9) / 36)) > 0 and var_200_7 < var_200_11 then
					arg_197_1.talkMaxDuration = var_200_11

					if var_200_11 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_11 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_9
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102048", "story_v_out_321102.awb") ~= 0 then
					local var_200_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102048", "story_v_out_321102.awb") / 1000

					if var_200_12 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_12 + var_200_6
					end

					if var_200_8.prefab_name ~= "" and arg_197_1.actors_[var_200_8.prefab_name] ~= nil then
						local var_200_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_8.prefab_name].transform, "story_v_out_321102", "321102048", "story_v_out_321102.awb")

						arg_197_1:RecordAudio("321102048", var_200_13)
						arg_197_1:RecordAudio("321102048", var_200_13)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_321102", "321102048", "story_v_out_321102.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_321102", "321102048", "story_v_out_321102.awb")
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
				actorName = "1011ui_story",
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
	Play321102049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 321102049
		arg_201_1.duration_ = 6.43

		local var_201_0 = {
			zh = 3.7,
			ja = 6.433
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
				arg_201_0:Play321102050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1156ui_story = arg_201_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1156ui_story, Vector3.New(-0.9, -1.1, -6.18), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1156ui_story"].transform.position).z)
				arg_201_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1156ui_story"].transform.localEulerAngles = arg_201_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(-0.9, -1.1, -6.18)
				arg_201_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1156ui_story"].transform.position).z)
				arg_201_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1156ui_story"].transform.localEulerAngles = arg_201_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["1156ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1156ui_story == nil then
				arg_201_1.var_.characterEffect1156ui_story = var_204_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 and not isNil(var_204_1) then
				if arg_201_1.var_.characterEffect1156ui_story and not isNil(var_204_1) then
					arg_201_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1156ui_story then
				arg_201_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_204_4 = arg_201_1.actors_["1011ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect1011ui_story == nil then
				arg_201_1.var_.characterEffect1011ui_story = var_204_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_5 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_5 and not isNil(var_204_4) then
				if arg_201_1.var_.characterEffect1011ui_story and not isNil(var_204_4) then
					arg_201_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_5)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_5 and arg_201_1.time_ < 0 + var_204_5 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect1011ui_story then
				arg_201_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action13_1")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_204_6 = 0
			local var_204_7 = 0.4

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_8 = arg_201_1:GetWordFromCfg(321102049)
				local var_204_9 = arg_201_1:FormatText(var_204_8.content)

				arg_201_1.text_.text = var_204_9

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_11 = 16 <= 0 and var_204_7 or var_204_7 * (utf8.len(var_204_9) / 16)

				if (16 <= 0 and var_204_7 or var_204_7 * (utf8.len(var_204_9) / 16)) > 0 and var_204_7 < var_204_11 then
					arg_201_1.talkMaxDuration = var_204_11

					if var_204_11 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_11 + var_204_6
					end
				end

				arg_201_1.text_.text = var_204_9
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102049", "story_v_out_321102.awb") ~= 0 then
					local var_204_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102049", "story_v_out_321102.awb") / 1000

					if var_204_12 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_12 + var_204_6
					end

					if var_204_8.prefab_name ~= "" and arg_201_1.actors_[var_204_8.prefab_name] ~= nil then
						local var_204_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_8.prefab_name].transform, "story_v_out_321102", "321102049", "story_v_out_321102.awb")

						arg_201_1:RecordAudio("321102049", var_204_13)
						arg_201_1:RecordAudio("321102049", var_204_13)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_321102", "321102049", "story_v_out_321102.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_321102", "321102049", "story_v_out_321102.awb")
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
				actorName = "1156ui_story",
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
	Play321102050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 321102050
		arg_205_1.duration_ = 9.43

		local var_205_0 = {
			zh = 5.966,
			ja = 9.433
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
				arg_205_0:Play321102051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1156ui_story = arg_205_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1156ui_story, Vector3.New(-0.9, -1.1, -6.18), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1156ui_story"].transform.position).z)
				arg_205_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1156ui_story"].transform.localEulerAngles = arg_205_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(-0.9, -1.1, -6.18)
				arg_205_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1156ui_story"].transform.position).z)
				arg_205_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1156ui_story"].transform.localEulerAngles = arg_205_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_208_1 = 0
			local var_208_2 = 0.8

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_3 = arg_205_1:GetWordFromCfg(321102050)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_6 = 32 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_4) / 32)

				if (32 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_4) / 32)) > 0 and var_208_2 < var_208_6 then
					arg_205_1.talkMaxDuration = var_208_6

					if var_208_6 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_6 + var_208_1
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102050", "story_v_out_321102.awb") ~= 0 then
					local var_208_7 = manager.audio:GetVoiceLength("story_v_out_321102", "321102050", "story_v_out_321102.awb") / 1000

					if var_208_7 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_1
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_out_321102", "321102050", "story_v_out_321102.awb")

						arg_205_1:RecordAudio("321102050", var_208_8)
						arg_205_1:RecordAudio("321102050", var_208_8)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_321102", "321102050", "story_v_out_321102.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_321102", "321102050", "story_v_out_321102.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_9 = math.max(var_208_2, arg_205_1.talkMaxDuration)

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_9 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_1) / var_208_9

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_1 + var_208_9 and arg_205_1.time_ < var_208_1 + var_208_9 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
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

		arg_205_1:InitPlayNodeList()
	end,
	Play321102051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 321102051
		arg_209_1.duration_ = 4.53

		local var_209_0 = {
			zh = 4.533,
			ja = 4.4
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
				arg_209_0:Play321102052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1011ui_story = arg_209_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1011ui_story"].transform.position).z)
				arg_209_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1011ui_story"].transform.localEulerAngles = arg_209_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_209_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1011ui_story"].transform.position).z)
				arg_209_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1011ui_story"].transform.localEulerAngles = arg_209_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1011ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1011ui_story == nil then
				arg_209_1.var_.characterEffect1011ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect1011ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1011ui_story then
				arg_209_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_212_4 = arg_209_1.actors_["1156ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_4) and arg_209_1.var_.characterEffect1156ui_story == nil then
				arg_209_1.var_.characterEffect1156ui_story = var_212_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_5 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_5 and not isNil(var_212_4) then
				if arg_209_1.var_.characterEffect1156ui_story and not isNil(var_212_4) then
					arg_209_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_5)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_5 and arg_209_1.time_ < 0 + var_212_5 + arg_212_0 and not isNil(var_212_4) and arg_209_1.var_.characterEffect1156ui_story then
				arg_209_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_2")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_212_6 = 0
			local var_212_7 = 0.35

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_8 = arg_209_1:GetWordFromCfg(321102051)
				local var_212_9 = arg_209_1:FormatText(var_212_8.content)

				arg_209_1.text_.text = var_212_9

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_11 = 14 <= 0 and var_212_7 or var_212_7 * (utf8.len(var_212_9) / 14)

				if (14 <= 0 and var_212_7 or var_212_7 * (utf8.len(var_212_9) / 14)) > 0 and var_212_7 < var_212_11 then
					arg_209_1.talkMaxDuration = var_212_11

					if var_212_11 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_11 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_9
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102051", "story_v_out_321102.awb") ~= 0 then
					local var_212_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102051", "story_v_out_321102.awb") / 1000

					if var_212_12 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_12 + var_212_6
					end

					if var_212_8.prefab_name ~= "" and arg_209_1.actors_[var_212_8.prefab_name] ~= nil then
						local var_212_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_8.prefab_name].transform, "story_v_out_321102", "321102051", "story_v_out_321102.awb")

						arg_209_1:RecordAudio("321102051", var_212_13)
						arg_209_1:RecordAudio("321102051", var_212_13)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_321102", "321102051", "story_v_out_321102.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_321102", "321102051", "story_v_out_321102.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_14 = math.max(var_212_7, arg_209_1.talkMaxDuration)

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_14 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_6) / var_212_14

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_6 + var_212_14 and arg_209_1.time_ < var_212_6 + var_212_14 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
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

		arg_209_1:InitPlayNodeList()
	end,
	Play321102052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 321102052
		arg_213_1.duration_ = 2

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play321102053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1156ui_story = arg_213_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1156ui_story, Vector3.New(-0.9, -1.1, -6.18), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1156ui_story"].transform.position).z)
				arg_213_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1156ui_story"].transform.localEulerAngles = arg_213_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(-0.9, -1.1, -6.18)
				arg_213_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1156ui_story"].transform.position).z)
				arg_213_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1156ui_story"].transform.localEulerAngles = arg_213_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1156ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1156ui_story == nil then
				arg_213_1.var_.characterEffect1156ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1156ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1156ui_story then
				arg_213_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_216_4 = arg_213_1.actors_["1011ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_4) and arg_213_1.var_.characterEffect1011ui_story == nil then
				arg_213_1.var_.characterEffect1011ui_story = var_216_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_5 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_5 and not isNil(var_216_4) then
				if arg_213_1.var_.characterEffect1011ui_story and not isNil(var_216_4) then
					arg_213_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_5)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_5 and arg_213_1.time_ < 0 + var_216_5 + arg_216_0 and not isNil(var_216_4) and arg_213_1.var_.characterEffect1011ui_story then
				arg_213_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action13_2")
			end

			local var_216_6 = 0
			local var_216_7 = 0.125

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_6 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_8 = arg_213_1:GetWordFromCfg(321102052)
				local var_216_9 = arg_213_1:FormatText(var_216_8.content)

				arg_213_1.text_.text = var_216_9

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_11 = 5 <= 0 and var_216_7 or var_216_7 * (utf8.len(var_216_9) / 5)

				if (5 <= 0 and var_216_7 or var_216_7 * (utf8.len(var_216_9) / 5)) > 0 and var_216_7 < var_216_11 then
					arg_213_1.talkMaxDuration = var_216_11

					if var_216_11 + var_216_6 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_11 + var_216_6
					end
				end

				arg_213_1.text_.text = var_216_9
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102052", "story_v_out_321102.awb") ~= 0 then
					local var_216_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102052", "story_v_out_321102.awb") / 1000

					if var_216_12 + var_216_6 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_12 + var_216_6
					end

					if var_216_8.prefab_name ~= "" and arg_213_1.actors_[var_216_8.prefab_name] ~= nil then
						local var_216_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_8.prefab_name].transform, "story_v_out_321102", "321102052", "story_v_out_321102.awb")

						arg_213_1:RecordAudio("321102052", var_216_13)
						arg_213_1:RecordAudio("321102052", var_216_13)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_321102", "321102052", "story_v_out_321102.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_321102", "321102052", "story_v_out_321102.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_14 = math.max(var_216_7, arg_213_1.talkMaxDuration)

			if var_216_6 <= arg_213_1.time_ and arg_213_1.time_ < var_216_6 + var_216_14 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_6) / var_216_14

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_6 + var_216_14 and arg_213_1.time_ < var_216_6 + var_216_14 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
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

		arg_213_1:InitPlayNodeList()
	end,
	Play321102053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 321102053
		arg_217_1.duration_ = 5.93

		local var_217_0 = {
			zh = 5.4,
			ja = 5.933
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
				arg_217_0:Play321102054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1011ui_story = arg_217_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1011ui_story"].transform.position).z)
				arg_217_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1011ui_story"].transform.localEulerAngles = arg_217_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_217_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1011ui_story"].transform.position).z)
				arg_217_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1011ui_story"].transform.localEulerAngles = arg_217_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_220_1 = arg_217_1.actors_["1011ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1011ui_story == nil then
				arg_217_1.var_.characterEffect1011ui_story = var_220_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 and not isNil(var_220_1) then
				if arg_217_1.var_.characterEffect1011ui_story and not isNil(var_220_1) then
					arg_217_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1011ui_story then
				arg_217_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_220_4 = arg_217_1.actors_["1156ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_4) and arg_217_1.var_.characterEffect1156ui_story == nil then
				arg_217_1.var_.characterEffect1156ui_story = var_220_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_5 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_5 and not isNil(var_220_4) then
				if arg_217_1.var_.characterEffect1156ui_story and not isNil(var_220_4) then
					arg_217_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_5)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_5 and arg_217_1.time_ < 0 + var_220_5 + arg_220_0 and not isNil(var_220_4) and arg_217_1.var_.characterEffect1156ui_story then
				arg_217_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_220_6 = 0
			local var_220_7 = 0.55

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_8 = arg_217_1:GetWordFromCfg(321102053)
				local var_220_9 = arg_217_1:FormatText(var_220_8.content)

				arg_217_1.text_.text = var_220_9

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_11 = 22 <= 0 and var_220_7 or var_220_7 * (utf8.len(var_220_9) / 22)

				if (22 <= 0 and var_220_7 or var_220_7 * (utf8.len(var_220_9) / 22)) > 0 and var_220_7 < var_220_11 then
					arg_217_1.talkMaxDuration = var_220_11

					if var_220_11 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_11 + var_220_6
					end
				end

				arg_217_1.text_.text = var_220_9
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102053", "story_v_out_321102.awb") ~= 0 then
					local var_220_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102053", "story_v_out_321102.awb") / 1000

					if var_220_12 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_12 + var_220_6
					end

					if var_220_8.prefab_name ~= "" and arg_217_1.actors_[var_220_8.prefab_name] ~= nil then
						local var_220_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_8.prefab_name].transform, "story_v_out_321102", "321102053", "story_v_out_321102.awb")

						arg_217_1:RecordAudio("321102053", var_220_13)
						arg_217_1:RecordAudio("321102053", var_220_13)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_321102", "321102053", "story_v_out_321102.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_321102", "321102053", "story_v_out_321102.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_14 = math.max(var_220_7, arg_217_1.talkMaxDuration)

			if var_220_6 <= arg_217_1.time_ and arg_217_1.time_ < var_220_6 + var_220_14 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_6) / var_220_14

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_6 + var_220_14 and arg_217_1.time_ < var_220_6 + var_220_14 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
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

		arg_217_1:InitPlayNodeList()
	end,
	Play321102054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 321102054
		arg_221_1.duration_ = 10.07

		local var_221_0 = {
			zh = 7.63199999815226,
			ja = 10.0659999981523
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
				arg_221_0:Play321102055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if arg_221_1.bgs_.L01h == nil then
				local var_224_0 = Object.Instantiate(arg_221_1.paintGo_)

				var_224_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L01h")
				var_224_0.name = "L01h"
				var_224_0.transform.parent = arg_221_1.stage_.transform
				var_224_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_221_1.bgs_.L01h = var_224_0
			end

			if 1.96599999815226 < arg_221_1.time_ and arg_221_1.time_ <= 1.96599999815226 + arg_224_0 then
				local var_224_1 = arg_221_1.bgs_.L01h

				arg_221_1.bgs_.L01h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_224_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_224_2 = var_224_1:GetComponent("SpriteRenderer")

				if var_224_2 and var_224_2.sprite then
					local var_224_3 = 2 * (var_224_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_224_1.transform.localScale = Vector3.New(var_224_3 / var_224_2.sprite.bounds.size.y < var_224_3 * manager.ui.mainCameraCom_.aspect / var_224_2.sprite.bounds.size.x and var_224_3 * manager.ui.mainCameraCom_.aspect / var_224_2.sprite.bounds.size.x or var_224_3 / var_224_2.sprite.bounds.size.y, var_224_3 / var_224_2.sprite.bounds.size.y < var_224_3 * manager.ui.mainCameraCom_.aspect / var_224_2.sprite.bounds.size.x and var_224_3 * manager.ui.mainCameraCom_.aspect / var_224_2.sprite.bounds.size.x or var_224_3 / var_224_2.sprite.bounds.size.y, 0)
				end

				for iter_224_0, iter_224_1 in pairs(arg_221_1.bgs_) do
					if iter_224_0 ~= "L01h" then
						iter_224_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_224_4 = 4

			if 4 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.allBtn_.enabled = false
			end

			if arg_221_1.time_ >= var_224_4 + 0.3 and arg_221_1.time_ < var_224_4 + 0.3 + arg_224_0 then
				arg_221_1.allBtn_.enabled = true
			end

			local var_224_5 = 0

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_6 = 2

			if var_224_5 <= arg_221_1.time_ and arg_221_1.time_ < var_224_5 + var_224_6 then
				local var_224_7 = Color.New(0, 0, 0)

				var_224_7.a = Mathf.Lerp(0, 1, (arg_221_1.time_ - var_224_5) / var_224_6)
				arg_221_1.mask_.color = var_224_7
			end

			if arg_221_1.time_ >= var_224_5 + var_224_6 and arg_221_1.time_ < var_224_5 + var_224_6 + arg_224_0 then
				local var_224_8 = Color.New(0, 0, 0)

				var_224_8.a = 1
				arg_221_1.mask_.color = var_224_8
			end

			local var_224_9 = 2.00000000298023

			if 2.00000000298023 < arg_221_1.time_ and arg_221_1.time_ <= var_224_9 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_10 = 2

			if var_224_9 <= arg_221_1.time_ and arg_221_1.time_ < var_224_9 + var_224_10 then
				local var_224_11 = Color.New(0, 0, 0)

				var_224_11.a = Mathf.Lerp(1, 0, (arg_221_1.time_ - var_224_9) / var_224_10)
				arg_221_1.mask_.color = var_224_11
			end

			if arg_221_1.time_ >= var_224_9 + var_224_10 and arg_221_1.time_ < var_224_9 + var_224_10 + arg_224_0 then
				local var_224_12 = Color.New(0, 0, 0)

				arg_221_1.mask_.enabled = false
				var_224_12.a = 0
				arg_221_1.mask_.color = var_224_12
			end

			local var_224_13 = arg_221_1.actors_["1011ui_story"].transform

			if 1.96599999815226 < arg_221_1.time_ and arg_221_1.time_ <= 1.96599999815226 + arg_224_0 then
				arg_221_1.var_.moveOldPos1011ui_story = var_224_13.localPosition
			end

			local var_224_14 = 0.001

			if 1.96599999815226 <= arg_221_1.time_ and arg_221_1.time_ < 1.96599999815226 + var_224_14 then
				var_224_13.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_221_1.time_ - 1.96599999815226) / var_224_14)
				var_224_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_13.position).x, (manager.ui.mainCamera.transform.position - var_224_13.position).y, (manager.ui.mainCamera.transform.position - var_224_13.position).z)
				var_224_13.localEulerAngles.z = 0
				var_224_13.localEulerAngles.x = 0
				var_224_13.localEulerAngles = var_224_13.localEulerAngles
			end

			if arg_221_1.time_ >= 1.96599999815226 + var_224_14 and arg_221_1.time_ < 1.96599999815226 + var_224_14 + arg_224_0 then
				var_224_13.localPosition = Vector3.New(0, 100, 0)
				var_224_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_13.position).x, (manager.ui.mainCamera.transform.position - var_224_13.position).y, (manager.ui.mainCamera.transform.position - var_224_13.position).z)
				var_224_13.localEulerAngles.z = 0
				var_224_13.localEulerAngles.x = 0
				var_224_13.localEulerAngles = var_224_13.localEulerAngles
			end

			local var_224_15 = arg_221_1.actors_["1156ui_story"].transform

			if 1.96599999815226 < arg_221_1.time_ and arg_221_1.time_ <= 1.96599999815226 + arg_224_0 then
				arg_221_1.var_.moveOldPos1156ui_story = var_224_15.localPosition
			end

			local var_224_16 = 0.001

			if 1.96599999815226 <= arg_221_1.time_ and arg_221_1.time_ < 1.96599999815226 + var_224_16 then
				var_224_15.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_221_1.time_ - 1.96599999815226) / var_224_16)
				var_224_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_15.position).x, (manager.ui.mainCamera.transform.position - var_224_15.position).y, (manager.ui.mainCamera.transform.position - var_224_15.position).z)
				var_224_15.localEulerAngles.z = 0
				var_224_15.localEulerAngles.x = 0
				var_224_15.localEulerAngles = var_224_15.localEulerAngles
			end

			if arg_221_1.time_ >= 1.96599999815226 + var_224_16 and arg_221_1.time_ < 1.96599999815226 + var_224_16 + arg_224_0 then
				var_224_15.localPosition = Vector3.New(0, 100, 0)
				var_224_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_15.position).x, (manager.ui.mainCamera.transform.position - var_224_15.position).y, (manager.ui.mainCamera.transform.position - var_224_15.position).z)
				var_224_15.localEulerAngles.z = 0
				var_224_15.localEulerAngles.x = 0
				var_224_15.localEulerAngles = var_224_15.localEulerAngles
			end

			local var_224_17 = "10100ui_story"

			if arg_221_1.actors_["10100ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10100ui_story"))) then
				local var_224_18 = Object.Instantiate(Asset.Load("Char/" .. "10100ui_story"), arg_221_1.stage_.transform)

				var_224_18.name = var_224_17
				var_224_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_221_1.actors_[var_224_17] = var_224_18

				local var_224_19 = var_224_18:GetComponentInChildren(typeof(CharacterEffect))

				var_224_19.enabled = true

				local var_224_20 = GameObjectTools.GetOrAddComponent(var_224_18, typeof(DynamicBoneHelper))

				if var_224_20 then
					var_224_20:EnableDynamicBone(false)
				end

				arg_221_1:ShowWeapon(var_224_19.transform, false)

				arg_221_1.var_[var_224_17 .. "Animator"] = var_224_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_221_1.var_[var_224_17 .. "Animator"].applyRootMotion = true
				arg_221_1.var_[var_224_17 .. "LipSync"] = var_224_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_224_21 = arg_221_1.actors_["10100ui_story"].transform

			if 3.8 < arg_221_1.time_ and arg_221_1.time_ <= 3.8 + arg_224_0 then
				arg_221_1.var_.moveOldPos10100ui_story = var_224_21.localPosition
			end

			local var_224_22 = 0.001

			if 3.8 <= arg_221_1.time_ and arg_221_1.time_ < 3.8 + var_224_22 then
				var_224_21.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10100ui_story, Vector3.New(0.7, -1.16, -6.25), (arg_221_1.time_ - 3.8) / var_224_22)
				var_224_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_21.position).x, (manager.ui.mainCamera.transform.position - var_224_21.position).y, (manager.ui.mainCamera.transform.position - var_224_21.position).z)
				var_224_21.localEulerAngles.z = 0
				var_224_21.localEulerAngles.x = 0
				var_224_21.localEulerAngles = var_224_21.localEulerAngles
			end

			if arg_221_1.time_ >= 3.8 + var_224_22 and arg_221_1.time_ < 3.8 + var_224_22 + arg_224_0 then
				var_224_21.localPosition = Vector3.New(0.7, -1.16, -6.25)
				var_224_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_21.position).x, (manager.ui.mainCamera.transform.position - var_224_21.position).y, (manager.ui.mainCamera.transform.position - var_224_21.position).z)
				var_224_21.localEulerAngles.z = 0
				var_224_21.localEulerAngles.x = 0
				var_224_21.localEulerAngles = var_224_21.localEulerAngles
			end

			local var_224_23 = arg_221_1.actors_["10100ui_story"]

			if 3.8 < arg_221_1.time_ and arg_221_1.time_ <= 3.8 + arg_224_0 and not isNil(var_224_23) and arg_221_1.var_.characterEffect10100ui_story == nil then
				arg_221_1.var_.characterEffect10100ui_story = var_224_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_24 = 0.200000002980232

			if 3.8 <= arg_221_1.time_ and arg_221_1.time_ < 3.8 + var_224_24 and not isNil(var_224_23) then
				if arg_221_1.var_.characterEffect10100ui_story and not isNil(var_224_23) then
					arg_221_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 3.8 + var_224_24 and arg_221_1.time_ < 3.8 + var_224_24 + arg_224_0 and not isNil(var_224_23) and arg_221_1.var_.characterEffect10100ui_story then
				arg_221_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 3.8 < arg_221_1.time_ and arg_221_1.time_ <= 3.8 + arg_224_0 then
				arg_221_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_1")
			end

			if 1.96599999815226 < arg_221_1.time_ and arg_221_1.time_ <= 1.96599999815226 + arg_224_0 then
				arg_221_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_chaos", "")
			end

			if arg_221_1.frameCnt_ <= 1 then
				arg_221_1.dialog_:SetActive(false)
			end

			local var_224_27 = 3.96599999815226
			local var_224_28 = 0.45

			if 3.96599999815226 < arg_221_1.time_ and arg_221_1.time_ <= var_224_27 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0

				arg_221_1.dialog_:SetActive(true)

				arg_221_1.dialogCg_.alpha = 0

				local var_224_29 = LeanTween.value(arg_221_1.dialog_, 0, 1, 0.3)

				var_224_29:setOnUpdate(LuaHelper.FloatAction(function(arg_225_0)
					arg_221_1.dialogCg_.alpha = arg_225_0
				end))
				var_224_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_221_1.dialog_)
					var_224_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_221_1.duration_ = arg_221_1.duration_ + 0.3

				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_30 = arg_221_1:GetWordFromCfg(321102054)
				local var_224_31 = arg_221_1:FormatText(var_224_30.content)

				arg_221_1.text_.text = var_224_31

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_33 = 18 <= 0 and var_224_28 or var_224_28 * (utf8.len(var_224_31) / 18)

				if (18 <= 0 and var_224_28 or var_224_28 * (utf8.len(var_224_31) / 18)) > 0 and var_224_28 < var_224_33 then
					arg_221_1.talkMaxDuration = var_224_33
					var_224_27 = var_224_27 + 0.3

					if var_224_33 + var_224_27 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_33 + var_224_27
					end
				end

				arg_221_1.text_.text = var_224_31
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102054", "story_v_out_321102.awb") ~= 0 then
					local var_224_34 = manager.audio:GetVoiceLength("story_v_out_321102", "321102054", "story_v_out_321102.awb") / 1000

					if var_224_34 + var_224_27 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_34 + var_224_27
					end

					if var_224_30.prefab_name ~= "" and arg_221_1.actors_[var_224_30.prefab_name] ~= nil then
						local var_224_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_30.prefab_name].transform, "story_v_out_321102", "321102054", "story_v_out_321102.awb")

						arg_221_1:RecordAudio("321102054", var_224_35)
						arg_221_1:RecordAudio("321102054", var_224_35)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_321102", "321102054", "story_v_out_321102.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_321102", "321102054", "story_v_out_321102.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_36 = var_224_27 + 0.3
			local var_224_37 = math.max(var_224_28, arg_221_1.talkMaxDuration)

			if var_224_27 + 0.3 <= arg_221_1.time_ and arg_221_1.time_ < var_224_36 + var_224_37 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_36) / var_224_37

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_36 + var_224_37 and arg_221_1.time_ < var_224_36 + var_224_37 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
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
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play321102055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 321102055
		arg_227_1.duration_ = 13.2

		local var_227_0 = {
			zh = 6.9,
			ja = 13.2
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
				arg_227_0:Play321102056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if arg_227_1.actors_["1089ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1089ui_story"))) then
				local var_230_0 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_227_1.stage_.transform)

				var_230_0.name = "1089ui_story"
				var_230_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.actors_["1089ui_story"] = var_230_0

				local var_230_1 = var_230_0:GetComponentInChildren(typeof(CharacterEffect))

				var_230_1.enabled = true

				local var_230_2 = GameObjectTools.GetOrAddComponent(var_230_0, typeof(DynamicBoneHelper))

				if var_230_2 then
					var_230_2:EnableDynamicBone(false)
				end

				arg_227_1:ShowWeapon(var_230_1.transform, false)

				arg_227_1.var_["1089ui_story" .. "Animator"] = var_230_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_227_1.var_["1089ui_story" .. "Animator"].applyRootMotion = true
				arg_227_1.var_["1089ui_story" .. "LipSync"] = var_230_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_230_3 = arg_227_1.actors_["1089ui_story"].transform

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1089ui_story = var_230_3.localPosition
			end

			local var_230_4 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 then
				var_230_3.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_227_1.time_ - 0) / var_230_4)
				var_230_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_3.position).x, (manager.ui.mainCamera.transform.position - var_230_3.position).y, (manager.ui.mainCamera.transform.position - var_230_3.position).z)
				var_230_3.localEulerAngles.z = 0
				var_230_3.localEulerAngles.x = 0
				var_230_3.localEulerAngles = var_230_3.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 then
				var_230_3.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				var_230_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_3.position).x, (manager.ui.mainCamera.transform.position - var_230_3.position).y, (manager.ui.mainCamera.transform.position - var_230_3.position).z)
				var_230_3.localEulerAngles.z = 0
				var_230_3.localEulerAngles.x = 0
				var_230_3.localEulerAngles = var_230_3.localEulerAngles
			end

			local var_230_5 = arg_227_1.actors_["1089ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_5) and arg_227_1.var_.characterEffect1089ui_story == nil then
				arg_227_1.var_.characterEffect1089ui_story = var_230_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_6 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_6 and not isNil(var_230_5) then
				if arg_227_1.var_.characterEffect1089ui_story and not isNil(var_230_5) then
					arg_227_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_6 and arg_227_1.time_ < 0 + var_230_6 + arg_230_0 and not isNil(var_230_5) and arg_227_1.var_.characterEffect1089ui_story then
				arg_227_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_230_8 = arg_227_1.actors_["10100ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_8) and arg_227_1.var_.characterEffect10100ui_story == nil then
				arg_227_1.var_.characterEffect10100ui_story = var_230_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_9 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_9 and not isNil(var_230_8) then
				if arg_227_1.var_.characterEffect10100ui_story and not isNil(var_230_8) then
					arg_227_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_227_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_9)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_9 and arg_227_1.time_ < 0 + var_230_9 + arg_230_0 and not isNil(var_230_8) and arg_227_1.var_.characterEffect10100ui_story then
				arg_227_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_227_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_230_10 = 0
			local var_230_11 = 0.725

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_10 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_12 = arg_227_1:GetWordFromCfg(321102055)
				local var_230_13 = arg_227_1:FormatText(var_230_12.content)

				arg_227_1.text_.text = var_230_13

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_15 = 29 <= 0 and var_230_11 or var_230_11 * (utf8.len(var_230_13) / 29)

				if (29 <= 0 and var_230_11 or var_230_11 * (utf8.len(var_230_13) / 29)) > 0 and var_230_11 < var_230_15 then
					arg_227_1.talkMaxDuration = var_230_15

					if var_230_15 + var_230_10 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_15 + var_230_10
					end
				end

				arg_227_1.text_.text = var_230_13
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102055", "story_v_out_321102.awb") ~= 0 then
					local var_230_16 = manager.audio:GetVoiceLength("story_v_out_321102", "321102055", "story_v_out_321102.awb") / 1000

					if var_230_16 + var_230_10 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_16 + var_230_10
					end

					if var_230_12.prefab_name ~= "" and arg_227_1.actors_[var_230_12.prefab_name] ~= nil then
						local var_230_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_12.prefab_name].transform, "story_v_out_321102", "321102055", "story_v_out_321102.awb")

						arg_227_1:RecordAudio("321102055", var_230_17)
						arg_227_1:RecordAudio("321102055", var_230_17)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_321102", "321102055", "story_v_out_321102.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_321102", "321102055", "story_v_out_321102.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_18 = math.max(var_230_11, arg_227_1.talkMaxDuration)

			if var_230_10 <= arg_227_1.time_ and arg_227_1.time_ < var_230_10 + var_230_18 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_10) / var_230_18

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_10 + var_230_18 and arg_227_1.time_ < var_230_10 + var_230_18 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
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

		arg_227_1:InitPlayNodeList()
	end,
	Play321102056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 321102056
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play321102057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1089ui_story = arg_231_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1089ui_story"].transform.position).z)
				arg_231_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1089ui_story"].transform.localEulerAngles = arg_231_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1089ui_story"].transform.position).z)
				arg_231_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1089ui_story"].transform.localEulerAngles = arg_231_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["10100ui_story"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos10100ui_story = var_234_1.localPosition
			end

			local var_234_2 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 then
				var_234_1.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 0) / var_234_2)
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

			local var_234_3 = arg_231_1.actors_["1089ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_3) and arg_231_1.var_.characterEffect1089ui_story == nil then
				arg_231_1.var_.characterEffect1089ui_story = var_234_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_4 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 and not isNil(var_234_3) then
				if arg_231_1.var_.characterEffect1089ui_story and not isNil(var_234_3) then
					arg_231_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_4)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 and not isNil(var_234_3) and arg_231_1.var_.characterEffect1089ui_story then
				arg_231_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_234_5 = 0
			local var_234_6 = 0.975

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_7 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(321102056).content)

				arg_231_1.text_.text = var_234_7

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_9 = 39 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_7) / 39)

				if (39 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_7) / 39)) > 0 and var_234_6 < var_234_9 then
					arg_231_1.talkMaxDuration = var_234_9

					if var_234_9 + var_234_5 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_5
					end
				end

				arg_231_1.text_.text = var_234_7
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_6, arg_231_1.talkMaxDuration)

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_5) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_5 + var_234_10 and arg_231_1.time_ < var_234_5 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
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
				actorName = "10100ui_story",
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
	Play321102057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 321102057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play321102058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 1.225

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(321102057).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 49 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 49)

				if (49 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 49)) > 0 and var_238_0 < var_238_3 then
					arg_235_1.talkMaxDuration = var_238_3

					if var_238_3 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_3 + 0
					end
				end

				arg_235_1.text_.text = var_238_1
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_4 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_4

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play321102058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 321102058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play321102059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 1.25

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(321102058).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 50 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 50)

				if (50 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 50)) > 0 and var_242_0 < var_242_3 then
					arg_239_1.talkMaxDuration = var_242_3

					if var_242_3 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_3 + 0
					end
				end

				arg_239_1.text_.text = var_242_1
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_4 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_4

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play321102059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 321102059
		arg_243_1.duration_ = 12.37

		local var_243_0 = {
			zh = 7.866,
			ja = 12.366
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play321102060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1089ui_story = arg_243_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1089ui_story"].transform.position).z)
				arg_243_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1089ui_story"].transform.localEulerAngles = arg_243_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				arg_243_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1089ui_story"].transform.position).z)
				arg_243_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1089ui_story"].transform.localEulerAngles = arg_243_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_246_1 = arg_243_1.actors_["1089ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1089ui_story == nil then
				arg_243_1.var_.characterEffect1089ui_story = var_246_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_2 and not isNil(var_246_1) then
				if arg_243_1.var_.characterEffect1089ui_story and not isNil(var_246_1) then
					arg_243_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_2 and arg_243_1.time_ < 0 + var_246_2 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1089ui_story then
				arg_243_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_2")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_246_4 = 0
			local var_246_5 = 0.675

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_4 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_6 = arg_243_1:GetWordFromCfg(321102059)
				local var_246_7 = arg_243_1:FormatText(var_246_6.content)

				arg_243_1.text_.text = var_246_7

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_9 = 27 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 27)

				if (27 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 27)) > 0 and var_246_5 < var_246_9 then
					arg_243_1.talkMaxDuration = var_246_9

					if var_246_9 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_9 + var_246_4
					end
				end

				arg_243_1.text_.text = var_246_7
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102059", "story_v_out_321102.awb") ~= 0 then
					local var_246_10 = manager.audio:GetVoiceLength("story_v_out_321102", "321102059", "story_v_out_321102.awb") / 1000

					if var_246_10 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_4
					end

					if var_246_6.prefab_name ~= "" and arg_243_1.actors_[var_246_6.prefab_name] ~= nil then
						local var_246_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_6.prefab_name].transform, "story_v_out_321102", "321102059", "story_v_out_321102.awb")

						arg_243_1:RecordAudio("321102059", var_246_11)
						arg_243_1:RecordAudio("321102059", var_246_11)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_321102", "321102059", "story_v_out_321102.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_321102", "321102059", "story_v_out_321102.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_12 = math.max(var_246_5, arg_243_1.talkMaxDuration)

			if var_246_4 <= arg_243_1.time_ and arg_243_1.time_ < var_246_4 + var_246_12 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_4) / var_246_12

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_4 + var_246_12 and arg_243_1.time_ < var_246_4 + var_246_12 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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

		arg_243_1:InitPlayNodeList()
	end,
	Play321102060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 321102060
		arg_247_1.duration_ = 9.07

		local var_247_0 = {
			zh = 6.7,
			ja = 9.066
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
				arg_247_0:Play321102061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos10100ui_story = arg_247_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_250_0 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				arg_247_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10100ui_story, Vector3.New(0.7, -1.16, -6.25), (arg_247_1.time_ - 0) / var_250_0)
				arg_247_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10100ui_story"].transform.position).z)
				arg_247_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["10100ui_story"].transform.localEulerAngles = arg_247_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				arg_247_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0.7, -1.16, -6.25)
				arg_247_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10100ui_story"].transform.position).z)
				arg_247_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["10100ui_story"].transform.localEulerAngles = arg_247_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_250_1 = arg_247_1.actors_["10100ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect10100ui_story == nil then
				arg_247_1.var_.characterEffect10100ui_story = var_250_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_2 and not isNil(var_250_1) then
				if arg_247_1.var_.characterEffect10100ui_story and not isNil(var_250_1) then
					arg_247_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_2 and arg_247_1.time_ < 0 + var_250_2 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect10100ui_story then
				arg_247_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_250_4 = arg_247_1.actors_["1089ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect1089ui_story == nil then
				arg_247_1.var_.characterEffect1089ui_story = var_250_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_5 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_5 and not isNil(var_250_4) then
				if arg_247_1.var_.characterEffect1089ui_story and not isNil(var_250_4) then
					arg_247_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_5)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_5 and arg_247_1.time_ < 0 + var_250_5 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect1089ui_story then
				arg_247_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_2")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_250_6 = 0
			local var_250_7 = 0.875

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_6 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_8 = arg_247_1:GetWordFromCfg(321102060)
				local var_250_9 = arg_247_1:FormatText(var_250_8.content)

				arg_247_1.text_.text = var_250_9

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_11 = 35 <= 0 and var_250_7 or var_250_7 * (utf8.len(var_250_9) / 35)

				if (35 <= 0 and var_250_7 or var_250_7 * (utf8.len(var_250_9) / 35)) > 0 and var_250_7 < var_250_11 then
					arg_247_1.talkMaxDuration = var_250_11

					if var_250_11 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_11 + var_250_6
					end
				end

				arg_247_1.text_.text = var_250_9
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102060", "story_v_out_321102.awb") ~= 0 then
					local var_250_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102060", "story_v_out_321102.awb") / 1000

					if var_250_12 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_12 + var_250_6
					end

					if var_250_8.prefab_name ~= "" and arg_247_1.actors_[var_250_8.prefab_name] ~= nil then
						local var_250_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_8.prefab_name].transform, "story_v_out_321102", "321102060", "story_v_out_321102.awb")

						arg_247_1:RecordAudio("321102060", var_250_13)
						arg_247_1:RecordAudio("321102060", var_250_13)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_321102", "321102060", "story_v_out_321102.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_321102", "321102060", "story_v_out_321102.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_14 = math.max(var_250_7, arg_247_1.talkMaxDuration)

			if var_250_6 <= arg_247_1.time_ and arg_247_1.time_ < var_250_6 + var_250_14 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_6) / var_250_14

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_6 + var_250_14 and arg_247_1.time_ < var_250_6 + var_250_14 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
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

		arg_247_1:InitPlayNodeList()
	end,
	Play321102061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 321102061
		arg_251_1.duration_ = 2.4

		local var_251_0 = {
			zh = 1.999999999999,
			ja = 2.4
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
				arg_251_0:Play321102062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1089ui_story = arg_251_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1089ui_story"].transform.position).z)
				arg_251_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1089ui_story"].transform.localEulerAngles = arg_251_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				arg_251_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1089ui_story"].transform.position).z)
				arg_251_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1089ui_story"].transform.localEulerAngles = arg_251_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_254_1 = arg_251_1.actors_["1089ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1089ui_story == nil then
				arg_251_1.var_.characterEffect1089ui_story = var_254_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_2 and not isNil(var_254_1) then
				if arg_251_1.var_.characterEffect1089ui_story and not isNil(var_254_1) then
					arg_251_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_2 and arg_251_1.time_ < 0 + var_254_2 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1089ui_story then
				arg_251_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_254_4 = arg_251_1.actors_["10100ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_4) and arg_251_1.var_.characterEffect10100ui_story == nil then
				arg_251_1.var_.characterEffect10100ui_story = var_254_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_5 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_5 and not isNil(var_254_4) then
				if arg_251_1.var_.characterEffect10100ui_story and not isNil(var_254_4) then
					arg_251_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_251_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_5)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_5 and arg_251_1.time_ < 0 + var_254_5 + arg_254_0 and not isNil(var_254_4) and arg_251_1.var_.characterEffect10100ui_story then
				arg_251_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_251_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_1")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_254_6 = 0
			local var_254_7 = 0.175

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_6 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_8 = arg_251_1:GetWordFromCfg(321102061)
				local var_254_9 = arg_251_1:FormatText(var_254_8.content)

				arg_251_1.text_.text = var_254_9

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_11 = 7 <= 0 and var_254_7 or var_254_7 * (utf8.len(var_254_9) / 7)

				if (7 <= 0 and var_254_7 or var_254_7 * (utf8.len(var_254_9) / 7)) > 0 and var_254_7 < var_254_11 then
					arg_251_1.talkMaxDuration = var_254_11

					if var_254_11 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_11 + var_254_6
					end
				end

				arg_251_1.text_.text = var_254_9
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102061", "story_v_out_321102.awb") ~= 0 then
					local var_254_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102061", "story_v_out_321102.awb") / 1000

					if var_254_12 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_12 + var_254_6
					end

					if var_254_8.prefab_name ~= "" and arg_251_1.actors_[var_254_8.prefab_name] ~= nil then
						local var_254_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_8.prefab_name].transform, "story_v_out_321102", "321102061", "story_v_out_321102.awb")

						arg_251_1:RecordAudio("321102061", var_254_13)
						arg_251_1:RecordAudio("321102061", var_254_13)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_321102", "321102061", "story_v_out_321102.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_321102", "321102061", "story_v_out_321102.awb")
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
				actorName = "1089ui_story",
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
	Play321102062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 321102062
		arg_255_1.duration_ = 2

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play321102063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos10100ui_story = arg_255_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_258_0 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 then
				arg_255_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10100ui_story, Vector3.New(0.7, -1.16, -6.25), (arg_255_1.time_ - 0) / var_258_0)
				arg_255_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10100ui_story"].transform.position).z)
				arg_255_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["10100ui_story"].transform.localEulerAngles = arg_255_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 then
				arg_255_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0.7, -1.16, -6.25)
				arg_255_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10100ui_story"].transform.position).z)
				arg_255_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["10100ui_story"].transform.localEulerAngles = arg_255_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_258_1 = arg_255_1.actors_["10100ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect10100ui_story == nil then
				arg_255_1.var_.characterEffect10100ui_story = var_258_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_2 and not isNil(var_258_1) then
				if arg_255_1.var_.characterEffect10100ui_story and not isNil(var_258_1) then
					arg_255_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_2 and arg_255_1.time_ < 0 + var_258_2 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect10100ui_story then
				arg_255_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_258_4 = arg_255_1.actors_["1089ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_4) and arg_255_1.var_.characterEffect1089ui_story == nil then
				arg_255_1.var_.characterEffect1089ui_story = var_258_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_5 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_5 and not isNil(var_258_4) then
				if arg_255_1.var_.characterEffect1089ui_story and not isNil(var_258_4) then
					arg_255_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_5)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_5 and arg_255_1.time_ < 0 + var_258_5 + arg_258_0 and not isNil(var_258_4) and arg_255_1.var_.characterEffect1089ui_story then
				arg_255_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action3_1")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_258_6 = 0
			local var_258_7 = 0.175

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_6 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_8 = arg_255_1:GetWordFromCfg(321102062)
				local var_258_9 = arg_255_1:FormatText(var_258_8.content)

				arg_255_1.text_.text = var_258_9

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_11 = 7 <= 0 and var_258_7 or var_258_7 * (utf8.len(var_258_9) / 7)

				if (7 <= 0 and var_258_7 or var_258_7 * (utf8.len(var_258_9) / 7)) > 0 and var_258_7 < var_258_11 then
					arg_255_1.talkMaxDuration = var_258_11

					if var_258_11 + var_258_6 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_11 + var_258_6
					end
				end

				arg_255_1.text_.text = var_258_9
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102062", "story_v_out_321102.awb") ~= 0 then
					local var_258_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102062", "story_v_out_321102.awb") / 1000

					if var_258_12 + var_258_6 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_12 + var_258_6
					end

					if var_258_8.prefab_name ~= "" and arg_255_1.actors_[var_258_8.prefab_name] ~= nil then
						local var_258_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_8.prefab_name].transform, "story_v_out_321102", "321102062", "story_v_out_321102.awb")

						arg_255_1:RecordAudio("321102062", var_258_13)
						arg_255_1:RecordAudio("321102062", var_258_13)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_321102", "321102062", "story_v_out_321102.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_321102", "321102062", "story_v_out_321102.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_14 = math.max(var_258_7, arg_255_1.talkMaxDuration)

			if var_258_6 <= arg_255_1.time_ and arg_255_1.time_ < var_258_6 + var_258_14 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_6) / var_258_14

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_6 + var_258_14 and arg_255_1.time_ < var_258_6 + var_258_14 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
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

		arg_255_1:InitPlayNodeList()
	end,
	Play321102063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 321102063
		arg_259_1.duration_ = 20.27

		local var_259_0 = {
			zh = 12.1,
			ja = 20.266
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
				arg_259_0:Play321102064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1089ui_story = arg_259_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_262_0 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 then
				arg_259_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_259_1.time_ - 0) / var_262_0)
				arg_259_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1089ui_story"].transform.position).z)
				arg_259_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1089ui_story"].transform.localEulerAngles = arg_259_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 then
				arg_259_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				arg_259_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1089ui_story"].transform.position).z)
				arg_259_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1089ui_story"].transform.localEulerAngles = arg_259_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_262_1 = arg_259_1.actors_["1089ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1089ui_story == nil then
				arg_259_1.var_.characterEffect1089ui_story = var_262_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_2 and not isNil(var_262_1) then
				if arg_259_1.var_.characterEffect1089ui_story and not isNil(var_262_1) then
					arg_259_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_2 and arg_259_1.time_ < 0 + var_262_2 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1089ui_story then
				arg_259_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_262_4 = arg_259_1.actors_["10100ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_4) and arg_259_1.var_.characterEffect10100ui_story == nil then
				arg_259_1.var_.characterEffect10100ui_story = var_262_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_5 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_5 and not isNil(var_262_4) then
				if arg_259_1.var_.characterEffect10100ui_story and not isNil(var_262_4) then
					arg_259_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_259_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_5)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_5 and arg_259_1.time_ < 0 + var_262_5 + arg_262_0 and not isNil(var_262_4) and arg_259_1.var_.characterEffect10100ui_story then
				arg_259_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_259_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_2")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_262_6 = 0
			local var_262_7 = 1.3

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_6 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_8 = arg_259_1:GetWordFromCfg(321102063)
				local var_262_9 = arg_259_1:FormatText(var_262_8.content)

				arg_259_1.text_.text = var_262_9

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_11 = 52 <= 0 and var_262_7 or var_262_7 * (utf8.len(var_262_9) / 52)

				if (52 <= 0 and var_262_7 or var_262_7 * (utf8.len(var_262_9) / 52)) > 0 and var_262_7 < var_262_11 then
					arg_259_1.talkMaxDuration = var_262_11

					if var_262_11 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_11 + var_262_6
					end
				end

				arg_259_1.text_.text = var_262_9
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102063", "story_v_out_321102.awb") ~= 0 then
					local var_262_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102063", "story_v_out_321102.awb") / 1000

					if var_262_12 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_12 + var_262_6
					end

					if var_262_8.prefab_name ~= "" and arg_259_1.actors_[var_262_8.prefab_name] ~= nil then
						local var_262_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_8.prefab_name].transform, "story_v_out_321102", "321102063", "story_v_out_321102.awb")

						arg_259_1:RecordAudio("321102063", var_262_13)
						arg_259_1:RecordAudio("321102063", var_262_13)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_321102", "321102063", "story_v_out_321102.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_321102", "321102063", "story_v_out_321102.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_14 = math.max(var_262_7, arg_259_1.talkMaxDuration)

			if var_262_6 <= arg_259_1.time_ and arg_259_1.time_ < var_262_6 + var_262_14 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_6) / var_262_14

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_6 + var_262_14 and arg_259_1.time_ < var_262_6 + var_262_14 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
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

		arg_259_1:InitPlayNodeList()
	end,
	Play321102064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 321102064
		arg_263_1.duration_ = 10.2

		local var_263_0 = {
			zh = 5.7,
			ja = 10.2
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
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play321102065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0.7

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_1 = arg_263_1:GetWordFromCfg(321102064)
				local var_266_2 = arg_263_1:FormatText(var_266_1.content)

				arg_263_1.text_.text = var_266_2

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_4 = 28 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_2) / 28)

				if (28 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_2) / 28)) > 0 and var_266_0 < var_266_4 then
					arg_263_1.talkMaxDuration = var_266_4

					if var_266_4 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_4 + 0
					end
				end

				arg_263_1.text_.text = var_266_2
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102064", "story_v_out_321102.awb") ~= 0 then
					local var_266_5 = manager.audio:GetVoiceLength("story_v_out_321102", "321102064", "story_v_out_321102.awb") / 1000

					if var_266_5 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + 0
					end

					if var_266_1.prefab_name ~= "" and arg_263_1.actors_[var_266_1.prefab_name] ~= nil then
						local var_266_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_1.prefab_name].transform, "story_v_out_321102", "321102064", "story_v_out_321102.awb")

						arg_263_1:RecordAudio("321102064", var_266_6)
						arg_263_1:RecordAudio("321102064", var_266_6)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_321102", "321102064", "story_v_out_321102.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_321102", "321102064", "story_v_out_321102.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_7 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_7 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_7

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_7 and arg_263_1.time_ < 0 + var_266_7 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play321102065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 321102065
		arg_267_1.duration_ = 4.13

		local var_267_0 = {
			zh = 1.999999999999,
			ja = 4.133
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play321102066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos10100ui_story = arg_267_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_270_0 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 then
				arg_267_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos10100ui_story, Vector3.New(0.7, -1.16, -6.25), (arg_267_1.time_ - 0) / var_270_0)
				arg_267_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["10100ui_story"].transform.position).z)
				arg_267_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["10100ui_story"].transform.localEulerAngles = arg_267_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 then
				arg_267_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0.7, -1.16, -6.25)
				arg_267_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["10100ui_story"].transform.position).z)
				arg_267_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["10100ui_story"].transform.localEulerAngles = arg_267_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_270_1 = arg_267_1.actors_["10100ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect10100ui_story == nil then
				arg_267_1.var_.characterEffect10100ui_story = var_270_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_2 and not isNil(var_270_1) then
				if arg_267_1.var_.characterEffect10100ui_story and not isNil(var_270_1) then
					arg_267_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_2 and arg_267_1.time_ < 0 + var_270_2 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect10100ui_story then
				arg_267_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_270_4 = arg_267_1.actors_["1089ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_4) and arg_267_1.var_.characterEffect1089ui_story == nil then
				arg_267_1.var_.characterEffect1089ui_story = var_270_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_5 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_5 and not isNil(var_270_4) then
				if arg_267_1.var_.characterEffect1089ui_story and not isNil(var_270_4) then
					arg_267_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_5)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_5 and arg_267_1.time_ < 0 + var_270_5 + arg_270_0 and not isNil(var_270_4) and arg_267_1.var_.characterEffect1089ui_story then
				arg_267_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action434")
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_270_6 = 0
			local var_270_7 = 0.175

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_6 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_8 = arg_267_1:GetWordFromCfg(321102065)
				local var_270_9 = arg_267_1:FormatText(var_270_8.content)

				arg_267_1.text_.text = var_270_9

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_11 = 7 <= 0 and var_270_7 or var_270_7 * (utf8.len(var_270_9) / 7)

				if (7 <= 0 and var_270_7 or var_270_7 * (utf8.len(var_270_9) / 7)) > 0 and var_270_7 < var_270_11 then
					arg_267_1.talkMaxDuration = var_270_11

					if var_270_11 + var_270_6 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_11 + var_270_6
					end
				end

				arg_267_1.text_.text = var_270_9
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102065", "story_v_out_321102.awb") ~= 0 then
					local var_270_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102065", "story_v_out_321102.awb") / 1000

					if var_270_12 + var_270_6 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_12 + var_270_6
					end

					if var_270_8.prefab_name ~= "" and arg_267_1.actors_[var_270_8.prefab_name] ~= nil then
						local var_270_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_8.prefab_name].transform, "story_v_out_321102", "321102065", "story_v_out_321102.awb")

						arg_267_1:RecordAudio("321102065", var_270_13)
						arg_267_1:RecordAudio("321102065", var_270_13)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_321102", "321102065", "story_v_out_321102.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_321102", "321102065", "story_v_out_321102.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_14 = math.max(var_270_7, arg_267_1.talkMaxDuration)

			if var_270_6 <= arg_267_1.time_ and arg_267_1.time_ < var_270_6 + var_270_14 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_6) / var_270_14

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_6 + var_270_14 and arg_267_1.time_ < var_270_6 + var_270_14 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
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

		arg_267_1:InitPlayNodeList()
	end,
	Play321102066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 321102066
		arg_271_1.duration_ = 4.23

		local var_271_0 = {
			zh = 3.2,
			ja = 4.233
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play321102067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1089ui_story = arg_271_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_274_0 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 then
				arg_271_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_271_1.time_ - 0) / var_274_0)
				arg_271_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1089ui_story"].transform.position).z)
				arg_271_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1089ui_story"].transform.localEulerAngles = arg_271_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 then
				arg_271_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				arg_271_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1089ui_story"].transform.position).z)
				arg_271_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1089ui_story"].transform.localEulerAngles = arg_271_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_274_1 = arg_271_1.actors_["1089ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1089ui_story == nil then
				arg_271_1.var_.characterEffect1089ui_story = var_274_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_2 and not isNil(var_274_1) then
				if arg_271_1.var_.characterEffect1089ui_story and not isNil(var_274_1) then
					arg_271_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_2 and arg_271_1.time_ < 0 + var_274_2 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1089ui_story then
				arg_271_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_274_4 = arg_271_1.actors_["10100ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_4) and arg_271_1.var_.characterEffect10100ui_story == nil then
				arg_271_1.var_.characterEffect10100ui_story = var_274_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_5 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_5 and not isNil(var_274_4) then
				if arg_271_1.var_.characterEffect10100ui_story and not isNil(var_274_4) then
					arg_271_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_271_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_5)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_5 and arg_271_1.time_ < 0 + var_274_5 + arg_274_0 and not isNil(var_274_4) and arg_271_1.var_.characterEffect10100ui_story then
				arg_271_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_271_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_274_6 = 0
			local var_274_7 = 0.25

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_6 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_8 = arg_271_1:GetWordFromCfg(321102066)
				local var_274_9 = arg_271_1:FormatText(var_274_8.content)

				arg_271_1.text_.text = var_274_9

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_11 = 10 <= 0 and var_274_7 or var_274_7 * (utf8.len(var_274_9) / 10)

				if (10 <= 0 and var_274_7 or var_274_7 * (utf8.len(var_274_9) / 10)) > 0 and var_274_7 < var_274_11 then
					arg_271_1.talkMaxDuration = var_274_11

					if var_274_11 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_11 + var_274_6
					end
				end

				arg_271_1.text_.text = var_274_9
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102066", "story_v_out_321102.awb") ~= 0 then
					local var_274_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102066", "story_v_out_321102.awb") / 1000

					if var_274_12 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_12 + var_274_6
					end

					if var_274_8.prefab_name ~= "" and arg_271_1.actors_[var_274_8.prefab_name] ~= nil then
						local var_274_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_8.prefab_name].transform, "story_v_out_321102", "321102066", "story_v_out_321102.awb")

						arg_271_1:RecordAudio("321102066", var_274_13)
						arg_271_1:RecordAudio("321102066", var_274_13)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_321102", "321102066", "story_v_out_321102.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_321102", "321102066", "story_v_out_321102.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_14 = math.max(var_274_7, arg_271_1.talkMaxDuration)

			if var_274_6 <= arg_271_1.time_ and arg_271_1.time_ < var_274_6 + var_274_14 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_6) / var_274_14

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_6 + var_274_14 and arg_271_1.time_ < var_274_6 + var_274_14 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
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

		arg_271_1:InitPlayNodeList()
	end,
	Play321102067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 321102067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play321102068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1089ui_story"]) and arg_275_1.var_.characterEffect1089ui_story == nil then
				arg_275_1.var_.characterEffect1089ui_story = arg_275_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1089ui_story"]) then
				if arg_275_1.var_.characterEffect1089ui_story and not isNil(arg_275_1.actors_["1089ui_story"]) then
					arg_275_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_0)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1089ui_story"]) and arg_275_1.var_.characterEffect1089ui_story then
				arg_275_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_278_1 = 0
			local var_278_2 = 0.7

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_3 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(321102067).content)

				arg_275_1.text_.text = var_278_3

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 28 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 28)

				if (28 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 28)) > 0 and var_278_2 < var_278_5 then
					arg_275_1.talkMaxDuration = var_278_5

					if var_278_5 + var_278_1 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + var_278_1
					end
				end

				arg_275_1.text_.text = var_278_3
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_6 = math.max(var_278_2, arg_275_1.talkMaxDuration)

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_6 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_1) / var_278_6

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_1 + var_278_6 and arg_275_1.time_ < var_278_1 + var_278_6 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play321102068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 321102068
		arg_279_1.duration_ = 8.5

		local var_279_0 = {
			zh = 6.866,
			ja = 8.5
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play321102069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1089ui_story = arg_279_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1089ui_story"].transform.position).z)
				arg_279_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1089ui_story"].transform.localEulerAngles = arg_279_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				arg_279_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1089ui_story"].transform.position).z)
				arg_279_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1089ui_story"].transform.localEulerAngles = arg_279_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_282_1 = arg_279_1.actors_["1089ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1089ui_story == nil then
				arg_279_1.var_.characterEffect1089ui_story = var_282_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 and not isNil(var_282_1) then
				if arg_279_1.var_.characterEffect1089ui_story and not isNil(var_282_1) then
					arg_279_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1089ui_story then
				arg_279_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_282_4 = 0
			local var_282_5 = 0.775

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_6 = arg_279_1:GetWordFromCfg(321102068)
				local var_282_7 = arg_279_1:FormatText(var_282_6.content)

				arg_279_1.text_.text = var_282_7

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_9 = 31 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 31)

				if (31 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 31)) > 0 and var_282_5 < var_282_9 then
					arg_279_1.talkMaxDuration = var_282_9

					if var_282_9 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_9 + var_282_4
					end
				end

				arg_279_1.text_.text = var_282_7
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102068", "story_v_out_321102.awb") ~= 0 then
					local var_282_10 = manager.audio:GetVoiceLength("story_v_out_321102", "321102068", "story_v_out_321102.awb") / 1000

					if var_282_10 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_4
					end

					if var_282_6.prefab_name ~= "" and arg_279_1.actors_[var_282_6.prefab_name] ~= nil then
						local var_282_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_6.prefab_name].transform, "story_v_out_321102", "321102068", "story_v_out_321102.awb")

						arg_279_1:RecordAudio("321102068", var_282_11)
						arg_279_1:RecordAudio("321102068", var_282_11)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_321102", "321102068", "story_v_out_321102.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_321102", "321102068", "story_v_out_321102.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_12 = math.max(var_282_5, arg_279_1.talkMaxDuration)

			if var_282_4 <= arg_279_1.time_ and arg_279_1.time_ < var_282_4 + var_282_12 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_4) / var_282_12

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_4 + var_282_12 and arg_279_1.time_ < var_282_4 + var_282_12 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
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

		arg_279_1:InitPlayNodeList()
	end,
	Play321102069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 321102069
		arg_283_1.duration_ = 4.47

		local var_283_0 = {
			zh = 2.766,
			ja = 4.466
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play321102070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos10100ui_story = arg_283_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10100ui_story, Vector3.New(0.7, -1.16, -6.25), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10100ui_story"].transform.position).z)
				arg_283_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["10100ui_story"].transform.localEulerAngles = arg_283_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0.7, -1.16, -6.25)
				arg_283_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10100ui_story"].transform.position).z)
				arg_283_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["10100ui_story"].transform.localEulerAngles = arg_283_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_286_1 = arg_283_1.actors_["10100ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect10100ui_story == nil then
				arg_283_1.var_.characterEffect10100ui_story = var_286_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_2 and not isNil(var_286_1) then
				if arg_283_1.var_.characterEffect10100ui_story and not isNil(var_286_1) then
					arg_283_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_2 and arg_283_1.time_ < 0 + var_286_2 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect10100ui_story then
				arg_283_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_286_4 = arg_283_1.actors_["1089ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_4) and arg_283_1.var_.characterEffect1089ui_story == nil then
				arg_283_1.var_.characterEffect1089ui_story = var_286_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_5 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_5 and not isNil(var_286_4) then
				if arg_283_1.var_.characterEffect1089ui_story and not isNil(var_286_4) then
					arg_283_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_5)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_5 and arg_283_1.time_ < 0 + var_286_5 + arg_286_0 and not isNil(var_286_4) and arg_283_1.var_.characterEffect1089ui_story then
				arg_283_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action442")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_286_6 = 0
			local var_286_7 = 0.3

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_6 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_8 = arg_283_1:GetWordFromCfg(321102069)
				local var_286_9 = arg_283_1:FormatText(var_286_8.content)

				arg_283_1.text_.text = var_286_9

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_11 = 12 <= 0 and var_286_7 or var_286_7 * (utf8.len(var_286_9) / 12)

				if (12 <= 0 and var_286_7 or var_286_7 * (utf8.len(var_286_9) / 12)) > 0 and var_286_7 < var_286_11 then
					arg_283_1.talkMaxDuration = var_286_11

					if var_286_11 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_11 + var_286_6
					end
				end

				arg_283_1.text_.text = var_286_9
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102069", "story_v_out_321102.awb") ~= 0 then
					local var_286_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102069", "story_v_out_321102.awb") / 1000

					if var_286_12 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_12 + var_286_6
					end

					if var_286_8.prefab_name ~= "" and arg_283_1.actors_[var_286_8.prefab_name] ~= nil then
						local var_286_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_8.prefab_name].transform, "story_v_out_321102", "321102069", "story_v_out_321102.awb")

						arg_283_1:RecordAudio("321102069", var_286_13)
						arg_283_1:RecordAudio("321102069", var_286_13)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_321102", "321102069", "story_v_out_321102.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_321102", "321102069", "story_v_out_321102.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_14 = math.max(var_286_7, arg_283_1.talkMaxDuration)

			if var_286_6 <= arg_283_1.time_ and arg_283_1.time_ < var_286_6 + var_286_14 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_6) / var_286_14

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_6 + var_286_14 and arg_283_1.time_ < var_286_6 + var_286_14 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
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

		arg_283_1:InitPlayNodeList()
	end,
	Play321102070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 321102070
		arg_287_1.duration_ = 3

		local var_287_0 = {
			zh = 2.3,
			ja = 3
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play321102071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos1089ui_story = arg_287_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_290_0 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 then
				arg_287_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_287_1.time_ - 0) / var_290_0)
				arg_287_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1089ui_story"].transform.position).z)
				arg_287_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1089ui_story"].transform.localEulerAngles = arg_287_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 then
				arg_287_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				arg_287_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1089ui_story"].transform.position).z)
				arg_287_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1089ui_story"].transform.localEulerAngles = arg_287_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_290_1 = arg_287_1.actors_["1089ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect1089ui_story == nil then
				arg_287_1.var_.characterEffect1089ui_story = var_290_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_2 and not isNil(var_290_1) then
				if arg_287_1.var_.characterEffect1089ui_story and not isNil(var_290_1) then
					arg_287_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_2 and arg_287_1.time_ < 0 + var_290_2 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect1089ui_story then
				arg_287_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_290_4 = arg_287_1.actors_["10100ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_4) and arg_287_1.var_.characterEffect10100ui_story == nil then
				arg_287_1.var_.characterEffect10100ui_story = var_290_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_5 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_5 and not isNil(var_290_4) then
				if arg_287_1.var_.characterEffect10100ui_story and not isNil(var_290_4) then
					arg_287_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_287_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_5)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_5 and arg_287_1.time_ < 0 + var_290_5 + arg_290_0 and not isNil(var_290_4) and arg_287_1.var_.characterEffect10100ui_story then
				arg_287_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_287_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089actionlink/1089action434")
			end

			local var_290_6 = 0
			local var_290_7 = 0.175

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_6 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_8 = arg_287_1:GetWordFromCfg(321102070)
				local var_290_9 = arg_287_1:FormatText(var_290_8.content)

				arg_287_1.text_.text = var_290_9

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_11 = 7 <= 0 and var_290_7 or var_290_7 * (utf8.len(var_290_9) / 7)

				if (7 <= 0 and var_290_7 or var_290_7 * (utf8.len(var_290_9) / 7)) > 0 and var_290_7 < var_290_11 then
					arg_287_1.talkMaxDuration = var_290_11

					if var_290_11 + var_290_6 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_11 + var_290_6
					end
				end

				arg_287_1.text_.text = var_290_9
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102070", "story_v_out_321102.awb") ~= 0 then
					local var_290_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102070", "story_v_out_321102.awb") / 1000

					if var_290_12 + var_290_6 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_12 + var_290_6
					end

					if var_290_8.prefab_name ~= "" and arg_287_1.actors_[var_290_8.prefab_name] ~= nil then
						local var_290_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_8.prefab_name].transform, "story_v_out_321102", "321102070", "story_v_out_321102.awb")

						arg_287_1:RecordAudio("321102070", var_290_13)
						arg_287_1:RecordAudio("321102070", var_290_13)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_321102", "321102070", "story_v_out_321102.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_321102", "321102070", "story_v_out_321102.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_14 = math.max(var_290_7, arg_287_1.talkMaxDuration)

			if var_290_6 <= arg_287_1.time_ and arg_287_1.time_ < var_290_6 + var_290_14 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_6) / var_290_14

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_6 + var_290_14 and arg_287_1.time_ < var_290_6 + var_290_14 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
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

		arg_287_1:InitPlayNodeList()
	end,
	Play321102071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 321102071
		arg_291_1.duration_ = 4.27

		local var_291_0 = {
			zh = 3.133,
			ja = 4.266
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play321102072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos10100ui_story = arg_291_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_294_0 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 then
				arg_291_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10100ui_story, Vector3.New(0.7, -1.16, -6.25), (arg_291_1.time_ - 0) / var_294_0)
				arg_291_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["10100ui_story"].transform.position).z)
				arg_291_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["10100ui_story"].transform.localEulerAngles = arg_291_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 then
				arg_291_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0.7, -1.16, -6.25)
				arg_291_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["10100ui_story"].transform.position).z)
				arg_291_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["10100ui_story"].transform.localEulerAngles = arg_291_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_294_1 = arg_291_1.actors_["10100ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect10100ui_story == nil then
				arg_291_1.var_.characterEffect10100ui_story = var_294_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_2 and not isNil(var_294_1) then
				if arg_291_1.var_.characterEffect10100ui_story and not isNil(var_294_1) then
					arg_291_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_2 and arg_291_1.time_ < 0 + var_294_2 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect10100ui_story then
				arg_291_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_294_4 = arg_291_1.actors_["1089ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_4) and arg_291_1.var_.characterEffect1089ui_story == nil then
				arg_291_1.var_.characterEffect1089ui_story = var_294_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_5 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_5 and not isNil(var_294_4) then
				if arg_291_1.var_.characterEffect1089ui_story and not isNil(var_294_4) then
					arg_291_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_5)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_5 and arg_291_1.time_ < 0 + var_294_5 + arg_294_0 and not isNil(var_294_4) and arg_291_1.var_.characterEffect1089ui_story then
				arg_291_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action2_2")
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_294_6 = 0
			local var_294_7 = 0.3

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_6 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_8 = arg_291_1:GetWordFromCfg(321102071)
				local var_294_9 = arg_291_1:FormatText(var_294_8.content)

				arg_291_1.text_.text = var_294_9

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_11 = 12 <= 0 and var_294_7 or var_294_7 * (utf8.len(var_294_9) / 12)

				if (12 <= 0 and var_294_7 or var_294_7 * (utf8.len(var_294_9) / 12)) > 0 and var_294_7 < var_294_11 then
					arg_291_1.talkMaxDuration = var_294_11

					if var_294_11 + var_294_6 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_11 + var_294_6
					end
				end

				arg_291_1.text_.text = var_294_9
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102071", "story_v_out_321102.awb") ~= 0 then
					local var_294_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102071", "story_v_out_321102.awb") / 1000

					if var_294_12 + var_294_6 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_12 + var_294_6
					end

					if var_294_8.prefab_name ~= "" and arg_291_1.actors_[var_294_8.prefab_name] ~= nil then
						local var_294_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_8.prefab_name].transform, "story_v_out_321102", "321102071", "story_v_out_321102.awb")

						arg_291_1:RecordAudio("321102071", var_294_13)
						arg_291_1:RecordAudio("321102071", var_294_13)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_321102", "321102071", "story_v_out_321102.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_321102", "321102071", "story_v_out_321102.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_14 = math.max(var_294_7, arg_291_1.talkMaxDuration)

			if var_294_6 <= arg_291_1.time_ and arg_291_1.time_ < var_294_6 + var_294_14 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_6) / var_294_14

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_6 + var_294_14 and arg_291_1.time_ < var_294_6 + var_294_14 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
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

		arg_291_1:InitPlayNodeList()
	end,
	Play321102072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 321102072
		arg_295_1.duration_ = 2.53

		local var_295_0 = {
			zh = 2.4,
			ja = 2.533
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play321102073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos1089ui_story = arg_295_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_298_0 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 then
				arg_295_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_295_1.time_ - 0) / var_298_0)
				arg_295_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1089ui_story"].transform.position).z)
				arg_295_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1089ui_story"].transform.localEulerAngles = arg_295_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 then
				arg_295_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				arg_295_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1089ui_story"].transform.position).z)
				arg_295_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1089ui_story"].transform.localEulerAngles = arg_295_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_298_1 = arg_295_1.actors_["1089ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1089ui_story == nil then
				arg_295_1.var_.characterEffect1089ui_story = var_298_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_2 and not isNil(var_298_1) then
				if arg_295_1.var_.characterEffect1089ui_story and not isNil(var_298_1) then
					arg_295_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= 0 + var_298_2 and arg_295_1.time_ < 0 + var_298_2 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1089ui_story then
				arg_295_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_298_4 = arg_295_1.actors_["10100ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_4) and arg_295_1.var_.characterEffect10100ui_story == nil then
				arg_295_1.var_.characterEffect10100ui_story = var_298_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_5 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_5 and not isNil(var_298_4) then
				if arg_295_1.var_.characterEffect10100ui_story and not isNil(var_298_4) then
					arg_295_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_295_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_5)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_5 and arg_295_1.time_ < 0 + var_298_5 + arg_298_0 and not isNil(var_298_4) and arg_295_1.var_.characterEffect10100ui_story then
				arg_295_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_295_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089actionlink/1089action445")
			end

			local var_298_6 = 0
			local var_298_7 = 0.25

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_6 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_8 = arg_295_1:GetWordFromCfg(321102072)
				local var_298_9 = arg_295_1:FormatText(var_298_8.content)

				arg_295_1.text_.text = var_298_9

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_11 = 10 <= 0 and var_298_7 or var_298_7 * (utf8.len(var_298_9) / 10)

				if (10 <= 0 and var_298_7 or var_298_7 * (utf8.len(var_298_9) / 10)) > 0 and var_298_7 < var_298_11 then
					arg_295_1.talkMaxDuration = var_298_11

					if var_298_11 + var_298_6 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_11 + var_298_6
					end
				end

				arg_295_1.text_.text = var_298_9
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102072", "story_v_out_321102.awb") ~= 0 then
					local var_298_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102072", "story_v_out_321102.awb") / 1000

					if var_298_12 + var_298_6 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_12 + var_298_6
					end

					if var_298_8.prefab_name ~= "" and arg_295_1.actors_[var_298_8.prefab_name] ~= nil then
						local var_298_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_8.prefab_name].transform, "story_v_out_321102", "321102072", "story_v_out_321102.awb")

						arg_295_1:RecordAudio("321102072", var_298_13)
						arg_295_1:RecordAudio("321102072", var_298_13)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_321102", "321102072", "story_v_out_321102.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_321102", "321102072", "story_v_out_321102.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_14 = math.max(var_298_7, arg_295_1.talkMaxDuration)

			if var_298_6 <= arg_295_1.time_ and arg_295_1.time_ < var_298_6 + var_298_14 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_6) / var_298_14

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_6 + var_298_14 and arg_295_1.time_ < var_298_6 + var_298_14 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
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

		arg_295_1:InitPlayNodeList()
	end,
	Play321102073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 321102073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play321102074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["1089ui_story"]) and arg_299_1.var_.characterEffect1089ui_story == nil then
				arg_299_1.var_.characterEffect1089ui_story = arg_299_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_0 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["1089ui_story"]) then
				if arg_299_1.var_.characterEffect1089ui_story and not isNil(arg_299_1.actors_["1089ui_story"]) then
					arg_299_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_299_1.time_ - 0) / var_302_0)
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["1089ui_story"]) and arg_299_1.var_.characterEffect1089ui_story then
				arg_299_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_302_1 = 0
			local var_302_2 = 0.85

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_3 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(321102073).content)

				arg_299_1.text_.text = var_302_3

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 34 <= 0 and var_302_2 or var_302_2 * (utf8.len(var_302_3) / 34)

				if (34 <= 0 and var_302_2 or var_302_2 * (utf8.len(var_302_3) / 34)) > 0 and var_302_2 < var_302_5 then
					arg_299_1.talkMaxDuration = var_302_5

					if var_302_5 + var_302_1 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + var_302_1
					end
				end

				arg_299_1.text_.text = var_302_3
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_6 = math.max(var_302_2, arg_299_1.talkMaxDuration)

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_6 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_1) / var_302_6

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_1 + var_302_6 and arg_299_1.time_ < var_302_1 + var_302_6 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play321102074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 321102074
		arg_303_1.duration_ = 4.67

		local var_303_0 = {
			zh = 3.9,
			ja = 4.666
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play321102075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1089ui_story = arg_303_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_306_0 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 then
				arg_303_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_303_1.time_ - 0) / var_306_0)
				arg_303_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1089ui_story"].transform.position).z)
				arg_303_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1089ui_story"].transform.localEulerAngles = arg_303_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 then
				arg_303_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				arg_303_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1089ui_story"].transform.position).z)
				arg_303_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1089ui_story"].transform.localEulerAngles = arg_303_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_306_1 = arg_303_1.actors_["1089ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect1089ui_story == nil then
				arg_303_1.var_.characterEffect1089ui_story = var_306_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_2 and not isNil(var_306_1) then
				if arg_303_1.var_.characterEffect1089ui_story and not isNil(var_306_1) then
					arg_303_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_2 and arg_303_1.time_ < 0 + var_306_2 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect1089ui_story then
				arg_303_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_2")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_306_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_303_1.bgmTxt_.text ~= var_306_6 and arg_303_1.bgmTxt_.text ~= "" then
						if arg_303_1.bgmTxt2_.text ~= "" then
							arg_303_1.bgmTxt_.text = arg_303_1.bgmTxt2_.text
						end

						arg_303_1.bgmTxt2_.text = var_306_6

						arg_303_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_303_1.bgmTxt_.text = var_306_6
						arg_303_1.bgmTxt2_.text = var_306_6
					end

					if arg_303_1.bgmTimer then
						arg_303_1.bgmTimer:Stop()

						arg_303_1.bgmTimer = nil
					end

					if arg_303_1.settingData.show_music_name == 1 then
						arg_303_1.musicController:SetSelectedState("show")
						arg_303_1.musicAnimator_:Play("open", 0, 0)

						if arg_303_1.settingData.music_time ~= 0 then
							arg_303_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_303_1.settingData.music_time), function()
								if arg_303_1 == nil or isNil(arg_303_1.bgmTxt_) then
									return
								end

								arg_303_1.musicController:SetSelectedState("hide")
								arg_303_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_306_7 = 0
			local var_306_8 = 0.4

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_7 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_9 = arg_303_1:GetWordFromCfg(321102074)
				local var_306_10 = arg_303_1:FormatText(var_306_9.content)

				arg_303_1.text_.text = var_306_10

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_12 = 16 <= 0 and var_306_8 or var_306_8 * (utf8.len(var_306_10) / 16)

				if (16 <= 0 and var_306_8 or var_306_8 * (utf8.len(var_306_10) / 16)) > 0 and var_306_8 < var_306_12 then
					arg_303_1.talkMaxDuration = var_306_12

					if var_306_12 + var_306_7 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_12 + var_306_7
					end
				end

				arg_303_1.text_.text = var_306_10
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102074", "story_v_out_321102.awb") ~= 0 then
					local var_306_13 = manager.audio:GetVoiceLength("story_v_out_321102", "321102074", "story_v_out_321102.awb") / 1000

					if var_306_13 + var_306_7 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_13 + var_306_7
					end

					if var_306_9.prefab_name ~= "" and arg_303_1.actors_[var_306_9.prefab_name] ~= nil then
						local var_306_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_9.prefab_name].transform, "story_v_out_321102", "321102074", "story_v_out_321102.awb")

						arg_303_1:RecordAudio("321102074", var_306_14)
						arg_303_1:RecordAudio("321102074", var_306_14)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_321102", "321102074", "story_v_out_321102.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_321102", "321102074", "story_v_out_321102.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_15 = math.max(var_306_8, arg_303_1.talkMaxDuration)

			if var_306_7 <= arg_303_1.time_ and arg_303_1.time_ < var_306_7 + var_306_15 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_7) / var_306_15

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_7 + var_306_15 and arg_303_1.time_ < var_306_7 + var_306_15 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
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

		arg_303_1:InitPlayNodeList()
	end,
	Play321102075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 321102075
		arg_308_1.duration_ = 12.53

		local var_308_0 = {
			zh = 11.3,
			ja = 12.533
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play321102076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if arg_308_1.bgs_.ST0504 == nil then
				local var_311_0 = Object.Instantiate(arg_308_1.paintGo_)

				var_311_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0504")
				var_311_0.name = "ST0504"
				var_311_0.transform.parent = arg_308_1.stage_.transform
				var_311_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_308_1.bgs_.ST0504 = var_311_0
			end

			if 2 < arg_308_1.time_ and arg_308_1.time_ <= 2 + arg_311_0 then
				local var_311_1 = arg_308_1.bgs_.ST0504

				arg_308_1.bgs_.ST0504.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_311_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_311_2 = var_311_1:GetComponent("SpriteRenderer")

				if var_311_2 and var_311_2.sprite then
					local var_311_3 = 2 * (var_311_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_311_1.transform.localScale = Vector3.New(var_311_3 / var_311_2.sprite.bounds.size.y < var_311_3 * manager.ui.mainCameraCom_.aspect / var_311_2.sprite.bounds.size.x and var_311_3 * manager.ui.mainCameraCom_.aspect / var_311_2.sprite.bounds.size.x or var_311_3 / var_311_2.sprite.bounds.size.y, var_311_3 / var_311_2.sprite.bounds.size.y < var_311_3 * manager.ui.mainCameraCom_.aspect / var_311_2.sprite.bounds.size.x and var_311_3 * manager.ui.mainCameraCom_.aspect / var_311_2.sprite.bounds.size.x or var_311_3 / var_311_2.sprite.bounds.size.y, 0)
				end

				for iter_311_0, iter_311_1 in pairs(arg_308_1.bgs_) do
					if iter_311_0 ~= "ST0504" then
						iter_311_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_311_4 = 3.999999999999

			if 3.999999999999 < arg_308_1.time_ and arg_308_1.time_ <= var_311_4 + arg_311_0 then
				arg_308_1.allBtn_.enabled = false
			end

			if arg_308_1.time_ >= var_311_4 + 0.3 and arg_308_1.time_ < var_311_4 + 0.3 + arg_311_0 then
				arg_308_1.allBtn_.enabled = true
			end

			local var_311_5 = 0

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_5 + arg_311_0 then
				arg_308_1.mask_.enabled = true
				arg_308_1.mask_.raycastTarget = true

				arg_308_1:SetGaussion(false)
			end

			local var_311_6 = 2

			if var_311_5 <= arg_308_1.time_ and arg_308_1.time_ < var_311_5 + var_311_6 then
				local var_311_7 = Color.New(0, 0, 0)

				var_311_7.a = Mathf.Lerp(0, 1, (arg_308_1.time_ - var_311_5) / var_311_6)
				arg_308_1.mask_.color = var_311_7
			end

			if arg_308_1.time_ >= var_311_5 + var_311_6 and arg_308_1.time_ < var_311_5 + var_311_6 + arg_311_0 then
				local var_311_8 = Color.New(0, 0, 0)

				var_311_8.a = 1
				arg_308_1.mask_.color = var_311_8
			end

			local var_311_9 = 2

			if 2 < arg_308_1.time_ and arg_308_1.time_ <= var_311_9 + arg_311_0 then
				arg_308_1.mask_.enabled = true
				arg_308_1.mask_.raycastTarget = true

				arg_308_1:SetGaussion(false)
			end

			local var_311_10 = 2

			if var_311_9 <= arg_308_1.time_ and arg_308_1.time_ < var_311_9 + var_311_10 then
				local var_311_11 = Color.New(0, 0, 0)

				var_311_11.a = Mathf.Lerp(1, 0, (arg_308_1.time_ - var_311_9) / var_311_10)
				arg_308_1.mask_.color = var_311_11
			end

			if arg_308_1.time_ >= var_311_9 + var_311_10 and arg_308_1.time_ < var_311_9 + var_311_10 + arg_311_0 then
				local var_311_12 = Color.New(0, 0, 0)

				arg_308_1.mask_.enabled = false
				var_311_12.a = 0
				arg_308_1.mask_.color = var_311_12
			end

			local var_311_13 = arg_308_1.actors_["1089ui_story"].transform

			if 1.96599999815226 < arg_308_1.time_ and arg_308_1.time_ <= 1.96599999815226 + arg_311_0 then
				arg_308_1.var_.moveOldPos1089ui_story = var_311_13.localPosition
			end

			local var_311_14 = 0.001

			if 1.96599999815226 <= arg_308_1.time_ and arg_308_1.time_ < 1.96599999815226 + var_311_14 then
				var_311_13.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_308_1.time_ - 1.96599999815226) / var_311_14)
				var_311_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_13.position).x, (manager.ui.mainCamera.transform.position - var_311_13.position).y, (manager.ui.mainCamera.transform.position - var_311_13.position).z)
				var_311_13.localEulerAngles.z = 0
				var_311_13.localEulerAngles.x = 0
				var_311_13.localEulerAngles = var_311_13.localEulerAngles
			end

			if arg_308_1.time_ >= 1.96599999815226 + var_311_14 and arg_308_1.time_ < 1.96599999815226 + var_311_14 + arg_311_0 then
				var_311_13.localPosition = Vector3.New(0, 100, 0)
				var_311_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_13.position).x, (manager.ui.mainCamera.transform.position - var_311_13.position).y, (manager.ui.mainCamera.transform.position - var_311_13.position).z)
				var_311_13.localEulerAngles.z = 0
				var_311_13.localEulerAngles.x = 0
				var_311_13.localEulerAngles = var_311_13.localEulerAngles
			end

			local var_311_15 = arg_308_1.actors_["10100ui_story"].transform

			if 1.96599999815226 < arg_308_1.time_ and arg_308_1.time_ <= 1.96599999815226 + arg_311_0 then
				arg_308_1.var_.moveOldPos10100ui_story = var_311_15.localPosition
			end

			local var_311_16 = 0.001

			if 1.96599999815226 <= arg_308_1.time_ and arg_308_1.time_ < 1.96599999815226 + var_311_16 then
				var_311_15.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_308_1.time_ - 1.96599999815226) / var_311_16)
				var_311_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_15.position).x, (manager.ui.mainCamera.transform.position - var_311_15.position).y, (manager.ui.mainCamera.transform.position - var_311_15.position).z)
				var_311_15.localEulerAngles.z = 0
				var_311_15.localEulerAngles.x = 0
				var_311_15.localEulerAngles = var_311_15.localEulerAngles
			end

			if arg_308_1.time_ >= 1.96599999815226 + var_311_16 and arg_308_1.time_ < 1.96599999815226 + var_311_16 + arg_311_0 then
				var_311_15.localPosition = Vector3.New(0, 100, 0)
				var_311_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_15.position).x, (manager.ui.mainCamera.transform.position - var_311_15.position).y, (manager.ui.mainCamera.transform.position - var_311_15.position).z)
				var_311_15.localEulerAngles.z = 0
				var_311_15.localEulerAngles.x = 0
				var_311_15.localEulerAngles = var_311_15.localEulerAngles
			end

			local var_311_17 = arg_308_1.actors_["1089ui_story"]

			if 1.96599999815226 < arg_308_1.time_ and arg_308_1.time_ <= 1.96599999815226 + arg_311_0 and not isNil(var_311_17) and arg_308_1.var_.characterEffect1089ui_story == nil then
				arg_308_1.var_.characterEffect1089ui_story = var_311_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_18 = 0.034000001847744

			if 1.96599999815226 <= arg_308_1.time_ and arg_308_1.time_ < 1.96599999815226 + var_311_18 and not isNil(var_311_17) then
				if arg_308_1.var_.characterEffect1089ui_story and not isNil(var_311_17) then
					arg_308_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 1.96599999815226) / var_311_18)
				end
			end

			if arg_308_1.time_ >= 1.96599999815226 + var_311_18 and arg_308_1.time_ < 1.96599999815226 + var_311_18 + arg_311_0 and not isNil(var_311_17) and arg_308_1.var_.characterEffect1089ui_story then
				arg_308_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_311_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_308_1.bgmTxt_.text ~= var_311_21 and arg_308_1.bgmTxt_.text ~= "" then
						if arg_308_1.bgmTxt2_.text ~= "" then
							arg_308_1.bgmTxt_.text = arg_308_1.bgmTxt2_.text
						end

						arg_308_1.bgmTxt2_.text = var_311_21

						arg_308_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_308_1.bgmTxt_.text = var_311_21
						arg_308_1.bgmTxt2_.text = var_311_21
					end

					if arg_308_1.bgmTimer then
						arg_308_1.bgmTimer:Stop()

						arg_308_1.bgmTimer = nil
					end

					if arg_308_1.settingData.show_music_name == 1 then
						arg_308_1.musicController:SetSelectedState("show")
						arg_308_1.musicAnimator_:Play("open", 0, 0)

						if arg_308_1.settingData.music_time ~= 0 then
							arg_308_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_308_1.settingData.music_time), function()
								if arg_308_1 == nil or isNil(arg_308_1.bgmTxt_) then
									return
								end

								arg_308_1.musicController:SetSelectedState("hide")
								arg_308_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.8 < arg_308_1.time_ and arg_308_1.time_ <= 1.8 + arg_311_0 then
				arg_308_1:AudioAction("play", "music", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle.awb")

				local var_311_24 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle")

				if "" ~= "" then
					if arg_308_1.bgmTxt_.text ~= var_311_24 and arg_308_1.bgmTxt_.text ~= "" then
						if arg_308_1.bgmTxt2_.text ~= "" then
							arg_308_1.bgmTxt_.text = arg_308_1.bgmTxt2_.text
						end

						arg_308_1.bgmTxt2_.text = var_311_24

						arg_308_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_308_1.bgmTxt_.text = var_311_24
						arg_308_1.bgmTxt2_.text = var_311_24
					end

					if arg_308_1.bgmTimer then
						arg_308_1.bgmTimer:Stop()

						arg_308_1.bgmTimer = nil
					end

					if arg_308_1.settingData.show_music_name == 1 then
						arg_308_1.musicController:SetSelectedState("show")
						arg_308_1.musicAnimator_:Play("open", 0, 0)

						if arg_308_1.settingData.music_time ~= 0 then
							arg_308_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_308_1.settingData.music_time), function()
								if arg_308_1 == nil or isNil(arg_308_1.bgmTxt_) then
									return
								end

								arg_308_1.musicController:SetSelectedState("hide")
								arg_308_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.366666666666667 < arg_308_1.time_ and arg_308_1.time_ <= 0.366666666666667 + arg_311_0 then
				arg_308_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_chaos", "")
			end

			if arg_308_1.frameCnt_ <= 1 then
				arg_308_1.dialog_:SetActive(false)
			end

			local var_311_26 = 4
			local var_311_27 = 0.975

			if 4 < arg_308_1.time_ and arg_308_1.time_ <= var_311_26 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0

				arg_308_1.dialog_:SetActive(true)

				arg_308_1.dialogCg_.alpha = 0

				local var_311_28 = LeanTween.value(arg_308_1.dialog_, 0, 1, 0.3)

				var_311_28:setOnUpdate(LuaHelper.FloatAction(function(arg_314_0)
					arg_308_1.dialogCg_.alpha = arg_314_0
				end))
				var_311_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_308_1.dialog_)
					var_311_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_308_1.duration_ = arg_308_1.duration_ + 0.3

				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[1176].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_29 = arg_308_1:GetWordFromCfg(321102075)
				local var_311_30 = arg_308_1:FormatText(var_311_29.content)

				arg_308_1.text_.text = var_311_30

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_32 = 39 <= 0 and var_311_27 or var_311_27 * (utf8.len(var_311_30) / 39)

				if (39 <= 0 and var_311_27 or var_311_27 * (utf8.len(var_311_30) / 39)) > 0 and var_311_27 < var_311_32 then
					arg_308_1.talkMaxDuration = var_311_32
					var_311_26 = var_311_26 + 0.3

					if var_311_32 + var_311_26 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_32 + var_311_26
					end
				end

				arg_308_1.text_.text = var_311_30
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102075", "story_v_out_321102.awb") ~= 0 then
					local var_311_33 = manager.audio:GetVoiceLength("story_v_out_321102", "321102075", "story_v_out_321102.awb") / 1000

					if var_311_33 + var_311_26 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_33 + var_311_26
					end

					if var_311_29.prefab_name ~= "" and arg_308_1.actors_[var_311_29.prefab_name] ~= nil then
						local var_311_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_29.prefab_name].transform, "story_v_out_321102", "321102075", "story_v_out_321102.awb")

						arg_308_1:RecordAudio("321102075", var_311_34)
						arg_308_1:RecordAudio("321102075", var_311_34)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_321102", "321102075", "story_v_out_321102.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_321102", "321102075", "story_v_out_321102.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_35 = var_311_26 + 0.3
			local var_311_36 = math.max(var_311_27, arg_308_1.talkMaxDuration)

			if var_311_26 + 0.3 <= arg_308_1.time_ and arg_308_1.time_ < var_311_35 + var_311_36 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_35) / var_311_36

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_35 + var_311_36 and arg_308_1.time_ < var_311_35 + var_311_36 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
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
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play321102076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 321102076
		arg_316_1.duration_ = 3.6

		local var_316_0 = {
			zh = 3,
			ja = 3.6
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play321102077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0.425

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[1176].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_1 = arg_316_1:GetWordFromCfg(321102076)
				local var_319_2 = arg_316_1:FormatText(var_319_1.content)

				arg_316_1.text_.text = var_319_2

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_4 = 17 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 17)

				if (17 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 17)) > 0 and var_319_0 < var_319_4 then
					arg_316_1.talkMaxDuration = var_319_4

					if var_319_4 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_4 + 0
					end
				end

				arg_316_1.text_.text = var_319_2
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102076", "story_v_out_321102.awb") ~= 0 then
					local var_319_5 = manager.audio:GetVoiceLength("story_v_out_321102", "321102076", "story_v_out_321102.awb") / 1000

					if var_319_5 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_5 + 0
					end

					if var_319_1.prefab_name ~= "" and arg_316_1.actors_[var_319_1.prefab_name] ~= nil then
						local var_319_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_1.prefab_name].transform, "story_v_out_321102", "321102076", "story_v_out_321102.awb")

						arg_316_1:RecordAudio("321102076", var_319_6)
						arg_316_1:RecordAudio("321102076", var_319_6)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_321102", "321102076", "story_v_out_321102.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_321102", "321102076", "story_v_out_321102.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_7 = math.max(var_319_0, arg_316_1.talkMaxDuration)

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_7 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - 0) / var_319_7

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= 0 + var_319_7 and arg_316_1.time_ < 0 + var_319_7 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play321102077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 321102077
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play321102078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 1.15

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_1 = arg_320_1:FormatText(arg_320_1:GetWordFromCfg(321102077).content)

				arg_320_1.text_.text = var_323_1

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_3 = 46 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_1) / 46)

				if (46 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_1) / 46)) > 0 and var_323_0 < var_323_3 then
					arg_320_1.talkMaxDuration = var_323_3

					if var_323_3 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_3 + 0
					end
				end

				arg_320_1.text_.text = var_323_1
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_4 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_4 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_4

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_4 and arg_320_1.time_ < 0 + var_323_4 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play321102078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 321102078
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play321102079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 1.2

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_1 = arg_324_1:FormatText(arg_324_1:GetWordFromCfg(321102078).content)

				arg_324_1.text_.text = var_327_1

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_3 = 48 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_1) / 48)

				if (48 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_1) / 48)) > 0 and var_327_0 < var_327_3 then
					arg_324_1.talkMaxDuration = var_327_3

					if var_327_3 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_3 + 0
					end
				end

				arg_324_1.text_.text = var_327_1
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_4 = math.max(var_327_0, arg_324_1.talkMaxDuration)

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_4 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - 0) / var_327_4

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= 0 + var_327_4 and arg_324_1.time_ < 0 + var_327_4 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play321102079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 321102079
		arg_328_1.duration_ = 10.57

		local var_328_0 = {
			zh = 6.4,
			ja = 10.566
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play321102080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0.95

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[1176].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_1 = arg_328_1:GetWordFromCfg(321102079)
				local var_331_2 = arg_328_1:FormatText(var_331_1.content)

				arg_328_1.text_.text = var_331_2

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_4 = 38 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_2) / 38)

				if (38 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_2) / 38)) > 0 and var_331_0 < var_331_4 then
					arg_328_1.talkMaxDuration = var_331_4

					if var_331_4 + 0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_4 + 0
					end
				end

				arg_328_1.text_.text = var_331_2
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102079", "story_v_out_321102.awb") ~= 0 then
					local var_331_5 = manager.audio:GetVoiceLength("story_v_out_321102", "321102079", "story_v_out_321102.awb") / 1000

					if var_331_5 + 0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_5 + 0
					end

					if var_331_1.prefab_name ~= "" and arg_328_1.actors_[var_331_1.prefab_name] ~= nil then
						local var_331_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_1.prefab_name].transform, "story_v_out_321102", "321102079", "story_v_out_321102.awb")

						arg_328_1:RecordAudio("321102079", var_331_6)
						arg_328_1:RecordAudio("321102079", var_331_6)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_321102", "321102079", "story_v_out_321102.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_321102", "321102079", "story_v_out_321102.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_7 = math.max(var_331_0, arg_328_1.talkMaxDuration)

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_7 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - 0) / var_331_7

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= 0 + var_331_7 and arg_328_1.time_ < 0 + var_331_7 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play321102080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 321102080
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play321102081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0.85

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_1 = arg_332_1:FormatText(arg_332_1:GetWordFromCfg(321102080).content)

				arg_332_1.text_.text = var_335_1

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_3 = 34 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_1) / 34)

				if (34 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_1) / 34)) > 0 and var_335_0 < var_335_3 then
					arg_332_1.talkMaxDuration = var_335_3

					if var_335_3 + 0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_3 + 0
					end
				end

				arg_332_1.text_.text = var_335_1
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_4 = math.max(var_335_0, arg_332_1.talkMaxDuration)

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_4 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - 0) / var_335_4

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= 0 + var_335_4 and arg_332_1.time_ < 0 + var_335_4 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play321102081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 321102081
		arg_336_1.duration_ = 9.43

		local var_336_0 = {
			zh = 5.1,
			ja = 9.433
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play321102082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if arg_336_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_339_0 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_336_1.stage_.transform)

				var_339_0.name = "1061ui_story"
				var_339_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_336_1.actors_["1061ui_story"] = var_339_0

				local var_339_1 = var_339_0:GetComponentInChildren(typeof(CharacterEffect))

				var_339_1.enabled = true

				local var_339_2 = GameObjectTools.GetOrAddComponent(var_339_0, typeof(DynamicBoneHelper))

				if var_339_2 then
					var_339_2:EnableDynamicBone(false)
				end

				arg_336_1:ShowWeapon(var_339_1.transform, false)

				arg_336_1.var_["1061ui_story" .. "Animator"] = var_339_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_336_1.var_["1061ui_story" .. "Animator"].applyRootMotion = true
				arg_336_1.var_["1061ui_story" .. "LipSync"] = var_339_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_339_3 = arg_336_1.actors_["1061ui_story"].transform

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.moveOldPos1061ui_story = var_339_3.localPosition
			end

			local var_339_4 = 0.001

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_4 then
				var_339_3.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_336_1.time_ - 0) / var_339_4)
				var_339_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_339_3.position).x, (manager.ui.mainCamera.transform.position - var_339_3.position).y, (manager.ui.mainCamera.transform.position - var_339_3.position).z)
				var_339_3.localEulerAngles.z = 0
				var_339_3.localEulerAngles.x = 0
				var_339_3.localEulerAngles = var_339_3.localEulerAngles
			end

			if arg_336_1.time_ >= 0 + var_339_4 and arg_336_1.time_ < 0 + var_339_4 + arg_339_0 then
				var_339_3.localPosition = Vector3.New(0, -1.18, -6.15)
				var_339_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_339_3.position).x, (manager.ui.mainCamera.transform.position - var_339_3.position).y, (manager.ui.mainCamera.transform.position - var_339_3.position).z)
				var_339_3.localEulerAngles.z = 0
				var_339_3.localEulerAngles.x = 0
				var_339_3.localEulerAngles = var_339_3.localEulerAngles
			end

			local var_339_5 = arg_336_1.actors_["1061ui_story"]

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(var_339_5) and arg_336_1.var_.characterEffect1061ui_story == nil then
				arg_336_1.var_.characterEffect1061ui_story = var_339_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_6 = 0.200000002980232

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_6 and not isNil(var_339_5) then
				if arg_336_1.var_.characterEffect1061ui_story and not isNil(var_339_5) then
					arg_336_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= 0 + var_339_6 and arg_336_1.time_ < 0 + var_339_6 + arg_339_0 and not isNil(var_339_5) and arg_336_1.var_.characterEffect1061ui_story then
				arg_336_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_339_8 = 0
			local var_339_9 = 0.55

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_8 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_10 = arg_336_1:GetWordFromCfg(321102081)
				local var_339_11 = arg_336_1:FormatText(var_339_10.content)

				arg_336_1.text_.text = var_339_11

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_13 = 22 <= 0 and var_339_9 or var_339_9 * (utf8.len(var_339_11) / 22)

				if (22 <= 0 and var_339_9 or var_339_9 * (utf8.len(var_339_11) / 22)) > 0 and var_339_9 < var_339_13 then
					arg_336_1.talkMaxDuration = var_339_13

					if var_339_13 + var_339_8 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_13 + var_339_8
					end
				end

				arg_336_1.text_.text = var_339_11
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102081", "story_v_out_321102.awb") ~= 0 then
					local var_339_14 = manager.audio:GetVoiceLength("story_v_out_321102", "321102081", "story_v_out_321102.awb") / 1000

					if var_339_14 + var_339_8 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_14 + var_339_8
					end

					if var_339_10.prefab_name ~= "" and arg_336_1.actors_[var_339_10.prefab_name] ~= nil then
						local var_339_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_10.prefab_name].transform, "story_v_out_321102", "321102081", "story_v_out_321102.awb")

						arg_336_1:RecordAudio("321102081", var_339_15)
						arg_336_1:RecordAudio("321102081", var_339_15)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_321102", "321102081", "story_v_out_321102.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_321102", "321102081", "story_v_out_321102.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_16 = math.max(var_339_9, arg_336_1.talkMaxDuration)

			if var_339_8 <= arg_336_1.time_ and arg_336_1.time_ < var_339_8 + var_339_16 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_8) / var_339_16

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_8 + var_339_16 and arg_336_1.time_ < var_339_8 + var_339_16 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
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

		arg_336_1:InitPlayNodeList()
	end,
	Play321102082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 321102082
		arg_340_1.duration_ = 3.9

		local var_340_0 = {
			zh = 3.166,
			ja = 3.9
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play321102083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(arg_340_1.actors_["1061ui_story"]) and arg_340_1.var_.characterEffect1061ui_story == nil then
				arg_340_1.var_.characterEffect1061ui_story = arg_340_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_0 = 0.200000002980232

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 and not isNil(arg_340_1.actors_["1061ui_story"]) then
				if arg_340_1.var_.characterEffect1061ui_story and not isNil(arg_340_1.actors_["1061ui_story"]) then
					arg_340_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_340_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_340_1.time_ - 0) / var_343_0)
				end
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 and not isNil(arg_340_1.actors_["1061ui_story"]) and arg_340_1.var_.characterEffect1061ui_story then
				arg_340_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_340_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_343_1 = 0
			local var_343_2 = 0.4

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[1176].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, true)
				arg_340_1.iconController_:SetSelectedState("hero")

				arg_340_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_340_1.callingController_:SetSelectedState("normal")

				arg_340_1.keyicon_.color = Color.New(1, 1, 1)
				arg_340_1.icon_.color = Color.New(1, 1, 1)

				local var_343_3 = arg_340_1:GetWordFromCfg(321102082)
				local var_343_4 = arg_340_1:FormatText(var_343_3.content)

				arg_340_1.text_.text = var_343_4

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_6 = 16 <= 0 and var_343_2 or var_343_2 * (utf8.len(var_343_4) / 16)

				if (16 <= 0 and var_343_2 or var_343_2 * (utf8.len(var_343_4) / 16)) > 0 and var_343_2 < var_343_6 then
					arg_340_1.talkMaxDuration = var_343_6

					if var_343_6 + var_343_1 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_6 + var_343_1
					end
				end

				arg_340_1.text_.text = var_343_4
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102082", "story_v_out_321102.awb") ~= 0 then
					local var_343_7 = manager.audio:GetVoiceLength("story_v_out_321102", "321102082", "story_v_out_321102.awb") / 1000

					if var_343_7 + var_343_1 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_7 + var_343_1
					end

					if var_343_3.prefab_name ~= "" and arg_340_1.actors_[var_343_3.prefab_name] ~= nil then
						local var_343_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_3.prefab_name].transform, "story_v_out_321102", "321102082", "story_v_out_321102.awb")

						arg_340_1:RecordAudio("321102082", var_343_8)
						arg_340_1:RecordAudio("321102082", var_343_8)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_321102", "321102082", "story_v_out_321102.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_321102", "321102082", "story_v_out_321102.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_9 = math.max(var_343_2, arg_340_1.talkMaxDuration)

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_9 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_1) / var_343_9

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_1 + var_343_9 and arg_340_1.time_ < var_343_1 + var_343_9 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play321102083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 321102083
		arg_344_1.duration_ = 12.2

		local var_344_0 = {
			zh = 7,
			ja = 12.2
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play321102084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0.775

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[1176].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, true)
				arg_344_1.iconController_:SetSelectedState("hero")

				arg_344_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_344_1.callingController_:SetSelectedState("normal")

				arg_344_1.keyicon_.color = Color.New(1, 1, 1)
				arg_344_1.icon_.color = Color.New(1, 1, 1)

				local var_347_1 = arg_344_1:GetWordFromCfg(321102083)
				local var_347_2 = arg_344_1:FormatText(var_347_1.content)

				arg_344_1.text_.text = var_347_2

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_4 = 31 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_2) / 31)

				if (31 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_2) / 31)) > 0 and var_347_0 < var_347_4 then
					arg_344_1.talkMaxDuration = var_347_4

					if var_347_4 + 0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_4 + 0
					end
				end

				arg_344_1.text_.text = var_347_2
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102083", "story_v_out_321102.awb") ~= 0 then
					local var_347_5 = manager.audio:GetVoiceLength("story_v_out_321102", "321102083", "story_v_out_321102.awb") / 1000

					if var_347_5 + 0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_5 + 0
					end

					if var_347_1.prefab_name ~= "" and arg_344_1.actors_[var_347_1.prefab_name] ~= nil then
						local var_347_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_1.prefab_name].transform, "story_v_out_321102", "321102083", "story_v_out_321102.awb")

						arg_344_1:RecordAudio("321102083", var_347_6)
						arg_344_1:RecordAudio("321102083", var_347_6)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_321102", "321102083", "story_v_out_321102.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_321102", "321102083", "story_v_out_321102.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_7 = math.max(var_347_0, arg_344_1.talkMaxDuration)

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_7 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - 0) / var_347_7

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= 0 + var_347_7 and arg_344_1.time_ < 0 + var_347_7 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play321102084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 321102084
		arg_348_1.duration_ = 4.47

		local var_348_0 = {
			zh = 3.066,
			ja = 4.466
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play321102085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.var_.moveOldPos1061ui_story = arg_348_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_351_0 = 0.001

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_0 then
				arg_348_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_348_1.time_ - 0) / var_351_0)
				arg_348_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_348_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1061ui_story"].transform.position).z)
				arg_348_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_348_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_348_1.actors_["1061ui_story"].transform.localEulerAngles = arg_348_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_348_1.time_ >= 0 + var_351_0 and arg_348_1.time_ < 0 + var_351_0 + arg_351_0 then
				arg_348_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_348_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_348_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1061ui_story"].transform.position).z)
				arg_348_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_348_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_348_1.actors_["1061ui_story"].transform.localEulerAngles = arg_348_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_351_1 = arg_348_1.actors_["1061ui_story"]

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(var_351_1) and arg_348_1.var_.characterEffect1061ui_story == nil then
				arg_348_1.var_.characterEffect1061ui_story = var_351_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_2 = 0.200000002980232

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_2 and not isNil(var_351_1) then
				if arg_348_1.var_.characterEffect1061ui_story and not isNil(var_351_1) then
					arg_348_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_348_1.time_ >= 0 + var_351_2 and arg_348_1.time_ < 0 + var_351_2 + arg_351_0 and not isNil(var_351_1) and arg_348_1.var_.characterEffect1061ui_story then
				arg_348_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action423")
			end

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_351_4 = 0
			local var_351_5 = 0.425

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_4 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_6 = arg_348_1:GetWordFromCfg(321102084)
				local var_351_7 = arg_348_1:FormatText(var_351_6.content)

				arg_348_1.text_.text = var_351_7

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_9 = 17 <= 0 and var_351_5 or var_351_5 * (utf8.len(var_351_7) / 17)

				if (17 <= 0 and var_351_5 or var_351_5 * (utf8.len(var_351_7) / 17)) > 0 and var_351_5 < var_351_9 then
					arg_348_1.talkMaxDuration = var_351_9

					if var_351_9 + var_351_4 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_9 + var_351_4
					end
				end

				arg_348_1.text_.text = var_351_7
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102084", "story_v_out_321102.awb") ~= 0 then
					local var_351_10 = manager.audio:GetVoiceLength("story_v_out_321102", "321102084", "story_v_out_321102.awb") / 1000

					if var_351_10 + var_351_4 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_10 + var_351_4
					end

					if var_351_6.prefab_name ~= "" and arg_348_1.actors_[var_351_6.prefab_name] ~= nil then
						local var_351_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_6.prefab_name].transform, "story_v_out_321102", "321102084", "story_v_out_321102.awb")

						arg_348_1:RecordAudio("321102084", var_351_11)
						arg_348_1:RecordAudio("321102084", var_351_11)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_321102", "321102084", "story_v_out_321102.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_321102", "321102084", "story_v_out_321102.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_12 = math.max(var_351_5, arg_348_1.talkMaxDuration)

			if var_351_4 <= arg_348_1.time_ and arg_348_1.time_ < var_351_4 + var_351_12 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_4) / var_351_12

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_4 + var_351_12 and arg_348_1.time_ < var_351_4 + var_351_12 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
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

		arg_348_1:InitPlayNodeList()
	end,
	Play321102085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 321102085
		arg_352_1.duration_ = 5.8

		local var_352_0 = {
			zh = 4.633,
			ja = 5.8
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play321102086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(arg_352_1.actors_["1061ui_story"]) and arg_352_1.var_.characterEffect1061ui_story == nil then
				arg_352_1.var_.characterEffect1061ui_story = arg_352_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_0 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 and not isNil(arg_352_1.actors_["1061ui_story"]) then
				if arg_352_1.var_.characterEffect1061ui_story and not isNil(arg_352_1.actors_["1061ui_story"]) then
					arg_352_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_352_1.time_ - 0) / var_355_0)
				end
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 and not isNil(arg_352_1.actors_["1061ui_story"]) and arg_352_1.var_.characterEffect1061ui_story then
				arg_352_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_355_1 = 0
			local var_355_2 = 0.575

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[1176].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_3 = arg_352_1:GetWordFromCfg(321102085)
				local var_355_4 = arg_352_1:FormatText(var_355_3.content)

				arg_352_1.text_.text = var_355_4

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_6 = 23 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_4) / 23)

				if (23 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_4) / 23)) > 0 and var_355_2 < var_355_6 then
					arg_352_1.talkMaxDuration = var_355_6

					if var_355_6 + var_355_1 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_6 + var_355_1
					end
				end

				arg_352_1.text_.text = var_355_4
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102085", "story_v_out_321102.awb") ~= 0 then
					local var_355_7 = manager.audio:GetVoiceLength("story_v_out_321102", "321102085", "story_v_out_321102.awb") / 1000

					if var_355_7 + var_355_1 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_7 + var_355_1
					end

					if var_355_3.prefab_name ~= "" and arg_352_1.actors_[var_355_3.prefab_name] ~= nil then
						local var_355_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_3.prefab_name].transform, "story_v_out_321102", "321102085", "story_v_out_321102.awb")

						arg_352_1:RecordAudio("321102085", var_355_8)
						arg_352_1:RecordAudio("321102085", var_355_8)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_321102", "321102085", "story_v_out_321102.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_321102", "321102085", "story_v_out_321102.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_9 = math.max(var_355_2, arg_352_1.talkMaxDuration)

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_9 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_1) / var_355_9

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_1 + var_355_9 and arg_352_1.time_ < var_355_1 + var_355_9 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play321102086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 321102086
		arg_356_1.duration_ = 11.1

		local var_356_0 = {
			zh = 7.466,
			ja = 11.1
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play321102087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0.925

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[1176].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_1 = arg_356_1:GetWordFromCfg(321102086)
				local var_359_2 = arg_356_1:FormatText(var_359_1.content)

				arg_356_1.text_.text = var_359_2

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_4 = 37 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_2) / 37)

				if (37 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_2) / 37)) > 0 and var_359_0 < var_359_4 then
					arg_356_1.talkMaxDuration = var_359_4

					if var_359_4 + 0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_4 + 0
					end
				end

				arg_356_1.text_.text = var_359_2
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102086", "story_v_out_321102.awb") ~= 0 then
					local var_359_5 = manager.audio:GetVoiceLength("story_v_out_321102", "321102086", "story_v_out_321102.awb") / 1000

					if var_359_5 + 0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_5 + 0
					end

					if var_359_1.prefab_name ~= "" and arg_356_1.actors_[var_359_1.prefab_name] ~= nil then
						local var_359_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_1.prefab_name].transform, "story_v_out_321102", "321102086", "story_v_out_321102.awb")

						arg_356_1:RecordAudio("321102086", var_359_6)
						arg_356_1:RecordAudio("321102086", var_359_6)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_321102", "321102086", "story_v_out_321102.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_321102", "321102086", "story_v_out_321102.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_7 = math.max(var_359_0, arg_356_1.talkMaxDuration)

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_7 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - 0) / var_359_7

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= 0 + var_359_7 and arg_356_1.time_ < 0 + var_359_7 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play321102087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 321102087
		arg_360_1.duration_ = 8.1

		local var_360_0 = {
			zh = 4.066,
			ja = 8.1
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play321102088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.var_.moveOldPos1061ui_story = arg_360_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_363_0 = 0.001

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_0 then
				arg_360_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_360_1.time_ - 0) / var_363_0)
				arg_360_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_360_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["1061ui_story"].transform.position).z)
				arg_360_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_360_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_360_1.actors_["1061ui_story"].transform.localEulerAngles = arg_360_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_360_1.time_ >= 0 + var_363_0 and arg_360_1.time_ < 0 + var_363_0 + arg_363_0 then
				arg_360_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_360_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_360_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["1061ui_story"].transform.position).z)
				arg_360_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_360_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_360_1.actors_["1061ui_story"].transform.localEulerAngles = arg_360_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_363_1 = arg_360_1.actors_["1061ui_story"]

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(var_363_1) and arg_360_1.var_.characterEffect1061ui_story == nil then
				arg_360_1.var_.characterEffect1061ui_story = var_363_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_2 = 0.200000002980232

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_2 and not isNil(var_363_1) then
				if arg_360_1.var_.characterEffect1061ui_story and not isNil(var_363_1) then
					arg_360_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= 0 + var_363_2 and arg_360_1.time_ < 0 + var_363_2 + arg_363_0 and not isNil(var_363_1) and arg_360_1.var_.characterEffect1061ui_story then
				arg_360_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_363_4 = 0
			local var_363_5 = 0.525

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_4 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_6 = arg_360_1:GetWordFromCfg(321102087)
				local var_363_7 = arg_360_1:FormatText(var_363_6.content)

				arg_360_1.text_.text = var_363_7

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_9 = 21 <= 0 and var_363_5 or var_363_5 * (utf8.len(var_363_7) / 21)

				if (21 <= 0 and var_363_5 or var_363_5 * (utf8.len(var_363_7) / 21)) > 0 and var_363_5 < var_363_9 then
					arg_360_1.talkMaxDuration = var_363_9

					if var_363_9 + var_363_4 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_9 + var_363_4
					end
				end

				arg_360_1.text_.text = var_363_7
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102087", "story_v_out_321102.awb") ~= 0 then
					local var_363_10 = manager.audio:GetVoiceLength("story_v_out_321102", "321102087", "story_v_out_321102.awb") / 1000

					if var_363_10 + var_363_4 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_10 + var_363_4
					end

					if var_363_6.prefab_name ~= "" and arg_360_1.actors_[var_363_6.prefab_name] ~= nil then
						local var_363_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_6.prefab_name].transform, "story_v_out_321102", "321102087", "story_v_out_321102.awb")

						arg_360_1:RecordAudio("321102087", var_363_11)
						arg_360_1:RecordAudio("321102087", var_363_11)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_321102", "321102087", "story_v_out_321102.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_321102", "321102087", "story_v_out_321102.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_12 = math.max(var_363_5, arg_360_1.talkMaxDuration)

			if var_363_4 <= arg_360_1.time_ and arg_360_1.time_ < var_363_4 + var_363_12 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_4) / var_363_12

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_4 + var_363_12 and arg_360_1.time_ < var_363_4 + var_363_12 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {
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

		arg_360_1:InitPlayNodeList()
	end,
	Play321102088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 321102088
		arg_364_1.duration_ = 9.1

		local var_364_0 = {
			zh = 6.133,
			ja = 9.1
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play321102089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 and not isNil(arg_364_1.actors_["1061ui_story"]) and arg_364_1.var_.characterEffect1061ui_story == nil then
				arg_364_1.var_.characterEffect1061ui_story = arg_364_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_0 = 0.200000002980232

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_0 and not isNil(arg_364_1.actors_["1061ui_story"]) then
				if arg_364_1.var_.characterEffect1061ui_story and not isNil(arg_364_1.actors_["1061ui_story"]) then
					arg_364_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_364_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_364_1.time_ - 0) / var_367_0)
				end
			end

			if arg_364_1.time_ >= 0 + var_367_0 and arg_364_1.time_ < 0 + var_367_0 + arg_367_0 and not isNil(arg_364_1.actors_["1061ui_story"]) and arg_364_1.var_.characterEffect1061ui_story then
				arg_364_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_364_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_367_1 = 0
			local var_367_2 = 0.825

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[1176].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_3 = arg_364_1:GetWordFromCfg(321102088)
				local var_367_4 = arg_364_1:FormatText(var_367_3.content)

				arg_364_1.text_.text = var_367_4

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_6 = 33 <= 0 and var_367_2 or var_367_2 * (utf8.len(var_367_4) / 33)

				if (33 <= 0 and var_367_2 or var_367_2 * (utf8.len(var_367_4) / 33)) > 0 and var_367_2 < var_367_6 then
					arg_364_1.talkMaxDuration = var_367_6

					if var_367_6 + var_367_1 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_6 + var_367_1
					end
				end

				arg_364_1.text_.text = var_367_4
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102088", "story_v_out_321102.awb") ~= 0 then
					local var_367_7 = manager.audio:GetVoiceLength("story_v_out_321102", "321102088", "story_v_out_321102.awb") / 1000

					if var_367_7 + var_367_1 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_7 + var_367_1
					end

					if var_367_3.prefab_name ~= "" and arg_364_1.actors_[var_367_3.prefab_name] ~= nil then
						local var_367_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_3.prefab_name].transform, "story_v_out_321102", "321102088", "story_v_out_321102.awb")

						arg_364_1:RecordAudio("321102088", var_367_8)
						arg_364_1:RecordAudio("321102088", var_367_8)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_321102", "321102088", "story_v_out_321102.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_321102", "321102088", "story_v_out_321102.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_9 = math.max(var_367_2, arg_364_1.talkMaxDuration)

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_9 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_1) / var_367_9

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_1 + var_367_9 and arg_364_1.time_ < var_367_1 + var_367_9 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play321102089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 321102089
		arg_368_1.duration_ = 9.07

		local var_368_0 = {
			zh = 5.6,
			ja = 9.066
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play321102090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0.65

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[1176].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_1 = arg_368_1:GetWordFromCfg(321102089)
				local var_371_2 = arg_368_1:FormatText(var_371_1.content)

				arg_368_1.text_.text = var_371_2

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_4 = 26 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 26)

				if (26 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 26)) > 0 and var_371_0 < var_371_4 then
					arg_368_1.talkMaxDuration = var_371_4

					if var_371_4 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_4 + 0
					end
				end

				arg_368_1.text_.text = var_371_2
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102089", "story_v_out_321102.awb") ~= 0 then
					local var_371_5 = manager.audio:GetVoiceLength("story_v_out_321102", "321102089", "story_v_out_321102.awb") / 1000

					if var_371_5 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_5 + 0
					end

					if var_371_1.prefab_name ~= "" and arg_368_1.actors_[var_371_1.prefab_name] ~= nil then
						local var_371_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_1.prefab_name].transform, "story_v_out_321102", "321102089", "story_v_out_321102.awb")

						arg_368_1:RecordAudio("321102089", var_371_6)
						arg_368_1:RecordAudio("321102089", var_371_6)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_321102", "321102089", "story_v_out_321102.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_321102", "321102089", "story_v_out_321102.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_7 = math.max(var_371_0, arg_368_1.talkMaxDuration)

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_7 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - 0) / var_371_7

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= 0 + var_371_7 and arg_368_1.time_ < 0 + var_371_7 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play321102090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 321102090
		arg_372_1.duration_ = 3.77

		local var_372_0 = {
			zh = 2.233,
			ja = 3.766
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play321102091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.var_.moveOldPos1061ui_story = arg_372_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_375_0 = 0.001

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 then
				arg_372_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_372_1.time_ - 0) / var_375_0)
				arg_372_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_372_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["1061ui_story"].transform.position).z)
				arg_372_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_372_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_372_1.actors_["1061ui_story"].transform.localEulerAngles = arg_372_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 then
				arg_372_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_372_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_372_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["1061ui_story"].transform.position).z)
				arg_372_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_372_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_372_1.actors_["1061ui_story"].transform.localEulerAngles = arg_372_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_375_1 = arg_372_1.actors_["1061ui_story"]

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(var_375_1) and arg_372_1.var_.characterEffect1061ui_story == nil then
				arg_372_1.var_.characterEffect1061ui_story = var_375_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_2 = 0.200000002980232

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_2 and not isNil(var_375_1) then
				if arg_372_1.var_.characterEffect1061ui_story and not isNil(var_375_1) then
					arg_372_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_372_1.time_ >= 0 + var_375_2 and arg_372_1.time_ < 0 + var_375_2 + arg_375_0 and not isNil(var_375_1) and arg_372_1.var_.characterEffect1061ui_story then
				arg_372_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_1")
			end

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva", "EmotionTimelineAnimator")
			end

			local var_375_4 = 0
			local var_375_5 = 0.3

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_4 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_6 = arg_372_1:GetWordFromCfg(321102090)
				local var_375_7 = arg_372_1:FormatText(var_375_6.content)

				arg_372_1.text_.text = var_375_7

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_9 = 12 <= 0 and var_375_5 or var_375_5 * (utf8.len(var_375_7) / 12)

				if (12 <= 0 and var_375_5 or var_375_5 * (utf8.len(var_375_7) / 12)) > 0 and var_375_5 < var_375_9 then
					arg_372_1.talkMaxDuration = var_375_9

					if var_375_9 + var_375_4 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_9 + var_375_4
					end
				end

				arg_372_1.text_.text = var_375_7
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102090", "story_v_out_321102.awb") ~= 0 then
					local var_375_10 = manager.audio:GetVoiceLength("story_v_out_321102", "321102090", "story_v_out_321102.awb") / 1000

					if var_375_10 + var_375_4 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_10 + var_375_4
					end

					if var_375_6.prefab_name ~= "" and arg_372_1.actors_[var_375_6.prefab_name] ~= nil then
						local var_375_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_6.prefab_name].transform, "story_v_out_321102", "321102090", "story_v_out_321102.awb")

						arg_372_1:RecordAudio("321102090", var_375_11)
						arg_372_1:RecordAudio("321102090", var_375_11)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_321102", "321102090", "story_v_out_321102.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_321102", "321102090", "story_v_out_321102.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_12 = math.max(var_375_5, arg_372_1.talkMaxDuration)

			if var_375_4 <= arg_372_1.time_ and arg_372_1.time_ < var_375_4 + var_375_12 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_4) / var_375_12

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_4 + var_375_12 and arg_372_1.time_ < var_375_4 + var_375_12 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
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

		arg_372_1:InitPlayNodeList()
	end,
	Play321102091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 321102091
		arg_376_1.duration_ = 9.13

		local var_376_0 = {
			zh = 7.6,
			ja = 9.133
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play321102092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(arg_376_1.actors_["1061ui_story"]) and arg_376_1.var_.characterEffect1061ui_story == nil then
				arg_376_1.var_.characterEffect1061ui_story = arg_376_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_0 = 0.200000002980232

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 and not isNil(arg_376_1.actors_["1061ui_story"]) then
				if arg_376_1.var_.characterEffect1061ui_story and not isNil(arg_376_1.actors_["1061ui_story"]) then
					arg_376_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_376_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_376_1.time_ - 0) / var_379_0)
				end
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 and not isNil(arg_376_1.actors_["1061ui_story"]) and arg_376_1.var_.characterEffect1061ui_story then
				arg_376_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_376_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_379_1 = 0
			local var_379_2 = 1.025

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[1176].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, true)
				arg_376_1.iconController_:SetSelectedState("hero")

				arg_376_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_376_1.callingController_:SetSelectedState("normal")

				arg_376_1.keyicon_.color = Color.New(1, 1, 1)
				arg_376_1.icon_.color = Color.New(1, 1, 1)

				local var_379_3 = arg_376_1:GetWordFromCfg(321102091)
				local var_379_4 = arg_376_1:FormatText(var_379_3.content)

				arg_376_1.text_.text = var_379_4

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_6 = 41 <= 0 and var_379_2 or var_379_2 * (utf8.len(var_379_4) / 41)

				if (41 <= 0 and var_379_2 or var_379_2 * (utf8.len(var_379_4) / 41)) > 0 and var_379_2 < var_379_6 then
					arg_376_1.talkMaxDuration = var_379_6

					if var_379_6 + var_379_1 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_6 + var_379_1
					end
				end

				arg_376_1.text_.text = var_379_4
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102091", "story_v_out_321102.awb") ~= 0 then
					local var_379_7 = manager.audio:GetVoiceLength("story_v_out_321102", "321102091", "story_v_out_321102.awb") / 1000

					if var_379_7 + var_379_1 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_7 + var_379_1
					end

					if var_379_3.prefab_name ~= "" and arg_376_1.actors_[var_379_3.prefab_name] ~= nil then
						local var_379_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_3.prefab_name].transform, "story_v_out_321102", "321102091", "story_v_out_321102.awb")

						arg_376_1:RecordAudio("321102091", var_379_8)
						arg_376_1:RecordAudio("321102091", var_379_8)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_321102", "321102091", "story_v_out_321102.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_321102", "321102091", "story_v_out_321102.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_9 = math.max(var_379_2, arg_376_1.talkMaxDuration)

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_9 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_1) / var_379_9

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_1 + var_379_9 and arg_376_1.time_ < var_379_1 + var_379_9 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play321102092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 321102092
		arg_380_1.duration_ = 4.5

		local var_380_0 = {
			zh = 2.866,
			ja = 4.5
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play321102093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0.3

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[1176].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_1 = arg_380_1:GetWordFromCfg(321102092)
				local var_383_2 = arg_380_1:FormatText(var_383_1.content)

				arg_380_1.text_.text = var_383_2

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_4 = 12 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_2) / 12)

				if (12 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_2) / 12)) > 0 and var_383_0 < var_383_4 then
					arg_380_1.talkMaxDuration = var_383_4

					if var_383_4 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_4 + 0
					end
				end

				arg_380_1.text_.text = var_383_2
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102092", "story_v_out_321102.awb") ~= 0 then
					local var_383_5 = manager.audio:GetVoiceLength("story_v_out_321102", "321102092", "story_v_out_321102.awb") / 1000

					if var_383_5 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_5 + 0
					end

					if var_383_1.prefab_name ~= "" and arg_380_1.actors_[var_383_1.prefab_name] ~= nil then
						local var_383_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_1.prefab_name].transform, "story_v_out_321102", "321102092", "story_v_out_321102.awb")

						arg_380_1:RecordAudio("321102092", var_383_6)
						arg_380_1:RecordAudio("321102092", var_383_6)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_321102", "321102092", "story_v_out_321102.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_321102", "321102092", "story_v_out_321102.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_7 = math.max(var_383_0, arg_380_1.talkMaxDuration)

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_7 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - 0) / var_383_7

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= 0 + var_383_7 and arg_380_1.time_ < 0 + var_383_7 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play321102093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 321102093
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play321102094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.var_.moveOldPos1061ui_story = arg_384_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_387_0 = 0.001

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 then
				arg_384_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_384_1.time_ - 0) / var_387_0)
				arg_384_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1061ui_story"].transform.position).z)
				arg_384_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["1061ui_story"].transform.localEulerAngles = arg_384_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 then
				arg_384_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_384_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1061ui_story"].transform.position).z)
				arg_384_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["1061ui_story"].transform.localEulerAngles = arg_384_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if 1 < arg_384_1.time_ and arg_384_1.time_ <= 1 + arg_387_0 then
				arg_384_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_ui", "")
			end

			local var_387_2 = 0
			local var_387_3 = 1.05

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_2 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, false)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_4 = arg_384_1:FormatText(arg_384_1:GetWordFromCfg(321102093).content)

				arg_384_1.text_.text = var_387_4

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_6 = 42 <= 0 and var_387_3 or var_387_3 * (utf8.len(var_387_4) / 42)

				if (42 <= 0 and var_387_3 or var_387_3 * (utf8.len(var_387_4) / 42)) > 0 and var_387_3 < var_387_6 then
					arg_384_1.talkMaxDuration = var_387_6

					if var_387_6 + var_387_2 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_6 + var_387_2
					end
				end

				arg_384_1.text_.text = var_387_4
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_7 = math.max(var_387_3, arg_384_1.talkMaxDuration)

			if var_387_2 <= arg_384_1.time_ and arg_384_1.time_ < var_387_2 + var_387_7 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_2) / var_387_7

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_2 + var_387_7 and arg_384_1.time_ < var_387_2 + var_387_7 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
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

		arg_384_1:InitPlayNodeList()
	end,
	Play321102094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 321102094
		arg_388_1.duration_ = 16.5

		local var_388_0 = {
			zh = 11.333,
			ja = 16.5
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play321102095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos1061ui_story = arg_388_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_391_0 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 then
				arg_388_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_388_1.time_ - 0) / var_391_0)
				arg_388_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1061ui_story"].transform.position).z)
				arg_388_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["1061ui_story"].transform.localEulerAngles = arg_388_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 then
				arg_388_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_388_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1061ui_story"].transform.position).z)
				arg_388_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["1061ui_story"].transform.localEulerAngles = arg_388_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_391_1 = arg_388_1.actors_["1061ui_story"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_1) and arg_388_1.var_.characterEffect1061ui_story == nil then
				arg_388_1.var_.characterEffect1061ui_story = var_391_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_2 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_2 and not isNil(var_391_1) then
				if arg_388_1.var_.characterEffect1061ui_story and not isNil(var_391_1) then
					arg_388_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= 0 + var_391_2 and arg_388_1.time_ < 0 + var_391_2 + arg_391_0 and not isNil(var_391_1) and arg_388_1.var_.characterEffect1061ui_story then
				arg_388_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_2")
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_391_4 = 0
			local var_391_5 = 1.5

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_4 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_6 = arg_388_1:GetWordFromCfg(321102094)
				local var_391_7 = arg_388_1:FormatText(var_391_6.content)

				arg_388_1.text_.text = var_391_7

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_9 = 60 <= 0 and var_391_5 or var_391_5 * (utf8.len(var_391_7) / 60)

				if (60 <= 0 and var_391_5 or var_391_5 * (utf8.len(var_391_7) / 60)) > 0 and var_391_5 < var_391_9 then
					arg_388_1.talkMaxDuration = var_391_9

					if var_391_9 + var_391_4 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_9 + var_391_4
					end
				end

				arg_388_1.text_.text = var_391_7
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102094", "story_v_out_321102.awb") ~= 0 then
					local var_391_10 = manager.audio:GetVoiceLength("story_v_out_321102", "321102094", "story_v_out_321102.awb") / 1000

					if var_391_10 + var_391_4 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_10 + var_391_4
					end

					if var_391_6.prefab_name ~= "" and arg_388_1.actors_[var_391_6.prefab_name] ~= nil then
						local var_391_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_6.prefab_name].transform, "story_v_out_321102", "321102094", "story_v_out_321102.awb")

						arg_388_1:RecordAudio("321102094", var_391_11)
						arg_388_1:RecordAudio("321102094", var_391_11)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_321102", "321102094", "story_v_out_321102.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_321102", "321102094", "story_v_out_321102.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_12 = math.max(var_391_5, arg_388_1.talkMaxDuration)

			if var_391_4 <= arg_388_1.time_ and arg_388_1.time_ < var_391_4 + var_391_12 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_4) / var_391_12

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_4 + var_391_12 and arg_388_1.time_ < var_391_4 + var_391_12 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
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

		arg_388_1:InitPlayNodeList()
	end,
	Play321102095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 321102095
		arg_392_1.duration_ = 9.93

		local var_392_0 = {
			zh = 6.1,
			ja = 9.933
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play321102096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.var_.moveOldPos1061ui_story = arg_392_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_395_0 = 0.001

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 then
				arg_392_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_392_1.time_ - 0) / var_395_0)
				arg_392_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_392_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1061ui_story"].transform.position).z)
				arg_392_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_392_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_392_1.actors_["1061ui_story"].transform.localEulerAngles = arg_392_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 then
				arg_392_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_392_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_392_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1061ui_story"].transform.position).z)
				arg_392_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_392_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_392_1.actors_["1061ui_story"].transform.localEulerAngles = arg_392_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_395_1 = 0
			local var_395_2 = 0.8

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_3 = arg_392_1:GetWordFromCfg(321102095)
				local var_395_4 = arg_392_1:FormatText(var_395_3.content)

				arg_392_1.text_.text = var_395_4

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_6 = 32 <= 0 and var_395_2 or var_395_2 * (utf8.len(var_395_4) / 32)

				if (32 <= 0 and var_395_2 or var_395_2 * (utf8.len(var_395_4) / 32)) > 0 and var_395_2 < var_395_6 then
					arg_392_1.talkMaxDuration = var_395_6

					if var_395_6 + var_395_1 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_6 + var_395_1
					end
				end

				arg_392_1.text_.text = var_395_4
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102095", "story_v_out_321102.awb") ~= 0 then
					local var_395_7 = manager.audio:GetVoiceLength("story_v_out_321102", "321102095", "story_v_out_321102.awb") / 1000

					if var_395_7 + var_395_1 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_7 + var_395_1
					end

					if var_395_3.prefab_name ~= "" and arg_392_1.actors_[var_395_3.prefab_name] ~= nil then
						local var_395_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_3.prefab_name].transform, "story_v_out_321102", "321102095", "story_v_out_321102.awb")

						arg_392_1:RecordAudio("321102095", var_395_8)
						arg_392_1:RecordAudio("321102095", var_395_8)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_321102", "321102095", "story_v_out_321102.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_321102", "321102095", "story_v_out_321102.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_9 = math.max(var_395_2, arg_392_1.talkMaxDuration)

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_9 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_1) / var_395_9

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_1 + var_395_9 and arg_392_1.time_ < var_395_1 + var_395_9 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
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

		arg_392_1:InitPlayNodeList()
	end,
	Play321102096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 321102096
		arg_396_1.duration_ = 10.77

		local var_396_0 = {
			zh = 7.133,
			ja = 10.766
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play321102097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0.875

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_1 = arg_396_1:GetWordFromCfg(321102096)
				local var_399_2 = arg_396_1:FormatText(var_399_1.content)

				arg_396_1.text_.text = var_399_2

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_4 = 35 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_2) / 35)

				if (35 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_2) / 35)) > 0 and var_399_0 < var_399_4 then
					arg_396_1.talkMaxDuration = var_399_4

					if var_399_4 + 0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_4 + 0
					end
				end

				arg_396_1.text_.text = var_399_2
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102096", "story_v_out_321102.awb") ~= 0 then
					local var_399_5 = manager.audio:GetVoiceLength("story_v_out_321102", "321102096", "story_v_out_321102.awb") / 1000

					if var_399_5 + 0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_5 + 0
					end

					if var_399_1.prefab_name ~= "" and arg_396_1.actors_[var_399_1.prefab_name] ~= nil then
						local var_399_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_1.prefab_name].transform, "story_v_out_321102", "321102096", "story_v_out_321102.awb")

						arg_396_1:RecordAudio("321102096", var_399_6)
						arg_396_1:RecordAudio("321102096", var_399_6)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_321102", "321102096", "story_v_out_321102.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_321102", "321102096", "story_v_out_321102.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_7 = math.max(var_399_0, arg_396_1.talkMaxDuration)

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_7 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - 0) / var_399_7

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= 0 + var_399_7 and arg_396_1.time_ < 0 + var_399_7 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play321102097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 321102097
		arg_400_1.duration_ = 7.47

		local var_400_0 = {
			zh = 7.466,
			ja = 6.2
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play321102098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if arg_400_1.bgs_.ST0505a == nil then
				local var_403_0 = Object.Instantiate(arg_400_1.paintGo_)

				var_403_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0505a")
				var_403_0.name = "ST0505a"
				var_403_0.transform.parent = arg_400_1.stage_.transform
				var_403_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_400_1.bgs_.ST0505a = var_403_0
			end

			if 2 < arg_400_1.time_ and arg_400_1.time_ <= 2 + arg_403_0 then
				local var_403_1 = arg_400_1.bgs_.ST0505a

				arg_400_1.bgs_.ST0505a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_403_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_403_2 = var_403_1:GetComponent("SpriteRenderer")

				if var_403_2 and var_403_2.sprite then
					local var_403_3 = 2 * (var_403_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_403_1.transform.localScale = Vector3.New(var_403_3 / var_403_2.sprite.bounds.size.y < var_403_3 * manager.ui.mainCameraCom_.aspect / var_403_2.sprite.bounds.size.x and var_403_3 * manager.ui.mainCameraCom_.aspect / var_403_2.sprite.bounds.size.x or var_403_3 / var_403_2.sprite.bounds.size.y, var_403_3 / var_403_2.sprite.bounds.size.y < var_403_3 * manager.ui.mainCameraCom_.aspect / var_403_2.sprite.bounds.size.x and var_403_3 * manager.ui.mainCameraCom_.aspect / var_403_2.sprite.bounds.size.x or var_403_3 / var_403_2.sprite.bounds.size.y, 0)
				end

				for iter_403_0, iter_403_1 in pairs(arg_400_1.bgs_) do
					if iter_403_0 ~= "ST0505a" then
						iter_403_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_403_4 = 4

			if 4 < arg_400_1.time_ and arg_400_1.time_ <= var_403_4 + arg_403_0 then
				arg_400_1.allBtn_.enabled = false
			end

			if arg_400_1.time_ >= var_403_4 + 0.3 and arg_400_1.time_ < var_403_4 + 0.3 + arg_403_0 then
				arg_400_1.allBtn_.enabled = true
			end

			local var_403_5 = 0

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_5 + arg_403_0 then
				arg_400_1.mask_.enabled = true
				arg_400_1.mask_.raycastTarget = true

				arg_400_1:SetGaussion(false)
			end

			local var_403_6 = 2

			if var_403_5 <= arg_400_1.time_ and arg_400_1.time_ < var_403_5 + var_403_6 then
				local var_403_7 = Color.New(0, 0, 0)

				var_403_7.a = Mathf.Lerp(0, 1, (arg_400_1.time_ - var_403_5) / var_403_6)
				arg_400_1.mask_.color = var_403_7
			end

			if arg_400_1.time_ >= var_403_5 + var_403_6 and arg_400_1.time_ < var_403_5 + var_403_6 + arg_403_0 then
				local var_403_8 = Color.New(0, 0, 0)

				var_403_8.a = 1
				arg_400_1.mask_.color = var_403_8
			end

			local var_403_9 = 2

			if 2 < arg_400_1.time_ and arg_400_1.time_ <= var_403_9 + arg_403_0 then
				arg_400_1.mask_.enabled = true
				arg_400_1.mask_.raycastTarget = true

				arg_400_1:SetGaussion(false)
			end

			local var_403_10 = 2

			if var_403_9 <= arg_400_1.time_ and arg_400_1.time_ < var_403_9 + var_403_10 then
				local var_403_11 = Color.New(0, 0, 0)

				var_403_11.a = Mathf.Lerp(1, 0, (arg_400_1.time_ - var_403_9) / var_403_10)
				arg_400_1.mask_.color = var_403_11
			end

			if arg_400_1.time_ >= var_403_9 + var_403_10 and arg_400_1.time_ < var_403_9 + var_403_10 + arg_403_0 then
				local var_403_12 = Color.New(0, 0, 0)

				arg_400_1.mask_.enabled = false
				var_403_12.a = 0
				arg_400_1.mask_.color = var_403_12
			end

			local var_403_13 = arg_400_1.actors_["1061ui_story"].transform

			if 1.96599999815226 < arg_400_1.time_ and arg_400_1.time_ <= 1.96599999815226 + arg_403_0 then
				arg_400_1.var_.moveOldPos1061ui_story = var_403_13.localPosition
			end

			local var_403_14 = 0.001

			if 1.96599999815226 <= arg_400_1.time_ and arg_400_1.time_ < 1.96599999815226 + var_403_14 then
				var_403_13.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_400_1.time_ - 1.96599999815226) / var_403_14)
				var_403_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_403_13.position).x, (manager.ui.mainCamera.transform.position - var_403_13.position).y, (manager.ui.mainCamera.transform.position - var_403_13.position).z)
				var_403_13.localEulerAngles.z = 0
				var_403_13.localEulerAngles.x = 0
				var_403_13.localEulerAngles = var_403_13.localEulerAngles
			end

			if arg_400_1.time_ >= 1.96599999815226 + var_403_14 and arg_400_1.time_ < 1.96599999815226 + var_403_14 + arg_403_0 then
				var_403_13.localPosition = Vector3.New(0, 100, 0)
				var_403_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_403_13.position).x, (manager.ui.mainCamera.transform.position - var_403_13.position).y, (manager.ui.mainCamera.transform.position - var_403_13.position).z)
				var_403_13.localEulerAngles.z = 0
				var_403_13.localEulerAngles.x = 0
				var_403_13.localEulerAngles = var_403_13.localEulerAngles
			end

			local var_403_15 = arg_400_1.actors_["1061ui_story"]

			if 1.96599999815226 < arg_400_1.time_ and arg_400_1.time_ <= 1.96599999815226 + arg_403_0 and not isNil(var_403_15) and arg_400_1.var_.characterEffect1061ui_story == nil then
				arg_400_1.var_.characterEffect1061ui_story = var_403_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_16 = 0.034000001847744

			if 1.96599999815226 <= arg_400_1.time_ and arg_400_1.time_ < 1.96599999815226 + var_403_16 and not isNil(var_403_15) then
				if arg_400_1.var_.characterEffect1061ui_story and not isNil(var_403_15) then
					arg_400_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_400_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_400_1.time_ - 1.96599999815226) / var_403_16)
				end
			end

			if arg_400_1.time_ >= 1.96599999815226 + var_403_16 and arg_400_1.time_ < 1.96599999815226 + var_403_16 + arg_403_0 and not isNil(var_403_15) and arg_400_1.var_.characterEffect1061ui_story then
				arg_400_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_400_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if arg_400_1.frameCnt_ <= 1 then
				arg_400_1.dialog_:SetActive(false)
			end

			local var_403_17 = 4
			local var_403_18 = 0.3

			if 4 < arg_400_1.time_ and arg_400_1.time_ <= var_403_17 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0

				arg_400_1.dialog_:SetActive(true)

				arg_400_1.dialogCg_.alpha = 0

				local var_403_19 = LeanTween.value(arg_400_1.dialog_, 0, 1, 0.3)

				var_403_19:setOnUpdate(LuaHelper.FloatAction(function(arg_404_0)
					arg_400_1.dialogCg_.alpha = arg_404_0
				end))
				var_403_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_400_1.dialog_)
					var_403_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_400_1.duration_ = arg_400_1.duration_ + 0.3

				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_20 = arg_400_1:GetWordFromCfg(321102097)
				local var_403_21 = arg_400_1:FormatText(var_403_20.content)

				arg_400_1.text_.text = var_403_21

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_23 = 12 <= 0 and var_403_18 or var_403_18 * (utf8.len(var_403_21) / 12)

				if (12 <= 0 and var_403_18 or var_403_18 * (utf8.len(var_403_21) / 12)) > 0 and var_403_18 < var_403_23 then
					arg_400_1.talkMaxDuration = var_403_23
					var_403_17 = var_403_17 + 0.3

					if var_403_23 + var_403_17 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_23 + var_403_17
					end
				end

				arg_400_1.text_.text = var_403_21
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102097", "story_v_out_321102.awb") ~= 0 then
					local var_403_24 = manager.audio:GetVoiceLength("story_v_out_321102", "321102097", "story_v_out_321102.awb") / 1000

					if var_403_24 + var_403_17 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_24 + var_403_17
					end

					if var_403_20.prefab_name ~= "" and arg_400_1.actors_[var_403_20.prefab_name] ~= nil then
						local var_403_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_20.prefab_name].transform, "story_v_out_321102", "321102097", "story_v_out_321102.awb")

						arg_400_1:RecordAudio("321102097", var_403_25)
						arg_400_1:RecordAudio("321102097", var_403_25)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_321102", "321102097", "story_v_out_321102.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_321102", "321102097", "story_v_out_321102.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_26 = var_403_17 + 0.3
			local var_403_27 = math.max(var_403_18, arg_400_1.talkMaxDuration)

			if var_403_17 + 0.3 <= arg_400_1.time_ and arg_400_1.time_ < var_403_26 + var_403_27 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_26) / var_403_27

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_26 + var_403_27 and arg_400_1.time_ < var_403_26 + var_403_27 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play321102098 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 321102098
		arg_406_1.duration_ = 6.03

		local var_406_0 = {
			zh = 5.933,
			ja = 6.033
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
				arg_406_0:Play321102099(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0.65

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_1 = arg_406_1:GetWordFromCfg(321102098)
				local var_409_2 = arg_406_1:FormatText(var_409_1.content)

				arg_406_1.text_.text = var_409_2

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_4 = 26 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 26)

				if (26 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 26)) > 0 and var_409_0 < var_409_4 then
					arg_406_1.talkMaxDuration = var_409_4

					if var_409_4 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_4 + 0
					end
				end

				arg_406_1.text_.text = var_409_2
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102098", "story_v_out_321102.awb") ~= 0 then
					local var_409_5 = manager.audio:GetVoiceLength("story_v_out_321102", "321102098", "story_v_out_321102.awb") / 1000

					if var_409_5 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_5 + 0
					end

					if var_409_1.prefab_name ~= "" and arg_406_1.actors_[var_409_1.prefab_name] ~= nil then
						local var_409_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_1.prefab_name].transform, "story_v_out_321102", "321102098", "story_v_out_321102.awb")

						arg_406_1:RecordAudio("321102098", var_409_6)
						arg_406_1:RecordAudio("321102098", var_409_6)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_321102", "321102098", "story_v_out_321102.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_321102", "321102098", "story_v_out_321102.awb")
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
	Play321102099 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 321102099
		arg_410_1.duration_ = 13.33

		local var_410_0 = {
			zh = 7.9,
			ja = 13.333
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play321102100(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0.85

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_1 = arg_410_1:GetWordFromCfg(321102099)
				local var_413_2 = arg_410_1:FormatText(var_413_1.content)

				arg_410_1.text_.text = var_413_2

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_4 = 34 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_2) / 34)

				if (34 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_2) / 34)) > 0 and var_413_0 < var_413_4 then
					arg_410_1.talkMaxDuration = var_413_4

					if var_413_4 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_4 + 0
					end
				end

				arg_410_1.text_.text = var_413_2
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102099", "story_v_out_321102.awb") ~= 0 then
					local var_413_5 = manager.audio:GetVoiceLength("story_v_out_321102", "321102099", "story_v_out_321102.awb") / 1000

					if var_413_5 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_5 + 0
					end

					if var_413_1.prefab_name ~= "" and arg_410_1.actors_[var_413_1.prefab_name] ~= nil then
						local var_413_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_1.prefab_name].transform, "story_v_out_321102", "321102099", "story_v_out_321102.awb")

						arg_410_1:RecordAudio("321102099", var_413_6)
						arg_410_1:RecordAudio("321102099", var_413_6)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_321102", "321102099", "story_v_out_321102.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_321102", "321102099", "story_v_out_321102.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_7 = math.max(var_413_0, arg_410_1.talkMaxDuration)

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_7 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - 0) / var_413_7

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= 0 + var_413_7 and arg_410_1.time_ < 0 + var_413_7 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play321102100 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 321102100
		arg_414_1.duration_ = 5.6

		local var_414_0 = {
			zh = 5.6,
			ja = 5.466
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play321102101(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0.575

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_1 = arg_414_1:GetWordFromCfg(321102100)
				local var_417_2 = arg_414_1:FormatText(var_417_1.content)

				arg_414_1.text_.text = var_417_2

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_4 = 23 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_2) / 23)

				if (23 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_2) / 23)) > 0 and var_417_0 < var_417_4 then
					arg_414_1.talkMaxDuration = var_417_4

					if var_417_4 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_4 + 0
					end
				end

				arg_414_1.text_.text = var_417_2
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102100", "story_v_out_321102.awb") ~= 0 then
					local var_417_5 = manager.audio:GetVoiceLength("story_v_out_321102", "321102100", "story_v_out_321102.awb") / 1000

					if var_417_5 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_5 + 0
					end

					if var_417_1.prefab_name ~= "" and arg_414_1.actors_[var_417_1.prefab_name] ~= nil then
						local var_417_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_1.prefab_name].transform, "story_v_out_321102", "321102100", "story_v_out_321102.awb")

						arg_414_1:RecordAudio("321102100", var_417_6)
						arg_414_1:RecordAudio("321102100", var_417_6)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_321102", "321102100", "story_v_out_321102.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_321102", "321102100", "story_v_out_321102.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_7 = math.max(var_417_0, arg_414_1.talkMaxDuration)

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_7 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - 0) / var_417_7

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= 0 + var_417_7 and arg_414_1.time_ < 0 + var_417_7 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play321102101 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 321102101
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play321102102(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0.55

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, false)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_1 = arg_418_1:FormatText(arg_418_1:GetWordFromCfg(321102101).content)

				arg_418_1.text_.text = var_421_1

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_3 = 22 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_1) / 22)

				if (22 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_1) / 22)) > 0 and var_421_0 < var_421_3 then
					arg_418_1.talkMaxDuration = var_421_3

					if var_421_3 + 0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_3 + 0
					end
				end

				arg_418_1.text_.text = var_421_1
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_4 = math.max(var_421_0, arg_418_1.talkMaxDuration)

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_4 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - 0) / var_421_4

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= 0 + var_421_4 and arg_418_1.time_ < 0 + var_421_4 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play321102102 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 321102102
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play321102103(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0.825

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, false)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_1 = arg_422_1:FormatText(arg_422_1:GetWordFromCfg(321102102).content)

				arg_422_1.text_.text = var_425_1

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_3 = 33 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_1) / 33)

				if (33 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_1) / 33)) > 0 and var_425_0 < var_425_3 then
					arg_422_1.talkMaxDuration = var_425_3

					if var_425_3 + 0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_3 + 0
					end
				end

				arg_422_1.text_.text = var_425_1
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_4 = math.max(var_425_0, arg_422_1.talkMaxDuration)

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_4 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - 0) / var_425_4

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= 0 + var_425_4 and arg_422_1.time_ < 0 + var_425_4 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play321102103 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 321102103
		arg_426_1.duration_ = 5.23

		local var_426_0 = {
			zh = 5.033,
			ja = 5.233
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
				arg_426_0:Play321102104(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if arg_426_1.actors_["1085ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1085ui_story"))) then
				local var_429_0 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_426_1.stage_.transform)

				var_429_0.name = "1085ui_story"
				var_429_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_426_1.actors_["1085ui_story"] = var_429_0

				local var_429_1 = var_429_0:GetComponentInChildren(typeof(CharacterEffect))

				var_429_1.enabled = true

				local var_429_2 = GameObjectTools.GetOrAddComponent(var_429_0, typeof(DynamicBoneHelper))

				if var_429_2 then
					var_429_2:EnableDynamicBone(false)
				end

				arg_426_1:ShowWeapon(var_429_1.transform, false)

				arg_426_1.var_["1085ui_story" .. "Animator"] = var_429_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_426_1.var_["1085ui_story" .. "Animator"].applyRootMotion = true
				arg_426_1.var_["1085ui_story" .. "LipSync"] = var_429_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_429_3 = arg_426_1.actors_["1085ui_story"].transform

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.var_.moveOldPos1085ui_story = var_429_3.localPosition
			end

			local var_429_4 = 0.001

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_4 then
				var_429_3.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_426_1.time_ - 0) / var_429_4)
				var_429_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_429_3.position).x, (manager.ui.mainCamera.transform.position - var_429_3.position).y, (manager.ui.mainCamera.transform.position - var_429_3.position).z)
				var_429_3.localEulerAngles.z = 0
				var_429_3.localEulerAngles.x = 0
				var_429_3.localEulerAngles = var_429_3.localEulerAngles
			end

			if arg_426_1.time_ >= 0 + var_429_4 and arg_426_1.time_ < 0 + var_429_4 + arg_429_0 then
				var_429_3.localPosition = Vector3.New(0, -1.01, -5.83)
				var_429_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_429_3.position).x, (manager.ui.mainCamera.transform.position - var_429_3.position).y, (manager.ui.mainCamera.transform.position - var_429_3.position).z)
				var_429_3.localEulerAngles.z = 0
				var_429_3.localEulerAngles.x = 0
				var_429_3.localEulerAngles = var_429_3.localEulerAngles
			end

			local var_429_5 = arg_426_1.actors_["1085ui_story"]

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(var_429_5) and arg_426_1.var_.characterEffect1085ui_story == nil then
				arg_426_1.var_.characterEffect1085ui_story = var_429_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_6 = 0.200000002980232

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_6 and not isNil(var_429_5) then
				if arg_426_1.var_.characterEffect1085ui_story and not isNil(var_429_5) then
					arg_426_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_426_1.time_ >= 0 + var_429_6 and arg_426_1.time_ < 0 + var_429_6 + arg_429_0 and not isNil(var_429_5) and arg_426_1.var_.characterEffect1085ui_story then
				arg_426_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_429_8 = 0
			local var_429_9 = 0.35

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_8 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_10 = arg_426_1:GetWordFromCfg(321102103)
				local var_429_11 = arg_426_1:FormatText(var_429_10.content)

				arg_426_1.text_.text = var_429_11

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_13 = 14 <= 0 and var_429_9 or var_429_9 * (utf8.len(var_429_11) / 14)

				if (14 <= 0 and var_429_9 or var_429_9 * (utf8.len(var_429_11) / 14)) > 0 and var_429_9 < var_429_13 then
					arg_426_1.talkMaxDuration = var_429_13

					if var_429_13 + var_429_8 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_13 + var_429_8
					end
				end

				arg_426_1.text_.text = var_429_11
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102103", "story_v_out_321102.awb") ~= 0 then
					local var_429_14 = manager.audio:GetVoiceLength("story_v_out_321102", "321102103", "story_v_out_321102.awb") / 1000

					if var_429_14 + var_429_8 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_14 + var_429_8
					end

					if var_429_10.prefab_name ~= "" and arg_426_1.actors_[var_429_10.prefab_name] ~= nil then
						local var_429_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_10.prefab_name].transform, "story_v_out_321102", "321102103", "story_v_out_321102.awb")

						arg_426_1:RecordAudio("321102103", var_429_15)
						arg_426_1:RecordAudio("321102103", var_429_15)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_321102", "321102103", "story_v_out_321102.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_321102", "321102103", "story_v_out_321102.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_16 = math.max(var_429_9, arg_426_1.talkMaxDuration)

			if var_429_8 <= arg_426_1.time_ and arg_426_1.time_ < var_429_8 + var_429_16 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_8) / var_429_16

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_8 + var_429_16 and arg_426_1.time_ < var_429_8 + var_429_16 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play321102104 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 321102104
		arg_430_1.duration_ = 9.63

		local var_430_0 = {
			zh = 7.5,
			ja = 9.633
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
				arg_430_0:Play321102105(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.var_.moveOldPos1085ui_story = arg_430_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_433_0 = 0.001

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 then
				arg_430_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_430_1.time_ - 0) / var_433_0)
				arg_430_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_430_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1085ui_story"].transform.position).z)
				arg_430_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_430_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_430_1.actors_["1085ui_story"].transform.localEulerAngles = arg_430_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 then
				arg_430_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_430_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_430_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1085ui_story"].transform.position).z)
				arg_430_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_430_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_430_1.actors_["1085ui_story"].transform.localEulerAngles = arg_430_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_433_1 = 0
			local var_433_2 = 0.6

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_3 = arg_430_1:GetWordFromCfg(321102104)
				local var_433_4 = arg_430_1:FormatText(var_433_3.content)

				arg_430_1.text_.text = var_433_4

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_6 = 24 <= 0 and var_433_2 or var_433_2 * (utf8.len(var_433_4) / 24)

				if (24 <= 0 and var_433_2 or var_433_2 * (utf8.len(var_433_4) / 24)) > 0 and var_433_2 < var_433_6 then
					arg_430_1.talkMaxDuration = var_433_6

					if var_433_6 + var_433_1 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_6 + var_433_1
					end
				end

				arg_430_1.text_.text = var_433_4
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102104", "story_v_out_321102.awb") ~= 0 then
					local var_433_7 = manager.audio:GetVoiceLength("story_v_out_321102", "321102104", "story_v_out_321102.awb") / 1000

					if var_433_7 + var_433_1 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_7 + var_433_1
					end

					if var_433_3.prefab_name ~= "" and arg_430_1.actors_[var_433_3.prefab_name] ~= nil then
						local var_433_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_3.prefab_name].transform, "story_v_out_321102", "321102104", "story_v_out_321102.awb")

						arg_430_1:RecordAudio("321102104", var_433_8)
						arg_430_1:RecordAudio("321102104", var_433_8)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_321102", "321102104", "story_v_out_321102.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_321102", "321102104", "story_v_out_321102.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_9 = math.max(var_433_2, arg_430_1.talkMaxDuration)

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_9 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_1) / var_433_9

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_1 + var_433_9 and arg_430_1.time_ < var_433_1 + var_433_9 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play321102105 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 321102105
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play321102106(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(arg_434_1.actors_["1085ui_story"]) and arg_434_1.var_.characterEffect1085ui_story == nil then
				arg_434_1.var_.characterEffect1085ui_story = arg_434_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_0 = 0.200000002980232

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_0 and not isNil(arg_434_1.actors_["1085ui_story"]) then
				if arg_434_1.var_.characterEffect1085ui_story and not isNil(arg_434_1.actors_["1085ui_story"]) then
					arg_434_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_434_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_434_1.time_ - 0) / var_437_0)
				end
			end

			if arg_434_1.time_ >= 0 + var_437_0 and arg_434_1.time_ < 0 + var_437_0 + arg_437_0 and not isNil(arg_434_1.actors_["1085ui_story"]) and arg_434_1.var_.characterEffect1085ui_story then
				arg_434_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_434_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0.05 < arg_434_1.time_ and arg_434_1.time_ <= 0.05 + arg_437_0 then
				arg_434_1:AudioAction("play", "effect", "se_story_140", "se_story_140_cat", "")
			end

			local var_437_2 = 0
			local var_437_3 = 1.125

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_2 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, false)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_4 = arg_434_1:FormatText(arg_434_1:GetWordFromCfg(321102105).content)

				arg_434_1.text_.text = var_437_4

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_6 = 45 <= 0 and var_437_3 or var_437_3 * (utf8.len(var_437_4) / 45)

				if (45 <= 0 and var_437_3 or var_437_3 * (utf8.len(var_437_4) / 45)) > 0 and var_437_3 < var_437_6 then
					arg_434_1.talkMaxDuration = var_437_6

					if var_437_6 + var_437_2 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_6 + var_437_2
					end
				end

				arg_434_1.text_.text = var_437_4
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_7 = math.max(var_437_3, arg_434_1.talkMaxDuration)

			if var_437_2 <= arg_434_1.time_ and arg_434_1.time_ < var_437_2 + var_437_7 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_2) / var_437_7

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_2 + var_437_7 and arg_434_1.time_ < var_437_2 + var_437_7 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play321102106 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 321102106
		arg_438_1.duration_ = 4.97

		local var_438_0 = {
			zh = 4.966,
			ja = 4.466
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
				arg_438_0:Play321102107(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0.4

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[1168].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_nainai")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_1 = arg_438_1:GetWordFromCfg(321102106)
				local var_441_2 = arg_438_1:FormatText(var_441_1.content)

				arg_438_1.text_.text = var_441_2

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_4 = 16 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_2) / 16)

				if (16 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_2) / 16)) > 0 and var_441_0 < var_441_4 then
					arg_438_1.talkMaxDuration = var_441_4

					if var_441_4 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_4 + 0
					end
				end

				arg_438_1.text_.text = var_441_2
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102106", "story_v_out_321102.awb") ~= 0 then
					local var_441_5 = manager.audio:GetVoiceLength("story_v_out_321102", "321102106", "story_v_out_321102.awb") / 1000

					if var_441_5 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_5 + 0
					end

					if var_441_1.prefab_name ~= "" and arg_438_1.actors_[var_441_1.prefab_name] ~= nil then
						local var_441_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_1.prefab_name].transform, "story_v_out_321102", "321102106", "story_v_out_321102.awb")

						arg_438_1:RecordAudio("321102106", var_441_6)
						arg_438_1:RecordAudio("321102106", var_441_6)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_321102", "321102106", "story_v_out_321102.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_321102", "321102106", "story_v_out_321102.awb")
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
	Play321102107 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 321102107
		arg_442_1.duration_ = 3.27

		local var_442_0 = {
			zh = 2.266,
			ja = 3.266
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
				arg_442_0:Play321102108(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.var_.moveOldPos1085ui_story = arg_442_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_445_0 = 0.001

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_0 then
				arg_442_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_442_1.time_ - 0) / var_445_0)
				arg_442_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_442_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["1085ui_story"].transform.position).z)
				arg_442_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_442_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_442_1.actors_["1085ui_story"].transform.localEulerAngles = arg_442_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_442_1.time_ >= 0 + var_445_0 and arg_442_1.time_ < 0 + var_445_0 + arg_445_0 then
				arg_442_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_442_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_442_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["1085ui_story"].transform.position).z)
				arg_442_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_442_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_442_1.actors_["1085ui_story"].transform.localEulerAngles = arg_442_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_445_1 = arg_442_1.actors_["1085ui_story"]

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(var_445_1) and arg_442_1.var_.characterEffect1085ui_story == nil then
				arg_442_1.var_.characterEffect1085ui_story = var_445_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_2 = 0.200000002980232

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_2 and not isNil(var_445_1) then
				if arg_442_1.var_.characterEffect1085ui_story and not isNil(var_445_1) then
					arg_442_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_442_1.time_ >= 0 + var_445_2 and arg_442_1.time_ < 0 + var_445_2 + arg_445_0 and not isNil(var_445_1) and arg_442_1.var_.characterEffect1085ui_story then
				arg_442_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action449")
			end

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_445_4 = 0
			local var_445_5 = 0.275

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_4 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_6 = arg_442_1:GetWordFromCfg(321102107)
				local var_445_7 = arg_442_1:FormatText(var_445_6.content)

				arg_442_1.text_.text = var_445_7

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_9 = 11 <= 0 and var_445_5 or var_445_5 * (utf8.len(var_445_7) / 11)

				if (11 <= 0 and var_445_5 or var_445_5 * (utf8.len(var_445_7) / 11)) > 0 and var_445_5 < var_445_9 then
					arg_442_1.talkMaxDuration = var_445_9

					if var_445_9 + var_445_4 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_9 + var_445_4
					end
				end

				arg_442_1.text_.text = var_445_7
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102107", "story_v_out_321102.awb") ~= 0 then
					local var_445_10 = manager.audio:GetVoiceLength("story_v_out_321102", "321102107", "story_v_out_321102.awb") / 1000

					if var_445_10 + var_445_4 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_10 + var_445_4
					end

					if var_445_6.prefab_name ~= "" and arg_442_1.actors_[var_445_6.prefab_name] ~= nil then
						local var_445_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_6.prefab_name].transform, "story_v_out_321102", "321102107", "story_v_out_321102.awb")

						arg_442_1:RecordAudio("321102107", var_445_11)
						arg_442_1:RecordAudio("321102107", var_445_11)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_321102", "321102107", "story_v_out_321102.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_321102", "321102107", "story_v_out_321102.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_12 = math.max(var_445_5, arg_442_1.talkMaxDuration)

			if var_445_4 <= arg_442_1.time_ and arg_442_1.time_ < var_445_4 + var_445_12 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_4) / var_445_12

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_4 + var_445_12 and arg_442_1.time_ < var_445_4 + var_445_12 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_442_1:InitPlayNodeList()
	end,
	Play321102108 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 321102108
		arg_446_1.duration_ = 9

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play321102109(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 2 < arg_446_1.time_ and arg_446_1.time_ <= 2 + arg_449_0 then
				local var_449_0 = arg_446_1.bgs_.L01h

				arg_446_1.bgs_.L01h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_449_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_449_1 = var_449_0:GetComponent("SpriteRenderer")

				if var_449_1 and var_449_1.sprite then
					local var_449_2 = 2 * (var_449_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_449_0.transform.localScale = Vector3.New(var_449_2 / var_449_1.sprite.bounds.size.y < var_449_2 * manager.ui.mainCameraCom_.aspect / var_449_1.sprite.bounds.size.x and var_449_2 * manager.ui.mainCameraCom_.aspect / var_449_1.sprite.bounds.size.x or var_449_2 / var_449_1.sprite.bounds.size.y, var_449_2 / var_449_1.sprite.bounds.size.y < var_449_2 * manager.ui.mainCameraCom_.aspect / var_449_1.sprite.bounds.size.x and var_449_2 * manager.ui.mainCameraCom_.aspect / var_449_1.sprite.bounds.size.x or var_449_2 / var_449_1.sprite.bounds.size.y, 0)
				end

				for iter_449_0, iter_449_1 in pairs(arg_446_1.bgs_) do
					if iter_449_0 ~= "L01h" then
						iter_449_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_449_3 = 3.999999999999

			if 3.999999999999 < arg_446_1.time_ and arg_446_1.time_ <= var_449_3 + arg_449_0 then
				arg_446_1.allBtn_.enabled = false
			end

			if arg_446_1.time_ >= var_449_3 + 0.3 and arg_446_1.time_ < var_449_3 + 0.3 + arg_449_0 then
				arg_446_1.allBtn_.enabled = true
			end

			local var_449_4 = 0

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_4 + arg_449_0 then
				arg_446_1.mask_.enabled = true
				arg_446_1.mask_.raycastTarget = true

				arg_446_1:SetGaussion(false)
			end

			local var_449_5 = 2

			if var_449_4 <= arg_446_1.time_ and arg_446_1.time_ < var_449_4 + var_449_5 then
				local var_449_6 = Color.New(0, 0, 0)

				var_449_6.a = Mathf.Lerp(0, 1, (arg_446_1.time_ - var_449_4) / var_449_5)
				arg_446_1.mask_.color = var_449_6
			end

			if arg_446_1.time_ >= var_449_4 + var_449_5 and arg_446_1.time_ < var_449_4 + var_449_5 + arg_449_0 then
				local var_449_7 = Color.New(0, 0, 0)

				var_449_7.a = 1
				arg_446_1.mask_.color = var_449_7
			end

			local var_449_8 = 2

			if 2 < arg_446_1.time_ and arg_446_1.time_ <= var_449_8 + arg_449_0 then
				arg_446_1.mask_.enabled = true
				arg_446_1.mask_.raycastTarget = true

				arg_446_1:SetGaussion(false)
			end

			local var_449_9 = 2

			if var_449_8 <= arg_446_1.time_ and arg_446_1.time_ < var_449_8 + var_449_9 then
				local var_449_10 = Color.New(0, 0, 0)

				var_449_10.a = Mathf.Lerp(1, 0, (arg_446_1.time_ - var_449_8) / var_449_9)
				arg_446_1.mask_.color = var_449_10
			end

			if arg_446_1.time_ >= var_449_8 + var_449_9 and arg_446_1.time_ < var_449_8 + var_449_9 + arg_449_0 then
				local var_449_11 = Color.New(0, 0, 0)

				arg_446_1.mask_.enabled = false
				var_449_11.a = 0
				arg_446_1.mask_.color = var_449_11
			end

			local var_449_12 = arg_446_1.actors_["1085ui_story"].transform

			if 1.96599999815226 < arg_446_1.time_ and arg_446_1.time_ <= 1.96599999815226 + arg_449_0 then
				arg_446_1.var_.moveOldPos1085ui_story = var_449_12.localPosition
			end

			local var_449_13 = 0.001

			if 1.96599999815226 <= arg_446_1.time_ and arg_446_1.time_ < 1.96599999815226 + var_449_13 then
				var_449_12.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_446_1.time_ - 1.96599999815226) / var_449_13)
				var_449_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_449_12.position).x, (manager.ui.mainCamera.transform.position - var_449_12.position).y, (manager.ui.mainCamera.transform.position - var_449_12.position).z)
				var_449_12.localEulerAngles.z = 0
				var_449_12.localEulerAngles.x = 0
				var_449_12.localEulerAngles = var_449_12.localEulerAngles
			end

			if arg_446_1.time_ >= 1.96599999815226 + var_449_13 and arg_446_1.time_ < 1.96599999815226 + var_449_13 + arg_449_0 then
				var_449_12.localPosition = Vector3.New(0, 100, 0)
				var_449_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_449_12.position).x, (manager.ui.mainCamera.transform.position - var_449_12.position).y, (manager.ui.mainCamera.transform.position - var_449_12.position).z)
				var_449_12.localEulerAngles.z = 0
				var_449_12.localEulerAngles.x = 0
				var_449_12.localEulerAngles = var_449_12.localEulerAngles
			end

			local var_449_14 = arg_446_1.actors_["1085ui_story"]

			if 1.96599999815226 < arg_446_1.time_ and arg_446_1.time_ <= 1.96599999815226 + arg_449_0 and not isNil(var_449_14) and arg_446_1.var_.characterEffect1085ui_story == nil then
				arg_446_1.var_.characterEffect1085ui_story = var_449_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_15 = 0.034000001847744

			if 1.96599999815226 <= arg_446_1.time_ and arg_446_1.time_ < 1.96599999815226 + var_449_15 and not isNil(var_449_14) then
				if arg_446_1.var_.characterEffect1085ui_story and not isNil(var_449_14) then
					arg_446_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_446_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_446_1.time_ - 1.96599999815226) / var_449_15)
				end
			end

			if arg_446_1.time_ >= 1.96599999815226 + var_449_15 and arg_446_1.time_ < 1.96599999815226 + var_449_15 + arg_449_0 and not isNil(var_449_14) and arg_446_1.var_.characterEffect1085ui_story then
				arg_446_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_446_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if arg_446_1.frameCnt_ <= 1 then
				arg_446_1.dialog_:SetActive(false)
			end

			local var_449_16 = 3.999999999999
			local var_449_17 = 1.35

			if 3.999999999999 < arg_446_1.time_ and arg_446_1.time_ <= var_449_16 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0

				arg_446_1.dialog_:SetActive(true)

				arg_446_1.dialogCg_.alpha = 0

				local var_449_18 = LeanTween.value(arg_446_1.dialog_, 0, 1, 0.3)

				var_449_18:setOnUpdate(LuaHelper.FloatAction(function(arg_450_0)
					arg_446_1.dialogCg_.alpha = arg_450_0
				end))
				var_449_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_446_1.dialog_)
					var_449_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_446_1.duration_ = arg_446_1.duration_ + 0.3

				SetActive(arg_446_1.leftNameGo_, false)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_19 = arg_446_1:FormatText(arg_446_1:GetWordFromCfg(321102108).content)

				arg_446_1.text_.text = var_449_19

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_21 = 54 <= 0 and var_449_17 or var_449_17 * (utf8.len(var_449_19) / 54)

				if (54 <= 0 and var_449_17 or var_449_17 * (utf8.len(var_449_19) / 54)) > 0 and var_449_17 < var_449_21 then
					arg_446_1.talkMaxDuration = var_449_21
					var_449_16 = var_449_16 + 0.3

					if var_449_21 + var_449_16 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_21 + var_449_16
					end
				end

				arg_446_1.text_.text = var_449_19
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_22 = var_449_16 + 0.3
			local var_449_23 = math.max(var_449_17, arg_446_1.talkMaxDuration)

			if var_449_16 + 0.3 <= arg_446_1.time_ and arg_446_1.time_ < var_449_22 + var_449_23 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_22) / var_449_23

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_22 + var_449_23 and arg_446_1.time_ < var_449_22 + var_449_23 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_446_1:InitPlayNodeList()
	end,
	Play321102109 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 321102109
		arg_452_1.duration_ = 3.47

		local var_452_0 = {
			zh = 2.9,
			ja = 3.466
		}
		local var_452_1 = manager.audio:GetLocalizationFlag()

		if var_452_0[var_452_1] ~= nil then
			arg_452_1.duration_ = var_452_0[var_452_1]
		end

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play321102110(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.var_.moveOldPos1085ui_story = arg_452_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_455_0 = 0.001

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_0 then
				arg_452_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_452_1.time_ - 0) / var_455_0)
				arg_452_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_452_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1085ui_story"].transform.position).z)
				arg_452_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_452_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_452_1.actors_["1085ui_story"].transform.localEulerAngles = arg_452_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_452_1.time_ >= 0 + var_455_0 and arg_452_1.time_ < 0 + var_455_0 + arg_455_0 then
				arg_452_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_452_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_452_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1085ui_story"].transform.position).z)
				arg_452_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_452_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_452_1.actors_["1085ui_story"].transform.localEulerAngles = arg_452_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_455_1 = arg_452_1.actors_["1085ui_story"]

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(var_455_1) and arg_452_1.var_.characterEffect1085ui_story == nil then
				arg_452_1.var_.characterEffect1085ui_story = var_455_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_2 = 0.200000002980232

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_2 and not isNil(var_455_1) then
				if arg_452_1.var_.characterEffect1085ui_story and not isNil(var_455_1) then
					arg_452_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_452_1.time_ >= 0 + var_455_2 and arg_452_1.time_ < 0 + var_455_2 + arg_455_0 and not isNil(var_455_1) and arg_452_1.var_.characterEffect1085ui_story then
				arg_452_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action497")
			end

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_455_4 = 0
			local var_455_5 = 0.275

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_4 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				arg_452_1.leftNameTxt_.text = arg_452_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_6 = arg_452_1:GetWordFromCfg(321102109)
				local var_455_7 = arg_452_1:FormatText(var_455_6.content)

				arg_452_1.text_.text = var_455_7

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_9 = 11 <= 0 and var_455_5 or var_455_5 * (utf8.len(var_455_7) / 11)

				if (11 <= 0 and var_455_5 or var_455_5 * (utf8.len(var_455_7) / 11)) > 0 and var_455_5 < var_455_9 then
					arg_452_1.talkMaxDuration = var_455_9

					if var_455_9 + var_455_4 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_9 + var_455_4
					end
				end

				arg_452_1.text_.text = var_455_7
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102109", "story_v_out_321102.awb") ~= 0 then
					local var_455_10 = manager.audio:GetVoiceLength("story_v_out_321102", "321102109", "story_v_out_321102.awb") / 1000

					if var_455_10 + var_455_4 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_10 + var_455_4
					end

					if var_455_6.prefab_name ~= "" and arg_452_1.actors_[var_455_6.prefab_name] ~= nil then
						local var_455_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_6.prefab_name].transform, "story_v_out_321102", "321102109", "story_v_out_321102.awb")

						arg_452_1:RecordAudio("321102109", var_455_11)
						arg_452_1:RecordAudio("321102109", var_455_11)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_out_321102", "321102109", "story_v_out_321102.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_out_321102", "321102109", "story_v_out_321102.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_12 = math.max(var_455_5, arg_452_1.talkMaxDuration)

			if var_455_4 <= arg_452_1.time_ and arg_452_1.time_ < var_455_4 + var_455_12 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_4) / var_455_12

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_4 + var_455_12 and arg_452_1.time_ < var_455_4 + var_455_12 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_452_1:InitPlayNodeList()
	end,
	Play321102110 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 321102110
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play321102111(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.var_.moveOldPos1085ui_story = arg_456_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_459_0 = 0.001

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_0 then
				arg_456_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_456_1.time_ - 0) / var_459_0)
				arg_456_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_456_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["1085ui_story"].transform.position).z)
				arg_456_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_456_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_456_1.actors_["1085ui_story"].transform.localEulerAngles = arg_456_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_456_1.time_ >= 0 + var_459_0 and arg_456_1.time_ < 0 + var_459_0 + arg_459_0 then
				arg_456_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_456_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_456_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["1085ui_story"].transform.position).z)
				arg_456_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_456_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_456_1.actors_["1085ui_story"].transform.localEulerAngles = arg_456_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_459_1 = arg_456_1.actors_["1085ui_story"]

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 and not isNil(var_459_1) and arg_456_1.var_.characterEffect1085ui_story == nil then
				arg_456_1.var_.characterEffect1085ui_story = var_459_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_2 = 0.200000002980232

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_2 and not isNil(var_459_1) then
				if arg_456_1.var_.characterEffect1085ui_story and not isNil(var_459_1) then
					arg_456_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_456_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_456_1.time_ - 0) / var_459_2)
				end
			end

			if arg_456_1.time_ >= 0 + var_459_2 and arg_456_1.time_ < 0 + var_459_2 + arg_459_0 and not isNil(var_459_1) and arg_456_1.var_.characterEffect1085ui_story then
				arg_456_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_456_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_459_3 = 0
			local var_459_4 = 0.8

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_3 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, false)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_5 = arg_456_1:FormatText(arg_456_1:GetWordFromCfg(321102110).content)

				arg_456_1.text_.text = var_459_5

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_7 = 32 <= 0 and var_459_4 or var_459_4 * (utf8.len(var_459_5) / 32)

				if (32 <= 0 and var_459_4 or var_459_4 * (utf8.len(var_459_5) / 32)) > 0 and var_459_4 < var_459_7 then
					arg_456_1.talkMaxDuration = var_459_7

					if var_459_7 + var_459_3 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_7 + var_459_3
					end
				end

				arg_456_1.text_.text = var_459_5
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_8 = math.max(var_459_4, arg_456_1.talkMaxDuration)

			if var_459_3 <= arg_456_1.time_ and arg_456_1.time_ < var_459_3 + var_459_8 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_3) / var_459_8

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_3 + var_459_8 and arg_456_1.time_ < var_459_3 + var_459_8 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_456_1:InitPlayNodeList()
	end,
	Play321102111 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 321102111
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play321102112(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = 1.475

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, false)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_1 = arg_460_1:FormatText(arg_460_1:GetWordFromCfg(321102111).content)

				arg_460_1.text_.text = var_463_1

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_3 = 59 <= 0 and var_463_0 or var_463_0 * (utf8.len(var_463_1) / 59)

				if (59 <= 0 and var_463_0 or var_463_0 * (utf8.len(var_463_1) / 59)) > 0 and var_463_0 < var_463_3 then
					arg_460_1.talkMaxDuration = var_463_3

					if var_463_3 + 0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_3 + 0
					end
				end

				arg_460_1.text_.text = var_463_1
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_4 = math.max(var_463_0, arg_460_1.talkMaxDuration)

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_4 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - 0) / var_463_4

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= 0 + var_463_4 and arg_460_1.time_ < 0 + var_463_4 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play321102112 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 321102112
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
			arg_464_1.auto_ = false
		end

		function arg_464_1.playNext_(arg_466_0)
			arg_464_1.onStoryFinished_()
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = 0.375

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, false)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_1 = arg_464_1:FormatText(arg_464_1:GetWordFromCfg(321102112).content)

				arg_464_1.text_.text = var_467_1

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_3 = 15 <= 0 and var_467_0 or var_467_0 * (utf8.len(var_467_1) / 15)

				if (15 <= 0 and var_467_0 or var_467_0 * (utf8.len(var_467_1) / 15)) > 0 and var_467_0 < var_467_3 then
					arg_464_1.talkMaxDuration = var_467_3

					if var_467_3 + 0 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_3 + 0
					end
				end

				arg_464_1.text_.text = var_467_1
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_4 = math.max(var_467_0, arg_464_1.talkMaxDuration)

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_4 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - 0) / var_467_4

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= 0 + var_467_4 and arg_464_1.time_ < 0 + var_467_4 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L10f",
		"TextureConfig/Background/L10g",
		"TextureConfig/Background/L01h",
		"TextureConfig/Background/ST0504",
		"TextureConfig/Background/ST0505a"
	},
	voices = {
		"story_v_out_321102.awb"
	}
}
