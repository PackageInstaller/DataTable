return {
	Play321191001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321191001
		arg_1_1.duration_ = 12.1

		local var_1_0 = {
			zh = 8.60000000298023,
			ja = 12.1000000029802
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
				arg_1_0:Play321191002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L10g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L10g")
				var_4_0.name = "L10g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L10g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L10g

				arg_1_1.bgs_.L10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L10g" then
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
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.71, -6)
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
			local var_4_25 = 0.55

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(321191001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 22 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 22)

				if (22 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 22)) > 0 and var_4_25 < var_4_30 then
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

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191001", "story_v_out_321191.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_321191", "321191001", "story_v_out_321191.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_321191", "321191001", "story_v_out_321191.awb")

						arg_1_1:RecordAudio("321191001", var_4_32)
						arg_1_1:RecordAudio("321191001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_321191", "321191001", "story_v_out_321191.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_321191", "321191001", "story_v_out_321191.awb")
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
	Play321191002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321191002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321191003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1011ui_story = arg_9_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1011ui_story"].transform.position).z)
				arg_9_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1011ui_story"].transform.localEulerAngles = arg_9_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1011ui_story"].transform.position).z)
				arg_9_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1011ui_story"].transform.localEulerAngles = arg_9_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_12_1 = arg_9_1.actors_["1011ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1011ui_story == nil then
				arg_9_1.var_.characterEffect1011ui_story = var_12_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 and not isNil(var_12_1) then
				if arg_9_1.var_.characterEffect1011ui_story and not isNil(var_12_1) then
					arg_9_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_2)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1011ui_story then
				arg_9_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_9_1.time_ and arg_9_1.time_ <= 0.034000001847744 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_136", "se_story_136_carengine", "")
			end

			local var_12_4 = 0
			local var_12_5 = 1.075

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_6 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(321191002).content)

				arg_9_1.text_.text = var_12_6

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_8 = 43 <= 0 and var_12_5 or var_12_5 * (utf8.len(var_12_6) / 43)

				if (43 <= 0 and var_12_5 or var_12_5 * (utf8.len(var_12_6) / 43)) > 0 and var_12_5 < var_12_8 then
					arg_9_1.talkMaxDuration = var_12_8

					if var_12_8 + var_12_4 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_4
					end
				end

				arg_9_1.text_.text = var_12_6
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_9 = math.max(var_12_5, arg_9_1.talkMaxDuration)

			if var_12_4 <= arg_9_1.time_ and arg_9_1.time_ < var_12_4 + var_12_9 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_4) / var_12_9

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_4 + var_12_9 and arg_9_1.time_ < var_12_4 + var_12_9 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play321191003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321191003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play321191004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.425

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(321191003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 57 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 57)

				if (57 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 57)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play321191004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321191004
		arg_17_1.duration_ = 8.47

		local var_17_0 = {
			zh = 6.233,
			ja = 8.466
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
				arg_17_0:Play321191005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1011ui_story = arg_17_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1011ui_story"].transform.position).z)
				arg_17_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1011ui_story"].transform.localEulerAngles = arg_17_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_17_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1011ui_story"].transform.position).z)
				arg_17_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1011ui_story"].transform.localEulerAngles = arg_17_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1011ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1011ui_story == nil then
				arg_17_1.var_.characterEffect1011ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1011ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1011ui_story then
				arg_17_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_2")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_20_4 = 0
			local var_20_5 = 0.7

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(321191004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 28 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 28)

				if (28 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 28)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191004", "story_v_out_321191.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_321191", "321191004", "story_v_out_321191.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_321191", "321191004", "story_v_out_321191.awb")

						arg_17_1:RecordAudio("321191004", var_20_11)
						arg_17_1:RecordAudio("321191004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_321191", "321191004", "story_v_out_321191.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_321191", "321191004", "story_v_out_321191.awb")
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
				actorName = "1011ui_story",
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
	Play321191005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321191005
		arg_21_1.duration_ = 17.67

		local var_21_0 = {
			zh = 8.3,
			ja = 17.666
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
				arg_21_0:Play321191006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1011ui_story"]) and arg_21_1.var_.characterEffect1011ui_story == nil then
				arg_21_1.var_.characterEffect1011ui_story = arg_21_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1011ui_story"]) then
				if arg_21_1.var_.characterEffect1011ui_story and not isNil(arg_21_1.actors_["1011ui_story"]) then
					arg_21_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1011ui_story"]) and arg_21_1.var_.characterEffect1011ui_story then
				arg_21_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.95

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(321191005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 38 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 38)

				if (38 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 38)) > 0 and var_24_2 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191005", "story_v_out_321191.awb") ~= 0 then
					local var_24_7 = manager.audio:GetVoiceLength("story_v_out_321191", "321191005", "story_v_out_321191.awb") / 1000

					if var_24_7 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_1
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_321191", "321191005", "story_v_out_321191.awb")

						arg_21_1:RecordAudio("321191005", var_24_8)
						arg_21_1:RecordAudio("321191005", var_24_8)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_321191", "321191005", "story_v_out_321191.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_321191", "321191005", "story_v_out_321191.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_9 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_9 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_9

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_9 and arg_21_1.time_ < var_24_1 + var_24_9 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play321191006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321191006
		arg_25_1.duration_ = 11.2

		local var_25_0 = {
			zh = 9.9,
			ja = 11.2
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
				arg_25_0:Play321191007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1011ui_story"]) and arg_25_1.var_.characterEffect1011ui_story == nil then
				arg_25_1.var_.characterEffect1011ui_story = arg_25_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1011ui_story"]) then
				if arg_25_1.var_.characterEffect1011ui_story and not isNil(arg_25_1.actors_["1011ui_story"]) then
					arg_25_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1011ui_story"]) and arg_25_1.var_.characterEffect1011ui_story then
				arg_25_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_28_2 = 0
			local var_28_3 = 0.975

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
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

				local var_28_4 = arg_25_1:GetWordFromCfg(321191006)
				local var_28_5 = arg_25_1:FormatText(var_28_4.content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 39 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 39)

				if (39 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 39)) > 0 and var_28_3 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191006", "story_v_out_321191.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_321191", "321191006", "story_v_out_321191.awb") / 1000

					if var_28_8 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_2
					end

					if var_28_4.prefab_name ~= "" and arg_25_1.actors_[var_28_4.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_4.prefab_name].transform, "story_v_out_321191", "321191006", "story_v_out_321191.awb")

						arg_25_1:RecordAudio("321191006", var_28_9)
						arg_25_1:RecordAudio("321191006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_321191", "321191006", "story_v_out_321191.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_321191", "321191006", "story_v_out_321191.awb")
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
	Play321191007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321191007
		arg_29_1.duration_ = 5.17

		local var_29_0 = {
			zh = 4.933,
			ja = 5.166
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
				arg_29_0:Play321191008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1011ui_story"]) and arg_29_1.var_.characterEffect1011ui_story == nil then
				arg_29_1.var_.characterEffect1011ui_story = arg_29_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1011ui_story"]) then
				if arg_29_1.var_.characterEffect1011ui_story and not isNil(arg_29_1.actors_["1011ui_story"]) then
					arg_29_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1011ui_story"]) and arg_29_1.var_.characterEffect1011ui_story then
				arg_29_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = 0.425

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(321191007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 17 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 17)

				if (17 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 17)) > 0 and var_32_2 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191007", "story_v_out_321191.awb") ~= 0 then
					local var_32_7 = manager.audio:GetVoiceLength("story_v_out_321191", "321191007", "story_v_out_321191.awb") / 1000

					if var_32_7 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_1
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_321191", "321191007", "story_v_out_321191.awb")

						arg_29_1:RecordAudio("321191007", var_32_8)
						arg_29_1:RecordAudio("321191007", var_32_8)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_321191", "321191007", "story_v_out_321191.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_321191", "321191007", "story_v_out_321191.awb")
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

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play321191008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321191008
		arg_33_1.duration_ = 5.03

		local var_33_0 = {
			zh = 5.033,
			ja = 3.966
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
				arg_33_0:Play321191009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1011ui_story"]) and arg_33_1.var_.characterEffect1011ui_story == nil then
				arg_33_1.var_.characterEffect1011ui_story = arg_33_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1011ui_story"]) then
				if arg_33_1.var_.characterEffect1011ui_story and not isNil(arg_33_1.actors_["1011ui_story"]) then
					arg_33_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1011ui_story"]) and arg_33_1.var_.characterEffect1011ui_story then
				arg_33_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_36_2 = 0
			local var_36_3 = 0.525

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:GetWordFromCfg(321191008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 21 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 21)

				if (21 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 21)) > 0 and var_36_3 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191008", "story_v_out_321191.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_321191", "321191008", "story_v_out_321191.awb") / 1000

					if var_36_8 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_2
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_out_321191", "321191008", "story_v_out_321191.awb")

						arg_33_1:RecordAudio("321191008", var_36_9)
						arg_33_1:RecordAudio("321191008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_321191", "321191008", "story_v_out_321191.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_321191", "321191008", "story_v_out_321191.awb")
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
	Play321191009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321191009
		arg_37_1.duration_ = 7.67

		local var_37_0 = {
			zh = 5.066,
			ja = 7.666
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
				arg_37_0:Play321191010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1011ui_story"]) and arg_37_1.var_.characterEffect1011ui_story == nil then
				arg_37_1.var_.characterEffect1011ui_story = arg_37_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1011ui_story"]) then
				if arg_37_1.var_.characterEffect1011ui_story and not isNil(arg_37_1.actors_["1011ui_story"]) then
					arg_37_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1011ui_story"]) and arg_37_1.var_.characterEffect1011ui_story then
				arg_37_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.6

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(321191009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 24 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 24)

				if (24 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 24)) > 0 and var_40_2 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191009", "story_v_out_321191.awb") ~= 0 then
					local var_40_7 = manager.audio:GetVoiceLength("story_v_out_321191", "321191009", "story_v_out_321191.awb") / 1000

					if var_40_7 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_1
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_321191", "321191009", "story_v_out_321191.awb")

						arg_37_1:RecordAudio("321191009", var_40_8)
						arg_37_1:RecordAudio("321191009", var_40_8)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_321191", "321191009", "story_v_out_321191.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_321191", "321191009", "story_v_out_321191.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_9 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_9 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_9

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_9 and arg_37_1.time_ < var_40_1 + var_40_9 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play321191010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 321191010
		arg_41_1.duration_ = 11.7

		local var_41_0 = {
			zh = 8.466,
			ja = 11.7
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
				arg_41_0:Play321191011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.95

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:GetWordFromCfg(321191010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 38 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 38)

				if (38 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 38)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191010", "story_v_out_321191.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191010", "story_v_out_321191.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_321191", "321191010", "story_v_out_321191.awb")

						arg_41_1:RecordAudio("321191010", var_44_6)
						arg_41_1:RecordAudio("321191010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_321191", "321191010", "story_v_out_321191.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_321191", "321191010", "story_v_out_321191.awb")
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
	Play321191011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 321191011
		arg_45_1.duration_ = 11.9

		local var_45_0 = {
			zh = 9.333,
			ja = 11.9
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
				arg_45_0:Play321191012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.175

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:GetWordFromCfg(321191011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 47 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 47)

				if (47 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 47)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191011", "story_v_out_321191.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191011", "story_v_out_321191.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_321191", "321191011", "story_v_out_321191.awb")

						arg_45_1:RecordAudio("321191011", var_48_6)
						arg_45_1:RecordAudio("321191011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_321191", "321191011", "story_v_out_321191.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_321191", "321191011", "story_v_out_321191.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play321191012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 321191012
		arg_49_1.duration_ = 13.17

		local var_49_0 = {
			zh = 7.7,
			ja = 13.166
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
				arg_49_0:Play321191013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.8

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(321191012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 32 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 32)

				if (32 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 32)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191012", "story_v_out_321191.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191012", "story_v_out_321191.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_321191", "321191012", "story_v_out_321191.awb")

						arg_49_1:RecordAudio("321191012", var_52_6)
						arg_49_1:RecordAudio("321191012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_321191", "321191012", "story_v_out_321191.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_321191", "321191012", "story_v_out_321191.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play321191013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 321191013
		arg_53_1.duration_ = 4.37

		local var_53_0 = {
			zh = 4,
			ja = 4.366
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
				arg_53_0:Play321191014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1011ui_story = arg_53_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1011ui_story"].transform.position).z)
				arg_53_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1011ui_story"].transform.localEulerAngles = arg_53_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_53_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1011ui_story"].transform.position).z)
				arg_53_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1011ui_story"].transform.localEulerAngles = arg_53_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1011ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1011ui_story == nil then
				arg_53_1.var_.characterEffect1011ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1011ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1011ui_story then
				arg_53_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_2")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_56_4 = 0
			local var_56_5 = 0.325

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(321191013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 13 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 13)

				if (13 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 13)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191013", "story_v_out_321191.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_321191", "321191013", "story_v_out_321191.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_321191", "321191013", "story_v_out_321191.awb")

						arg_53_1:RecordAudio("321191013", var_56_11)
						arg_53_1:RecordAudio("321191013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_321191", "321191013", "story_v_out_321191.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_321191", "321191013", "story_v_out_321191.awb")
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
				actorName = "1011ui_story",
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
	Play321191014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 321191014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play321191015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1011ui_story = arg_57_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1011ui_story"].transform.position).z)
				arg_57_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1011ui_story"].transform.localEulerAngles = arg_57_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1011ui_story"].transform.position).z)
				arg_57_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1011ui_story"].transform.localEulerAngles = arg_57_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1011ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1011ui_story == nil then
				arg_57_1.var_.characterEffect1011ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1011ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_2)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1011ui_story then
				arg_57_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_60_3 = 0
			local var_60_4 = 0.95

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

				local var_60_5 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(321191014).content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 38 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_5) / 38)

				if (38 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_5) / 38)) > 0 and var_60_4 < var_60_7 then
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
				actorName = "1011ui_story",
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
	Play321191015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 321191015
		arg_61_1.duration_ = 5.27

		local var_61_0 = {
			zh = 3.966,
			ja = 5.266
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
				arg_61_0:Play321191016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.475

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:GetWordFromCfg(321191015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 19 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 19)

				if (19 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 19)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191015", "story_v_out_321191.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191015", "story_v_out_321191.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_321191", "321191015", "story_v_out_321191.awb")

						arg_61_1:RecordAudio("321191015", var_64_6)
						arg_61_1:RecordAudio("321191015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_321191", "321191015", "story_v_out_321191.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_321191", "321191015", "story_v_out_321191.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play321191016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 321191016
		arg_65_1.duration_ = 11.43

		local var_65_0 = {
			zh = 9.633,
			ja = 11.433
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
				arg_65_0:Play321191017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1011ui_story = arg_65_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1011ui_story"].transform.position).z)
				arg_65_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1011ui_story"].transform.localEulerAngles = arg_65_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_65_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1011ui_story"].transform.position).z)
				arg_65_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1011ui_story"].transform.localEulerAngles = arg_65_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1011ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1011ui_story == nil then
				arg_65_1.var_.characterEffect1011ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1011ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1011ui_story then
				arg_65_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_68_4 = 0
			local var_68_5 = 0.9

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(321191016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 36 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 36)

				if (36 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 36)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191016", "story_v_out_321191.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_321191", "321191016", "story_v_out_321191.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_321191", "321191016", "story_v_out_321191.awb")

						arg_65_1:RecordAudio("321191016", var_68_11)
						arg_65_1:RecordAudio("321191016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_321191", "321191016", "story_v_out_321191.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_321191", "321191016", "story_v_out_321191.awb")
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
				actorName = "1011ui_story",
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
	Play321191017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 321191017
		arg_69_1.duration_ = 8.5

		local var_69_0 = {
			zh = 6.333,
			ja = 8.5
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
				arg_69_0:Play321191018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1011ui_story = arg_69_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1011ui_story"].transform.position).z)
				arg_69_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1011ui_story"].transform.localEulerAngles = arg_69_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_69_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1011ui_story"].transform.position).z)
				arg_69_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1011ui_story"].transform.localEulerAngles = arg_69_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_72_1 = 0
			local var_72_2 = 0.65

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(321191017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_6 = 26 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_4) / 26)

				if (26 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_4) / 26)) > 0 and var_72_2 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191017", "story_v_out_321191.awb") ~= 0 then
					local var_72_7 = manager.audio:GetVoiceLength("story_v_out_321191", "321191017", "story_v_out_321191.awb") / 1000

					if var_72_7 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_1
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_321191", "321191017", "story_v_out_321191.awb")

						arg_69_1:RecordAudio("321191017", var_72_8)
						arg_69_1:RecordAudio("321191017", var_72_8)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_321191", "321191017", "story_v_out_321191.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_321191", "321191017", "story_v_out_321191.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_9 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_9 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_9

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_9 and arg_69_1.time_ < var_72_1 + var_72_9 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play321191018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 321191018
		arg_73_1.duration_ = 10.8

		local var_73_0 = {
			zh = 5.8,
			ja = 10.8
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
				arg_73_0:Play321191019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1011ui_story"]) and arg_73_1.var_.characterEffect1011ui_story == nil then
				arg_73_1.var_.characterEffect1011ui_story = arg_73_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1011ui_story"]) then
				if arg_73_1.var_.characterEffect1011ui_story and not isNil(arg_73_1.actors_["1011ui_story"]) then
					arg_73_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1011ui_story"]) and arg_73_1.var_.characterEffect1011ui_story then
				arg_73_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 0.775

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(321191018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 31 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 31)

				if (31 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 31)) > 0 and var_76_2 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191018", "story_v_out_321191.awb") ~= 0 then
					local var_76_7 = manager.audio:GetVoiceLength("story_v_out_321191", "321191018", "story_v_out_321191.awb") / 1000

					if var_76_7 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_1
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_321191", "321191018", "story_v_out_321191.awb")

						arg_73_1:RecordAudio("321191018", var_76_8)
						arg_73_1:RecordAudio("321191018", var_76_8)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_321191", "321191018", "story_v_out_321191.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_321191", "321191018", "story_v_out_321191.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_9 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_9 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_9

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_9 and arg_73_1.time_ < var_76_1 + var_76_9 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play321191019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 321191019
		arg_77_1.duration_ = 7.97

		local var_77_0 = {
			zh = 4.133,
			ja = 7.966
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
				arg_77_0:Play321191020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1011ui_story"]) and arg_77_1.var_.characterEffect1011ui_story == nil then
				arg_77_1.var_.characterEffect1011ui_story = arg_77_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1011ui_story"]) then
				if arg_77_1.var_.characterEffect1011ui_story and not isNil(arg_77_1.actors_["1011ui_story"]) then
					arg_77_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1011ui_story"]) and arg_77_1.var_.characterEffect1011ui_story then
				arg_77_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_80_2 = 0
			local var_80_3 = 0.375

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:GetWordFromCfg(321191019)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 15 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 15)

				if (15 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 15)) > 0 and var_80_3 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191019", "story_v_out_321191.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_321191", "321191019", "story_v_out_321191.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_out_321191", "321191019", "story_v_out_321191.awb")

						arg_77_1:RecordAudio("321191019", var_80_9)
						arg_77_1:RecordAudio("321191019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_321191", "321191019", "story_v_out_321191.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_321191", "321191019", "story_v_out_321191.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_10 and arg_77_1.time_ < var_80_2 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play321191020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 321191020
		arg_81_1.duration_ = 14.3

		local var_81_0 = {
			zh = 10.4,
			ja = 14.3
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
				arg_81_0:Play321191021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 1.175

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(321191020)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 47 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 47)

				if (47 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 47)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191020", "story_v_out_321191.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191020", "story_v_out_321191.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_321191", "321191020", "story_v_out_321191.awb")

						arg_81_1:RecordAudio("321191020", var_84_6)
						arg_81_1:RecordAudio("321191020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_321191", "321191020", "story_v_out_321191.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_321191", "321191020", "story_v_out_321191.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play321191021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 321191021
		arg_85_1.duration_ = 15.33

		local var_85_0 = {
			zh = 7.066,
			ja = 15.333
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
				arg_85_0:Play321191022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1011ui_story = arg_85_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1011ui_story"].transform.position).z)
				arg_85_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1011ui_story"].transform.localEulerAngles = arg_85_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_85_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1011ui_story"].transform.position).z)
				arg_85_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1011ui_story"].transform.localEulerAngles = arg_85_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_2")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_88_1 = 0
			local var_88_2 = 0.8

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(321191021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_6 = 32 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 32)

				if (32 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 32)) > 0 and var_88_2 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191021", "story_v_out_321191.awb") ~= 0 then
					local var_88_7 = manager.audio:GetVoiceLength("story_v_out_321191", "321191021", "story_v_out_321191.awb") / 1000

					if var_88_7 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_1
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_321191", "321191021", "story_v_out_321191.awb")

						arg_85_1:RecordAudio("321191021", var_88_8)
						arg_85_1:RecordAudio("321191021", var_88_8)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_321191", "321191021", "story_v_out_321191.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_321191", "321191021", "story_v_out_321191.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_9 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_9 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_9

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_9 and arg_85_1.time_ < var_88_1 + var_88_9 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
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

		arg_85_1:InitPlayNodeList()
	end,
	Play321191022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 321191022
		arg_89_1.duration_ = 9

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play321191023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if arg_89_1.bgs_.ST73 == nil then
				local var_92_0 = Object.Instantiate(arg_89_1.paintGo_)

				var_92_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST73")
				var_92_0.name = "ST73"
				var_92_0.transform.parent = arg_89_1.stage_.transform
				var_92_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.bgs_.ST73 = var_92_0
			end

			if 2 < arg_89_1.time_ and arg_89_1.time_ <= 2 + arg_92_0 then
				local var_92_1 = arg_89_1.bgs_.ST73

				arg_89_1.bgs_.ST73.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_92_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_92_2 = var_92_1:GetComponent("SpriteRenderer")

				if var_92_2 and var_92_2.sprite then
					local var_92_3 = 2 * (var_92_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_92_1.transform.localScale = Vector3.New(var_92_3 / var_92_2.sprite.bounds.size.y < var_92_3 * manager.ui.mainCameraCom_.aspect / var_92_2.sprite.bounds.size.x and var_92_3 * manager.ui.mainCameraCom_.aspect / var_92_2.sprite.bounds.size.x or var_92_3 / var_92_2.sprite.bounds.size.y, var_92_3 / var_92_2.sprite.bounds.size.y < var_92_3 * manager.ui.mainCameraCom_.aspect / var_92_2.sprite.bounds.size.x and var_92_3 * manager.ui.mainCameraCom_.aspect / var_92_2.sprite.bounds.size.x or var_92_3 / var_92_2.sprite.bounds.size.y, 0)
				end

				for iter_92_0, iter_92_1 in pairs(arg_89_1.bgs_) do
					if iter_92_0 ~= "ST73" then
						iter_92_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_92_4 = 4

			if 4 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.allBtn_.enabled = false
			end

			if arg_89_1.time_ >= var_92_4 + 0.3 and arg_89_1.time_ < var_92_4 + 0.3 + arg_92_0 then
				arg_89_1.allBtn_.enabled = true
			end

			local var_92_5 = 0

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_6 = 2

			if var_92_5 <= arg_89_1.time_ and arg_89_1.time_ < var_92_5 + var_92_6 then
				local var_92_7 = Color.New(0, 0, 0)

				var_92_7.a = Mathf.Lerp(0, 1, (arg_89_1.time_ - var_92_5) / var_92_6)
				arg_89_1.mask_.color = var_92_7
			end

			if arg_89_1.time_ >= var_92_5 + var_92_6 and arg_89_1.time_ < var_92_5 + var_92_6 + arg_92_0 then
				local var_92_8 = Color.New(0, 0, 0)

				var_92_8.a = 1
				arg_89_1.mask_.color = var_92_8
			end

			local var_92_9 = 2

			if 2 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_10 = 2

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_10 then
				local var_92_11 = Color.New(0, 0, 0)

				var_92_11.a = Mathf.Lerp(1, 0, (arg_89_1.time_ - var_92_9) / var_92_10)
				arg_89_1.mask_.color = var_92_11
			end

			if arg_89_1.time_ >= var_92_9 + var_92_10 and arg_89_1.time_ < var_92_9 + var_92_10 + arg_92_0 then
				local var_92_12 = Color.New(0, 0, 0)

				arg_89_1.mask_.enabled = false
				var_92_12.a = 0
				arg_89_1.mask_.color = var_92_12
			end

			local var_92_13 = arg_89_1.actors_["1011ui_story"].transform

			if 1.96599999815226 < arg_89_1.time_ and arg_89_1.time_ <= 1.96599999815226 + arg_92_0 then
				arg_89_1.var_.moveOldPos1011ui_story = var_92_13.localPosition
			end

			local var_92_14 = 0.001

			if 1.96599999815226 <= arg_89_1.time_ and arg_89_1.time_ < 1.96599999815226 + var_92_14 then
				var_92_13.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 1.96599999815226) / var_92_14)
				var_92_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_13.position).x, (manager.ui.mainCamera.transform.position - var_92_13.position).y, (manager.ui.mainCamera.transform.position - var_92_13.position).z)
				var_92_13.localEulerAngles.z = 0
				var_92_13.localEulerAngles.x = 0
				var_92_13.localEulerAngles = var_92_13.localEulerAngles
			end

			if arg_89_1.time_ >= 1.96599999815226 + var_92_14 and arg_89_1.time_ < 1.96599999815226 + var_92_14 + arg_92_0 then
				var_92_13.localPosition = Vector3.New(0, 100, 0)
				var_92_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_13.position).x, (manager.ui.mainCamera.transform.position - var_92_13.position).y, (manager.ui.mainCamera.transform.position - var_92_13.position).z)
				var_92_13.localEulerAngles.z = 0
				var_92_13.localEulerAngles.x = 0
				var_92_13.localEulerAngles = var_92_13.localEulerAngles
			end

			local var_92_15 = arg_89_1.actors_["1011ui_story"]

			if 1.96599999815226 < arg_89_1.time_ and arg_89_1.time_ <= 1.96599999815226 + arg_92_0 and not isNil(var_92_15) and arg_89_1.var_.characterEffect1011ui_story == nil then
				arg_89_1.var_.characterEffect1011ui_story = var_92_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_16 = 0.034000001847744

			if 1.96599999815226 <= arg_89_1.time_ and arg_89_1.time_ < 1.96599999815226 + var_92_16 and not isNil(var_92_15) then
				if arg_89_1.var_.characterEffect1011ui_story and not isNil(var_92_15) then
					arg_89_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 1.96599999815226) / var_92_16)
				end
			end

			if arg_89_1.time_ >= 1.96599999815226 + var_92_16 and arg_89_1.time_ < 1.96599999815226 + var_92_16 + arg_92_0 and not isNil(var_92_15) and arg_89_1.var_.characterEffect1011ui_story then
				arg_89_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if arg_89_1.frameCnt_ <= 1 then
				arg_89_1.dialog_:SetActive(false)
			end

			local var_92_17 = 4
			local var_92_18 = 0.7

			if 4 < arg_89_1.time_ and arg_89_1.time_ <= var_92_17 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0

				arg_89_1.dialog_:SetActive(true)

				arg_89_1.dialogCg_.alpha = 0

				local var_92_19 = LeanTween.value(arg_89_1.dialog_, 0, 1, 0.3)

				var_92_19:setOnUpdate(LuaHelper.FloatAction(function(arg_93_0)
					arg_89_1.dialogCg_.alpha = arg_93_0
				end))
				var_92_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_89_1.dialog_)
					var_92_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_89_1.duration_ = arg_89_1.duration_ + 0.3

				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_20 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(321191022).content)

				arg_89_1.text_.text = var_92_20

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_22 = 28 <= 0 and var_92_18 or var_92_18 * (utf8.len(var_92_20) / 28)

				if (28 <= 0 and var_92_18 or var_92_18 * (utf8.len(var_92_20) / 28)) > 0 and var_92_18 < var_92_22 then
					arg_89_1.talkMaxDuration = var_92_22
					var_92_17 = var_92_17 + 0.3

					if var_92_22 + var_92_17 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_22 + var_92_17
					end
				end

				arg_89_1.text_.text = var_92_20
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_23 = var_92_17 + 0.3
			local var_92_24 = math.max(var_92_18, arg_89_1.talkMaxDuration)

			if var_92_17 + 0.3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_23 + var_92_24 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_23) / var_92_24

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_23 + var_92_24 and arg_89_1.time_ < var_92_23 + var_92_24 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play321191023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 321191023
		arg_95_1.duration_ = 8.37

		local var_95_0 = {
			zh = 5.066,
			ja = 8.366
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
				arg_95_0:Play321191024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if arg_95_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_98_0 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_95_1.stage_.transform)

				var_98_0.name = "10104ui_story"
				var_98_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.actors_["10104ui_story"] = var_98_0

				local var_98_1 = var_98_0:GetComponentInChildren(typeof(CharacterEffect))

				var_98_1.enabled = true

				local var_98_2 = GameObjectTools.GetOrAddComponent(var_98_0, typeof(DynamicBoneHelper))

				if var_98_2 then
					var_98_2:EnableDynamicBone(false)
				end

				arg_95_1:ShowWeapon(var_98_1.transform, false)

				arg_95_1.var_["10104ui_story" .. "Animator"] = var_98_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_95_1.var_["10104ui_story" .. "Animator"].applyRootMotion = true
				arg_95_1.var_["10104ui_story" .. "LipSync"] = var_98_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_98_3 = arg_95_1.actors_["10104ui_story"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10104ui_story = var_98_3.localPosition
			end

			local var_98_4 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				var_98_3.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_95_1.time_ - 0) / var_98_4)
				var_98_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_3.position).x, (manager.ui.mainCamera.transform.position - var_98_3.position).y, (manager.ui.mainCamera.transform.position - var_98_3.position).z)
				var_98_3.localEulerAngles.z = 0
				var_98_3.localEulerAngles.x = 0
				var_98_3.localEulerAngles = var_98_3.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				var_98_3.localPosition = Vector3.New(0.02, -1.12, -5.99)
				var_98_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_3.position).x, (manager.ui.mainCamera.transform.position - var_98_3.position).y, (manager.ui.mainCamera.transform.position - var_98_3.position).z)
				var_98_3.localEulerAngles.z = 0
				var_98_3.localEulerAngles.x = 0
				var_98_3.localEulerAngles = var_98_3.localEulerAngles
			end

			local var_98_5 = arg_95_1.actors_["10104ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.characterEffect10104ui_story == nil then
				arg_95_1.var_.characterEffect10104ui_story = var_98_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_6 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_6 and not isNil(var_98_5) then
				if arg_95_1.var_.characterEffect10104ui_story and not isNil(var_98_5) then
					arg_95_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_6 and arg_95_1.time_ < 0 + var_98_6 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.characterEffect10104ui_story then
				arg_95_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_98_8 = 0
			local var_98_9 = 0.6

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_10 = arg_95_1:GetWordFromCfg(321191023)
				local var_98_11 = arg_95_1:FormatText(var_98_10.content)

				arg_95_1.text_.text = var_98_11

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_13 = 24 <= 0 and var_98_9 or var_98_9 * (utf8.len(var_98_11) / 24)

				if (24 <= 0 and var_98_9 or var_98_9 * (utf8.len(var_98_11) / 24)) > 0 and var_98_9 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13

					if var_98_13 + var_98_8 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_8
					end
				end

				arg_95_1.text_.text = var_98_11
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191023", "story_v_out_321191.awb") ~= 0 then
					local var_98_14 = manager.audio:GetVoiceLength("story_v_out_321191", "321191023", "story_v_out_321191.awb") / 1000

					if var_98_14 + var_98_8 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_14 + var_98_8
					end

					if var_98_10.prefab_name ~= "" and arg_95_1.actors_[var_98_10.prefab_name] ~= nil then
						local var_98_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_10.prefab_name].transform, "story_v_out_321191", "321191023", "story_v_out_321191.awb")

						arg_95_1:RecordAudio("321191023", var_98_15)
						arg_95_1:RecordAudio("321191023", var_98_15)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_321191", "321191023", "story_v_out_321191.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_321191", "321191023", "story_v_out_321191.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_16 = math.max(var_98_9, arg_95_1.talkMaxDuration)

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_16 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_8) / var_98_16

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_8 + var_98_16 and arg_95_1.time_ < var_98_8 + var_98_16 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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

		arg_95_1:InitPlayNodeList()
	end,
	Play321191024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 321191024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play321191025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["10104ui_story"]) and arg_99_1.var_.characterEffect10104ui_story == nil then
				arg_99_1.var_.characterEffect10104ui_story = arg_99_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["10104ui_story"]) then
				if arg_99_1.var_.characterEffect10104ui_story and not isNil(arg_99_1.actors_["10104ui_story"]) then
					arg_99_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_99_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_0)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["10104ui_story"]) and arg_99_1.var_.characterEffect10104ui_story then
				arg_99_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_99_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_102_1 = 0
			local var_102_2 = 0.725

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_3 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(321191024).content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 29 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 29)

				if (29 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 29)) > 0 and var_102_2 < var_102_5 then
					arg_99_1.talkMaxDuration = var_102_5

					if var_102_5 + var_102_1 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + var_102_1
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_6 = math.max(var_102_2, arg_99_1.talkMaxDuration)

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_6 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_1) / var_102_6

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_1 + var_102_6 and arg_99_1.time_ < var_102_1 + var_102_6 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play321191025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 321191025
		arg_103_1.duration_ = 8.33

		local var_103_0 = {
			zh = 5.166,
			ja = 8.333
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
				arg_103_0:Play321191026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["10104ui_story"]) and arg_103_1.var_.characterEffect10104ui_story == nil then
				arg_103_1.var_.characterEffect10104ui_story = arg_103_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["10104ui_story"]) then
				if arg_103_1.var_.characterEffect10104ui_story and not isNil(arg_103_1.actors_["10104ui_story"]) then
					arg_103_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["10104ui_story"]) and arg_103_1.var_.characterEffect10104ui_story then
				arg_103_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_2")
			end

			local var_106_2 = 0
			local var_106_3 = 0.625

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_2 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_4 = arg_103_1:GetWordFromCfg(321191025)
				local var_106_5 = arg_103_1:FormatText(var_106_4.content)

				arg_103_1.text_.text = var_106_5

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_7 = 25 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_5) / 25)

				if (25 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_5) / 25)) > 0 and var_106_3 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_2
					end
				end

				arg_103_1.text_.text = var_106_5
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191025", "story_v_out_321191.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_out_321191", "321191025", "story_v_out_321191.awb") / 1000

					if var_106_8 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_2
					end

					if var_106_4.prefab_name ~= "" and arg_103_1.actors_[var_106_4.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_4.prefab_name].transform, "story_v_out_321191", "321191025", "story_v_out_321191.awb")

						arg_103_1:RecordAudio("321191025", var_106_9)
						arg_103_1:RecordAudio("321191025", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_321191", "321191025", "story_v_out_321191.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_321191", "321191025", "story_v_out_321191.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_3, arg_103_1.talkMaxDuration)

			if var_106_2 <= arg_103_1.time_ and arg_103_1.time_ < var_106_2 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_2) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_2 + var_106_10 and arg_103_1.time_ < var_106_2 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play321191026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 321191026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play321191027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["10104ui_story"]) and arg_107_1.var_.characterEffect10104ui_story == nil then
				arg_107_1.var_.characterEffect10104ui_story = arg_107_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["10104ui_story"]) then
				if arg_107_1.var_.characterEffect10104ui_story and not isNil(arg_107_1.actors_["10104ui_story"]) then
					arg_107_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_107_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_0)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["10104ui_story"]) and arg_107_1.var_.characterEffect10104ui_story then
				arg_107_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_107_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_110_1 = 0
			local var_110_2 = 1.4

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_3 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(321191026).content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 56 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 56)

				if (56 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 56)) > 0 and var_110_2 < var_110_5 then
					arg_107_1.talkMaxDuration = var_110_5

					if var_110_5 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + var_110_1
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_6 = math.max(var_110_2, arg_107_1.talkMaxDuration)

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_6 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_1) / var_110_6

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_1 + var_110_6 and arg_107_1.time_ < var_110_1 + var_110_6 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play321191027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 321191027
		arg_111_1.duration_ = 10.93

		local var_111_0 = {
			zh = 7.6,
			ja = 10.933
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
				arg_111_0:Play321191028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["10104ui_story"]) and arg_111_1.var_.characterEffect10104ui_story == nil then
				arg_111_1.var_.characterEffect10104ui_story = arg_111_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["10104ui_story"]) then
				if arg_111_1.var_.characterEffect10104ui_story and not isNil(arg_111_1.actors_["10104ui_story"]) then
					arg_111_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["10104ui_story"]) and arg_111_1.var_.characterEffect10104ui_story then
				arg_111_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_114_2 = 0
			local var_114_3 = 0.825

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_4 = arg_111_1:GetWordFromCfg(321191027)
				local var_114_5 = arg_111_1:FormatText(var_114_4.content)

				arg_111_1.text_.text = var_114_5

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_7 = 33 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 33)

				if (33 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 33)) > 0 and var_114_3 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_2
					end
				end

				arg_111_1.text_.text = var_114_5
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191027", "story_v_out_321191.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_321191", "321191027", "story_v_out_321191.awb") / 1000

					if var_114_8 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_2
					end

					if var_114_4.prefab_name ~= "" and arg_111_1.actors_[var_114_4.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_4.prefab_name].transform, "story_v_out_321191", "321191027", "story_v_out_321191.awb")

						arg_111_1:RecordAudio("321191027", var_114_9)
						arg_111_1:RecordAudio("321191027", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_321191", "321191027", "story_v_out_321191.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_321191", "321191027", "story_v_out_321191.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_3, arg_111_1.talkMaxDuration)

			if var_114_2 <= arg_111_1.time_ and arg_111_1.time_ < var_114_2 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_2) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_2 + var_114_10 and arg_111_1.time_ < var_114_2 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play321191028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 321191028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play321191029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["10104ui_story"]) and arg_115_1.var_.characterEffect10104ui_story == nil then
				arg_115_1.var_.characterEffect10104ui_story = arg_115_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["10104ui_story"]) then
				if arg_115_1.var_.characterEffect10104ui_story and not isNil(arg_115_1.actors_["10104ui_story"]) then
					arg_115_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_115_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_0)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["10104ui_story"]) and arg_115_1.var_.characterEffect10104ui_story then
				arg_115_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_115_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_118_1 = 0
			local var_118_2 = 0.975

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_3 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(321191028).content)

				arg_115_1.text_.text = var_118_3

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 39 <= 0 and var_118_2 or var_118_2 * (utf8.len(var_118_3) / 39)

				if (39 <= 0 and var_118_2 or var_118_2 * (utf8.len(var_118_3) / 39)) > 0 and var_118_2 < var_118_5 then
					arg_115_1.talkMaxDuration = var_118_5

					if var_118_5 + var_118_1 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + var_118_1
					end
				end

				arg_115_1.text_.text = var_118_3
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_6 = math.max(var_118_2, arg_115_1.talkMaxDuration)

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_6 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_1) / var_118_6

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_1 + var_118_6 and arg_115_1.time_ < var_118_1 + var_118_6 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play321191029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 321191029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play321191030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.45

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_1 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(321191029).content)

				arg_119_1.text_.text = var_122_1

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_3 = 18 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 18)

				if (18 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 18)) > 0 and var_122_0 < var_122_3 then
					arg_119_1.talkMaxDuration = var_122_3

					if var_122_3 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_3 + 0
					end
				end

				arg_119_1.text_.text = var_122_1
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_4 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_4

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play321191030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 321191030
		arg_123_1.duration_ = 5.87

		local var_123_0 = {
			zh = 4.433,
			ja = 5.866
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
				arg_123_0:Play321191031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10104ui_story = arg_123_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10104ui_story"].transform.position).z)
				arg_123_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["10104ui_story"].transform.localEulerAngles = arg_123_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10104ui_story"].transform.position).z)
				arg_123_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["10104ui_story"].transform.localEulerAngles = arg_123_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_126_1 = 0
			local var_126_2 = 0.625

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_3 = arg_123_1:GetWordFromCfg(321191030)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_6 = 25 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_4) / 25)

				if (25 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_4) / 25)) > 0 and var_126_2 < var_126_6 then
					arg_123_1.talkMaxDuration = var_126_6

					if var_126_6 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191030", "story_v_out_321191.awb") ~= 0 then
					local var_126_7 = manager.audio:GetVoiceLength("story_v_out_321191", "321191030", "story_v_out_321191.awb") / 1000

					if var_126_7 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_1
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_321191", "321191030", "story_v_out_321191.awb")

						arg_123_1:RecordAudio("321191030", var_126_8)
						arg_123_1:RecordAudio("321191030", var_126_8)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_321191", "321191030", "story_v_out_321191.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_321191", "321191030", "story_v_out_321191.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_9 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_9 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_9

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_9 and arg_123_1.time_ < var_126_1 + var_126_9 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play321191031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 321191031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play321191032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 1.225

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(321191031).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 49 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 49)

				if (49 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 49)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play321191032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 321191032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play321191033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 1.025

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(321191032).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 41 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 41)

				if (41 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 41)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play321191033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 321191033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play321191034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.825

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_1 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(321191033).content)

				arg_135_1.text_.text = var_138_1

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_3 = 33 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 33)

				if (33 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 33)) > 0 and var_138_0 < var_138_3 then
					arg_135_1.talkMaxDuration = var_138_3

					if var_138_3 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_3 + 0
					end
				end

				arg_135_1.text_.text = var_138_1
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_4 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_4

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play321191034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 321191034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play321191035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 1.125

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(321191034).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 45 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 45)

				if (45 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 45)) > 0 and var_142_0 < var_142_3 then
					arg_139_1.talkMaxDuration = var_142_3

					if var_142_3 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_3 + 0
					end
				end

				arg_139_1.text_.text = var_142_1
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_4 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_4

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play321191035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 321191035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play321191036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.25

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_1 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(321191035).content)

				arg_143_1.text_.text = var_146_1

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_3 = 10 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 10)

				if (10 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 10)) > 0 and var_146_0 < var_146_3 then
					arg_143_1.talkMaxDuration = var_146_3

					if var_146_3 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_3 + 0
					end
				end

				arg_143_1.text_.text = var_146_1
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_4 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_4

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play321191036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 321191036
		arg_147_1.duration_ = 8.15

		local var_147_0 = {
			zh = 8.115999999999,
			ja = 8.149999999999
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
				arg_147_0:Play321191037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 2 < arg_147_1.time_ and arg_147_1.time_ <= 2 + arg_150_0 then
				local var_150_0 = arg_147_1.bgs_.L10g

				arg_147_1.bgs_.L10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_150_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_150_1 = var_150_0:GetComponent("SpriteRenderer")

				if var_150_1 and var_150_1.sprite then
					local var_150_2 = 2 * (var_150_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_150_0.transform.localScale = Vector3.New(var_150_2 / var_150_1.sprite.bounds.size.y < var_150_2 * manager.ui.mainCameraCom_.aspect / var_150_1.sprite.bounds.size.x and var_150_2 * manager.ui.mainCameraCom_.aspect / var_150_1.sprite.bounds.size.x or var_150_2 / var_150_1.sprite.bounds.size.y, var_150_2 / var_150_1.sprite.bounds.size.y < var_150_2 * manager.ui.mainCameraCom_.aspect / var_150_1.sprite.bounds.size.x and var_150_2 * manager.ui.mainCameraCom_.aspect / var_150_1.sprite.bounds.size.x or var_150_2 / var_150_1.sprite.bounds.size.y, 0)
				end

				for iter_150_0, iter_150_1 in pairs(arg_147_1.bgs_) do
					if iter_150_0 ~= "L10g" then
						iter_150_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_150_3 = 3.999999999999

			if 3.999999999999 < arg_147_1.time_ and arg_147_1.time_ <= var_150_3 + arg_150_0 then
				arg_147_1.allBtn_.enabled = false
			end

			if arg_147_1.time_ >= var_150_3 + 0.3 and arg_147_1.time_ < var_150_3 + 0.3 + arg_150_0 then
				arg_147_1.allBtn_.enabled = true
			end

			local var_150_4 = 0

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_5 = 2

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_5 then
				local var_150_6 = Color.New(0, 0, 0)

				var_150_6.a = Mathf.Lerp(0, 1, (arg_147_1.time_ - var_150_4) / var_150_5)
				arg_147_1.mask_.color = var_150_6
			end

			if arg_147_1.time_ >= var_150_4 + var_150_5 and arg_147_1.time_ < var_150_4 + var_150_5 + arg_150_0 then
				local var_150_7 = Color.New(0, 0, 0)

				var_150_7.a = 1
				arg_147_1.mask_.color = var_150_7
			end

			local var_150_8 = 2

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_9 = 2

			if var_150_8 <= arg_147_1.time_ and arg_147_1.time_ < var_150_8 + var_150_9 then
				local var_150_10 = Color.New(0, 0, 0)

				var_150_10.a = Mathf.Lerp(1, 0, (arg_147_1.time_ - var_150_8) / var_150_9)
				arg_147_1.mask_.color = var_150_10
			end

			if arg_147_1.time_ >= var_150_8 + var_150_9 and arg_147_1.time_ < var_150_8 + var_150_9 + arg_150_0 then
				local var_150_11 = Color.New(0, 0, 0)

				arg_147_1.mask_.enabled = false
				var_150_11.a = 0
				arg_147_1.mask_.color = var_150_11
			end

			if arg_147_1.frameCnt_ <= 1 then
				arg_147_1.dialog_:SetActive(false)
			end

			local var_150_12 = 3.949999999999
			local var_150_13 = 0.35

			if 3.949999999999 < arg_147_1.time_ and arg_147_1.time_ <= var_150_12 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				arg_147_1.dialog_:SetActive(true)

				arg_147_1.dialogCg_.alpha = 0

				local var_150_14 = LeanTween.value(arg_147_1.dialog_, 0, 1, 0.3)

				var_150_14:setOnUpdate(LuaHelper.FloatAction(function(arg_151_0)
					arg_147_1.dialogCg_.alpha = arg_151_0
				end))
				var_150_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_147_1.dialog_)
					var_150_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_147_1.duration_ = arg_147_1.duration_ + 0.3

				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_15 = arg_147_1:GetWordFromCfg(321191036)
				local var_150_16 = arg_147_1:FormatText(var_150_15.content)

				arg_147_1.text_.text = var_150_16

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_18 = 14 <= 0 and var_150_13 or var_150_13 * (utf8.len(var_150_16) / 14)

				if (14 <= 0 and var_150_13 or var_150_13 * (utf8.len(var_150_16) / 14)) > 0 and var_150_13 < var_150_18 then
					arg_147_1.talkMaxDuration = var_150_18
					var_150_12 = var_150_12 + 0.3

					if var_150_18 + var_150_12 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_18 + var_150_12
					end
				end

				arg_147_1.text_.text = var_150_16
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191036", "story_v_out_321191.awb") ~= 0 then
					local var_150_19 = manager.audio:GetVoiceLength("story_v_out_321191", "321191036", "story_v_out_321191.awb") / 1000

					if var_150_19 + var_150_12 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_19 + var_150_12
					end

					if var_150_15.prefab_name ~= "" and arg_147_1.actors_[var_150_15.prefab_name] ~= nil then
						local var_150_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_15.prefab_name].transform, "story_v_out_321191", "321191036", "story_v_out_321191.awb")

						arg_147_1:RecordAudio("321191036", var_150_20)
						arg_147_1:RecordAudio("321191036", var_150_20)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_321191", "321191036", "story_v_out_321191.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_321191", "321191036", "story_v_out_321191.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_21 = var_150_12 + 0.3
			local var_150_22 = math.max(var_150_13, arg_147_1.talkMaxDuration)

			if var_150_12 + 0.3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_21 + var_150_22 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_21) / var_150_22

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_21 + var_150_22 and arg_147_1.time_ < var_150_21 + var_150_22 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play321191037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 321191037
		arg_153_1.duration_ = 3.1

		local var_153_0 = {
			zh = 1.999999999999,
			ja = 3.1
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
				arg_153_0:Play321191038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1011ui_story = arg_153_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).z)
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles = arg_153_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
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

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_156_4 = 0
			local var_156_5 = 0.125

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
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

				local var_156_6 = arg_153_1:GetWordFromCfg(321191037)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 5 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 5)

				if (5 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 5)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191037", "story_v_out_321191.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_out_321191", "321191037", "story_v_out_321191.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_out_321191", "321191037", "story_v_out_321191.awb")

						arg_153_1:RecordAudio("321191037", var_156_11)
						arg_153_1:RecordAudio("321191037", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_321191", "321191037", "story_v_out_321191.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_321191", "321191037", "story_v_out_321191.awb")
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
	Play321191038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 321191038
		arg_157_1.duration_ = 4.13

		local var_157_0 = {
			zh = 2.966,
			ja = 4.133
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
				arg_157_0:Play321191039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1011ui_story"]) and arg_157_1.var_.characterEffect1011ui_story == nil then
				arg_157_1.var_.characterEffect1011ui_story = arg_157_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1011ui_story"]) then
				if arg_157_1.var_.characterEffect1011ui_story and not isNil(arg_157_1.actors_["1011ui_story"]) then
					arg_157_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_0)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1011ui_story"]) and arg_157_1.var_.characterEffect1011ui_story then
				arg_157_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_160_1 = 0
			local var_160_2 = 0.325

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_3 = arg_157_1:GetWordFromCfg(321191038)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_6 = 13 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_4) / 13)

				if (13 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_4) / 13)) > 0 and var_160_2 < var_160_6 then
					arg_157_1.talkMaxDuration = var_160_6

					if var_160_6 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191038", "story_v_out_321191.awb") ~= 0 then
					local var_160_7 = manager.audio:GetVoiceLength("story_v_out_321191", "321191038", "story_v_out_321191.awb") / 1000

					if var_160_7 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_1
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_321191", "321191038", "story_v_out_321191.awb")

						arg_157_1:RecordAudio("321191038", var_160_8)
						arg_157_1:RecordAudio("321191038", var_160_8)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_321191", "321191038", "story_v_out_321191.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_321191", "321191038", "story_v_out_321191.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_9 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_9 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_9

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_9 and arg_157_1.time_ < var_160_1 + var_160_9 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play321191039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 321191039
		arg_161_1.duration_ = 9.6

		local var_161_0 = {
			zh = 6.033,
			ja = 9.6
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
				arg_161_0:Play321191040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1011ui_story = arg_161_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1011ui_story"].transform.position).z)
				arg_161_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1011ui_story"].transform.localEulerAngles = arg_161_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
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

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_2")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_164_4 = 0
			local var_164_5 = 0.525

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
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

				local var_164_6 = arg_161_1:GetWordFromCfg(321191039)
				local var_164_7 = arg_161_1:FormatText(var_164_6.content)

				arg_161_1.text_.text = var_164_7

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 21 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 21)

				if (21 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 21)) > 0 and var_164_5 < var_164_9 then
					arg_161_1.talkMaxDuration = var_164_9

					if var_164_9 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_7
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191039", "story_v_out_321191.awb") ~= 0 then
					local var_164_10 = manager.audio:GetVoiceLength("story_v_out_321191", "321191039", "story_v_out_321191.awb") / 1000

					if var_164_10 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_4
					end

					if var_164_6.prefab_name ~= "" and arg_161_1.actors_[var_164_6.prefab_name] ~= nil then
						local var_164_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_6.prefab_name].transform, "story_v_out_321191", "321191039", "story_v_out_321191.awb")

						arg_161_1:RecordAudio("321191039", var_164_11)
						arg_161_1:RecordAudio("321191039", var_164_11)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_321191", "321191039", "story_v_out_321191.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_321191", "321191039", "story_v_out_321191.awb")
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
	Play321191040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 321191040
		arg_165_1.duration_ = 5.63

		local var_165_0 = {
			zh = 4.266,
			ja = 5.633
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
				arg_165_0:Play321191041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1011ui_story = arg_165_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).z)
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles = arg_165_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).z)
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles = arg_165_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1011ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1011ui_story == nil then
				arg_165_1.var_.characterEffect1011ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1011ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_2)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1011ui_story then
				arg_165_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_168_3 = 0
			local var_168_4 = 0.6

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_3 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1182].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_5 = arg_165_1:GetWordFromCfg(321191040)
				local var_168_6 = arg_165_1:FormatText(var_168_5.content)

				arg_165_1.text_.text = var_168_6

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_8 = 24 <= 0 and var_168_4 or var_168_4 * (utf8.len(var_168_6) / 24)

				if (24 <= 0 and var_168_4 or var_168_4 * (utf8.len(var_168_6) / 24)) > 0 and var_168_4 < var_168_8 then
					arg_165_1.talkMaxDuration = var_168_8

					if var_168_8 + var_168_3 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_3
					end
				end

				arg_165_1.text_.text = var_168_6
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191040", "story_v_out_321191.awb") ~= 0 then
					local var_168_9 = manager.audio:GetVoiceLength("story_v_out_321191", "321191040", "story_v_out_321191.awb") / 1000

					if var_168_9 + var_168_3 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_3
					end

					if var_168_5.prefab_name ~= "" and arg_165_1.actors_[var_168_5.prefab_name] ~= nil then
						local var_168_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_5.prefab_name].transform, "story_v_out_321191", "321191040", "story_v_out_321191.awb")

						arg_165_1:RecordAudio("321191040", var_168_10)
						arg_165_1:RecordAudio("321191040", var_168_10)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_321191", "321191040", "story_v_out_321191.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_321191", "321191040", "story_v_out_321191.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_11 = math.max(var_168_4, arg_165_1.talkMaxDuration)

			if var_168_3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_3 + var_168_11 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_3) / var_168_11

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_3 + var_168_11 and arg_165_1.time_ < var_168_3 + var_168_11 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
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

		arg_165_1:InitPlayNodeList()
	end,
	Play321191041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 321191041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play321191042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 1.375

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(321191041).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 55 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 55)

				if (55 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 55)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play321191042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 321191042
		arg_173_1.duration_ = 10.23

		local var_173_0 = {
			zh = 5.233,
			ja = 10.233
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
				arg_173_0:Play321191043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.5

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_1 = arg_173_1:GetWordFromCfg(321191042)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 20 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 20)

				if (20 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 20)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191042", "story_v_out_321191.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191042", "story_v_out_321191.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_out_321191", "321191042", "story_v_out_321191.awb")

						arg_173_1:RecordAudio("321191042", var_176_6)
						arg_173_1:RecordAudio("321191042", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_321191", "321191042", "story_v_out_321191.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_321191", "321191042", "story_v_out_321191.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play321191043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 321191043
		arg_177_1.duration_ = 4.3

		local var_177_0 = {
			zh = 2.7,
			ja = 4.3
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
				arg_177_0:Play321191044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.35

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1182].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_1 = arg_177_1:GetWordFromCfg(321191043)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 14 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 14)

				if (14 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 14)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191043", "story_v_out_321191.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191043", "story_v_out_321191.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_321191", "321191043", "story_v_out_321191.awb")

						arg_177_1:RecordAudio("321191043", var_180_6)
						arg_177_1:RecordAudio("321191043", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_321191", "321191043", "story_v_out_321191.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_321191", "321191043", "story_v_out_321191.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play321191044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 321191044
		arg_181_1.duration_ = 13.2

		local var_181_0 = {
			zh = 7.9,
			ja = 13.2
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
				arg_181_0:Play321191045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.95

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_1 = arg_181_1:GetWordFromCfg(321191044)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 38 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 38)

				if (38 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 38)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191044", "story_v_out_321191.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191044", "story_v_out_321191.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_321191", "321191044", "story_v_out_321191.awb")

						arg_181_1:RecordAudio("321191044", var_184_6)
						arg_181_1:RecordAudio("321191044", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_321191", "321191044", "story_v_out_321191.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_321191", "321191044", "story_v_out_321191.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play321191045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 321191045
		arg_185_1.duration_ = 4.1

		local var_185_0 = {
			zh = 2.166,
			ja = 4.1
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
				arg_185_0:Play321191046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.25

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1182].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_1 = arg_185_1:GetWordFromCfg(321191045)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 10 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 10)

				if (10 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 10)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191045", "story_v_out_321191.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191045", "story_v_out_321191.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_321191", "321191045", "story_v_out_321191.awb")

						arg_185_1:RecordAudio("321191045", var_188_6)
						arg_185_1:RecordAudio("321191045", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_321191", "321191045", "story_v_out_321191.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_321191", "321191045", "story_v_out_321191.awb")
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
	Play321191046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 321191046
		arg_189_1.duration_ = 16.37

		local var_189_0 = {
			zh = 8.066,
			ja = 16.366
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
				arg_189_0:Play321191047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 1

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:GetWordFromCfg(321191046)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 40 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 40)

				if (40 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 40)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191046", "story_v_out_321191.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191046", "story_v_out_321191.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_321191", "321191046", "story_v_out_321191.awb")

						arg_189_1:RecordAudio("321191046", var_192_6)
						arg_189_1:RecordAudio("321191046", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_321191", "321191046", "story_v_out_321191.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_321191", "321191046", "story_v_out_321191.awb")
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
	Play321191047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 321191047
		arg_193_1.duration_ = 2.73

		local var_193_0 = {
			zh = 2.466,
			ja = 2.733
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
				arg_193_0:Play321191048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.225

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1182].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_1 = arg_193_1:GetWordFromCfg(321191047)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 9 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 9)

				if (9 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 9)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191047", "story_v_out_321191.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191047", "story_v_out_321191.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_out_321191", "321191047", "story_v_out_321191.awb")

						arg_193_1:RecordAudio("321191047", var_196_6)
						arg_193_1:RecordAudio("321191047", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_321191", "321191047", "story_v_out_321191.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_321191", "321191047", "story_v_out_321191.awb")
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
	Play321191048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 321191048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play321191049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.95

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

				local var_200_1 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(321191048).content)

				arg_197_1.text_.text = var_200_1

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_3 = 38 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 38)

				if (38 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 38)) > 0 and var_200_0 < var_200_3 then
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
	Play321191049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 321191049
		arg_201_1.duration_ = 2.47

		local var_201_0 = {
			zh = 2.366,
			ja = 2.466
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
				arg_201_0:Play321191050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.275

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_1 = arg_201_1:GetWordFromCfg(321191049)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 11 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 11)

				if (11 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 11)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191049", "story_v_out_321191.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191049", "story_v_out_321191.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_321191", "321191049", "story_v_out_321191.awb")

						arg_201_1:RecordAudio("321191049", var_204_6)
						arg_201_1:RecordAudio("321191049", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_321191", "321191049", "story_v_out_321191.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_321191", "321191049", "story_v_out_321191.awb")
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
	Play321191050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 321191050
		arg_205_1.duration_ = 10.33

		local var_205_0 = {
			zh = 7.066,
			ja = 10.333
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
				arg_205_0:Play321191051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.875

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_1 = arg_205_1:GetWordFromCfg(321191050)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 35 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 35)

				if (35 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 35)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191050", "story_v_out_321191.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191050", "story_v_out_321191.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_321191", "321191050", "story_v_out_321191.awb")

						arg_205_1:RecordAudio("321191050", var_208_6)
						arg_205_1:RecordAudio("321191050", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_321191", "321191050", "story_v_out_321191.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_321191", "321191050", "story_v_out_321191.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play321191051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 321191051
		arg_209_1.duration_ = 12.93

		local var_209_0 = {
			zh = 10.2,
			ja = 12.933
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
				arg_209_0:Play321191052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 1.225

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_1 = arg_209_1:GetWordFromCfg(321191051)
				local var_212_2 = arg_209_1:FormatText(var_212_1.content)

				arg_209_1.text_.text = var_212_2

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 49 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 49)

				if (49 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 49)) > 0 and var_212_0 < var_212_4 then
					arg_209_1.talkMaxDuration = var_212_4

					if var_212_4 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_4 + 0
					end
				end

				arg_209_1.text_.text = var_212_2
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191051", "story_v_out_321191.awb") ~= 0 then
					local var_212_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191051", "story_v_out_321191.awb") / 1000

					if var_212_5 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + 0
					end

					if var_212_1.prefab_name ~= "" and arg_209_1.actors_[var_212_1.prefab_name] ~= nil then
						local var_212_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_1.prefab_name].transform, "story_v_out_321191", "321191051", "story_v_out_321191.awb")

						arg_209_1:RecordAudio("321191051", var_212_6)
						arg_209_1:RecordAudio("321191051", var_212_6)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_321191", "321191051", "story_v_out_321191.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_321191", "321191051", "story_v_out_321191.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play321191052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 321191052
		arg_213_1.duration_ = 13.77

		local var_213_0 = {
			zh = 9.466,
			ja = 13.766
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
				arg_213_0:Play321191053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.9

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_1 = arg_213_1:GetWordFromCfg(321191052)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 36 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 36)

				if (36 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 36)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191052", "story_v_out_321191.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191052", "story_v_out_321191.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_out_321191", "321191052", "story_v_out_321191.awb")

						arg_213_1:RecordAudio("321191052", var_216_6)
						arg_213_1:RecordAudio("321191052", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_321191", "321191052", "story_v_out_321191.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_321191", "321191052", "story_v_out_321191.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play321191053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 321191053
		arg_217_1.duration_ = 7.83

		local var_217_0 = {
			zh = 5.6,
			ja = 7.833
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
				arg_217_0:Play321191054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.475

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_1 = arg_217_1:GetWordFromCfg(321191053)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 19 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 19)

				if (19 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 19)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191053", "story_v_out_321191.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191053", "story_v_out_321191.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_out_321191", "321191053", "story_v_out_321191.awb")

						arg_217_1:RecordAudio("321191053", var_220_6)
						arg_217_1:RecordAudio("321191053", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_321191", "321191053", "story_v_out_321191.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_321191", "321191053", "story_v_out_321191.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play321191054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 321191054
		arg_221_1.duration_ = 11.17

		local var_221_0 = {
			zh = 6.466,
			ja = 11.166
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
				arg_221_0:Play321191055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1011ui_story = arg_221_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1011ui_story"].transform.position).z)
				arg_221_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1011ui_story"].transform.localEulerAngles = arg_221_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_221_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1011ui_story"].transform.position).z)
				arg_221_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1011ui_story"].transform.localEulerAngles = arg_221_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["1011ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1011ui_story == nil then
				arg_221_1.var_.characterEffect1011ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect1011ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1011ui_story then
				arg_221_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_224_4 = 0
			local var_224_5 = 0.625

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_6 = arg_221_1:GetWordFromCfg(321191054)
				local var_224_7 = arg_221_1:FormatText(var_224_6.content)

				arg_221_1.text_.text = var_224_7

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_9 = 25 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 25)

				if (25 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 25)) > 0 and var_224_5 < var_224_9 then
					arg_221_1.talkMaxDuration = var_224_9

					if var_224_9 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_9 + var_224_4
					end
				end

				arg_221_1.text_.text = var_224_7
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191054", "story_v_out_321191.awb") ~= 0 then
					local var_224_10 = manager.audio:GetVoiceLength("story_v_out_321191", "321191054", "story_v_out_321191.awb") / 1000

					if var_224_10 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_4
					end

					if var_224_6.prefab_name ~= "" and arg_221_1.actors_[var_224_6.prefab_name] ~= nil then
						local var_224_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_6.prefab_name].transform, "story_v_out_321191", "321191054", "story_v_out_321191.awb")

						arg_221_1:RecordAudio("321191054", var_224_11)
						arg_221_1:RecordAudio("321191054", var_224_11)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_321191", "321191054", "story_v_out_321191.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_321191", "321191054", "story_v_out_321191.awb")
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

		arg_221_1.nodeConfigList_ = {
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

		arg_221_1:InitPlayNodeList()
	end,
	Play321191055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 321191055
		arg_225_1.duration_ = 9.23

		local var_225_0 = {
			zh = 6.433,
			ja = 9.233
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
				arg_225_0:Play321191056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1011ui_story"]) and arg_225_1.var_.characterEffect1011ui_story == nil then
				arg_225_1.var_.characterEffect1011ui_story = arg_225_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1011ui_story"]) then
				if arg_225_1.var_.characterEffect1011ui_story and not isNil(arg_225_1.actors_["1011ui_story"]) then
					arg_225_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1011ui_story"]) and arg_225_1.var_.characterEffect1011ui_story then
				arg_225_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_228_1 = 0
			local var_228_2 = 0.675

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:GetWordFromCfg(321191055)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_6 = 27 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_4) / 27)

				if (27 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_4) / 27)) > 0 and var_228_2 < var_228_6 then
					arg_225_1.talkMaxDuration = var_228_6

					if var_228_6 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_6 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191055", "story_v_out_321191.awb") ~= 0 then
					local var_228_7 = manager.audio:GetVoiceLength("story_v_out_321191", "321191055", "story_v_out_321191.awb") / 1000

					if var_228_7 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_1
					end

					if var_228_3.prefab_name ~= "" and arg_225_1.actors_[var_228_3.prefab_name] ~= nil then
						local var_228_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_3.prefab_name].transform, "story_v_out_321191", "321191055", "story_v_out_321191.awb")

						arg_225_1:RecordAudio("321191055", var_228_8)
						arg_225_1:RecordAudio("321191055", var_228_8)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_321191", "321191055", "story_v_out_321191.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_321191", "321191055", "story_v_out_321191.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_9 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_9 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_9

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_9 and arg_225_1.time_ < var_228_1 + var_228_9 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play321191056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 321191056
		arg_229_1.duration_ = 9

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play321191057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 2 < arg_229_1.time_ and arg_229_1.time_ <= 2 + arg_232_0 then
				local var_232_0 = arg_229_1.bgs_.ST73

				arg_229_1.bgs_.ST73.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_232_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_232_1 = var_232_0:GetComponent("SpriteRenderer")

				if var_232_1 and var_232_1.sprite then
					local var_232_2 = 2 * (var_232_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_232_0.transform.localScale = Vector3.New(var_232_2 / var_232_1.sprite.bounds.size.y < var_232_2 * manager.ui.mainCameraCom_.aspect / var_232_1.sprite.bounds.size.x and var_232_2 * manager.ui.mainCameraCom_.aspect / var_232_1.sprite.bounds.size.x or var_232_2 / var_232_1.sprite.bounds.size.y, var_232_2 / var_232_1.sprite.bounds.size.y < var_232_2 * manager.ui.mainCameraCom_.aspect / var_232_1.sprite.bounds.size.x and var_232_2 * manager.ui.mainCameraCom_.aspect / var_232_1.sprite.bounds.size.x or var_232_2 / var_232_1.sprite.bounds.size.y, 0)
				end

				for iter_232_0, iter_232_1 in pairs(arg_229_1.bgs_) do
					if iter_232_0 ~= "ST73" then
						iter_232_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_232_3 = 3.999999999999

			if 3.999999999999 < arg_229_1.time_ and arg_229_1.time_ <= var_232_3 + arg_232_0 then
				arg_229_1.allBtn_.enabled = false
			end

			if arg_229_1.time_ >= var_232_3 + 0.3 and arg_229_1.time_ < var_232_3 + 0.3 + arg_232_0 then
				arg_229_1.allBtn_.enabled = true
			end

			local var_232_4 = 0

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_5 = 2

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_5 then
				local var_232_6 = Color.New(0, 0, 0)

				var_232_6.a = Mathf.Lerp(0, 1, (arg_229_1.time_ - var_232_4) / var_232_5)
				arg_229_1.mask_.color = var_232_6
			end

			if arg_229_1.time_ >= var_232_4 + var_232_5 and arg_229_1.time_ < var_232_4 + var_232_5 + arg_232_0 then
				local var_232_7 = Color.New(0, 0, 0)

				var_232_7.a = 1
				arg_229_1.mask_.color = var_232_7
			end

			local var_232_8 = 2

			if 2 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_9 = 2

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_9 then
				local var_232_10 = Color.New(0, 0, 0)

				var_232_10.a = Mathf.Lerp(1, 0, (arg_229_1.time_ - var_232_8) / var_232_9)
				arg_229_1.mask_.color = var_232_10
			end

			if arg_229_1.time_ >= var_232_8 + var_232_9 and arg_229_1.time_ < var_232_8 + var_232_9 + arg_232_0 then
				local var_232_11 = Color.New(0, 0, 0)

				arg_229_1.mask_.enabled = false
				var_232_11.a = 0
				arg_229_1.mask_.color = var_232_11
			end

			local var_232_12 = arg_229_1.actors_["1011ui_story"].transform

			if 1.96599999815226 < arg_229_1.time_ and arg_229_1.time_ <= 1.96599999815226 + arg_232_0 then
				arg_229_1.var_.moveOldPos1011ui_story = var_232_12.localPosition
			end

			local var_232_13 = 0.001

			if 1.96599999815226 <= arg_229_1.time_ and arg_229_1.time_ < 1.96599999815226 + var_232_13 then
				var_232_12.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_229_1.time_ - 1.96599999815226) / var_232_13)
				var_232_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_12.position).x, (manager.ui.mainCamera.transform.position - var_232_12.position).y, (manager.ui.mainCamera.transform.position - var_232_12.position).z)
				var_232_12.localEulerAngles.z = 0
				var_232_12.localEulerAngles.x = 0
				var_232_12.localEulerAngles = var_232_12.localEulerAngles
			end

			if arg_229_1.time_ >= 1.96599999815226 + var_232_13 and arg_229_1.time_ < 1.96599999815226 + var_232_13 + arg_232_0 then
				var_232_12.localPosition = Vector3.New(0, 100, 0)
				var_232_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_12.position).x, (manager.ui.mainCamera.transform.position - var_232_12.position).y, (manager.ui.mainCamera.transform.position - var_232_12.position).z)
				var_232_12.localEulerAngles.z = 0
				var_232_12.localEulerAngles.x = 0
				var_232_12.localEulerAngles = var_232_12.localEulerAngles
			end

			if arg_229_1.frameCnt_ <= 1 then
				arg_229_1.dialog_:SetActive(false)
			end

			local var_232_14 = 4
			local var_232_15 = 0.8

			if 4 < arg_229_1.time_ and arg_229_1.time_ <= var_232_14 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				arg_229_1.dialog_:SetActive(true)

				arg_229_1.dialogCg_.alpha = 0

				local var_232_16 = LeanTween.value(arg_229_1.dialog_, 0, 1, 0.3)

				var_232_16:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_229_1.dialogCg_.alpha = arg_233_0
				end))
				var_232_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_229_1.dialog_)
					var_232_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_229_1.duration_ = arg_229_1.duration_ + 0.3

				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_17 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(321191056).content)

				arg_229_1.text_.text = var_232_17

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_19 = 32 <= 0 and var_232_15 or var_232_15 * (utf8.len(var_232_17) / 32)

				if (32 <= 0 and var_232_15 or var_232_15 * (utf8.len(var_232_17) / 32)) > 0 and var_232_15 < var_232_19 then
					arg_229_1.talkMaxDuration = var_232_19
					var_232_14 = var_232_14 + 0.3

					if var_232_19 + var_232_14 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_19 + var_232_14
					end
				end

				arg_229_1.text_.text = var_232_17
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_20 = var_232_14 + 0.3
			local var_232_21 = math.max(var_232_15, arg_229_1.talkMaxDuration)

			if var_232_14 + 0.3 <= arg_229_1.time_ and arg_229_1.time_ < var_232_20 + var_232_21 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_20) / var_232_21

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_20 + var_232_21 and arg_229_1.time_ < var_232_20 + var_232_21 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play321191057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 321191057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play321191058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 1.3

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(321191057).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 52 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 52)

				if (52 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 52)) > 0 and var_238_0 < var_238_3 then
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
	Play321191058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 321191058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play321191059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 1.025

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(321191058).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 41 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 41)

				if (41 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 41)) > 0 and var_242_0 < var_242_3 then
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
	Play321191059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 321191059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play321191060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.875

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_1 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(321191059).content)

				arg_243_1.text_.text = var_246_1

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_3 = 35 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 35)

				if (35 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 35)) > 0 and var_246_0 < var_246_3 then
					arg_243_1.talkMaxDuration = var_246_3

					if var_246_3 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_3 + 0
					end
				end

				arg_243_1.text_.text = var_246_1
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_4 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_4 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_4

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_4 and arg_243_1.time_ < 0 + var_246_4 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play321191060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 321191060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play321191061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0.95

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_1 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(321191060).content)

				arg_247_1.text_.text = var_250_1

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_3 = 38 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 38)

				if (38 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 38)) > 0 and var_250_0 < var_250_3 then
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
	Play321191061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 321191061
		arg_251_1.duration_ = 3.33

		local var_251_0 = {
			zh = 2.4,
			ja = 3.333
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
				arg_251_0:Play321191062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if arg_251_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_254_0 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_251_1.stage_.transform)

				var_254_0.name = "1284ui_story"
				var_254_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_251_1.actors_["1284ui_story"] = var_254_0

				local var_254_1 = var_254_0:GetComponentInChildren(typeof(CharacterEffect))

				var_254_1.enabled = true

				local var_254_2 = GameObjectTools.GetOrAddComponent(var_254_0, typeof(DynamicBoneHelper))

				if var_254_2 then
					var_254_2:EnableDynamicBone(false)
				end

				arg_251_1:ShowWeapon(var_254_1.transform, false)

				arg_251_1.var_["1284ui_story" .. "Animator"] = var_254_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_251_1.var_["1284ui_story" .. "Animator"].applyRootMotion = true
				arg_251_1.var_["1284ui_story" .. "LipSync"] = var_254_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_254_3 = arg_251_1.actors_["1284ui_story"].transform

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1284ui_story = var_254_3.localPosition
			end

			local var_254_4 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_4 then
				var_254_3.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_251_1.time_ - 0) / var_254_4)
				var_254_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_3.position).x, (manager.ui.mainCamera.transform.position - var_254_3.position).y, (manager.ui.mainCamera.transform.position - var_254_3.position).z)
				var_254_3.localEulerAngles.z = 0
				var_254_3.localEulerAngles.x = 0
				var_254_3.localEulerAngles = var_254_3.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_4 and arg_251_1.time_ < 0 + var_254_4 + arg_254_0 then
				var_254_3.localPosition = Vector3.New(0, -0.985, -6.22)
				var_254_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_3.position).x, (manager.ui.mainCamera.transform.position - var_254_3.position).y, (manager.ui.mainCamera.transform.position - var_254_3.position).z)
				var_254_3.localEulerAngles.z = 0
				var_254_3.localEulerAngles.x = 0
				var_254_3.localEulerAngles = var_254_3.localEulerAngles
			end

			local var_254_5 = arg_251_1.actors_["1284ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_5) and arg_251_1.var_.characterEffect1284ui_story == nil then
				arg_251_1.var_.characterEffect1284ui_story = var_254_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_6 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_6 and not isNil(var_254_5) then
				if arg_251_1.var_.characterEffect1284ui_story and not isNil(var_254_5) then
					arg_251_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_6 and arg_251_1.time_ < 0 + var_254_6 + arg_254_0 and not isNil(var_254_5) and arg_251_1.var_.characterEffect1284ui_story then
				arg_251_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_254_8 = 0
			local var_254_9 = 0.25

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_8 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_10 = arg_251_1:GetWordFromCfg(321191061)
				local var_254_11 = arg_251_1:FormatText(var_254_10.content)

				arg_251_1.text_.text = var_254_11

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_13 = 10 <= 0 and var_254_9 or var_254_9 * (utf8.len(var_254_11) / 10)

				if (10 <= 0 and var_254_9 or var_254_9 * (utf8.len(var_254_11) / 10)) > 0 and var_254_9 < var_254_13 then
					arg_251_1.talkMaxDuration = var_254_13

					if var_254_13 + var_254_8 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_13 + var_254_8
					end
				end

				arg_251_1.text_.text = var_254_11
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191061", "story_v_out_321191.awb") ~= 0 then
					local var_254_14 = manager.audio:GetVoiceLength("story_v_out_321191", "321191061", "story_v_out_321191.awb") / 1000

					if var_254_14 + var_254_8 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_14 + var_254_8
					end

					if var_254_10.prefab_name ~= "" and arg_251_1.actors_[var_254_10.prefab_name] ~= nil then
						local var_254_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_10.prefab_name].transform, "story_v_out_321191", "321191061", "story_v_out_321191.awb")

						arg_251_1:RecordAudio("321191061", var_254_15)
						arg_251_1:RecordAudio("321191061", var_254_15)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_321191", "321191061", "story_v_out_321191.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_321191", "321191061", "story_v_out_321191.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_16 = math.max(var_254_9, arg_251_1.talkMaxDuration)

			if var_254_8 <= arg_251_1.time_ and arg_251_1.time_ < var_254_8 + var_254_16 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_8) / var_254_16

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_8 + var_254_16 and arg_251_1.time_ < var_254_8 + var_254_16 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
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

		arg_251_1:InitPlayNodeList()
	end,
	Play321191062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 321191062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play321191063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1284ui_story"]) and arg_255_1.var_.characterEffect1284ui_story == nil then
				arg_255_1.var_.characterEffect1284ui_story = arg_255_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1284ui_story"]) then
				if arg_255_1.var_.characterEffect1284ui_story and not isNil(arg_255_1.actors_["1284ui_story"]) then
					arg_255_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_0)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1284ui_story"]) and arg_255_1.var_.characterEffect1284ui_story then
				arg_255_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_258_1 = 0
			local var_258_2 = 0.875

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_3 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(321191062).content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 35 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 35)

				if (35 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 35)) > 0 and var_258_2 < var_258_5 then
					arg_255_1.talkMaxDuration = var_258_5

					if var_258_5 + var_258_1 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + var_258_1
					end
				end

				arg_255_1.text_.text = var_258_3
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_6 = math.max(var_258_2, arg_255_1.talkMaxDuration)

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_6 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_1) / var_258_6

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_1 + var_258_6 and arg_255_1.time_ < var_258_1 + var_258_6 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play321191063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 321191063
		arg_259_1.duration_ = 1.6

		local var_259_0 = {
			zh = 0.999999999999,
			ja = 1.6
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
				arg_259_0:Play321191064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.075

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_1 = arg_259_1:GetWordFromCfg(321191063)
				local var_262_2 = arg_259_1:FormatText(var_262_1.content)

				arg_259_1.text_.text = var_262_2

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 3 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 3)

				if (3 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 3)) > 0 and var_262_0 < var_262_4 then
					arg_259_1.talkMaxDuration = var_262_4

					if var_262_4 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_4 + 0
					end
				end

				arg_259_1.text_.text = var_262_2
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191063", "story_v_out_321191.awb") ~= 0 then
					local var_262_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191063", "story_v_out_321191.awb") / 1000

					if var_262_5 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + 0
					end

					if var_262_1.prefab_name ~= "" and arg_259_1.actors_[var_262_1.prefab_name] ~= nil then
						local var_262_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_1.prefab_name].transform, "story_v_out_321191", "321191063", "story_v_out_321191.awb")

						arg_259_1:RecordAudio("321191063", var_262_6)
						arg_259_1:RecordAudio("321191063", var_262_6)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_321191", "321191063", "story_v_out_321191.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_321191", "321191063", "story_v_out_321191.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_7 and arg_259_1.time_ < 0 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play321191064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 321191064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play321191065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1284ui_story = arg_263_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1284ui_story"].transform.position).z)
				arg_263_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1284ui_story"].transform.localEulerAngles = arg_263_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_263_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1284ui_story"].transform.position).z)
				arg_263_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1284ui_story"].transform.localEulerAngles = arg_263_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["10104ui_story"].transform

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos10104ui_story = var_266_1.localPosition
			end

			local var_266_2 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 then
				var_266_1.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_263_1.time_ - 0) / var_266_2)
				var_266_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_1.position).x, (manager.ui.mainCamera.transform.position - var_266_1.position).y, (manager.ui.mainCamera.transform.position - var_266_1.position).z)
				var_266_1.localEulerAngles.z = 0
				var_266_1.localEulerAngles.x = 0
				var_266_1.localEulerAngles = var_266_1.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 then
				var_266_1.localPosition = Vector3.New(0, 100, 0)
				var_266_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_1.position).x, (manager.ui.mainCamera.transform.position - var_266_1.position).y, (manager.ui.mainCamera.transform.position - var_266_1.position).z)
				var_266_1.localEulerAngles.z = 0
				var_266_1.localEulerAngles.x = 0
				var_266_1.localEulerAngles = var_266_1.localEulerAngles
			end

			local var_266_3 = arg_263_1.actors_["10104ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_3) and arg_263_1.var_.characterEffect10104ui_story == nil then
				arg_263_1.var_.characterEffect10104ui_story = var_266_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_4 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 and not isNil(var_266_3) then
				if arg_263_1.var_.characterEffect10104ui_story and not isNil(var_266_3) then
					arg_263_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_263_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_4)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 and not isNil(var_266_3) and arg_263_1.var_.characterEffect10104ui_story then
				arg_263_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_263_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0.525 < arg_263_1.time_ and arg_263_1.time_ <= 0.525 + arg_266_0 then
				arg_263_1:AudioAction("play", "effect", "se_story_140", "se_story_140_box", "")
			end

			local var_266_6 = 0
			local var_266_7 = 1.525

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_6 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_8 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(321191064).content)

				arg_263_1.text_.text = var_266_8

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_10 = 61 <= 0 and var_266_7 or var_266_7 * (utf8.len(var_266_8) / 61)

				if (61 <= 0 and var_266_7 or var_266_7 * (utf8.len(var_266_8) / 61)) > 0 and var_266_7 < var_266_10 then
					arg_263_1.talkMaxDuration = var_266_10

					if var_266_10 + var_266_6 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_6
					end
				end

				arg_263_1.text_.text = var_266_8
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_11 = math.max(var_266_7, arg_263_1.talkMaxDuration)

			if var_266_6 <= arg_263_1.time_ and arg_263_1.time_ < var_266_6 + var_266_11 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_6) / var_266_11

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_6 + var_266_11 and arg_263_1.time_ < var_266_6 + var_266_11 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
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

		arg_263_1:InitPlayNodeList()
	end,
	Play321191065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 321191065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play321191066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0.725

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_1 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(321191065).content)

				arg_267_1.text_.text = var_270_1

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_3 = 29 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 29)

				if (29 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 29)) > 0 and var_270_0 < var_270_3 then
					arg_267_1.talkMaxDuration = var_270_3

					if var_270_3 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_3 + 0
					end
				end

				arg_267_1.text_.text = var_270_1
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_4 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_4

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play321191066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 321191066
		arg_271_1.duration_ = 15.43

		local var_271_0 = {
			zh = 11.033,
			ja = 15.433
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
				arg_271_0:Play321191067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos10104ui_story = arg_271_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_274_0 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 then
				arg_271_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_271_1.time_ - 0) / var_274_0)
				arg_271_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["10104ui_story"].transform.position).z)
				arg_271_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["10104ui_story"].transform.localEulerAngles = arg_271_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 then
				arg_271_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_271_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["10104ui_story"].transform.position).z)
				arg_271_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["10104ui_story"].transform.localEulerAngles = arg_271_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_274_1 = arg_271_1.actors_["10104ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect10104ui_story == nil then
				arg_271_1.var_.characterEffect10104ui_story = var_274_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_2 and not isNil(var_274_1) then
				if arg_271_1.var_.characterEffect10104ui_story and not isNil(var_274_1) then
					arg_271_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_2 and arg_271_1.time_ < 0 + var_274_2 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect10104ui_story then
				arg_271_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_274_4 = 0
			local var_274_5 = 1.375

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_6 = arg_271_1:GetWordFromCfg(321191066)
				local var_274_7 = arg_271_1:FormatText(var_274_6.content)

				arg_271_1.text_.text = var_274_7

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_9 = 55 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 55)

				if (55 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 55)) > 0 and var_274_5 < var_274_9 then
					arg_271_1.talkMaxDuration = var_274_9

					if var_274_9 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_9 + var_274_4
					end
				end

				arg_271_1.text_.text = var_274_7
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191066", "story_v_out_321191.awb") ~= 0 then
					local var_274_10 = manager.audio:GetVoiceLength("story_v_out_321191", "321191066", "story_v_out_321191.awb") / 1000

					if var_274_10 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_4
					end

					if var_274_6.prefab_name ~= "" and arg_271_1.actors_[var_274_6.prefab_name] ~= nil then
						local var_274_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_6.prefab_name].transform, "story_v_out_321191", "321191066", "story_v_out_321191.awb")

						arg_271_1:RecordAudio("321191066", var_274_11)
						arg_271_1:RecordAudio("321191066", var_274_11)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_321191", "321191066", "story_v_out_321191.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_321191", "321191066", "story_v_out_321191.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_12 = math.max(var_274_5, arg_271_1.talkMaxDuration)

			if var_274_4 <= arg_271_1.time_ and arg_271_1.time_ < var_274_4 + var_274_12 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_4) / var_274_12

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_4 + var_274_12 and arg_271_1.time_ < var_274_4 + var_274_12 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
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

		arg_271_1:InitPlayNodeList()
	end,
	Play321191067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 321191067
		arg_275_1.duration_ = 15.97

		local var_275_0 = {
			zh = 8.433,
			ja = 15.966
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play321191068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos10104ui_story = arg_275_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["10104ui_story"].transform.position).z)
				arg_275_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["10104ui_story"].transform.localEulerAngles = arg_275_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_275_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["10104ui_story"].transform.position).z)
				arg_275_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["10104ui_story"].transform.localEulerAngles = arg_275_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_278_1 = 0
			local var_278_2 = 1.175

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_3 = arg_275_1:GetWordFromCfg(321191067)
				local var_278_4 = arg_275_1:FormatText(var_278_3.content)

				arg_275_1.text_.text = var_278_4

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_6 = 47 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_4) / 47)

				if (47 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_4) / 47)) > 0 and var_278_2 < var_278_6 then
					arg_275_1.talkMaxDuration = var_278_6

					if var_278_6 + var_278_1 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_6 + var_278_1
					end
				end

				arg_275_1.text_.text = var_278_4
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191067", "story_v_out_321191.awb") ~= 0 then
					local var_278_7 = manager.audio:GetVoiceLength("story_v_out_321191", "321191067", "story_v_out_321191.awb") / 1000

					if var_278_7 + var_278_1 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_1
					end

					if var_278_3.prefab_name ~= "" and arg_275_1.actors_[var_278_3.prefab_name] ~= nil then
						local var_278_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_3.prefab_name].transform, "story_v_out_321191", "321191067", "story_v_out_321191.awb")

						arg_275_1:RecordAudio("321191067", var_278_8)
						arg_275_1:RecordAudio("321191067", var_278_8)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_321191", "321191067", "story_v_out_321191.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_321191", "321191067", "story_v_out_321191.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_9 = math.max(var_278_2, arg_275_1.talkMaxDuration)

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_9 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_1) / var_278_9

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_1 + var_278_9 and arg_275_1.time_ < var_278_1 + var_278_9 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
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

		arg_275_1:InitPlayNodeList()
	end,
	Play321191068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 321191068
		arg_279_1.duration_ = 4.5

		local var_279_0 = {
			zh = 2.733,
			ja = 4.5
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
				arg_279_0:Play321191069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1284ui_story = arg_279_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1284ui_story"].transform.position).z)
				arg_279_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1284ui_story"].transform.localEulerAngles = arg_279_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
				arg_279_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1284ui_story"].transform.position).z)
				arg_279_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1284ui_story"].transform.localEulerAngles = arg_279_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_282_1 = arg_279_1.actors_["10104ui_story"].transform

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos10104ui_story = var_282_1.localPosition
			end

			local var_282_2 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 then
				var_282_1.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10104ui_story, Vector3.New(-0.88, -1.12, -5.99), (arg_279_1.time_ - 0) / var_282_2)
				var_282_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_1.position).x, (manager.ui.mainCamera.transform.position - var_282_1.position).y, (manager.ui.mainCamera.transform.position - var_282_1.position).z)
				var_282_1.localEulerAngles.z = 0
				var_282_1.localEulerAngles.x = 0
				var_282_1.localEulerAngles = var_282_1.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 then
				var_282_1.localPosition = Vector3.New(-0.88, -1.12, -5.99)
				var_282_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_1.position).x, (manager.ui.mainCamera.transform.position - var_282_1.position).y, (manager.ui.mainCamera.transform.position - var_282_1.position).z)
				var_282_1.localEulerAngles.z = 0
				var_282_1.localEulerAngles.x = 0
				var_282_1.localEulerAngles = var_282_1.localEulerAngles
			end

			local var_282_3 = arg_279_1.actors_["1284ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_3) and arg_279_1.var_.characterEffect1284ui_story == nil then
				arg_279_1.var_.characterEffect1284ui_story = var_282_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_4 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 and not isNil(var_282_3) then
				if arg_279_1.var_.characterEffect1284ui_story and not isNil(var_282_3) then
					arg_279_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 and not isNil(var_282_3) and arg_279_1.var_.characterEffect1284ui_story then
				arg_279_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_282_6 = arg_279_1.actors_["10104ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_6) and arg_279_1.var_.characterEffect10104ui_story == nil then
				arg_279_1.var_.characterEffect10104ui_story = var_282_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_7 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_7 and not isNil(var_282_6) then
				if arg_279_1.var_.characterEffect10104ui_story and not isNil(var_282_6) then
					arg_279_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_279_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_7)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_7 and arg_279_1.time_ < 0 + var_282_7 + arg_282_0 and not isNil(var_282_6) and arg_279_1.var_.characterEffect10104ui_story then
				arg_279_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_279_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_282_8 = 0
			local var_282_9 = 0.4

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_8 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_10 = arg_279_1:GetWordFromCfg(321191068)
				local var_282_11 = arg_279_1:FormatText(var_282_10.content)

				arg_279_1.text_.text = var_282_11

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_13 = 16 <= 0 and var_282_9 or var_282_9 * (utf8.len(var_282_11) / 16)

				if (16 <= 0 and var_282_9 or var_282_9 * (utf8.len(var_282_11) / 16)) > 0 and var_282_9 < var_282_13 then
					arg_279_1.talkMaxDuration = var_282_13

					if var_282_13 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_13 + var_282_8
					end
				end

				arg_279_1.text_.text = var_282_11
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191068", "story_v_out_321191.awb") ~= 0 then
					local var_282_14 = manager.audio:GetVoiceLength("story_v_out_321191", "321191068", "story_v_out_321191.awb") / 1000

					if var_282_14 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_14 + var_282_8
					end

					if var_282_10.prefab_name ~= "" and arg_279_1.actors_[var_282_10.prefab_name] ~= nil then
						local var_282_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_10.prefab_name].transform, "story_v_out_321191", "321191068", "story_v_out_321191.awb")

						arg_279_1:RecordAudio("321191068", var_282_15)
						arg_279_1:RecordAudio("321191068", var_282_15)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_321191", "321191068", "story_v_out_321191.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_321191", "321191068", "story_v_out_321191.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_16 = math.max(var_282_9, arg_279_1.talkMaxDuration)

			if var_282_8 <= arg_279_1.time_ and arg_279_1.time_ < var_282_8 + var_282_16 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_8) / var_282_16

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_8 + var_282_16 and arg_279_1.time_ < var_282_8 + var_282_16 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
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

		arg_279_1:InitPlayNodeList()
	end,
	Play321191069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 321191069
		arg_283_1.duration_ = 5.53

		local var_283_0 = {
			zh = 4.133,
			ja = 5.533
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
				arg_283_0:Play321191070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["10104ui_story"]) and arg_283_1.var_.characterEffect10104ui_story == nil then
				arg_283_1.var_.characterEffect10104ui_story = arg_283_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["10104ui_story"]) then
				if arg_283_1.var_.characterEffect10104ui_story and not isNil(arg_283_1.actors_["10104ui_story"]) then
					arg_283_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["10104ui_story"]) and arg_283_1.var_.characterEffect10104ui_story then
				arg_283_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_286_2 = arg_283_1.actors_["1284ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_2) and arg_283_1.var_.characterEffect1284ui_story == nil then
				arg_283_1.var_.characterEffect1284ui_story = var_286_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_3 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_3 and not isNil(var_286_2) then
				if arg_283_1.var_.characterEffect1284ui_story and not isNil(var_286_2) then
					arg_283_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_3)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_3 and arg_283_1.time_ < 0 + var_286_3 + arg_286_0 and not isNil(var_286_2) and arg_283_1.var_.characterEffect1284ui_story then
				arg_283_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_2")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_286_4 = 0
			local var_286_5 = 0.55

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_4 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_6 = arg_283_1:GetWordFromCfg(321191069)
				local var_286_7 = arg_283_1:FormatText(var_286_6.content)

				arg_283_1.text_.text = var_286_7

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_9 = 22 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 22)

				if (22 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 22)) > 0 and var_286_5 < var_286_9 then
					arg_283_1.talkMaxDuration = var_286_9

					if var_286_9 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_9 + var_286_4
					end
				end

				arg_283_1.text_.text = var_286_7
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191069", "story_v_out_321191.awb") ~= 0 then
					local var_286_10 = manager.audio:GetVoiceLength("story_v_out_321191", "321191069", "story_v_out_321191.awb") / 1000

					if var_286_10 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_10 + var_286_4
					end

					if var_286_6.prefab_name ~= "" and arg_283_1.actors_[var_286_6.prefab_name] ~= nil then
						local var_286_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_6.prefab_name].transform, "story_v_out_321191", "321191069", "story_v_out_321191.awb")

						arg_283_1:RecordAudio("321191069", var_286_11)
						arg_283_1:RecordAudio("321191069", var_286_11)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_321191", "321191069", "story_v_out_321191.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_321191", "321191069", "story_v_out_321191.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_12 = math.max(var_286_5, arg_283_1.talkMaxDuration)

			if var_286_4 <= arg_283_1.time_ and arg_283_1.time_ < var_286_4 + var_286_12 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_4) / var_286_12

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_4 + var_286_12 and arg_283_1.time_ < var_286_4 + var_286_12 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play321191070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 321191070
		arg_287_1.duration_ = 21.13

		local var_287_0 = {
			zh = 11.266,
			ja = 21.133
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
				arg_287_0:Play321191071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 1.4

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_1 = arg_287_1:GetWordFromCfg(321191070)
				local var_290_2 = arg_287_1:FormatText(var_290_1.content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 56 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 56)

				if (56 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 56)) > 0 and var_290_0 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + 0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191070", "story_v_out_321191.awb") ~= 0 then
					local var_290_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191070", "story_v_out_321191.awb") / 1000

					if var_290_5 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + 0
					end

					if var_290_1.prefab_name ~= "" and arg_287_1.actors_[var_290_1.prefab_name] ~= nil then
						local var_290_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_1.prefab_name].transform, "story_v_out_321191", "321191070", "story_v_out_321191.awb")

						arg_287_1:RecordAudio("321191070", var_290_6)
						arg_287_1:RecordAudio("321191070", var_290_6)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_321191", "321191070", "story_v_out_321191.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_321191", "321191070", "story_v_out_321191.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_7 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_7

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play321191071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 321191071
		arg_291_1.duration_ = 11.13

		local var_291_0 = {
			zh = 5.966,
			ja = 11.133
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
				arg_291_0:Play321191072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_294_0 = 0
			local var_294_1 = 0.8

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_2 = arg_291_1:GetWordFromCfg(321191071)
				local var_294_3 = arg_291_1:FormatText(var_294_2.content)

				arg_291_1.text_.text = var_294_3

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 32 <= 0 and var_294_1 or var_294_1 * (utf8.len(var_294_3) / 32)

				if (32 <= 0 and var_294_1 or var_294_1 * (utf8.len(var_294_3) / 32)) > 0 and var_294_1 < var_294_5 then
					arg_291_1.talkMaxDuration = var_294_5

					if var_294_5 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + var_294_0
					end
				end

				arg_291_1.text_.text = var_294_3
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191071", "story_v_out_321191.awb") ~= 0 then
					local var_294_6 = manager.audio:GetVoiceLength("story_v_out_321191", "321191071", "story_v_out_321191.awb") / 1000

					if var_294_6 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_6 + var_294_0
					end

					if var_294_2.prefab_name ~= "" and arg_291_1.actors_[var_294_2.prefab_name] ~= nil then
						local var_294_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_2.prefab_name].transform, "story_v_out_321191", "321191071", "story_v_out_321191.awb")

						arg_291_1:RecordAudio("321191071", var_294_7)
						arg_291_1:RecordAudio("321191071", var_294_7)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_321191", "321191071", "story_v_out_321191.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_321191", "321191071", "story_v_out_321191.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_8 = math.max(var_294_1, arg_291_1.talkMaxDuration)

			if var_294_0 <= arg_291_1.time_ and arg_291_1.time_ < var_294_0 + var_294_8 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_0) / var_294_8

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_0 + var_294_8 and arg_291_1.time_ < var_294_0 + var_294_8 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play321191072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 321191072
		arg_295_1.duration_ = 6.63

		local var_295_0 = {
			zh = 5.799999999999,
			ja = 6.633
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
				arg_295_0:Play321191073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 2.00000000298023 < arg_295_1.time_ and arg_295_1.time_ <= 2.00000000298023 + arg_298_0 then
				local var_298_0 = arg_295_1.bgs_.L10g

				arg_295_1.bgs_.L10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_298_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_298_1 = var_298_0:GetComponent("SpriteRenderer")

				if var_298_1 and var_298_1.sprite then
					local var_298_2 = 2 * (var_298_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_298_0.transform.localScale = Vector3.New(var_298_2 / var_298_1.sprite.bounds.size.y < var_298_2 * manager.ui.mainCameraCom_.aspect / var_298_1.sprite.bounds.size.x and var_298_2 * manager.ui.mainCameraCom_.aspect / var_298_1.sprite.bounds.size.x or var_298_2 / var_298_1.sprite.bounds.size.y, var_298_2 / var_298_1.sprite.bounds.size.y < var_298_2 * manager.ui.mainCameraCom_.aspect / var_298_1.sprite.bounds.size.x and var_298_2 * manager.ui.mainCameraCom_.aspect / var_298_1.sprite.bounds.size.x or var_298_2 / var_298_1.sprite.bounds.size.y, 0)
				end

				for iter_298_0, iter_298_1 in pairs(arg_295_1.bgs_) do
					if iter_298_0 ~= "L10g" then
						iter_298_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_298_3 = 4

			if 4 < arg_295_1.time_ and arg_295_1.time_ <= var_298_3 + arg_298_0 then
				arg_295_1.allBtn_.enabled = false
			end

			if arg_295_1.time_ >= var_298_3 + 0.3 and arg_295_1.time_ < var_298_3 + 0.3 + arg_298_0 then
				arg_295_1.allBtn_.enabled = true
			end

			local var_298_4 = 0

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_4 + arg_298_0 then
				arg_295_1.mask_.enabled = true
				arg_295_1.mask_.raycastTarget = true

				arg_295_1:SetGaussion(false)
			end

			local var_298_5 = 2

			if var_298_4 <= arg_295_1.time_ and arg_295_1.time_ < var_298_4 + var_298_5 then
				local var_298_6 = Color.New(0, 0, 0)

				var_298_6.a = Mathf.Lerp(0, 1, (arg_295_1.time_ - var_298_4) / var_298_5)
				arg_295_1.mask_.color = var_298_6
			end

			if arg_295_1.time_ >= var_298_4 + var_298_5 and arg_295_1.time_ < var_298_4 + var_298_5 + arg_298_0 then
				local var_298_7 = Color.New(0, 0, 0)

				var_298_7.a = 1
				arg_295_1.mask_.color = var_298_7
			end

			local var_298_8 = 2

			if 2 < arg_295_1.time_ and arg_295_1.time_ <= var_298_8 + arg_298_0 then
				arg_295_1.mask_.enabled = true
				arg_295_1.mask_.raycastTarget = true

				arg_295_1:SetGaussion(false)
			end

			local var_298_9 = 2

			if var_298_8 <= arg_295_1.time_ and arg_295_1.time_ < var_298_8 + var_298_9 then
				local var_298_10 = Color.New(0, 0, 0)

				var_298_10.a = Mathf.Lerp(1, 0, (arg_295_1.time_ - var_298_8) / var_298_9)
				arg_295_1.mask_.color = var_298_10
			end

			if arg_295_1.time_ >= var_298_8 + var_298_9 and arg_295_1.time_ < var_298_8 + var_298_9 + arg_298_0 then
				local var_298_11 = Color.New(0, 0, 0)

				arg_295_1.mask_.enabled = false
				var_298_11.a = 0
				arg_295_1.mask_.color = var_298_11
			end

			local var_298_12 = arg_295_1.actors_["10104ui_story"].transform

			if 1.96599999815226 < arg_295_1.time_ and arg_295_1.time_ <= 1.96599999815226 + arg_298_0 then
				arg_295_1.var_.moveOldPos10104ui_story = var_298_12.localPosition
			end

			local var_298_13 = 0.001

			if 1.96599999815226 <= arg_295_1.time_ and arg_295_1.time_ < 1.96599999815226 + var_298_13 then
				var_298_12.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_295_1.time_ - 1.96599999815226) / var_298_13)
				var_298_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_298_12.position).x, (manager.ui.mainCamera.transform.position - var_298_12.position).y, (manager.ui.mainCamera.transform.position - var_298_12.position).z)
				var_298_12.localEulerAngles.z = 0
				var_298_12.localEulerAngles.x = 0
				var_298_12.localEulerAngles = var_298_12.localEulerAngles
			end

			if arg_295_1.time_ >= 1.96599999815226 + var_298_13 and arg_295_1.time_ < 1.96599999815226 + var_298_13 + arg_298_0 then
				var_298_12.localPosition = Vector3.New(0, 100, 0)
				var_298_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_298_12.position).x, (manager.ui.mainCamera.transform.position - var_298_12.position).y, (manager.ui.mainCamera.transform.position - var_298_12.position).z)
				var_298_12.localEulerAngles.z = 0
				var_298_12.localEulerAngles.x = 0
				var_298_12.localEulerAngles = var_298_12.localEulerAngles
			end

			local var_298_14 = arg_295_1.actors_["1284ui_story"].transform

			if 1.96599999815226 < arg_295_1.time_ and arg_295_1.time_ <= 1.96599999815226 + arg_298_0 then
				arg_295_1.var_.moveOldPos1284ui_story = var_298_14.localPosition
			end

			local var_298_15 = 0.001

			if 1.96599999815226 <= arg_295_1.time_ and arg_295_1.time_ < 1.96599999815226 + var_298_15 then
				var_298_14.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_295_1.time_ - 1.96599999815226) / var_298_15)
				var_298_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_298_14.position).x, (manager.ui.mainCamera.transform.position - var_298_14.position).y, (manager.ui.mainCamera.transform.position - var_298_14.position).z)
				var_298_14.localEulerAngles.z = 0
				var_298_14.localEulerAngles.x = 0
				var_298_14.localEulerAngles = var_298_14.localEulerAngles
			end

			if arg_295_1.time_ >= 1.96599999815226 + var_298_15 and arg_295_1.time_ < 1.96599999815226 + var_298_15 + arg_298_0 then
				var_298_14.localPosition = Vector3.New(0, 100, 0)
				var_298_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_298_14.position).x, (manager.ui.mainCamera.transform.position - var_298_14.position).y, (manager.ui.mainCamera.transform.position - var_298_14.position).z)
				var_298_14.localEulerAngles.z = 0
				var_298_14.localEulerAngles.x = 0
				var_298_14.localEulerAngles = var_298_14.localEulerAngles
			end

			local var_298_16 = arg_295_1.actors_["1011ui_story"].transform

			if 3.8 < arg_295_1.time_ and arg_295_1.time_ <= 3.8 + arg_298_0 then
				arg_295_1.var_.moveOldPos1011ui_story = var_298_16.localPosition
			end

			local var_298_17 = 0.001

			if 3.8 <= arg_295_1.time_ and arg_295_1.time_ < 3.8 + var_298_17 then
				var_298_16.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_295_1.time_ - 3.8) / var_298_17)
				var_298_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_298_16.position).x, (manager.ui.mainCamera.transform.position - var_298_16.position).y, (manager.ui.mainCamera.transform.position - var_298_16.position).z)
				var_298_16.localEulerAngles.z = 0
				var_298_16.localEulerAngles.x = 0
				var_298_16.localEulerAngles = var_298_16.localEulerAngles
			end

			if arg_295_1.time_ >= 3.8 + var_298_17 and arg_295_1.time_ < 3.8 + var_298_17 + arg_298_0 then
				var_298_16.localPosition = Vector3.New(0, -0.71, -6)
				var_298_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_298_16.position).x, (manager.ui.mainCamera.transform.position - var_298_16.position).y, (manager.ui.mainCamera.transform.position - var_298_16.position).z)
				var_298_16.localEulerAngles.z = 0
				var_298_16.localEulerAngles.x = 0
				var_298_16.localEulerAngles = var_298_16.localEulerAngles
			end

			local var_298_18 = arg_295_1.actors_["1011ui_story"]

			if 3.8 < arg_295_1.time_ and arg_295_1.time_ <= 3.8 + arg_298_0 and not isNil(var_298_18) and arg_295_1.var_.characterEffect1011ui_story == nil then
				arg_295_1.var_.characterEffect1011ui_story = var_298_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_19 = 0.200000002980232

			if 3.8 <= arg_295_1.time_ and arg_295_1.time_ < 3.8 + var_298_19 and not isNil(var_298_18) then
				if arg_295_1.var_.characterEffect1011ui_story and not isNil(var_298_18) then
					arg_295_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= 3.8 + var_298_19 and arg_295_1.time_ < 3.8 + var_298_19 + arg_298_0 and not isNil(var_298_18) and arg_295_1.var_.characterEffect1011ui_story then
				arg_295_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 3.8 < arg_295_1.time_ and arg_295_1.time_ <= 3.8 + arg_298_0 then
				arg_295_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 3.8 < arg_295_1.time_ and arg_295_1.time_ <= 3.8 + arg_298_0 then
				arg_295_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			if arg_295_1.frameCnt_ <= 1 then
				arg_295_1.dialog_:SetActive(false)
			end

			local var_298_21 = 4
			local var_298_22 = 0.15

			if 4 < arg_295_1.time_ and arg_295_1.time_ <= var_298_21 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0

				arg_295_1.dialog_:SetActive(true)

				arg_295_1.dialogCg_.alpha = 0

				local var_298_23 = LeanTween.value(arg_295_1.dialog_, 0, 1, 0.3)

				var_298_23:setOnUpdate(LuaHelper.FloatAction(function(arg_299_0)
					arg_295_1.dialogCg_.alpha = arg_299_0
				end))
				var_298_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_295_1.dialog_)
					var_298_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_295_1.duration_ = arg_295_1.duration_ + 0.3

				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_24 = arg_295_1:GetWordFromCfg(321191072)
				local var_298_25 = arg_295_1:FormatText(var_298_24.content)

				arg_295_1.text_.text = var_298_25

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_27 = 6 <= 0 and var_298_22 or var_298_22 * (utf8.len(var_298_25) / 6)

				if (6 <= 0 and var_298_22 or var_298_22 * (utf8.len(var_298_25) / 6)) > 0 and var_298_22 < var_298_27 then
					arg_295_1.talkMaxDuration = var_298_27
					var_298_21 = var_298_21 + 0.3

					if var_298_27 + var_298_21 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_27 + var_298_21
					end
				end

				arg_295_1.text_.text = var_298_25
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191072", "story_v_out_321191.awb") ~= 0 then
					local var_298_28 = manager.audio:GetVoiceLength("story_v_out_321191", "321191072", "story_v_out_321191.awb") / 1000

					if var_298_28 + var_298_21 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_28 + var_298_21
					end

					if var_298_24.prefab_name ~= "" and arg_295_1.actors_[var_298_24.prefab_name] ~= nil then
						local var_298_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_24.prefab_name].transform, "story_v_out_321191", "321191072", "story_v_out_321191.awb")

						arg_295_1:RecordAudio("321191072", var_298_29)
						arg_295_1:RecordAudio("321191072", var_298_29)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_321191", "321191072", "story_v_out_321191.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_321191", "321191072", "story_v_out_321191.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_30 = var_298_21 + 0.3
			local var_298_31 = math.max(var_298_22, arg_295_1.talkMaxDuration)

			if var_298_21 + 0.3 <= arg_295_1.time_ and arg_295_1.time_ < var_298_30 + var_298_31 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_30) / var_298_31

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_30 + var_298_31 and arg_295_1.time_ < var_298_30 + var_298_31 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play321191073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 321191073
		arg_301_1.duration_ = 6.2

		local var_301_0 = {
			zh = 6.2,
			ja = 5.2
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play321191074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_304_0 = 0
			local var_304_1 = 0.475

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_2 = arg_301_1:GetWordFromCfg(321191073)
				local var_304_3 = arg_301_1:FormatText(var_304_2.content)

				arg_301_1.text_.text = var_304_3

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 19 <= 0 and var_304_1 or var_304_1 * (utf8.len(var_304_3) / 19)

				if (19 <= 0 and var_304_1 or var_304_1 * (utf8.len(var_304_3) / 19)) > 0 and var_304_1 < var_304_5 then
					arg_301_1.talkMaxDuration = var_304_5

					if var_304_5 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_3
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191073", "story_v_out_321191.awb") ~= 0 then
					local var_304_6 = manager.audio:GetVoiceLength("story_v_out_321191", "321191073", "story_v_out_321191.awb") / 1000

					if var_304_6 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_6 + var_304_0
					end

					if var_304_2.prefab_name ~= "" and arg_301_1.actors_[var_304_2.prefab_name] ~= nil then
						local var_304_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_2.prefab_name].transform, "story_v_out_321191", "321191073", "story_v_out_321191.awb")

						arg_301_1:RecordAudio("321191073", var_304_7)
						arg_301_1:RecordAudio("321191073", var_304_7)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_321191", "321191073", "story_v_out_321191.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_321191", "321191073", "story_v_out_321191.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_8 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_8 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_8

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_8 and arg_301_1.time_ < var_304_0 + var_304_8 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play321191074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 321191074
		arg_305_1.duration_ = 5.37

		local var_305_0 = {
			zh = 2.466,
			ja = 5.366
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
				arg_305_0:Play321191075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1011ui_story"]) and arg_305_1.var_.characterEffect1011ui_story == nil then
				arg_305_1.var_.characterEffect1011ui_story = arg_305_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1011ui_story"]) then
				if arg_305_1.var_.characterEffect1011ui_story and not isNil(arg_305_1.actors_["1011ui_story"]) then
					arg_305_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_0)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1011ui_story"]) and arg_305_1.var_.characterEffect1011ui_story then
				arg_305_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_308_1 = 0
			local var_308_2 = 0.3

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:GetWordFromCfg(321191074)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_6 = 12 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_4) / 12)

				if (12 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_4) / 12)) > 0 and var_308_2 < var_308_6 then
					arg_305_1.talkMaxDuration = var_308_6

					if var_308_6 + var_308_1 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_6 + var_308_1
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191074", "story_v_out_321191.awb") ~= 0 then
					local var_308_7 = manager.audio:GetVoiceLength("story_v_out_321191", "321191074", "story_v_out_321191.awb") / 1000

					if var_308_7 + var_308_1 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_1
					end

					if var_308_3.prefab_name ~= "" and arg_305_1.actors_[var_308_3.prefab_name] ~= nil then
						local var_308_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_3.prefab_name].transform, "story_v_out_321191", "321191074", "story_v_out_321191.awb")

						arg_305_1:RecordAudio("321191074", var_308_8)
						arg_305_1:RecordAudio("321191074", var_308_8)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_321191", "321191074", "story_v_out_321191.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_321191", "321191074", "story_v_out_321191.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_9 = math.max(var_308_2, arg_305_1.talkMaxDuration)

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_9 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_1) / var_308_9

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_1 + var_308_9 and arg_305_1.time_ < var_308_1 + var_308_9 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play321191075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 321191075
		arg_309_1.duration_ = 8.2

		local var_309_0 = {
			zh = 4.6,
			ja = 8.2
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
				arg_309_0:Play321191076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos1011ui_story = arg_309_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_312_0 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 then
				arg_309_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_309_1.time_ - 0) / var_312_0)
				arg_309_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1011ui_story"].transform.position).z)
				arg_309_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1011ui_story"].transform.localEulerAngles = arg_309_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 then
				arg_309_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_309_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1011ui_story"].transform.position).z)
				arg_309_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1011ui_story"].transform.localEulerAngles = arg_309_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_312_1 = arg_309_1.actors_["1011ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1011ui_story == nil then
				arg_309_1.var_.characterEffect1011ui_story = var_312_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_2 and not isNil(var_312_1) then
				if arg_309_1.var_.characterEffect1011ui_story and not isNil(var_312_1) then
					arg_309_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_2 and arg_309_1.time_ < 0 + var_312_2 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1011ui_story then
				arg_309_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action426")
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_312_4 = 0
			local var_312_5 = 0.375

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_6 = arg_309_1:GetWordFromCfg(321191075)
				local var_312_7 = arg_309_1:FormatText(var_312_6.content)

				arg_309_1.text_.text = var_312_7

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_9 = 15 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 15)

				if (15 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 15)) > 0 and var_312_5 < var_312_9 then
					arg_309_1.talkMaxDuration = var_312_9

					if var_312_9 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_9 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_7
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191075", "story_v_out_321191.awb") ~= 0 then
					local var_312_10 = manager.audio:GetVoiceLength("story_v_out_321191", "321191075", "story_v_out_321191.awb") / 1000

					if var_312_10 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_4
					end

					if var_312_6.prefab_name ~= "" and arg_309_1.actors_[var_312_6.prefab_name] ~= nil then
						local var_312_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_6.prefab_name].transform, "story_v_out_321191", "321191075", "story_v_out_321191.awb")

						arg_309_1:RecordAudio("321191075", var_312_11)
						arg_309_1:RecordAudio("321191075", var_312_11)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_321191", "321191075", "story_v_out_321191.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_321191", "321191075", "story_v_out_321191.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_12 = math.max(var_312_5, arg_309_1.talkMaxDuration)

			if var_312_4 <= arg_309_1.time_ and arg_309_1.time_ < var_312_4 + var_312_12 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_4) / var_312_12

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_4 + var_312_12 and arg_309_1.time_ < var_312_4 + var_312_12 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
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

		arg_309_1:InitPlayNodeList()
	end,
	Play321191076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 321191076
		arg_313_1.duration_ = 3.47

		local var_313_0 = {
			zh = 3.133,
			ja = 3.466
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play321191077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1011ui_story"]) and arg_313_1.var_.characterEffect1011ui_story == nil then
				arg_313_1.var_.characterEffect1011ui_story = arg_313_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1011ui_story"]) then
				if arg_313_1.var_.characterEffect1011ui_story and not isNil(arg_313_1.actors_["1011ui_story"]) then
					arg_313_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_0)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1011ui_story"]) and arg_313_1.var_.characterEffect1011ui_story then
				arg_313_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_316_1 = 0
			local var_316_2 = 0.25

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_3 = arg_313_1:GetWordFromCfg(321191076)
				local var_316_4 = arg_313_1:FormatText(var_316_3.content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_6 = 10 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_4) / 10)

				if (10 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_4) / 10)) > 0 and var_316_2 < var_316_6 then
					arg_313_1.talkMaxDuration = var_316_6

					if var_316_6 + var_316_1 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_6 + var_316_1
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191076", "story_v_out_321191.awb") ~= 0 then
					local var_316_7 = manager.audio:GetVoiceLength("story_v_out_321191", "321191076", "story_v_out_321191.awb") / 1000

					if var_316_7 + var_316_1 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_1
					end

					if var_316_3.prefab_name ~= "" and arg_313_1.actors_[var_316_3.prefab_name] ~= nil then
						local var_316_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_3.prefab_name].transform, "story_v_out_321191", "321191076", "story_v_out_321191.awb")

						arg_313_1:RecordAudio("321191076", var_316_8)
						arg_313_1:RecordAudio("321191076", var_316_8)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_321191", "321191076", "story_v_out_321191.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_321191", "321191076", "story_v_out_321191.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_9 = math.max(var_316_2, arg_313_1.talkMaxDuration)

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_9 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_1) / var_316_9

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_1 + var_316_9 and arg_313_1.time_ < var_316_1 + var_316_9 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play321191077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 321191077
		arg_317_1.duration_ = 4.63

		local var_317_0 = {
			zh = 4.633,
			ja = 4.1
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play321191078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1011ui_story = arg_317_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1011ui_story"].transform.position).z)
				arg_317_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1011ui_story"].transform.localEulerAngles = arg_317_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_317_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1011ui_story"].transform.position).z)
				arg_317_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1011ui_story"].transform.localEulerAngles = arg_317_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_320_1 = arg_317_1.actors_["1011ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1011ui_story == nil then
				arg_317_1.var_.characterEffect1011ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 and not isNil(var_320_1) then
				if arg_317_1.var_.characterEffect1011ui_story and not isNil(var_320_1) then
					arg_317_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1011ui_story then
				arg_317_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_2")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_320_4 = 0
			local var_320_5 = 0.45

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_4 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_6 = arg_317_1:GetWordFromCfg(321191077)
				local var_320_7 = arg_317_1:FormatText(var_320_6.content)

				arg_317_1.text_.text = var_320_7

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_9 = 18 <= 0 and var_320_5 or var_320_5 * (utf8.len(var_320_7) / 18)

				if (18 <= 0 and var_320_5 or var_320_5 * (utf8.len(var_320_7) / 18)) > 0 and var_320_5 < var_320_9 then
					arg_317_1.talkMaxDuration = var_320_9

					if var_320_9 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_9 + var_320_4
					end
				end

				arg_317_1.text_.text = var_320_7
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191077", "story_v_out_321191.awb") ~= 0 then
					local var_320_10 = manager.audio:GetVoiceLength("story_v_out_321191", "321191077", "story_v_out_321191.awb") / 1000

					if var_320_10 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_10 + var_320_4
					end

					if var_320_6.prefab_name ~= "" and arg_317_1.actors_[var_320_6.prefab_name] ~= nil then
						local var_320_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_6.prefab_name].transform, "story_v_out_321191", "321191077", "story_v_out_321191.awb")

						arg_317_1:RecordAudio("321191077", var_320_11)
						arg_317_1:RecordAudio("321191077", var_320_11)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_321191", "321191077", "story_v_out_321191.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_321191", "321191077", "story_v_out_321191.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_12 = math.max(var_320_5, arg_317_1.talkMaxDuration)

			if var_320_4 <= arg_317_1.time_ and arg_317_1.time_ < var_320_4 + var_320_12 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_4) / var_320_12

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_4 + var_320_12 and arg_317_1.time_ < var_320_4 + var_320_12 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
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

		arg_317_1:InitPlayNodeList()
	end,
	Play321191078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 321191078
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play321191079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1011ui_story"]) and arg_321_1.var_.characterEffect1011ui_story == nil then
				arg_321_1.var_.characterEffect1011ui_story = arg_321_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1011ui_story"]) then
				if arg_321_1.var_.characterEffect1011ui_story and not isNil(arg_321_1.actors_["1011ui_story"]) then
					arg_321_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_0)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1011ui_story"]) and arg_321_1.var_.characterEffect1011ui_story then
				arg_321_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_324_1 = 0
			local var_324_2 = 1.525

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_3 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(321191078).content)

				arg_321_1.text_.text = var_324_3

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 61 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 61)

				if (61 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 61)) > 0 and var_324_2 < var_324_5 then
					arg_321_1.talkMaxDuration = var_324_5

					if var_324_5 + var_324_1 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + var_324_1
					end
				end

				arg_321_1.text_.text = var_324_3
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_6 = math.max(var_324_2, arg_321_1.talkMaxDuration)

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_6 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_1) / var_324_6

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_1 + var_324_6 and arg_321_1.time_ < var_324_1 + var_324_6 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play321191079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 321191079
		arg_325_1.duration_ = 4.03

		local var_325_0 = {
			zh = 1.999999999999,
			ja = 4.033
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
				arg_325_0:Play321191080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1011ui_story = arg_325_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_328_0 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 then
				arg_325_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_325_1.time_ - 0) / var_328_0)
				arg_325_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1011ui_story"].transform.position).z)
				arg_325_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1011ui_story"].transform.localEulerAngles = arg_325_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 then
				arg_325_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_325_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1011ui_story"].transform.position).z)
				arg_325_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1011ui_story"].transform.localEulerAngles = arg_325_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_328_1 = arg_325_1.actors_["1011ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1011ui_story == nil then
				arg_325_1.var_.characterEffect1011ui_story = var_328_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_2 and not isNil(var_328_1) then
				if arg_325_1.var_.characterEffect1011ui_story and not isNil(var_328_1) then
					arg_325_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_2 and arg_325_1.time_ < 0 + var_328_2 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1011ui_story then
				arg_325_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_328_4 = 0
			local var_328_5 = 0.075

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_4 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_6 = arg_325_1:GetWordFromCfg(321191079)
				local var_328_7 = arg_325_1:FormatText(var_328_6.content)

				arg_325_1.text_.text = var_328_7

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_9 = 3 <= 0 and var_328_5 or var_328_5 * (utf8.len(var_328_7) / 3)

				if (3 <= 0 and var_328_5 or var_328_5 * (utf8.len(var_328_7) / 3)) > 0 and var_328_5 < var_328_9 then
					arg_325_1.talkMaxDuration = var_328_9

					if var_328_9 + var_328_4 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_9 + var_328_4
					end
				end

				arg_325_1.text_.text = var_328_7
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191079", "story_v_out_321191.awb") ~= 0 then
					local var_328_10 = manager.audio:GetVoiceLength("story_v_out_321191", "321191079", "story_v_out_321191.awb") / 1000

					if var_328_10 + var_328_4 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_10 + var_328_4
					end

					if var_328_6.prefab_name ~= "" and arg_325_1.actors_[var_328_6.prefab_name] ~= nil then
						local var_328_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_6.prefab_name].transform, "story_v_out_321191", "321191079", "story_v_out_321191.awb")

						arg_325_1:RecordAudio("321191079", var_328_11)
						arg_325_1:RecordAudio("321191079", var_328_11)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_321191", "321191079", "story_v_out_321191.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_321191", "321191079", "story_v_out_321191.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_12 = math.max(var_328_5, arg_325_1.talkMaxDuration)

			if var_328_4 <= arg_325_1.time_ and arg_325_1.time_ < var_328_4 + var_328_12 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_4) / var_328_12

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_4 + var_328_12 and arg_325_1.time_ < var_328_4 + var_328_12 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
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

		arg_325_1:InitPlayNodeList()
	end,
	Play321191080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 321191080
		arg_329_1.duration_ = 14.2

		local var_329_0 = {
			zh = 9.6,
			ja = 14.2
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play321191081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["1011ui_story"]) and arg_329_1.var_.characterEffect1011ui_story == nil then
				arg_329_1.var_.characterEffect1011ui_story = arg_329_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["1011ui_story"]) then
				if arg_329_1.var_.characterEffect1011ui_story and not isNil(arg_329_1.actors_["1011ui_story"]) then
					arg_329_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_0)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["1011ui_story"]) and arg_329_1.var_.characterEffect1011ui_story then
				arg_329_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_332_1 = 0
			local var_332_2 = 1.15

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_3 = arg_329_1:GetWordFromCfg(321191080)
				local var_332_4 = arg_329_1:FormatText(var_332_3.content)

				arg_329_1.text_.text = var_332_4

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_6 = 46 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_4) / 46)

				if (46 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_4) / 46)) > 0 and var_332_2 < var_332_6 then
					arg_329_1.talkMaxDuration = var_332_6

					if var_332_6 + var_332_1 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_6 + var_332_1
					end
				end

				arg_329_1.text_.text = var_332_4
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191080", "story_v_out_321191.awb") ~= 0 then
					local var_332_7 = manager.audio:GetVoiceLength("story_v_out_321191", "321191080", "story_v_out_321191.awb") / 1000

					if var_332_7 + var_332_1 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_7 + var_332_1
					end

					if var_332_3.prefab_name ~= "" and arg_329_1.actors_[var_332_3.prefab_name] ~= nil then
						local var_332_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_3.prefab_name].transform, "story_v_out_321191", "321191080", "story_v_out_321191.awb")

						arg_329_1:RecordAudio("321191080", var_332_8)
						arg_329_1:RecordAudio("321191080", var_332_8)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_321191", "321191080", "story_v_out_321191.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_321191", "321191080", "story_v_out_321191.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_9 = math.max(var_332_2, arg_329_1.talkMaxDuration)

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_9 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_1) / var_332_9

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_1 + var_332_9 and arg_329_1.time_ < var_332_1 + var_332_9 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play321191081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 321191081
		arg_333_1.duration_ = 13.23

		local var_333_0 = {
			zh = 5.833,
			ja = 13.233
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play321191082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0.85

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_1 = arg_333_1:GetWordFromCfg(321191081)
				local var_336_2 = arg_333_1:FormatText(var_336_1.content)

				arg_333_1.text_.text = var_336_2

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_4 = 34 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 34)

				if (34 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 34)) > 0 and var_336_0 < var_336_4 then
					arg_333_1.talkMaxDuration = var_336_4

					if var_336_4 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_4 + 0
					end
				end

				arg_333_1.text_.text = var_336_2
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191081", "story_v_out_321191.awb") ~= 0 then
					local var_336_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191081", "story_v_out_321191.awb") / 1000

					if var_336_5 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + 0
					end

					if var_336_1.prefab_name ~= "" and arg_333_1.actors_[var_336_1.prefab_name] ~= nil then
						local var_336_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_1.prefab_name].transform, "story_v_out_321191", "321191081", "story_v_out_321191.awb")

						arg_333_1:RecordAudio("321191081", var_336_6)
						arg_333_1:RecordAudio("321191081", var_336_6)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_321191", "321191081", "story_v_out_321191.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_321191", "321191081", "story_v_out_321191.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_7 = math.max(var_336_0, arg_333_1.talkMaxDuration)

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_7 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - 0) / var_336_7

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= 0 + var_336_7 and arg_333_1.time_ < 0 + var_336_7 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play321191082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 321191082
		arg_337_1.duration_ = 9.2

		local var_337_0 = {
			zh = 9.2,
			ja = 7.866
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play321191083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 1.05

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_1 = arg_337_1:GetWordFromCfg(321191082)
				local var_340_2 = arg_337_1:FormatText(var_340_1.content)

				arg_337_1.text_.text = var_340_2

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_4 = 42 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 42)

				if (42 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 42)) > 0 and var_340_0 < var_340_4 then
					arg_337_1.talkMaxDuration = var_340_4

					if var_340_4 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_4 + 0
					end
				end

				arg_337_1.text_.text = var_340_2
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191082", "story_v_out_321191.awb") ~= 0 then
					local var_340_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191082", "story_v_out_321191.awb") / 1000

					if var_340_5 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + 0
					end

					if var_340_1.prefab_name ~= "" and arg_337_1.actors_[var_340_1.prefab_name] ~= nil then
						local var_340_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_1.prefab_name].transform, "story_v_out_321191", "321191082", "story_v_out_321191.awb")

						arg_337_1:RecordAudio("321191082", var_340_6)
						arg_337_1:RecordAudio("321191082", var_340_6)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_321191", "321191082", "story_v_out_321191.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_321191", "321191082", "story_v_out_321191.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_7 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_7 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_7

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_7 and arg_337_1.time_ < 0 + var_340_7 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play321191083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 321191083
		arg_341_1.duration_ = 3.8

		local var_341_0 = {
			zh = 3.7,
			ja = 3.8
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play321191084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1011ui_story = arg_341_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1011ui_story"].transform.position).z)
				arg_341_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1011ui_story"].transform.localEulerAngles = arg_341_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_341_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1011ui_story"].transform.position).z)
				arg_341_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1011ui_story"].transform.localEulerAngles = arg_341_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["1011ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1011ui_story == nil then
				arg_341_1.var_.characterEffect1011ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect1011ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1011ui_story then
				arg_341_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_2")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_344_4 = 0
			local var_344_5 = 0.325

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_6 = arg_341_1:GetWordFromCfg(321191083)
				local var_344_7 = arg_341_1:FormatText(var_344_6.content)

				arg_341_1.text_.text = var_344_7

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 13 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 13)

				if (13 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 13)) > 0 and var_344_5 < var_344_9 then
					arg_341_1.talkMaxDuration = var_344_9

					if var_344_9 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_4
					end
				end

				arg_341_1.text_.text = var_344_7
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191083", "story_v_out_321191.awb") ~= 0 then
					local var_344_10 = manager.audio:GetVoiceLength("story_v_out_321191", "321191083", "story_v_out_321191.awb") / 1000

					if var_344_10 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_4
					end

					if var_344_6.prefab_name ~= "" and arg_341_1.actors_[var_344_6.prefab_name] ~= nil then
						local var_344_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_6.prefab_name].transform, "story_v_out_321191", "321191083", "story_v_out_321191.awb")

						arg_341_1:RecordAudio("321191083", var_344_11)
						arg_341_1:RecordAudio("321191083", var_344_11)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_321191", "321191083", "story_v_out_321191.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_321191", "321191083", "story_v_out_321191.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_12 = math.max(var_344_5, arg_341_1.talkMaxDuration)

			if var_344_4 <= arg_341_1.time_ and arg_341_1.time_ < var_344_4 + var_344_12 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_4) / var_344_12

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_4 + var_344_12 and arg_341_1.time_ < var_344_4 + var_344_12 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
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

		arg_341_1:InitPlayNodeList()
	end,
	Play321191084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 321191084
		arg_345_1.duration_ = 8.63

		local var_345_0 = {
			zh = 5.3,
			ja = 8.633
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play321191085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["1011ui_story"]) and arg_345_1.var_.characterEffect1011ui_story == nil then
				arg_345_1.var_.characterEffect1011ui_story = arg_345_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_0 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["1011ui_story"]) then
				if arg_345_1.var_.characterEffect1011ui_story and not isNil(arg_345_1.actors_["1011ui_story"]) then
					arg_345_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_0)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["1011ui_story"]) and arg_345_1.var_.characterEffect1011ui_story then
				arg_345_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_348_1 = 0
			local var_348_2 = 0.675

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_3 = arg_345_1:GetWordFromCfg(321191084)
				local var_348_4 = arg_345_1:FormatText(var_348_3.content)

				arg_345_1.text_.text = var_348_4

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_6 = 27 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_4) / 27)

				if (27 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_4) / 27)) > 0 and var_348_2 < var_348_6 then
					arg_345_1.talkMaxDuration = var_348_6

					if var_348_6 + var_348_1 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_6 + var_348_1
					end
				end

				arg_345_1.text_.text = var_348_4
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191084", "story_v_out_321191.awb") ~= 0 then
					local var_348_7 = manager.audio:GetVoiceLength("story_v_out_321191", "321191084", "story_v_out_321191.awb") / 1000

					if var_348_7 + var_348_1 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_7 + var_348_1
					end

					if var_348_3.prefab_name ~= "" and arg_345_1.actors_[var_348_3.prefab_name] ~= nil then
						local var_348_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_3.prefab_name].transform, "story_v_out_321191", "321191084", "story_v_out_321191.awb")

						arg_345_1:RecordAudio("321191084", var_348_8)
						arg_345_1:RecordAudio("321191084", var_348_8)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_321191", "321191084", "story_v_out_321191.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_321191", "321191084", "story_v_out_321191.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_9 = math.max(var_348_2, arg_345_1.talkMaxDuration)

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_9 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_1) / var_348_9

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_1 + var_348_9 and arg_345_1.time_ < var_348_1 + var_348_9 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play321191085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 321191085
		arg_349_1.duration_ = 6.43

		local var_349_0 = {
			zh = 5.866,
			ja = 6.433
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play321191086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(arg_349_1.actors_["1011ui_story"]) and arg_349_1.var_.characterEffect1011ui_story == nil then
				arg_349_1.var_.characterEffect1011ui_story = arg_349_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_0 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 and not isNil(arg_349_1.actors_["1011ui_story"]) then
				if arg_349_1.var_.characterEffect1011ui_story and not isNil(arg_349_1.actors_["1011ui_story"]) then
					arg_349_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 and not isNil(arg_349_1.actors_["1011ui_story"]) and arg_349_1.var_.characterEffect1011ui_story then
				arg_349_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_352_2 = 0
			local var_352_3 = 0.525

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_2 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_4 = arg_349_1:GetWordFromCfg(321191085)
				local var_352_5 = arg_349_1:FormatText(var_352_4.content)

				arg_349_1.text_.text = var_352_5

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_7 = 21 <= 0 and var_352_3 or var_352_3 * (utf8.len(var_352_5) / 21)

				if (21 <= 0 and var_352_3 or var_352_3 * (utf8.len(var_352_5) / 21)) > 0 and var_352_3 < var_352_7 then
					arg_349_1.talkMaxDuration = var_352_7

					if var_352_7 + var_352_2 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_7 + var_352_2
					end
				end

				arg_349_1.text_.text = var_352_5
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191085", "story_v_out_321191.awb") ~= 0 then
					local var_352_8 = manager.audio:GetVoiceLength("story_v_out_321191", "321191085", "story_v_out_321191.awb") / 1000

					if var_352_8 + var_352_2 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_8 + var_352_2
					end

					if var_352_4.prefab_name ~= "" and arg_349_1.actors_[var_352_4.prefab_name] ~= nil then
						local var_352_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_4.prefab_name].transform, "story_v_out_321191", "321191085", "story_v_out_321191.awb")

						arg_349_1:RecordAudio("321191085", var_352_9)
						arg_349_1:RecordAudio("321191085", var_352_9)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_321191", "321191085", "story_v_out_321191.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_321191", "321191085", "story_v_out_321191.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_10 = math.max(var_352_3, arg_349_1.talkMaxDuration)

			if var_352_2 <= arg_349_1.time_ and arg_349_1.time_ < var_352_2 + var_352_10 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_2) / var_352_10

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_2 + var_352_10 and arg_349_1.time_ < var_352_2 + var_352_10 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play321191086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 321191086
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play321191087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1011ui_story = arg_353_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_356_0 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 then
				arg_353_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_353_1.time_ - 0) / var_356_0)
				arg_353_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1011ui_story"].transform.position).z)
				arg_353_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1011ui_story"].transform.localEulerAngles = arg_353_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 then
				arg_353_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_353_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1011ui_story"].transform.position).z)
				arg_353_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1011ui_story"].transform.localEulerAngles = arg_353_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_356_1 = arg_353_1.actors_["1011ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1011ui_story == nil then
				arg_353_1.var_.characterEffect1011ui_story = var_356_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_2 and not isNil(var_356_1) then
				if arg_353_1.var_.characterEffect1011ui_story and not isNil(var_356_1) then
					arg_353_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_2)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_2 and arg_353_1.time_ < 0 + var_356_2 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1011ui_story then
				arg_353_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 1.33333333333333 < arg_353_1.time_ and arg_353_1.time_ <= 1.33333333333333 + arg_356_0 then
				arg_353_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_down", "")
			end

			local var_356_4 = 0
			local var_356_5 = 1.55

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_4 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_6 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(321191086).content)

				arg_353_1.text_.text = var_356_6

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_8 = 62 <= 0 and var_356_5 or var_356_5 * (utf8.len(var_356_6) / 62)

				if (62 <= 0 and var_356_5 or var_356_5 * (utf8.len(var_356_6) / 62)) > 0 and var_356_5 < var_356_8 then
					arg_353_1.talkMaxDuration = var_356_8

					if var_356_8 + var_356_4 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_8 + var_356_4
					end
				end

				arg_353_1.text_.text = var_356_6
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_9 = math.max(var_356_5, arg_353_1.talkMaxDuration)

			if var_356_4 <= arg_353_1.time_ and arg_353_1.time_ < var_356_4 + var_356_9 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_4) / var_356_9

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_4 + var_356_9 and arg_353_1.time_ < var_356_4 + var_356_9 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
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

		arg_353_1:InitPlayNodeList()
	end,
	Play321191087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 321191087
		arg_357_1.duration_ = 4.73

		local var_357_0 = {
			zh = 4.733,
			ja = 4.633
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
				arg_357_0:Play321191088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1011ui_story = arg_357_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_360_0 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 then
				arg_357_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_357_1.time_ - 0) / var_360_0)
				arg_357_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1011ui_story"].transform.position).z)
				arg_357_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1011ui_story"].transform.localEulerAngles = arg_357_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 then
				arg_357_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_357_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1011ui_story"].transform.position).z)
				arg_357_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1011ui_story"].transform.localEulerAngles = arg_357_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_360_1 = arg_357_1.actors_["1011ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1011ui_story == nil then
				arg_357_1.var_.characterEffect1011ui_story = var_360_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_2 and not isNil(var_360_1) then
				if arg_357_1.var_.characterEffect1011ui_story and not isNil(var_360_1) then
					arg_357_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_2 and arg_357_1.time_ < 0 + var_360_2 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1011ui_story then
				arg_357_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_360_4 = 0
			local var_360_5 = 0.425

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_6 = arg_357_1:GetWordFromCfg(321191087)
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

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191087", "story_v_out_321191.awb") ~= 0 then
					local var_360_10 = manager.audio:GetVoiceLength("story_v_out_321191", "321191087", "story_v_out_321191.awb") / 1000

					if var_360_10 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_10 + var_360_4
					end

					if var_360_6.prefab_name ~= "" and arg_357_1.actors_[var_360_6.prefab_name] ~= nil then
						local var_360_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_6.prefab_name].transform, "story_v_out_321191", "321191087", "story_v_out_321191.awb")

						arg_357_1:RecordAudio("321191087", var_360_11)
						arg_357_1:RecordAudio("321191087", var_360_11)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_321191", "321191087", "story_v_out_321191.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_321191", "321191087", "story_v_out_321191.awb")
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

		arg_357_1.nodeConfigList_ = {
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

		arg_357_1:InitPlayNodeList()
	end,
	Play321191088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 321191088
		arg_361_1.duration_ = 11.4

		local var_361_0 = {
			zh = 10.1,
			ja = 11.4
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
				arg_361_0:Play321191089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1011ui_story"]) and arg_361_1.var_.characterEffect1011ui_story == nil then
				arg_361_1.var_.characterEffect1011ui_story = arg_361_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1011ui_story"]) then
				if arg_361_1.var_.characterEffect1011ui_story and not isNil(arg_361_1.actors_["1011ui_story"]) then
					arg_361_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_0)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1011ui_story"]) and arg_361_1.var_.characterEffect1011ui_story then
				arg_361_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_364_1 = 0
			local var_364_2 = 0.775

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:GetWordFromCfg(321191088)
				local var_364_4 = arg_361_1:FormatText(var_364_3.content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_6 = 31 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_4) / 31)

				if (31 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_4) / 31)) > 0 and var_364_2 < var_364_6 then
					arg_361_1.talkMaxDuration = var_364_6

					if var_364_6 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_6 + var_364_1
					end
				end

				arg_361_1.text_.text = var_364_4
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191088", "story_v_out_321191.awb") ~= 0 then
					local var_364_7 = manager.audio:GetVoiceLength("story_v_out_321191", "321191088", "story_v_out_321191.awb") / 1000

					if var_364_7 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_1
					end

					if var_364_3.prefab_name ~= "" and arg_361_1.actors_[var_364_3.prefab_name] ~= nil then
						local var_364_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_3.prefab_name].transform, "story_v_out_321191", "321191088", "story_v_out_321191.awb")

						arg_361_1:RecordAudio("321191088", var_364_8)
						arg_361_1:RecordAudio("321191088", var_364_8)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_321191", "321191088", "story_v_out_321191.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_321191", "321191088", "story_v_out_321191.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_9 = math.max(var_364_2, arg_361_1.talkMaxDuration)

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_9 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_1) / var_364_9

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_1 + var_364_9 and arg_361_1.time_ < var_364_1 + var_364_9 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play321191089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 321191089
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play321191090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos1011ui_story = arg_365_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_368_0 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 then
				arg_365_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_365_1.time_ - 0) / var_368_0)
				arg_365_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_365_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1011ui_story"].transform.position).z)
				arg_365_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_365_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_365_1.actors_["1011ui_story"].transform.localEulerAngles = arg_365_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 then
				arg_365_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_365_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_365_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1011ui_story"].transform.position).z)
				arg_365_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_365_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_365_1.actors_["1011ui_story"].transform.localEulerAngles = arg_365_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if 0.8 < arg_365_1.time_ and arg_365_1.time_ <= 0.8 + arg_368_0 then
				arg_365_1:AudioAction("play", "effect", "se_story_140", "se_story_140_brake", "")
			end

			local var_368_2 = 0
			local var_368_3 = 1.55

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_2 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, false)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_4 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(321191089).content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_6 = 62 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_4) / 62)

				if (62 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_4) / 62)) > 0 and var_368_3 < var_368_6 then
					arg_365_1.talkMaxDuration = var_368_6

					if var_368_6 + var_368_2 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_6 + var_368_2
					end
				end

				arg_365_1.text_.text = var_368_4
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_7 = math.max(var_368_3, arg_365_1.talkMaxDuration)

			if var_368_2 <= arg_365_1.time_ and arg_365_1.time_ < var_368_2 + var_368_7 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_2) / var_368_7

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_2 + var_368_7 and arg_365_1.time_ < var_368_2 + var_368_7 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
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

		arg_365_1:InitPlayNodeList()
	end,
	Play321191090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 321191090
		arg_369_1.duration_ = 2

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play321191091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos1011ui_story = arg_369_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_372_0 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 then
				arg_369_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_369_1.time_ - 0) / var_372_0)
				arg_369_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1011ui_story"].transform.position).z)
				arg_369_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1011ui_story"].transform.localEulerAngles = arg_369_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 then
				arg_369_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_369_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1011ui_story"].transform.position).z)
				arg_369_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1011ui_story"].transform.localEulerAngles = arg_369_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_372_1 = arg_369_1.actors_["1011ui_story"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect1011ui_story == nil then
				arg_369_1.var_.characterEffect1011ui_story = var_372_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_2 and not isNil(var_372_1) then
				if arg_369_1.var_.characterEffect1011ui_story and not isNil(var_372_1) then
					arg_369_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_369_1.time_ >= 0 + var_372_2 and arg_369_1.time_ < 0 + var_372_2 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect1011ui_story then
				arg_369_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_372_4 = 0
			local var_372_5 = 0.1

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_4 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_6 = arg_369_1:GetWordFromCfg(321191090)
				local var_372_7 = arg_369_1:FormatText(var_372_6.content)

				arg_369_1.text_.text = var_372_7

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_9 = 4 <= 0 and var_372_5 or var_372_5 * (utf8.len(var_372_7) / 4)

				if (4 <= 0 and var_372_5 or var_372_5 * (utf8.len(var_372_7) / 4)) > 0 and var_372_5 < var_372_9 then
					arg_369_1.talkMaxDuration = var_372_9

					if var_372_9 + var_372_4 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_9 + var_372_4
					end
				end

				arg_369_1.text_.text = var_372_7
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191090", "story_v_out_321191.awb") ~= 0 then
					local var_372_10 = manager.audio:GetVoiceLength("story_v_out_321191", "321191090", "story_v_out_321191.awb") / 1000

					if var_372_10 + var_372_4 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_10 + var_372_4
					end

					if var_372_6.prefab_name ~= "" and arg_369_1.actors_[var_372_6.prefab_name] ~= nil then
						local var_372_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_6.prefab_name].transform, "story_v_out_321191", "321191090", "story_v_out_321191.awb")

						arg_369_1:RecordAudio("321191090", var_372_11)
						arg_369_1:RecordAudio("321191090", var_372_11)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_321191", "321191090", "story_v_out_321191.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_321191", "321191090", "story_v_out_321191.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_12 = math.max(var_372_5, arg_369_1.talkMaxDuration)

			if var_372_4 <= arg_369_1.time_ and arg_369_1.time_ < var_372_4 + var_372_12 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_4) / var_372_12

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_4 + var_372_12 and arg_369_1.time_ < var_372_4 + var_372_12 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
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

		arg_369_1:InitPlayNodeList()
	end,
	Play321191091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 321191091
		arg_373_1.duration_ = 1.67

		local var_373_0 = {
			zh = 1.4,
			ja = 1.666
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play321191092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["1011ui_story"]) and arg_373_1.var_.characterEffect1011ui_story == nil then
				arg_373_1.var_.characterEffect1011ui_story = arg_373_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_0 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["1011ui_story"]) then
				if arg_373_1.var_.characterEffect1011ui_story and not isNil(arg_373_1.actors_["1011ui_story"]) then
					arg_373_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_373_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_373_1.time_ - 0) / var_376_0)
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["1011ui_story"]) and arg_373_1.var_.characterEffect1011ui_story then
				arg_373_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_373_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_376_1 = 0
			local var_376_2 = 0.1

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[1182].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_3 = arg_373_1:GetWordFromCfg(321191091)
				local var_376_4 = arg_373_1:FormatText(var_376_3.content)

				arg_373_1.text_.text = var_376_4

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_6 = 4 <= 0 and var_376_2 or var_376_2 * (utf8.len(var_376_4) / 4)

				if (4 <= 0 and var_376_2 or var_376_2 * (utf8.len(var_376_4) / 4)) > 0 and var_376_2 < var_376_6 then
					arg_373_1.talkMaxDuration = var_376_6

					if var_376_6 + var_376_1 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_6 + var_376_1
					end
				end

				arg_373_1.text_.text = var_376_4
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191091", "story_v_out_321191.awb") ~= 0 then
					local var_376_7 = manager.audio:GetVoiceLength("story_v_out_321191", "321191091", "story_v_out_321191.awb") / 1000

					if var_376_7 + var_376_1 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_1
					end

					if var_376_3.prefab_name ~= "" and arg_373_1.actors_[var_376_3.prefab_name] ~= nil then
						local var_376_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_3.prefab_name].transform, "story_v_out_321191", "321191091", "story_v_out_321191.awb")

						arg_373_1:RecordAudio("321191091", var_376_8)
						arg_373_1:RecordAudio("321191091", var_376_8)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_321191", "321191091", "story_v_out_321191.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_321191", "321191091", "story_v_out_321191.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_9 = math.max(var_376_2, arg_373_1.talkMaxDuration)

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_9 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_1) / var_376_9

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_1 + var_376_9 and arg_373_1.time_ < var_376_1 + var_376_9 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play321191092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 321191092
		arg_377_1.duration_ = 1.53

		local var_377_0 = {
			zh = 1.533,
			ja = 1.5
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
				arg_377_0:Play321191093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1011ui_story = arg_377_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_380_0 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 then
				arg_377_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_377_1.time_ - 0) / var_380_0)
				arg_377_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1011ui_story"].transform.position).z)
				arg_377_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1011ui_story"].transform.localEulerAngles = arg_377_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 then
				arg_377_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_377_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1011ui_story"].transform.position).z)
				arg_377_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1011ui_story"].transform.localEulerAngles = arg_377_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_380_1 = arg_377_1.actors_["1011ui_story"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1011ui_story == nil then
				arg_377_1.var_.characterEffect1011ui_story = var_380_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_2 and not isNil(var_380_1) then
				if arg_377_1.var_.characterEffect1011ui_story and not isNil(var_380_1) then
					arg_377_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= 0 + var_380_2 and arg_377_1.time_ < 0 + var_380_2 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1011ui_story then
				arg_377_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_380_4 = 0
			local var_380_5 = 0.175

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_4 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_6 = arg_377_1:GetWordFromCfg(321191092)
				local var_380_7 = arg_377_1:FormatText(var_380_6.content)

				arg_377_1.text_.text = var_380_7

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_9 = 7 <= 0 and var_380_5 or var_380_5 * (utf8.len(var_380_7) / 7)

				if (7 <= 0 and var_380_5 or var_380_5 * (utf8.len(var_380_7) / 7)) > 0 and var_380_5 < var_380_9 then
					arg_377_1.talkMaxDuration = var_380_9

					if var_380_9 + var_380_4 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_9 + var_380_4
					end
				end

				arg_377_1.text_.text = var_380_7
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191092", "story_v_out_321191.awb") ~= 0 then
					local var_380_10 = manager.audio:GetVoiceLength("story_v_out_321191", "321191092", "story_v_out_321191.awb") / 1000

					if var_380_10 + var_380_4 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_10 + var_380_4
					end

					if var_380_6.prefab_name ~= "" and arg_377_1.actors_[var_380_6.prefab_name] ~= nil then
						local var_380_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_6.prefab_name].transform, "story_v_out_321191", "321191092", "story_v_out_321191.awb")

						arg_377_1:RecordAudio("321191092", var_380_11)
						arg_377_1:RecordAudio("321191092", var_380_11)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_321191", "321191092", "story_v_out_321191.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_321191", "321191092", "story_v_out_321191.awb")
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
				actorName = "1011ui_story",
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
	Play321191093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 321191093
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play321191094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos1011ui_story = arg_381_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_384_0 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 then
				arg_381_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_381_1.time_ - 0) / var_384_0)
				arg_381_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1011ui_story"].transform.position).z)
				arg_381_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1011ui_story"].transform.localEulerAngles = arg_381_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 then
				arg_381_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_381_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1011ui_story"].transform.position).z)
				arg_381_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1011ui_story"].transform.localEulerAngles = arg_381_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_384_1 = arg_381_1.actors_["1011ui_story"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect1011ui_story == nil then
				arg_381_1.var_.characterEffect1011ui_story = var_384_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_2 and not isNil(var_384_1) then
				if arg_381_1.var_.characterEffect1011ui_story and not isNil(var_384_1) then
					arg_381_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_381_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_381_1.time_ - 0) / var_384_2)
				end
			end

			if arg_381_1.time_ >= 0 + var_384_2 and arg_381_1.time_ < 0 + var_384_2 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect1011ui_story then
				arg_381_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_381_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_381_1.time_ and arg_381_1.time_ <= 0.034000001847744 + arg_384_0 then
				arg_381_1:AudioAction("play", "effect", "se_story_140", "se_story_140_turn", "")
			end

			local var_384_4 = 0
			local var_384_5 = 1.175

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_4 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_6 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(321191093).content)

				arg_381_1.text_.text = var_384_6

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_8 = 47 <= 0 and var_384_5 or var_384_5 * (utf8.len(var_384_6) / 47)

				if (47 <= 0 and var_384_5 or var_384_5 * (utf8.len(var_384_6) / 47)) > 0 and var_384_5 < var_384_8 then
					arg_381_1.talkMaxDuration = var_384_8

					if var_384_8 + var_384_4 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_8 + var_384_4
					end
				end

				arg_381_1.text_.text = var_384_6
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_9 = math.max(var_384_5, arg_381_1.talkMaxDuration)

			if var_384_4 <= arg_381_1.time_ and arg_381_1.time_ < var_384_4 + var_384_9 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_4) / var_384_9

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_4 + var_384_9 and arg_381_1.time_ < var_384_4 + var_384_9 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
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

		arg_381_1:InitPlayNodeList()
	end,
	Play321191094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 321191094
		arg_385_1.duration_ = 4.17

		local var_385_0 = {
			zh = 2.833,
			ja = 4.166
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
				arg_385_0:Play321191095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0.275

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_1 = arg_385_1:GetWordFromCfg(321191094)
				local var_388_2 = arg_385_1:FormatText(var_388_1.content)

				arg_385_1.text_.text = var_388_2

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_4 = 11 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 11)

				if (11 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 11)) > 0 and var_388_0 < var_388_4 then
					arg_385_1.talkMaxDuration = var_388_4

					if var_388_4 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_4 + 0
					end
				end

				arg_385_1.text_.text = var_388_2
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191094", "story_v_out_321191.awb") ~= 0 then
					local var_388_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191094", "story_v_out_321191.awb") / 1000

					if var_388_5 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + 0
					end

					if var_388_1.prefab_name ~= "" and arg_385_1.actors_[var_388_1.prefab_name] ~= nil then
						local var_388_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_1.prefab_name].transform, "story_v_out_321191", "321191094", "story_v_out_321191.awb")

						arg_385_1:RecordAudio("321191094", var_388_6)
						arg_385_1:RecordAudio("321191094", var_388_6)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_321191", "321191094", "story_v_out_321191.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_321191", "321191094", "story_v_out_321191.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_7 = math.max(var_388_0, arg_385_1.talkMaxDuration)

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_7 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - 0) / var_388_7

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= 0 + var_388_7 and arg_385_1.time_ < 0 + var_388_7 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play321191095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 321191095
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play321191096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos1011ui_story = arg_389_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_392_0 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 then
				arg_389_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_389_1.time_ - 0) / var_392_0)
				arg_389_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1011ui_story"].transform.position).z)
				arg_389_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1011ui_story"].transform.localEulerAngles = arg_389_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 then
				arg_389_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_389_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1011ui_story"].transform.position).z)
				arg_389_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1011ui_story"].transform.localEulerAngles = arg_389_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_392_1 = arg_389_1.actors_["1011ui_story"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect1011ui_story == nil then
				arg_389_1.var_.characterEffect1011ui_story = var_392_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_2 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_2 and not isNil(var_392_1) then
				if arg_389_1.var_.characterEffect1011ui_story and not isNil(var_392_1) then
					arg_389_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_389_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_389_1.time_ - 0) / var_392_2)
				end
			end

			if arg_389_1.time_ >= 0 + var_392_2 and arg_389_1.time_ < 0 + var_392_2 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect1011ui_story then
				arg_389_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_389_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_392_3 = 0
			local var_392_4 = 1.175

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_3 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_5 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(321191095).content)

				arg_389_1.text_.text = var_392_5

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_7 = 47 <= 0 and var_392_4 or var_392_4 * (utf8.len(var_392_5) / 47)

				if (47 <= 0 and var_392_4 or var_392_4 * (utf8.len(var_392_5) / 47)) > 0 and var_392_4 < var_392_7 then
					arg_389_1.talkMaxDuration = var_392_7

					if var_392_7 + var_392_3 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_3
					end
				end

				arg_389_1.text_.text = var_392_5
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_8 = math.max(var_392_4, arg_389_1.talkMaxDuration)

			if var_392_3 <= arg_389_1.time_ and arg_389_1.time_ < var_392_3 + var_392_8 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_3) / var_392_8

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_3 + var_392_8 and arg_389_1.time_ < var_392_3 + var_392_8 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
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

		arg_389_1:InitPlayNodeList()
	end,
	Play321191096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 321191096
		arg_393_1.duration_ = 6.2

		local var_393_0 = {
			zh = 3.2,
			ja = 6.2
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
				arg_393_0:Play321191097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0.275

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[1182].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_1 = arg_393_1:GetWordFromCfg(321191096)
				local var_396_2 = arg_393_1:FormatText(var_396_1.content)

				arg_393_1.text_.text = var_396_2

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_4 = 11 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_2) / 11)

				if (11 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_2) / 11)) > 0 and var_396_0 < var_396_4 then
					arg_393_1.talkMaxDuration = var_396_4

					if var_396_4 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_4 + 0
					end
				end

				arg_393_1.text_.text = var_396_2
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191096", "story_v_out_321191.awb") ~= 0 then
					local var_396_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191096", "story_v_out_321191.awb") / 1000

					if var_396_5 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_5 + 0
					end

					if var_396_1.prefab_name ~= "" and arg_393_1.actors_[var_396_1.prefab_name] ~= nil then
						local var_396_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_1.prefab_name].transform, "story_v_out_321191", "321191096", "story_v_out_321191.awb")

						arg_393_1:RecordAudio("321191096", var_396_6)
						arg_393_1:RecordAudio("321191096", var_396_6)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_321191", "321191096", "story_v_out_321191.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_321191", "321191096", "story_v_out_321191.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_7 = math.max(var_396_0, arg_393_1.talkMaxDuration)

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_7 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - 0) / var_396_7

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= 0 + var_396_7 and arg_393_1.time_ < 0 + var_396_7 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play321191097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 321191097
		arg_397_1.duration_ = 6.63

		local var_397_0 = {
			zh = 6.633,
			ja = 6.533
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
				arg_397_0:Play321191098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0.525

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_1 = arg_397_1:GetWordFromCfg(321191097)
				local var_400_2 = arg_397_1:FormatText(var_400_1.content)

				arg_397_1.text_.text = var_400_2

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_4 = 21 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_2) / 21)

				if (21 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_2) / 21)) > 0 and var_400_0 < var_400_4 then
					arg_397_1.talkMaxDuration = var_400_4

					if var_400_4 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_4 + 0
					end
				end

				arg_397_1.text_.text = var_400_2
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191097", "story_v_out_321191.awb") ~= 0 then
					local var_400_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191097", "story_v_out_321191.awb") / 1000

					if var_400_5 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_5 + 0
					end

					if var_400_1.prefab_name ~= "" and arg_397_1.actors_[var_400_1.prefab_name] ~= nil then
						local var_400_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_1.prefab_name].transform, "story_v_out_321191", "321191097", "story_v_out_321191.awb")

						arg_397_1:RecordAudio("321191097", var_400_6)
						arg_397_1:RecordAudio("321191097", var_400_6)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_321191", "321191097", "story_v_out_321191.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_321191", "321191097", "story_v_out_321191.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_7 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_7 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_7

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_7 and arg_397_1.time_ < 0 + var_400_7 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play321191098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 321191098
		arg_401_1.duration_ = 8.9

		local var_401_0 = {
			zh = 8.5,
			ja = 8.9
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play321191099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.725

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_1 = arg_401_1:GetWordFromCfg(321191098)
				local var_404_2 = arg_401_1:FormatText(var_404_1.content)

				arg_401_1.text_.text = var_404_2

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 29 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 29)

				if (29 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 29)) > 0 and var_404_0 < var_404_4 then
					arg_401_1.talkMaxDuration = var_404_4

					if var_404_4 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_4 + 0
					end
				end

				arg_401_1.text_.text = var_404_2
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191098", "story_v_out_321191.awb") ~= 0 then
					local var_404_5 = manager.audio:GetVoiceLength("story_v_out_321191", "321191098", "story_v_out_321191.awb") / 1000

					if var_404_5 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_5 + 0
					end

					if var_404_1.prefab_name ~= "" and arg_401_1.actors_[var_404_1.prefab_name] ~= nil then
						local var_404_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_1.prefab_name].transform, "story_v_out_321191", "321191098", "story_v_out_321191.awb")

						arg_401_1:RecordAudio("321191098", var_404_6)
						arg_401_1:RecordAudio("321191098", var_404_6)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_321191", "321191098", "story_v_out_321191.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_321191", "321191098", "story_v_out_321191.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_7 and arg_401_1.time_ < 0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play321191099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 321191099
		arg_405_1.duration_ = 5.77

		local var_405_0 = {
			zh = 4.266,
			ja = 5.766
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
				arg_405_0:Play321191100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos1011ui_story = arg_405_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_408_0 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 then
				arg_405_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_405_1.time_ - 0) / var_408_0)
				arg_405_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1011ui_story"].transform.position).z)
				arg_405_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1011ui_story"].transform.localEulerAngles = arg_405_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 then
				arg_405_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_405_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1011ui_story"].transform.position).z)
				arg_405_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1011ui_story"].transform.localEulerAngles = arg_405_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_408_1 = arg_405_1.actors_["1011ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1011ui_story == nil then
				arg_405_1.var_.characterEffect1011ui_story = var_408_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_2 and not isNil(var_408_1) then
				if arg_405_1.var_.characterEffect1011ui_story and not isNil(var_408_1) then
					arg_405_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= 0 + var_408_2 and arg_405_1.time_ < 0 + var_408_2 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1011ui_story then
				arg_405_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_408_4 = 0
			local var_408_5 = 0.475

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_4 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_6 = arg_405_1:GetWordFromCfg(321191099)
				local var_408_7 = arg_405_1:FormatText(var_408_6.content)

				arg_405_1.text_.text = var_408_7

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_9 = 19 <= 0 and var_408_5 or var_408_5 * (utf8.len(var_408_7) / 19)

				if (19 <= 0 and var_408_5 or var_408_5 * (utf8.len(var_408_7) / 19)) > 0 and var_408_5 < var_408_9 then
					arg_405_1.talkMaxDuration = var_408_9

					if var_408_9 + var_408_4 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_9 + var_408_4
					end
				end

				arg_405_1.text_.text = var_408_7
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191099", "story_v_out_321191.awb") ~= 0 then
					local var_408_10 = manager.audio:GetVoiceLength("story_v_out_321191", "321191099", "story_v_out_321191.awb") / 1000

					if var_408_10 + var_408_4 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_10 + var_408_4
					end

					if var_408_6.prefab_name ~= "" and arg_405_1.actors_[var_408_6.prefab_name] ~= nil then
						local var_408_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_6.prefab_name].transform, "story_v_out_321191", "321191099", "story_v_out_321191.awb")

						arg_405_1:RecordAudio("321191099", var_408_11)
						arg_405_1:RecordAudio("321191099", var_408_11)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_321191", "321191099", "story_v_out_321191.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_321191", "321191099", "story_v_out_321191.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_12 = math.max(var_408_5, arg_405_1.talkMaxDuration)

			if var_408_4 <= arg_405_1.time_ and arg_405_1.time_ < var_408_4 + var_408_12 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_4) / var_408_12

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_4 + var_408_12 and arg_405_1.time_ < var_408_4 + var_408_12 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
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

		arg_405_1:InitPlayNodeList()
	end,
	Play321191100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 321191100
		arg_409_1.duration_ = 4.6

		local var_409_0 = {
			zh = 2.633,
			ja = 4.6
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play321191101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos1011ui_story = arg_409_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_412_0 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 then
				arg_409_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_409_1.time_ - 0) / var_412_0)
				arg_409_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1011ui_story"].transform.position).z)
				arg_409_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["1011ui_story"].transform.localEulerAngles = arg_409_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 then
				arg_409_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_409_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1011ui_story"].transform.position).z)
				arg_409_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["1011ui_story"].transform.localEulerAngles = arg_409_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_412_1 = 0
			local var_412_2 = 0.375

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_3 = arg_409_1:GetWordFromCfg(321191100)
				local var_412_4 = arg_409_1:FormatText(var_412_3.content)

				arg_409_1.text_.text = var_412_4

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_6 = 15 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_4) / 15)

				if (15 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_4) / 15)) > 0 and var_412_2 < var_412_6 then
					arg_409_1.talkMaxDuration = var_412_6

					if var_412_6 + var_412_1 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_6 + var_412_1
					end
				end

				arg_409_1.text_.text = var_412_4
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191100", "story_v_out_321191.awb") ~= 0 then
					local var_412_7 = manager.audio:GetVoiceLength("story_v_out_321191", "321191100", "story_v_out_321191.awb") / 1000

					if var_412_7 + var_412_1 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_1
					end

					if var_412_3.prefab_name ~= "" and arg_409_1.actors_[var_412_3.prefab_name] ~= nil then
						local var_412_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_3.prefab_name].transform, "story_v_out_321191", "321191100", "story_v_out_321191.awb")

						arg_409_1:RecordAudio("321191100", var_412_8)
						arg_409_1:RecordAudio("321191100", var_412_8)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_321191", "321191100", "story_v_out_321191.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_321191", "321191100", "story_v_out_321191.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_9 = math.max(var_412_2, arg_409_1.talkMaxDuration)

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_9 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_1) / var_412_9

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_1 + var_412_9 and arg_409_1.time_ < var_412_1 + var_412_9 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
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

		arg_409_1:InitPlayNodeList()
	end,
	Play321191101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 321191101
		arg_413_1.duration_ = 8.83

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play321191102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if arg_413_1.bgs_.L15f == nil then
				local var_416_0 = Object.Instantiate(arg_413_1.paintGo_)

				var_416_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L15f")
				var_416_0.name = "L15f"
				var_416_0.transform.parent = arg_413_1.stage_.transform
				var_416_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_413_1.bgs_.L15f = var_416_0
			end

			if 2 < arg_413_1.time_ and arg_413_1.time_ <= 2 + arg_416_0 then
				local var_416_1 = arg_413_1.bgs_.L15f

				arg_413_1.bgs_.L15f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_416_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_416_2 = var_416_1:GetComponent("SpriteRenderer")

				if var_416_2 and var_416_2.sprite then
					local var_416_3 = 2 * (var_416_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_416_1.transform.localScale = Vector3.New(var_416_3 / var_416_2.sprite.bounds.size.y < var_416_3 * manager.ui.mainCameraCom_.aspect / var_416_2.sprite.bounds.size.x and var_416_3 * manager.ui.mainCameraCom_.aspect / var_416_2.sprite.bounds.size.x or var_416_3 / var_416_2.sprite.bounds.size.y, var_416_3 / var_416_2.sprite.bounds.size.y < var_416_3 * manager.ui.mainCameraCom_.aspect / var_416_2.sprite.bounds.size.x and var_416_3 * manager.ui.mainCameraCom_.aspect / var_416_2.sprite.bounds.size.x or var_416_3 / var_416_2.sprite.bounds.size.y, 0)
				end

				for iter_416_0, iter_416_1 in pairs(arg_413_1.bgs_) do
					if iter_416_0 ~= "L15f" then
						iter_416_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_416_4 = 4

			if 4 < arg_413_1.time_ and arg_413_1.time_ <= var_416_4 + arg_416_0 then
				arg_413_1.allBtn_.enabled = false
			end

			if arg_413_1.time_ >= var_416_4 + 0.3 and arg_413_1.time_ < var_416_4 + 0.3 + arg_416_0 then
				arg_413_1.allBtn_.enabled = true
			end

			local var_416_5 = 0

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_5 + arg_416_0 then
				arg_413_1.mask_.enabled = true
				arg_413_1.mask_.raycastTarget = true

				arg_413_1:SetGaussion(false)
			end

			local var_416_6 = 2

			if var_416_5 <= arg_413_1.time_ and arg_413_1.time_ < var_416_5 + var_416_6 then
				local var_416_7 = Color.New(0, 0, 0)

				var_416_7.a = Mathf.Lerp(0, 1, (arg_413_1.time_ - var_416_5) / var_416_6)
				arg_413_1.mask_.color = var_416_7
			end

			if arg_413_1.time_ >= var_416_5 + var_416_6 and arg_413_1.time_ < var_416_5 + var_416_6 + arg_416_0 then
				local var_416_8 = Color.New(0, 0, 0)

				var_416_8.a = 1
				arg_413_1.mask_.color = var_416_8
			end

			local var_416_9 = 2

			if 2 < arg_413_1.time_ and arg_413_1.time_ <= var_416_9 + arg_416_0 then
				arg_413_1.mask_.enabled = true
				arg_413_1.mask_.raycastTarget = true

				arg_413_1:SetGaussion(false)
			end

			local var_416_10 = 2

			if var_416_9 <= arg_413_1.time_ and arg_413_1.time_ < var_416_9 + var_416_10 then
				local var_416_11 = Color.New(0, 0, 0)

				var_416_11.a = Mathf.Lerp(1, 0, (arg_413_1.time_ - var_416_9) / var_416_10)
				arg_413_1.mask_.color = var_416_11
			end

			if arg_413_1.time_ >= var_416_9 + var_416_10 and arg_413_1.time_ < var_416_9 + var_416_10 + arg_416_0 then
				local var_416_12 = Color.New(0, 0, 0)

				arg_413_1.mask_.enabled = false
				var_416_12.a = 0
				arg_413_1.mask_.color = var_416_12
			end

			local var_416_13 = arg_413_1.actors_["1011ui_story"].transform

			if 1.96599999815226 < arg_413_1.time_ and arg_413_1.time_ <= 1.96599999815226 + arg_416_0 then
				arg_413_1.var_.moveOldPos1011ui_story = var_416_13.localPosition
			end

			local var_416_14 = 0.001

			if 1.96599999815226 <= arg_413_1.time_ and arg_413_1.time_ < 1.96599999815226 + var_416_14 then
				var_416_13.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_413_1.time_ - 1.96599999815226) / var_416_14)
				var_416_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_416_13.position).x, (manager.ui.mainCamera.transform.position - var_416_13.position).y, (manager.ui.mainCamera.transform.position - var_416_13.position).z)
				var_416_13.localEulerAngles.z = 0
				var_416_13.localEulerAngles.x = 0
				var_416_13.localEulerAngles = var_416_13.localEulerAngles
			end

			if arg_413_1.time_ >= 1.96599999815226 + var_416_14 and arg_413_1.time_ < 1.96599999815226 + var_416_14 + arg_416_0 then
				var_416_13.localPosition = Vector3.New(0, 100, 0)
				var_416_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_416_13.position).x, (manager.ui.mainCamera.transform.position - var_416_13.position).y, (manager.ui.mainCamera.transform.position - var_416_13.position).z)
				var_416_13.localEulerAngles.z = 0
				var_416_13.localEulerAngles.x = 0
				var_416_13.localEulerAngles = var_416_13.localEulerAngles
			end

			local var_416_15 = arg_413_1.actors_["1011ui_story"]

			if 1.96599999815226 < arg_413_1.time_ and arg_413_1.time_ <= 1.96599999815226 + arg_416_0 and not isNil(var_416_15) and arg_413_1.var_.characterEffect1011ui_story == nil then
				arg_413_1.var_.characterEffect1011ui_story = var_416_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_16 = 0.034000001847744

			if 1.96599999815226 <= arg_413_1.time_ and arg_413_1.time_ < 1.96599999815226 + var_416_16 and not isNil(var_416_15) then
				if arg_413_1.var_.characterEffect1011ui_story and not isNil(var_416_15) then
					arg_413_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_413_1.time_ - 1.96599999815226) / var_416_16)
				end
			end

			if arg_413_1.time_ >= 1.96599999815226 + var_416_16 and arg_413_1.time_ < 1.96599999815226 + var_416_16 + arg_416_0 and not isNil(var_416_15) and arg_413_1.var_.characterEffect1011ui_story then
				arg_413_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 4.5 < arg_413_1.time_ and arg_413_1.time_ <= 4.5 + arg_416_0 then
				arg_413_1:AudioAction("play", "effect", "se_story_side_1094", "se_story_1094_run", "")
			end

			if arg_413_1.frameCnt_ <= 1 then
				arg_413_1.dialog_:SetActive(false)
			end

			local var_416_18 = 3.83333333333333
			local var_416_19 = 1.075

			if 3.83333333333333 < arg_413_1.time_ and arg_413_1.time_ <= var_416_18 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0

				arg_413_1.dialog_:SetActive(true)

				arg_413_1.dialogCg_.alpha = 0

				local var_416_20 = LeanTween.value(arg_413_1.dialog_, 0, 1, 0.3)

				var_416_20:setOnUpdate(LuaHelper.FloatAction(function(arg_417_0)
					arg_413_1.dialogCg_.alpha = arg_417_0
				end))
				var_416_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_413_1.dialog_)
					var_416_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_413_1.duration_ = arg_413_1.duration_ + 0.3

				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_21 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(321191101).content)

				arg_413_1.text_.text = var_416_21

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_23 = 43 <= 0 and var_416_19 or var_416_19 * (utf8.len(var_416_21) / 43)

				if (43 <= 0 and var_416_19 or var_416_19 * (utf8.len(var_416_21) / 43)) > 0 and var_416_19 < var_416_23 then
					arg_413_1.talkMaxDuration = var_416_23
					var_416_18 = var_416_18 + 0.3

					if var_416_23 + var_416_18 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_23 + var_416_18
					end
				end

				arg_413_1.text_.text = var_416_21
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_24 = var_416_18 + 0.3
			local var_416_25 = math.max(var_416_19, arg_413_1.talkMaxDuration)

			if var_416_18 + 0.3 <= arg_413_1.time_ and arg_413_1.time_ < var_416_24 + var_416_25 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_24) / var_416_25

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_24 + var_416_25 and arg_413_1.time_ < var_416_24 + var_416_25 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play321191102 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 321191102
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play321191103(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0.975

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_1 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(321191102).content)

				arg_419_1.text_.text = var_422_1

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_3 = 39 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_1) / 39)

				if (39 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_1) / 39)) > 0 and var_422_0 < var_422_3 then
					arg_419_1.talkMaxDuration = var_422_3

					if var_422_3 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_3 + 0
					end
				end

				arg_419_1.text_.text = var_422_1
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_4 = math.max(var_422_0, arg_419_1.talkMaxDuration)

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_4 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - 0) / var_422_4

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= 0 + var_422_4 and arg_419_1.time_ < 0 + var_422_4 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play321191103 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 321191103
		arg_423_1.duration_ = 4.2

		local var_423_0 = {
			zh = 3.7,
			ja = 4.2
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play321191104(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.var_.moveOldPos1011ui_story = arg_423_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_426_0 = 0.001

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 then
				arg_423_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_423_1.time_ - 0) / var_426_0)
				arg_423_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1011ui_story"].transform.position).z)
				arg_423_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1011ui_story"].transform.localEulerAngles = arg_423_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 then
				arg_423_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_423_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1011ui_story"].transform.position).z)
				arg_423_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1011ui_story"].transform.localEulerAngles = arg_423_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_426_1 = arg_423_1.actors_["1011ui_story"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1011ui_story == nil then
				arg_423_1.var_.characterEffect1011ui_story = var_426_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_2 and not isNil(var_426_1) then
				if arg_423_1.var_.characterEffect1011ui_story and not isNil(var_426_1) then
					arg_423_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= 0 + var_426_2 and arg_423_1.time_ < 0 + var_426_2 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1011ui_story then
				arg_423_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_2")
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_426_4 = 0
			local var_426_5 = 0.425

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_4 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_6 = arg_423_1:GetWordFromCfg(321191103)
				local var_426_7 = arg_423_1:FormatText(var_426_6.content)

				arg_423_1.text_.text = var_426_7

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_9 = 16 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 16)

				if (16 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 16)) > 0 and var_426_5 < var_426_9 then
					arg_423_1.talkMaxDuration = var_426_9

					if var_426_9 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_9 + var_426_4
					end
				end

				arg_423_1.text_.text = var_426_7
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191103", "story_v_out_321191.awb") ~= 0 then
					local var_426_10 = manager.audio:GetVoiceLength("story_v_out_321191", "321191103", "story_v_out_321191.awb") / 1000

					if var_426_10 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_10 + var_426_4
					end

					if var_426_6.prefab_name ~= "" and arg_423_1.actors_[var_426_6.prefab_name] ~= nil then
						local var_426_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_6.prefab_name].transform, "story_v_out_321191", "321191103", "story_v_out_321191.awb")

						arg_423_1:RecordAudio("321191103", var_426_11)
						arg_423_1:RecordAudio("321191103", var_426_11)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_321191", "321191103", "story_v_out_321191.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_321191", "321191103", "story_v_out_321191.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_12 = math.max(var_426_5, arg_423_1.talkMaxDuration)

			if var_426_4 <= arg_423_1.time_ and arg_423_1.time_ < var_426_4 + var_426_12 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_4) / var_426_12

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_4 + var_426_12 and arg_423_1.time_ < var_426_4 + var_426_12 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
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

		arg_423_1:InitPlayNodeList()
	end,
	Play321191104 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 321191104
		arg_427_1.duration_ = 2

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play321191105(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if arg_427_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_430_0 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_427_1.stage_.transform)

				var_430_0.name = "404001ui_story"
				var_430_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_427_1.actors_["404001ui_story"] = var_430_0

				local var_430_1 = var_430_0:GetComponentInChildren(typeof(CharacterEffect))

				var_430_1.enabled = true

				local var_430_2 = GameObjectTools.GetOrAddComponent(var_430_0, typeof(DynamicBoneHelper))

				if var_430_2 then
					var_430_2:EnableDynamicBone(false)
				end

				arg_427_1:ShowWeapon(var_430_1.transform, false)

				arg_427_1.var_["404001ui_story" .. "Animator"] = var_430_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_427_1.var_["404001ui_story" .. "Animator"].applyRootMotion = true
				arg_427_1.var_["404001ui_story" .. "LipSync"] = var_430_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_430_3 = arg_427_1.actors_["404001ui_story"].transform

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos404001ui_story = var_430_3.localPosition
			end

			local var_430_4 = 0.001

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_4 then
				var_430_3.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_427_1.time_ - 0) / var_430_4)
				var_430_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_430_3.position).x, (manager.ui.mainCamera.transform.position - var_430_3.position).y, (manager.ui.mainCamera.transform.position - var_430_3.position).z)
				var_430_3.localEulerAngles.z = 0
				var_430_3.localEulerAngles.x = 0
				var_430_3.localEulerAngles = var_430_3.localEulerAngles
			end

			if arg_427_1.time_ >= 0 + var_430_4 and arg_427_1.time_ < 0 + var_430_4 + arg_430_0 then
				var_430_3.localPosition = Vector3.New(0, -1.55, -5.5)
				var_430_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_430_3.position).x, (manager.ui.mainCamera.transform.position - var_430_3.position).y, (manager.ui.mainCamera.transform.position - var_430_3.position).z)
				var_430_3.localEulerAngles.z = 0
				var_430_3.localEulerAngles.x = 0
				var_430_3.localEulerAngles = var_430_3.localEulerAngles
			end

			local var_430_5 = arg_427_1.actors_["1011ui_story"].transform

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos1011ui_story = var_430_5.localPosition
			end

			local var_430_6 = 0.001

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_6 then
				var_430_5.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_427_1.time_ - 0) / var_430_6)
				var_430_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_430_5.position).x, (manager.ui.mainCamera.transform.position - var_430_5.position).y, (manager.ui.mainCamera.transform.position - var_430_5.position).z)
				var_430_5.localEulerAngles.z = 0
				var_430_5.localEulerAngles.x = 0
				var_430_5.localEulerAngles = var_430_5.localEulerAngles
			end

			if arg_427_1.time_ >= 0 + var_430_6 and arg_427_1.time_ < 0 + var_430_6 + arg_430_0 then
				var_430_5.localPosition = Vector3.New(0, 100, 0)
				var_430_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_430_5.position).x, (manager.ui.mainCamera.transform.position - var_430_5.position).y, (manager.ui.mainCamera.transform.position - var_430_5.position).z)
				var_430_5.localEulerAngles.z = 0
				var_430_5.localEulerAngles.x = 0
				var_430_5.localEulerAngles = var_430_5.localEulerAngles
			end

			local var_430_7 = arg_427_1.actors_["404001ui_story"]

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(var_430_7) and arg_427_1.var_.characterEffect404001ui_story == nil then
				arg_427_1.var_.characterEffect404001ui_story = var_430_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_8 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_8 and not isNil(var_430_7) then
				if arg_427_1.var_.characterEffect404001ui_story and not isNil(var_430_7) then
					arg_427_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= 0 + var_430_8 and arg_427_1.time_ < 0 + var_430_8 + arg_430_0 and not isNil(var_430_7) and arg_427_1.var_.characterEffect404001ui_story then
				arg_427_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_430_10 = arg_427_1.actors_["1011ui_story"]

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(var_430_10) and arg_427_1.var_.characterEffect1011ui_story == nil then
				arg_427_1.var_.characterEffect1011ui_story = var_430_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_11 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_11 and not isNil(var_430_10) then
				if arg_427_1.var_.characterEffect1011ui_story and not isNil(var_430_10) then
					arg_427_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_427_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_427_1.time_ - 0) / var_430_11)
				end
			end

			if arg_427_1.time_ >= 0 + var_430_11 and arg_427_1.time_ < 0 + var_430_11 + arg_430_0 and not isNil(var_430_10) and arg_427_1.var_.characterEffect1011ui_story then
				arg_427_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_427_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_430_12 = 0
			local var_430_13 = 0.075

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_12 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_14 = arg_427_1:GetWordFromCfg(321191104)
				local var_430_15 = arg_427_1:FormatText(var_430_14.content)

				arg_427_1.text_.text = var_430_15

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_17 = 3 <= 0 and var_430_13 or var_430_13 * (utf8.len(var_430_15) / 3)

				if (3 <= 0 and var_430_13 or var_430_13 * (utf8.len(var_430_15) / 3)) > 0 and var_430_13 < var_430_17 then
					arg_427_1.talkMaxDuration = var_430_17

					if var_430_17 + var_430_12 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_17 + var_430_12
					end
				end

				arg_427_1.text_.text = var_430_15
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191104", "story_v_out_321191.awb") ~= 0 then
					local var_430_18 = manager.audio:GetVoiceLength("story_v_out_321191", "321191104", "story_v_out_321191.awb") / 1000

					if var_430_18 + var_430_12 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_18 + var_430_12
					end

					if var_430_14.prefab_name ~= "" and arg_427_1.actors_[var_430_14.prefab_name] ~= nil then
						local var_430_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_14.prefab_name].transform, "story_v_out_321191", "321191104", "story_v_out_321191.awb")

						arg_427_1:RecordAudio("321191104", var_430_19)
						arg_427_1:RecordAudio("321191104", var_430_19)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_321191", "321191104", "story_v_out_321191.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_321191", "321191104", "story_v_out_321191.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_20 = math.max(var_430_13, arg_427_1.talkMaxDuration)

			if var_430_12 <= arg_427_1.time_ and arg_427_1.time_ < var_430_12 + var_430_20 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_12) / var_430_20

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_12 + var_430_20 and arg_427_1.time_ < var_430_12 + var_430_20 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
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

		arg_427_1:InitPlayNodeList()
	end,
	Play321191105 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 321191105
		arg_431_1.duration_ = 6.2

		local var_431_0 = {
			zh = 4.1,
			ja = 6.2
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
			arg_431_1.auto_ = false
		end

		function arg_431_1.playNext_(arg_433_0)
			arg_431_1.onStoryFinished_()
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.var_.moveOldPos404001ui_story = arg_431_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_434_0 = 0.001

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 then
				arg_431_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_431_1.time_ - 0) / var_434_0)
				arg_431_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_431_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["404001ui_story"].transform.position).z)
				arg_431_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_431_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_431_1.actors_["404001ui_story"].transform.localEulerAngles = arg_431_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 then
				arg_431_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_431_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_431_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["404001ui_story"].transform.position).z)
				arg_431_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_431_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_431_1.actors_["404001ui_story"].transform.localEulerAngles = arg_431_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_434_1 = 0
			local var_434_2 = 0.525

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_3 = arg_431_1:GetWordFromCfg(321191105)
				local var_434_4 = arg_431_1:FormatText(var_434_3.content)

				arg_431_1.text_.text = var_434_4

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_6 = 21 <= 0 and var_434_2 or var_434_2 * (utf8.len(var_434_4) / 21)

				if (21 <= 0 and var_434_2 or var_434_2 * (utf8.len(var_434_4) / 21)) > 0 and var_434_2 < var_434_6 then
					arg_431_1.talkMaxDuration = var_434_6

					if var_434_6 + var_434_1 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_6 + var_434_1
					end
				end

				arg_431_1.text_.text = var_434_4
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321191", "321191105", "story_v_out_321191.awb") ~= 0 then
					local var_434_7 = manager.audio:GetVoiceLength("story_v_out_321191", "321191105", "story_v_out_321191.awb") / 1000

					if var_434_7 + var_434_1 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_7 + var_434_1
					end

					if var_434_3.prefab_name ~= "" and arg_431_1.actors_[var_434_3.prefab_name] ~= nil then
						local var_434_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_3.prefab_name].transform, "story_v_out_321191", "321191105", "story_v_out_321191.awb")

						arg_431_1:RecordAudio("321191105", var_434_8)
						arg_431_1:RecordAudio("321191105", var_434_8)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_321191", "321191105", "story_v_out_321191.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_321191", "321191105", "story_v_out_321191.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_9 = math.max(var_434_2, arg_431_1.talkMaxDuration)

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_9 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_1) / var_434_9

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_1 + var_434_9 and arg_431_1.time_ < var_434_1 + var_434_9 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
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

		arg_431_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L10g",
		"TextureConfig/Background/ST73",
		"TextureConfig/Background/L15f"
	},
	voices = {
		"story_v_out_321191.awb"
	}
}
