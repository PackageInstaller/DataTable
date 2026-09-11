return {
	Play321401001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321401001
		arg_1_1.duration_ = 4.47

		local var_1_0 = {
			zh = 4.466,
			ja = 4
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
				arg_1_0:Play321401002(arg_1_1)
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

			local var_4_9 = "1111ui_story"

			if arg_1_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1111ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1111ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.87, -5.7)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1111ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1111ui_story == nil then
				arg_1_1.var_.characterEffect1111ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1111ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1111ui_story then
				arg_1_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled")

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
			local var_4_25 = 0.275

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(321401001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 11 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 11)

				if (11 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 11)) > 0 and var_4_25 < var_4_30 then
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

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401001", "story_v_out_321401.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_321401", "321401001", "story_v_out_321401.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_321401", "321401001", "story_v_out_321401.awb")

						arg_1_1:RecordAudio("321401001", var_4_32)
						arg_1_1:RecordAudio("321401001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_321401", "321401001", "story_v_out_321401.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_321401", "321401001", "story_v_out_321401.awb")
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
				actorName = "1111ui_story",
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
	Play321401002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321401002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321401003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1111ui_story = arg_9_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1111ui_story"].transform.position).z)
				arg_9_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1111ui_story"].transform.localEulerAngles = arg_9_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1111ui_story"].transform.position).z)
				arg_9_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1111ui_story"].transform.localEulerAngles = arg_9_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_12_1 = 0
			local var_12_2 = 1.175

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(321401002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 47 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 47)

				if (47 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 47)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play321401003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321401003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play321401004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0.05 < arg_13_1.time_ and arg_13_1.time_ <= 0.05 + arg_16_0 then
				arg_13_1:AudioAction("play", "effect", "se_story_140", "se_story_140_reaction", "")
			end

			local var_16_1 = 0
			local var_16_2 = 1.3

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(321401003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 52 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 52)

				if (52 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 52)) > 0 and var_16_2 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_6 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_6 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_6

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_6 and arg_13_1.time_ < var_16_1 + var_16_6 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play321401004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321401004
		arg_17_1.duration_ = 3.6

		local var_17_0 = {
			zh = 3.6,
			ja = 2.433
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
				arg_17_0:Play321401005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1111ui_story = arg_17_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1111ui_story"].transform.position).z)
				arg_17_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1111ui_story"].transform.localEulerAngles = arg_17_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_17_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1111ui_story"].transform.position).z)
				arg_17_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1111ui_story"].transform.localEulerAngles = arg_17_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1111ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1111ui_story == nil then
				arg_17_1.var_.characterEffect1111ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1111ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1111ui_story then
				arg_17_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_20_4 = 0
			local var_20_5 = 0.175

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(321401004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 7 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 7)

				if (7 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 7)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401004", "story_v_out_321401.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_321401", "321401004", "story_v_out_321401.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_321401", "321401004", "story_v_out_321401.awb")

						arg_17_1:RecordAudio("321401004", var_20_11)
						arg_17_1:RecordAudio("321401004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_321401", "321401004", "story_v_out_321401.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_321401", "321401004", "story_v_out_321401.awb")
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
				actorName = "1111ui_story",
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
	Play321401005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321401005
		arg_21_1.duration_ = 6.8

		local var_21_0 = {
			zh = 4.066,
			ja = 6.8
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
				arg_21_0:Play321401006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["10131ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10131ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "10131ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["10131ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["10131ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["10131ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["10131ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["10131ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10131ui_story = var_24_3.localPosition
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0.83, -0.96, -5.8)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			local var_24_5 = arg_21_1.actors_["10131ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect10131ui_story == nil then
				arg_21_1.var_.characterEffect10131ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.characterEffect10131ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect10131ui_story then
				arg_21_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_24_8 = arg_21_1.actors_["1111ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.characterEffect1111ui_story == nil then
				arg_21_1.var_.characterEffect1111ui_story = var_24_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_9 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_9 and not isNil(var_24_8) then
				if arg_21_1.var_.characterEffect1111ui_story and not isNil(var_24_8) then
					arg_21_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_9)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_9 and arg_21_1.time_ < 0 + var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.characterEffect1111ui_story then
				arg_21_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_24_10 = 0
			local var_24_11 = 0.4

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_12 = arg_21_1:GetWordFromCfg(321401005)
				local var_24_13 = arg_21_1:FormatText(var_24_12.content)

				arg_21_1.text_.text = var_24_13

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_15 = 16 <= 0 and var_24_11 or var_24_11 * (utf8.len(var_24_13) / 16)

				if (16 <= 0 and var_24_11 or var_24_11 * (utf8.len(var_24_13) / 16)) > 0 and var_24_11 < var_24_15 then
					arg_21_1.talkMaxDuration = var_24_15

					if var_24_15 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_10
					end
				end

				arg_21_1.text_.text = var_24_13
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401005", "story_v_out_321401.awb") ~= 0 then
					local var_24_16 = manager.audio:GetVoiceLength("story_v_out_321401", "321401005", "story_v_out_321401.awb") / 1000

					if var_24_16 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_10
					end

					if var_24_12.prefab_name ~= "" and arg_21_1.actors_[var_24_12.prefab_name] ~= nil then
						local var_24_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_12.prefab_name].transform, "story_v_out_321401", "321401005", "story_v_out_321401.awb")

						arg_21_1:RecordAudio("321401005", var_24_17)
						arg_21_1:RecordAudio("321401005", var_24_17)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_321401", "321401005", "story_v_out_321401.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_321401", "321401005", "story_v_out_321401.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_18 = math.max(var_24_11, arg_21_1.talkMaxDuration)

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_18 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_10) / var_24_18

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_10 + var_24_18 and arg_21_1.time_ < var_24_10 + var_24_18 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play321401006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321401006
		arg_25_1.duration_ = 5.23

		local var_25_0 = {
			zh = 3.9,
			ja = 5.233
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
				arg_25_0:Play321401007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1111ui_story = arg_25_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).z)
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles = arg_25_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_25_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).z)
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles = arg_25_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1111ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1111ui_story == nil then
				arg_25_1.var_.characterEffect1111ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1111ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1111ui_story then
				arg_25_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_28_4 = arg_25_1.actors_["10131ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect10131ui_story == nil then
				arg_25_1.var_.characterEffect10131ui_story = var_28_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_5 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_5 and not isNil(var_28_4) then
				if arg_25_1.var_.characterEffect10131ui_story and not isNil(var_28_4) then
					arg_25_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_5)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_5 and arg_25_1.time_ < 0 + var_28_5 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect10131ui_story then
				arg_25_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_28_6 = 0
			local var_28_7 = 0.4

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_8 = arg_25_1:GetWordFromCfg(321401006)
				local var_28_9 = arg_25_1:FormatText(var_28_8.content)

				arg_25_1.text_.text = var_28_9

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 16 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_9) / 16)

				if (16 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_9) / 16)) > 0 and var_28_7 < var_28_11 then
					arg_25_1.talkMaxDuration = var_28_11

					if var_28_11 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_9
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401006", "story_v_out_321401.awb") ~= 0 then
					local var_28_12 = manager.audio:GetVoiceLength("story_v_out_321401", "321401006", "story_v_out_321401.awb") / 1000

					if var_28_12 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_6
					end

					if var_28_8.prefab_name ~= "" and arg_25_1.actors_[var_28_8.prefab_name] ~= nil then
						local var_28_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_8.prefab_name].transform, "story_v_out_321401", "321401006", "story_v_out_321401.awb")

						arg_25_1:RecordAudio("321401006", var_28_13)
						arg_25_1:RecordAudio("321401006", var_28_13)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_321401", "321401006", "story_v_out_321401.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_321401", "321401006", "story_v_out_321401.awb")
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
				actorName = "1111ui_story",
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
	Play321401007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321401007
		arg_29_1.duration_ = 7.37

		local var_29_0 = {
			zh = 5.833,
			ja = 7.366
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
				arg_29_0:Play321401008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_32_0 = 0
			local var_32_1 = 0.65

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(321401007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 26 <= 0 and var_32_1 or var_32_1 * (utf8.len(var_32_3) / 26)

				if (26 <= 0 and var_32_1 or var_32_1 * (utf8.len(var_32_3) / 26)) > 0 and var_32_1 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401007", "story_v_out_321401.awb") ~= 0 then
					local var_32_6 = manager.audio:GetVoiceLength("story_v_out_321401", "321401007", "story_v_out_321401.awb") / 1000

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end

					if var_32_2.prefab_name ~= "" and arg_29_1.actors_[var_32_2.prefab_name] ~= nil then
						local var_32_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_2.prefab_name].transform, "story_v_out_321401", "321401007", "story_v_out_321401.awb")

						arg_29_1:RecordAudio("321401007", var_32_7)
						arg_29_1:RecordAudio("321401007", var_32_7)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_321401", "321401007", "story_v_out_321401.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_321401", "321401007", "story_v_out_321401.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play321401008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321401008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play321401009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1111ui_story = arg_33_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).z)
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles = arg_33_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).z)
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles = arg_33_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["10131ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10131ui_story = var_36_1.localPosition
			end

			local var_36_2 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 then
				var_36_1.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_2)
				var_36_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_1.position).x, (manager.ui.mainCamera.transform.position - var_36_1.position).y, (manager.ui.mainCamera.transform.position - var_36_1.position).z)
				var_36_1.localEulerAngles.z = 0
				var_36_1.localEulerAngles.x = 0
				var_36_1.localEulerAngles = var_36_1.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 then
				var_36_1.localPosition = Vector3.New(0, 100, 0)
				var_36_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_1.position).x, (manager.ui.mainCamera.transform.position - var_36_1.position).y, (manager.ui.mainCamera.transform.position - var_36_1.position).z)
				var_36_1.localEulerAngles.z = 0
				var_36_1.localEulerAngles.x = 0
				var_36_1.localEulerAngles = var_36_1.localEulerAngles
			end

			local var_36_3 = arg_33_1.actors_["1111ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.characterEffect1111ui_story == nil then
				arg_33_1.var_.characterEffect1111ui_story = var_36_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_4 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 and not isNil(var_36_3) then
				if arg_33_1.var_.characterEffect1111ui_story and not isNil(var_36_3) then
					arg_33_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_4)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.characterEffect1111ui_story then
				arg_33_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0.05 < arg_33_1.time_ and arg_33_1.time_ <= 0.05 + arg_36_0 then
				arg_33_1:AudioAction("play", "effect", "se_story_141", "se_story_141_door03", "")
			end

			local var_36_6 = 0
			local var_36_7 = 1.175

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(321401008).content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 47 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_8) / 47)

				if (47 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_8) / 47)) > 0 and var_36_7 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_11 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_11 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_11

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_11 and arg_33_1.time_ < var_36_6 + var_36_11 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play321401009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321401009
		arg_37_1.duration_ = 2

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play321401010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1111ui_story = arg_37_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1111ui_story"].transform.position).z)
				arg_37_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1111ui_story"].transform.localEulerAngles = arg_37_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_37_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1111ui_story"].transform.position).z)
				arg_37_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1111ui_story"].transform.localEulerAngles = arg_37_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1111ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1111ui_story == nil then
				arg_37_1.var_.characterEffect1111ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1111ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1111ui_story then
				arg_37_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_40_4 = 0
			local var_40_5 = 0.05

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(321401009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 2 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 2)

				if (2 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 2)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401009", "story_v_out_321401.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_321401", "321401009", "story_v_out_321401.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_321401", "321401009", "story_v_out_321401.awb")

						arg_37_1:RecordAudio("321401009", var_40_11)
						arg_37_1:RecordAudio("321401009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_321401", "321401009", "story_v_out_321401.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_321401", "321401009", "story_v_out_321401.awb")
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

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play321401010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 321401010
		arg_41_1.duration_ = 8.8

		local var_41_0 = {
			zh = 7.60000000298023,
			ja = 8.80000000298023
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
				arg_41_0:Play321401011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if arg_41_1.bgs_.L11f == nil then
				local var_44_0 = Object.Instantiate(arg_41_1.paintGo_)

				var_44_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L11f")
				var_44_0.name = "L11f"
				var_44_0.transform.parent = arg_41_1.stage_.transform
				var_44_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.bgs_.L11f = var_44_0
			end

			if 1.98333333333333 < arg_41_1.time_ and arg_41_1.time_ <= 1.98333333333333 + arg_44_0 then
				local var_44_1 = arg_41_1.bgs_.L11f

				arg_41_1.bgs_.L11f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_44_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_44_2 = var_44_1:GetComponent("SpriteRenderer")

				if var_44_2 and var_44_2.sprite then
					local var_44_3 = 2 * (var_44_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_44_1.transform.localScale = Vector3.New(var_44_3 / var_44_2.sprite.bounds.size.y < var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x and var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x or var_44_3 / var_44_2.sprite.bounds.size.y, var_44_3 / var_44_2.sprite.bounds.size.y < var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x and var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x or var_44_3 / var_44_2.sprite.bounds.size.y, 0)
				end

				for iter_44_0, iter_44_1 in pairs(arg_41_1.bgs_) do
					if iter_44_0 ~= "L11f" then
						iter_44_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_44_4 = 4.00000000298023

			if 4.00000000298023 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			if arg_41_1.time_ >= var_44_4 + 0.3 and arg_41_1.time_ < var_44_4 + 0.3 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end

			local var_44_5 = 0

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_6 = 2

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 then
				local var_44_7 = Color.New(0, 0, 0)

				var_44_7.a = Mathf.Lerp(0, 1, (arg_41_1.time_ - var_44_5) / var_44_6)
				arg_41_1.mask_.color = var_44_7
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 then
				local var_44_8 = Color.New(0, 0, 0)

				var_44_8.a = 1
				arg_41_1.mask_.color = var_44_8
			end

			local var_44_9 = 2.00000000298023

			if 2.00000000298023 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_10 = 2

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 then
				local var_44_11 = Color.New(0, 0, 0)

				var_44_11.a = Mathf.Lerp(1, 0, (arg_41_1.time_ - var_44_9) / var_44_10)
				arg_41_1.mask_.color = var_44_11
			end

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 then
				local var_44_12 = Color.New(0, 0, 0)

				arg_41_1.mask_.enabled = false
				var_44_12.a = 0
				arg_41_1.mask_.color = var_44_12
			end

			local var_44_13 = "1211ui_story"

			if arg_41_1.actors_["1211ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1211ui_story"))) then
				local var_44_14 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_41_1.stage_.transform)

				var_44_14.name = var_44_13
				var_44_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_[var_44_13] = var_44_14

				local var_44_15 = var_44_14:GetComponentInChildren(typeof(CharacterEffect))

				var_44_15.enabled = true

				local var_44_16 = GameObjectTools.GetOrAddComponent(var_44_14, typeof(DynamicBoneHelper))

				if var_44_16 then
					var_44_16:EnableDynamicBone(false)
				end

				arg_41_1:ShowWeapon(var_44_15.transform, false)

				arg_41_1.var_[var_44_13 .. "Animator"] = var_44_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_41_1.var_[var_44_13 .. "Animator"].applyRootMotion = true
				arg_41_1.var_[var_44_13 .. "LipSync"] = var_44_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_44_17 = arg_41_1.actors_["1211ui_story"].transform

			if 3.8 < arg_41_1.time_ and arg_41_1.time_ <= 3.8 + arg_44_0 then
				arg_41_1.var_.moveOldPos1211ui_story = var_44_17.localPosition
			end

			local var_44_18 = 0.001

			if 3.8 <= arg_41_1.time_ and arg_41_1.time_ < 3.8 + var_44_18 then
				var_44_17.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1211ui_story, Vector3.New(0, -0.67, -6.07), (arg_41_1.time_ - 3.8) / var_44_18)
				var_44_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_17.position).x, (manager.ui.mainCamera.transform.position - var_44_17.position).y, (manager.ui.mainCamera.transform.position - var_44_17.position).z)
				var_44_17.localEulerAngles.z = 0
				var_44_17.localEulerAngles.x = 0
				var_44_17.localEulerAngles = var_44_17.localEulerAngles
			end

			if arg_41_1.time_ >= 3.8 + var_44_18 and arg_41_1.time_ < 3.8 + var_44_18 + arg_44_0 then
				var_44_17.localPosition = Vector3.New(0, -0.67, -6.07)
				var_44_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_17.position).x, (manager.ui.mainCamera.transform.position - var_44_17.position).y, (manager.ui.mainCamera.transform.position - var_44_17.position).z)
				var_44_17.localEulerAngles.z = 0
				var_44_17.localEulerAngles.x = 0
				var_44_17.localEulerAngles = var_44_17.localEulerAngles
			end

			local var_44_19 = arg_41_1.actors_["1211ui_story"]

			if 3.8 < arg_41_1.time_ and arg_41_1.time_ <= 3.8 + arg_44_0 and not isNil(var_44_19) and arg_41_1.var_.characterEffect1211ui_story == nil then
				arg_41_1.var_.characterEffect1211ui_story = var_44_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_20 = 0.200000002980232

			if 3.8 <= arg_41_1.time_ and arg_41_1.time_ < 3.8 + var_44_20 and not isNil(var_44_19) then
				if arg_41_1.var_.characterEffect1211ui_story and not isNil(var_44_19) then
					arg_41_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 3.8 + var_44_20 and arg_41_1.time_ < 3.8 + var_44_20 + arg_44_0 and not isNil(var_44_19) and arg_41_1.var_.characterEffect1211ui_story then
				arg_41_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_44_22 = arg_41_1.actors_["1111ui_story"]

			if 1.98333333333333 < arg_41_1.time_ and arg_41_1.time_ <= 1.98333333333333 + arg_44_0 and not isNil(var_44_22) and arg_41_1.var_.characterEffect1111ui_story == nil then
				arg_41_1.var_.characterEffect1111ui_story = var_44_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_23 = 0.0166666666666667

			if 1.98333333333333 <= arg_41_1.time_ and arg_41_1.time_ < 1.98333333333333 + var_44_23 and not isNil(var_44_22) then
				if arg_41_1.var_.characterEffect1111ui_story and not isNil(var_44_22) then
					arg_41_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 1.98333333333333) / var_44_23)
				end
			end

			if arg_41_1.time_ >= 1.98333333333333 + var_44_23 and arg_41_1.time_ < 1.98333333333333 + var_44_23 + arg_44_0 and not isNil(var_44_22) and arg_41_1.var_.characterEffect1111ui_story then
				arg_41_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 3.8 < arg_41_1.time_ and arg_41_1.time_ <= 3.8 + arg_44_0 then
				arg_41_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 3.8 < arg_41_1.time_ and arg_41_1.time_ <= 3.8 + arg_44_0 then
				arg_41_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_44_24 = arg_41_1.actors_["1111ui_story"].transform

			if 1.96599999815226 < arg_41_1.time_ and arg_41_1.time_ <= 1.96599999815226 + arg_44_0 then
				arg_41_1.var_.moveOldPos1111ui_story = var_44_24.localPosition
			end

			local var_44_25 = 0.001

			if 1.96599999815226 <= arg_41_1.time_ and arg_41_1.time_ < 1.96599999815226 + var_44_25 then
				var_44_24.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 1.96599999815226) / var_44_25)
				var_44_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_24.position).x, (manager.ui.mainCamera.transform.position - var_44_24.position).y, (manager.ui.mainCamera.transform.position - var_44_24.position).z)
				var_44_24.localEulerAngles.z = 0
				var_44_24.localEulerAngles.x = 0
				var_44_24.localEulerAngles = var_44_24.localEulerAngles
			end

			if arg_41_1.time_ >= 1.96599999815226 + var_44_25 and arg_41_1.time_ < 1.96599999815226 + var_44_25 + arg_44_0 then
				var_44_24.localPosition = Vector3.New(0, 100, 0)
				var_44_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_24.position).x, (manager.ui.mainCamera.transform.position - var_44_24.position).y, (manager.ui.mainCamera.transform.position - var_44_24.position).z)
				var_44_24.localEulerAngles.z = 0
				var_44_24.localEulerAngles.x = 0
				var_44_24.localEulerAngles = var_44_24.localEulerAngles
			end

			if arg_41_1.frameCnt_ <= 1 then
				arg_41_1.dialog_:SetActive(false)
			end

			local var_44_26 = 3.90000000298023
			local var_44_27 = 0.4

			if 3.90000000298023 < arg_41_1.time_ and arg_41_1.time_ <= var_44_26 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_28 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_28:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_29 = arg_41_1:GetWordFromCfg(321401010)
				local var_44_30 = arg_41_1:FormatText(var_44_29.content)

				arg_41_1.text_.text = var_44_30

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_32 = 16 <= 0 and var_44_27 or var_44_27 * (utf8.len(var_44_30) / 16)

				if (16 <= 0 and var_44_27 or var_44_27 * (utf8.len(var_44_30) / 16)) > 0 and var_44_27 < var_44_32 then
					arg_41_1.talkMaxDuration = var_44_32
					var_44_26 = var_44_26 + 0.3

					if var_44_32 + var_44_26 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_32 + var_44_26
					end
				end

				arg_41_1.text_.text = var_44_30
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401010", "story_v_out_321401.awb") ~= 0 then
					local var_44_33 = manager.audio:GetVoiceLength("story_v_out_321401", "321401010", "story_v_out_321401.awb") / 1000

					if var_44_33 + var_44_26 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_33 + var_44_26
					end

					if var_44_29.prefab_name ~= "" and arg_41_1.actors_[var_44_29.prefab_name] ~= nil then
						local var_44_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_29.prefab_name].transform, "story_v_out_321401", "321401010", "story_v_out_321401.awb")

						arg_41_1:RecordAudio("321401010", var_44_34)
						arg_41_1:RecordAudio("321401010", var_44_34)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_321401", "321401010", "story_v_out_321401.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_321401", "321401010", "story_v_out_321401.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_35 = var_44_26 + 0.3
			local var_44_36 = math.max(var_44_27, arg_41_1.talkMaxDuration)

			if var_44_26 + 0.3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_35 + var_44_36 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_35) / var_44_36

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_35 + var_44_36 and arg_41_1.time_ < var_44_35 + var_44_36 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play321401011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 321401011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play321401012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1211ui_story = arg_47_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1211ui_story"].transform.position).z)
				arg_47_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1211ui_story"].transform.localEulerAngles = arg_47_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1211ui_story"].transform.position).z)
				arg_47_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1211ui_story"].transform.localEulerAngles = arg_47_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_50_1 = arg_47_1.actors_["1211ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1211ui_story == nil then
				arg_47_1.var_.characterEffect1211ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect1211ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_2)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1211ui_story then
				arg_47_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0.05 < arg_47_1.time_ and arg_47_1.time_ <= 0.05 + arg_50_0 then
				arg_47_1:AudioAction("play", "effect", "se_story_141", "se_story_141_spaceclose", "")
			end

			local var_50_4 = 0
			local var_50_5 = 1.525

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(321401011).content)

				arg_47_1.text_.text = var_50_6

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_8 = 61 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_6) / 61)

				if (61 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_6) / 61)) > 0 and var_50_5 < var_50_8 then
					arg_47_1.talkMaxDuration = var_50_8

					if var_50_8 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_4
					end
				end

				arg_47_1.text_.text = var_50_6
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_9 = math.max(var_50_5, arg_47_1.talkMaxDuration)

			if var_50_4 <= arg_47_1.time_ and arg_47_1.time_ < var_50_4 + var_50_9 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_4) / var_50_9

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_4 + var_50_9 and arg_47_1.time_ < var_50_4 + var_50_9 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play321401012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 321401012
		arg_51_1.duration_ = 8.7

		local var_51_0 = {
			zh = 4.9,
			ja = 8.7
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
				arg_51_0:Play321401013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if arg_51_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_54_0 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_51_1.stage_.transform)

				var_54_0.name = "1061ui_story"
				var_54_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_["1061ui_story"] = var_54_0

				local var_54_1 = var_54_0:GetComponentInChildren(typeof(CharacterEffect))

				var_54_1.enabled = true

				local var_54_2 = GameObjectTools.GetOrAddComponent(var_54_0, typeof(DynamicBoneHelper))

				if var_54_2 then
					var_54_2:EnableDynamicBone(false)
				end

				arg_51_1:ShowWeapon(var_54_1.transform, false)

				arg_51_1.var_["1061ui_story" .. "Animator"] = var_54_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_51_1.var_["1061ui_story" .. "Animator"].applyRootMotion = true
				arg_51_1.var_["1061ui_story" .. "LipSync"] = var_54_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_54_3 = arg_51_1.actors_["1061ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1061ui_story = var_54_3.localPosition
			end

			local var_54_4 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				var_54_3.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_51_1.time_ - 0) / var_54_4)
				var_54_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_3.position).x, (manager.ui.mainCamera.transform.position - var_54_3.position).y, (manager.ui.mainCamera.transform.position - var_54_3.position).z)
				var_54_3.localEulerAngles.z = 0
				var_54_3.localEulerAngles.x = 0
				var_54_3.localEulerAngles = var_54_3.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				var_54_3.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				var_54_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_3.position).x, (manager.ui.mainCamera.transform.position - var_54_3.position).y, (manager.ui.mainCamera.transform.position - var_54_3.position).z)
				var_54_3.localEulerAngles.z = 0
				var_54_3.localEulerAngles.x = 0
				var_54_3.localEulerAngles = var_54_3.localEulerAngles
			end

			local var_54_5 = arg_51_1.actors_["1061ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_5) and arg_51_1.var_.characterEffect1061ui_story == nil then
				arg_51_1.var_.characterEffect1061ui_story = var_54_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_6 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_6 and not isNil(var_54_5) then
				if arg_51_1.var_.characterEffect1061ui_story and not isNil(var_54_5) then
					arg_51_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_6 and arg_51_1.time_ < 0 + var_54_6 + arg_54_0 and not isNil(var_54_5) and arg_51_1.var_.characterEffect1061ui_story then
				arg_51_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_54_8 = 0
			local var_54_9 = 0.65

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_8 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_10 = arg_51_1:GetWordFromCfg(321401012)
				local var_54_11 = arg_51_1:FormatText(var_54_10.content)

				arg_51_1.text_.text = var_54_11

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_13 = 26 <= 0 and var_54_9 or var_54_9 * (utf8.len(var_54_11) / 26)

				if (26 <= 0 and var_54_9 or var_54_9 * (utf8.len(var_54_11) / 26)) > 0 and var_54_9 < var_54_13 then
					arg_51_1.talkMaxDuration = var_54_13

					if var_54_13 + var_54_8 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_13 + var_54_8
					end
				end

				arg_51_1.text_.text = var_54_11
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401012", "story_v_out_321401.awb") ~= 0 then
					local var_54_14 = manager.audio:GetVoiceLength("story_v_out_321401", "321401012", "story_v_out_321401.awb") / 1000

					if var_54_14 + var_54_8 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_14 + var_54_8
					end

					if var_54_10.prefab_name ~= "" and arg_51_1.actors_[var_54_10.prefab_name] ~= nil then
						local var_54_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_10.prefab_name].transform, "story_v_out_321401", "321401012", "story_v_out_321401.awb")

						arg_51_1:RecordAudio("321401012", var_54_15)
						arg_51_1:RecordAudio("321401012", var_54_15)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_321401", "321401012", "story_v_out_321401.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_321401", "321401012", "story_v_out_321401.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_16 = math.max(var_54_9, arg_51_1.talkMaxDuration)

			if var_54_8 <= arg_51_1.time_ and arg_51_1.time_ < var_54_8 + var_54_16 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_8) / var_54_16

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_8 + var_54_16 and arg_51_1.time_ < var_54_8 + var_54_16 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
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

		arg_51_1:InitPlayNodeList()
	end,
	Play321401013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 321401013
		arg_55_1.duration_ = 9.57

		local var_55_0 = {
			zh = 7,
			ja = 9.566
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
				arg_55_0:Play321401014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1211ui_story = arg_55_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1211ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1211ui_story"].transform.position).z)
				arg_55_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1211ui_story"].transform.localEulerAngles = arg_55_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0.7, -0.67, -6.07)
				arg_55_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1211ui_story"].transform.position).z)
				arg_55_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1211ui_story"].transform.localEulerAngles = arg_55_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["1211ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1211ui_story == nil then
				arg_55_1.var_.characterEffect1211ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect1211ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1211ui_story then
				arg_55_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_58_4 = arg_55_1.actors_["1061ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_4) and arg_55_1.var_.characterEffect1061ui_story == nil then
				arg_55_1.var_.characterEffect1061ui_story = var_58_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_5 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_5 and not isNil(var_58_4) then
				if arg_55_1.var_.characterEffect1061ui_story and not isNil(var_58_4) then
					arg_55_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_5)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_5 and arg_55_1.time_ < 0 + var_58_5 + arg_58_0 and not isNil(var_58_4) and arg_55_1.var_.characterEffect1061ui_story then
				arg_55_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_2")
			end

			local var_58_6 = 0
			local var_58_7 = 0.85

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_8 = arg_55_1:GetWordFromCfg(321401013)
				local var_58_9 = arg_55_1:FormatText(var_58_8.content)

				arg_55_1.text_.text = var_58_9

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_11 = 34 <= 0 and var_58_7 or var_58_7 * (utf8.len(var_58_9) / 34)

				if (34 <= 0 and var_58_7 or var_58_7 * (utf8.len(var_58_9) / 34)) > 0 and var_58_7 < var_58_11 then
					arg_55_1.talkMaxDuration = var_58_11

					if var_58_11 + var_58_6 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_11 + var_58_6
					end
				end

				arg_55_1.text_.text = var_58_9
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401013", "story_v_out_321401.awb") ~= 0 then
					local var_58_12 = manager.audio:GetVoiceLength("story_v_out_321401", "321401013", "story_v_out_321401.awb") / 1000

					if var_58_12 + var_58_6 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_12 + var_58_6
					end

					if var_58_8.prefab_name ~= "" and arg_55_1.actors_[var_58_8.prefab_name] ~= nil then
						local var_58_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_8.prefab_name].transform, "story_v_out_321401", "321401013", "story_v_out_321401.awb")

						arg_55_1:RecordAudio("321401013", var_58_13)
						arg_55_1:RecordAudio("321401013", var_58_13)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_321401", "321401013", "story_v_out_321401.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_321401", "321401013", "story_v_out_321401.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_14 = math.max(var_58_7, arg_55_1.talkMaxDuration)

			if var_58_6 <= arg_55_1.time_ and arg_55_1.time_ < var_58_6 + var_58_14 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_6) / var_58_14

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_6 + var_58_14 and arg_55_1.time_ < var_58_6 + var_58_14 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play321401014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 321401014
		arg_59_1.duration_ = 14.13

		local var_59_0 = {
			zh = 9.3,
			ja = 14.133
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
				arg_59_0:Play321401015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1061ui_story = arg_59_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1061ui_story"].transform.position).z)
				arg_59_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1061ui_story"].transform.localEulerAngles = arg_59_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_59_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1061ui_story"].transform.position).z)
				arg_59_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1061ui_story"].transform.localEulerAngles = arg_59_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_62_1 = arg_59_1.actors_["1061ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1061ui_story == nil then
				arg_59_1.var_.characterEffect1061ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect1061ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1061ui_story then
				arg_59_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_62_4 = arg_59_1.actors_["1211ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_4) and arg_59_1.var_.characterEffect1211ui_story == nil then
				arg_59_1.var_.characterEffect1211ui_story = var_62_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_5 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_5 and not isNil(var_62_4) then
				if arg_59_1.var_.characterEffect1211ui_story and not isNil(var_62_4) then
					arg_59_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_5)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_5 and arg_59_1.time_ < 0 + var_62_5 + arg_62_0 and not isNil(var_62_4) and arg_59_1.var_.characterEffect1211ui_story then
				arg_59_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_62_6 = 0
			local var_62_7 = 1.025

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_8 = arg_59_1:GetWordFromCfg(321401014)
				local var_62_9 = arg_59_1:FormatText(var_62_8.content)

				arg_59_1.text_.text = var_62_9

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_11 = 41 <= 0 and var_62_7 or var_62_7 * (utf8.len(var_62_9) / 41)

				if (41 <= 0 and var_62_7 or var_62_7 * (utf8.len(var_62_9) / 41)) > 0 and var_62_7 < var_62_11 then
					arg_59_1.talkMaxDuration = var_62_11

					if var_62_11 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_11 + var_62_6
					end
				end

				arg_59_1.text_.text = var_62_9
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401014", "story_v_out_321401.awb") ~= 0 then
					local var_62_12 = manager.audio:GetVoiceLength("story_v_out_321401", "321401014", "story_v_out_321401.awb") / 1000

					if var_62_12 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_12 + var_62_6
					end

					if var_62_8.prefab_name ~= "" and arg_59_1.actors_[var_62_8.prefab_name] ~= nil then
						local var_62_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_8.prefab_name].transform, "story_v_out_321401", "321401014", "story_v_out_321401.awb")

						arg_59_1:RecordAudio("321401014", var_62_13)
						arg_59_1:RecordAudio("321401014", var_62_13)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_321401", "321401014", "story_v_out_321401.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_321401", "321401014", "story_v_out_321401.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_14 = math.max(var_62_7, arg_59_1.talkMaxDuration)

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_14 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_6) / var_62_14

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_6 + var_62_14 and arg_59_1.time_ < var_62_6 + var_62_14 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
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

		arg_59_1:InitPlayNodeList()
	end,
	Play321401015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 321401015
		arg_63_1.duration_ = 5.57

		local var_63_0 = {
			zh = 5.566,
			ja = 5.133
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
				arg_63_0:Play321401016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1061ui_story = arg_63_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_63_1.time_ - 0) / var_66_0)
				arg_63_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1061ui_story"].transform.position).z)
				arg_63_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1061ui_story"].transform.localEulerAngles = arg_63_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_63_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1061ui_story"].transform.position).z)
				arg_63_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1061ui_story"].transform.localEulerAngles = arg_63_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_66_1 = 0
			local var_66_2 = 0.475

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_3 = arg_63_1:GetWordFromCfg(321401015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_6 = 19 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_4) / 19)

				if (19 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_4) / 19)) > 0 and var_66_2 < var_66_6 then
					arg_63_1.talkMaxDuration = var_66_6

					if var_66_6 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_6 + var_66_1
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401015", "story_v_out_321401.awb") ~= 0 then
					local var_66_7 = manager.audio:GetVoiceLength("story_v_out_321401", "321401015", "story_v_out_321401.awb") / 1000

					if var_66_7 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_1
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_321401", "321401015", "story_v_out_321401.awb")

						arg_63_1:RecordAudio("321401015", var_66_8)
						arg_63_1:RecordAudio("321401015", var_66_8)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_321401", "321401015", "story_v_out_321401.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_321401", "321401015", "story_v_out_321401.awb")
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

		arg_63_1.nodeConfigList_ = {
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

		arg_63_1:InitPlayNodeList()
	end,
	Play321401016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 321401016
		arg_67_1.duration_ = 4.97

		local var_67_0 = {
			zh = 4.633,
			ja = 4.966
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
				arg_67_0:Play321401017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1211ui_story = arg_67_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1211ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1211ui_story"].transform.position).z)
				arg_67_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1211ui_story"].transform.localEulerAngles = arg_67_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0.7, -0.67, -6.07)
				arg_67_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1211ui_story"].transform.position).z)
				arg_67_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1211ui_story"].transform.localEulerAngles = arg_67_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_70_1 = arg_67_1.actors_["1211ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1211ui_story == nil then
				arg_67_1.var_.characterEffect1211ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect1211ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1211ui_story then
				arg_67_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_70_4 = arg_67_1.actors_["1061ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_4) and arg_67_1.var_.characterEffect1061ui_story == nil then
				arg_67_1.var_.characterEffect1061ui_story = var_70_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_5 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_5 and not isNil(var_70_4) then
				if arg_67_1.var_.characterEffect1061ui_story and not isNil(var_70_4) then
					arg_67_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_5)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_5 and arg_67_1.time_ < 0 + var_70_5 + arg_70_0 and not isNil(var_70_4) and arg_67_1.var_.characterEffect1061ui_story then
				arg_67_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_1")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_70_6 = 0
			local var_70_7 = 0.6

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_8 = arg_67_1:GetWordFromCfg(321401016)
				local var_70_9 = arg_67_1:FormatText(var_70_8.content)

				arg_67_1.text_.text = var_70_9

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_11 = 24 <= 0 and var_70_7 or var_70_7 * (utf8.len(var_70_9) / 24)

				if (24 <= 0 and var_70_7 or var_70_7 * (utf8.len(var_70_9) / 24)) > 0 and var_70_7 < var_70_11 then
					arg_67_1.talkMaxDuration = var_70_11

					if var_70_11 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_11 + var_70_6
					end
				end

				arg_67_1.text_.text = var_70_9
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401016", "story_v_out_321401.awb") ~= 0 then
					local var_70_12 = manager.audio:GetVoiceLength("story_v_out_321401", "321401016", "story_v_out_321401.awb") / 1000

					if var_70_12 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_12 + var_70_6
					end

					if var_70_8.prefab_name ~= "" and arg_67_1.actors_[var_70_8.prefab_name] ~= nil then
						local var_70_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_8.prefab_name].transform, "story_v_out_321401", "321401016", "story_v_out_321401.awb")

						arg_67_1:RecordAudio("321401016", var_70_13)
						arg_67_1:RecordAudio("321401016", var_70_13)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_321401", "321401016", "story_v_out_321401.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_321401", "321401016", "story_v_out_321401.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_14 = math.max(var_70_7, arg_67_1.talkMaxDuration)

			if var_70_6 <= arg_67_1.time_ and arg_67_1.time_ < var_70_6 + var_70_14 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_6) / var_70_14

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_6 + var_70_14 and arg_67_1.time_ < var_70_6 + var_70_14 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play321401017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 321401017
		arg_71_1.duration_ = 3.63

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play321401018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1061ui_story = arg_71_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1061ui_story"].transform.position).z)
				arg_71_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1061ui_story"].transform.localEulerAngles = arg_71_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_71_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1061ui_story"].transform.position).z)
				arg_71_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1061ui_story"].transform.localEulerAngles = arg_71_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["1061ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1061ui_story == nil then
				arg_71_1.var_.characterEffect1061ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect1061ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1061ui_story then
				arg_71_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_74_4 = arg_71_1.actors_["1211ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect1211ui_story == nil then
				arg_71_1.var_.characterEffect1211ui_story = var_74_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_5 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_5 and not isNil(var_74_4) then
				if arg_71_1.var_.characterEffect1211ui_story and not isNil(var_74_4) then
					arg_71_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_5)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_5 and arg_71_1.time_ < 0 + var_74_5 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect1211ui_story then
				arg_71_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_74_6 = 0
			local var_74_7 = 0.5

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_8 = arg_71_1:GetWordFromCfg(321401017)
				local var_74_9 = arg_71_1:FormatText(var_74_8.content)

				arg_71_1.text_.text = var_74_9

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_11 = 20 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 20)

				if (20 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 20)) > 0 and var_74_7 < var_74_11 then
					arg_71_1.talkMaxDuration = var_74_11

					if var_74_11 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_11 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_9
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401017", "story_v_out_321401.awb") ~= 0 then
					local var_74_12 = manager.audio:GetVoiceLength("story_v_out_321401", "321401017", "story_v_out_321401.awb") / 1000

					if var_74_12 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_6
					end

					if var_74_8.prefab_name ~= "" and arg_71_1.actors_[var_74_8.prefab_name] ~= nil then
						local var_74_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_8.prefab_name].transform, "story_v_out_321401", "321401017", "story_v_out_321401.awb")

						arg_71_1:RecordAudio("321401017", var_74_13)
						arg_71_1:RecordAudio("321401017", var_74_13)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_321401", "321401017", "story_v_out_321401.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_321401", "321401017", "story_v_out_321401.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_14 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_14 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_14

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_14 and arg_71_1.time_ < var_74_6 + var_74_14 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
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

		arg_71_1:InitPlayNodeList()
	end,
	Play321401018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 321401018
		arg_75_1.duration_ = 18.27

		local var_75_0 = {
			zh = 14.2,
			ja = 18.266
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
				arg_75_0:Play321401019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if arg_75_1.bgs_.L10g == nil then
				local var_78_0 = Object.Instantiate(arg_75_1.paintGo_)

				var_78_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L10g")
				var_78_0.name = "L10g"
				var_78_0.transform.parent = arg_75_1.stage_.transform
				var_78_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.bgs_.L10g = var_78_0
			end

			if 2 < arg_75_1.time_ and arg_75_1.time_ <= 2 + arg_78_0 then
				local var_78_1 = arg_75_1.bgs_.L10g

				arg_75_1.bgs_.L10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_78_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_78_2 = var_78_1:GetComponent("SpriteRenderer")

				if var_78_2 and var_78_2.sprite then
					local var_78_3 = 2 * (var_78_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_78_1.transform.localScale = Vector3.New(var_78_3 / var_78_2.sprite.bounds.size.y < var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x and var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x or var_78_3 / var_78_2.sprite.bounds.size.y, var_78_3 / var_78_2.sprite.bounds.size.y < var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x and var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x or var_78_3 / var_78_2.sprite.bounds.size.y, 0)
				end

				for iter_78_0, iter_78_1 in pairs(arg_75_1.bgs_) do
					if iter_78_0 ~= "L10g" then
						iter_78_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_78_4 = 4

			if 4 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				arg_75_1.allBtn_.enabled = false
			end

			if arg_75_1.time_ >= var_78_4 + 0.3 and arg_75_1.time_ < var_78_4 + 0.3 + arg_78_0 then
				arg_75_1.allBtn_.enabled = true
			end

			local var_78_5 = 0

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_6 = 2

			if var_78_5 <= arg_75_1.time_ and arg_75_1.time_ < var_78_5 + var_78_6 then
				local var_78_7 = Color.New(0, 0, 0)

				var_78_7.a = Mathf.Lerp(0, 1, (arg_75_1.time_ - var_78_5) / var_78_6)
				arg_75_1.mask_.color = var_78_7
			end

			if arg_75_1.time_ >= var_78_5 + var_78_6 and arg_75_1.time_ < var_78_5 + var_78_6 + arg_78_0 then
				local var_78_8 = Color.New(0, 0, 0)

				var_78_8.a = 1
				arg_75_1.mask_.color = var_78_8
			end

			local var_78_9 = 2

			if 2 < arg_75_1.time_ and arg_75_1.time_ <= var_78_9 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_10 = 2

			if var_78_9 <= arg_75_1.time_ and arg_75_1.time_ < var_78_9 + var_78_10 then
				local var_78_11 = Color.New(0, 0, 0)

				var_78_11.a = Mathf.Lerp(1, 0, (arg_75_1.time_ - var_78_9) / var_78_10)
				arg_75_1.mask_.color = var_78_11
			end

			if arg_75_1.time_ >= var_78_9 + var_78_10 and arg_75_1.time_ < var_78_9 + var_78_10 + arg_78_0 then
				local var_78_12 = Color.New(0, 0, 0)

				arg_75_1.mask_.enabled = false
				var_78_12.a = 0
				arg_75_1.mask_.color = var_78_12
			end

			local var_78_13 = arg_75_1.actors_["1061ui_story"].transform

			if 3.8 < arg_75_1.time_ and arg_75_1.time_ <= 3.8 + arg_78_0 then
				arg_75_1.var_.moveOldPos1061ui_story = var_78_13.localPosition
			end

			local var_78_14 = 0.001

			if 3.8 <= arg_75_1.time_ and arg_75_1.time_ < 3.8 + var_78_14 then
				var_78_13.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_75_1.time_ - 3.8) / var_78_14)
				var_78_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_13.position).x, (manager.ui.mainCamera.transform.position - var_78_13.position).y, (manager.ui.mainCamera.transform.position - var_78_13.position).z)
				var_78_13.localEulerAngles.z = 0
				var_78_13.localEulerAngles.x = 0
				var_78_13.localEulerAngles = var_78_13.localEulerAngles
			end

			if arg_75_1.time_ >= 3.8 + var_78_14 and arg_75_1.time_ < 3.8 + var_78_14 + arg_78_0 then
				var_78_13.localPosition = Vector3.New(0, -1.18, -6.15)
				var_78_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_13.position).x, (manager.ui.mainCamera.transform.position - var_78_13.position).y, (manager.ui.mainCamera.transform.position - var_78_13.position).z)
				var_78_13.localEulerAngles.z = 0
				var_78_13.localEulerAngles.x = 0
				var_78_13.localEulerAngles = var_78_13.localEulerAngles
			end

			if 3.8 < arg_75_1.time_ and arg_75_1.time_ <= 3.8 + arg_78_0 then
				arg_75_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 3.8 < arg_75_1.time_ and arg_75_1.time_ <= 3.8 + arg_78_0 then
				arg_75_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 3.8 < arg_75_1.time_ and arg_75_1.time_ <= 3.8 + arg_78_0 then
				if arg_75_1.var_.characterEffect1061ui_story == nil then
					arg_75_1.var_.characterEffect1061ui_story = arg_75_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_78_15 = arg_75_1.var_.characterEffect1061ui_story

				arg_75_1.var_.characterEffect1061ui_story.imageEffect:turnOff()

				var_78_15.interferenceEffect.enabled = true
				var_78_15.interferenceEffect.noise = 0.001
				var_78_15.interferenceEffect.simTimeScale = 1
				var_78_15.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 3.8 < arg_75_1.time_ and arg_75_1.time_ <= 3.8 + arg_78_0 then
				if arg_75_1.var_.characterEffect1061ui_story == nil then
					arg_75_1.var_.characterEffect1061ui_story = arg_75_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_75_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_78_17 = arg_75_1.actors_["1061ui_story"].transform

			if 2 < arg_75_1.time_ and arg_75_1.time_ <= 2 + arg_78_0 then
				arg_75_1.var_.moveOldPos1061ui_story = var_78_17.localPosition
			end

			local var_78_18 = 0.001

			if 2 <= arg_75_1.time_ and arg_75_1.time_ < 2 + var_78_18 then
				var_78_17.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 2) / var_78_18)
				var_78_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_17.position).x, (manager.ui.mainCamera.transform.position - var_78_17.position).y, (manager.ui.mainCamera.transform.position - var_78_17.position).z)
				var_78_17.localEulerAngles.z = 0
				var_78_17.localEulerAngles.x = 0
				var_78_17.localEulerAngles = var_78_17.localEulerAngles
			end

			if arg_75_1.time_ >= 2 + var_78_18 and arg_75_1.time_ < 2 + var_78_18 + arg_78_0 then
				var_78_17.localPosition = Vector3.New(0, 100, 0)
				var_78_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_17.position).x, (manager.ui.mainCamera.transform.position - var_78_17.position).y, (manager.ui.mainCamera.transform.position - var_78_17.position).z)
				var_78_17.localEulerAngles.z = 0
				var_78_17.localEulerAngles.x = 0
				var_78_17.localEulerAngles = var_78_17.localEulerAngles
			end

			local var_78_19 = arg_75_1.actors_["1211ui_story"].transform

			if 2 < arg_75_1.time_ and arg_75_1.time_ <= 2 + arg_78_0 then
				arg_75_1.var_.moveOldPos1211ui_story = var_78_19.localPosition
			end

			local var_78_20 = 0.001

			if 2 <= arg_75_1.time_ and arg_75_1.time_ < 2 + var_78_20 then
				var_78_19.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 2) / var_78_20)
				var_78_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_19.position).x, (manager.ui.mainCamera.transform.position - var_78_19.position).y, (manager.ui.mainCamera.transform.position - var_78_19.position).z)
				var_78_19.localEulerAngles.z = 0
				var_78_19.localEulerAngles.x = 0
				var_78_19.localEulerAngles = var_78_19.localEulerAngles
			end

			if arg_75_1.time_ >= 2 + var_78_20 and arg_75_1.time_ < 2 + var_78_20 + arg_78_0 then
				var_78_19.localPosition = Vector3.New(0, 100, 0)
				var_78_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_19.position).x, (manager.ui.mainCamera.transform.position - var_78_19.position).y, (manager.ui.mainCamera.transform.position - var_78_19.position).z)
				var_78_19.localEulerAngles.z = 0
				var_78_19.localEulerAngles.x = 0
				var_78_19.localEulerAngles = var_78_19.localEulerAngles
			end

			local var_78_21 = 2

			arg_75_1.isInRecall_ = false

			if var_78_21 < arg_75_1.time_ and arg_75_1.time_ <= var_78_21 + arg_78_0 then
				arg_75_1.screenFilterGo_:SetActive(true)

				arg_75_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_78_2, iter_78_3 in pairs(arg_75_1.actors_) do
					for iter_78_4, iter_78_5 in ipairs((iter_78_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_78_5.color = iter_78_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_78_22 = 0.034000001847744

			if var_78_21 <= arg_75_1.time_ and arg_75_1.time_ < var_78_21 + var_78_22 then
				arg_75_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_75_1.time_ - var_78_21) / var_78_22)
			end

			if arg_75_1.time_ >= var_78_21 + var_78_22 and arg_75_1.time_ < var_78_21 + var_78_22 + arg_78_0 then
				arg_75_1.screenFilterEffect_.weight = 1
			end

			if arg_75_1.frameCnt_ <= 1 then
				arg_75_1.dialog_:SetActive(false)
			end

			local var_78_23 = 4
			local var_78_24 = 1.3

			if 4 < arg_75_1.time_ and arg_75_1.time_ <= var_78_23 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				arg_75_1.dialog_:SetActive(true)

				arg_75_1.dialogCg_.alpha = 0

				local var_78_25 = LeanTween.value(arg_75_1.dialog_, 0, 1, 0.3)

				var_78_25:setOnUpdate(LuaHelper.FloatAction(function(arg_79_0)
					arg_75_1.dialogCg_.alpha = arg_79_0
				end))
				var_78_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_75_1.dialog_)
					var_78_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_75_1.duration_ = arg_75_1.duration_ + 0.3

				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_26 = arg_75_1:GetWordFromCfg(321401018)
				local var_78_27 = arg_75_1:FormatText(var_78_26.content)

				arg_75_1.text_.text = var_78_27

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_29 = 52 <= 0 and var_78_24 or var_78_24 * (utf8.len(var_78_27) / 52)

				if (52 <= 0 and var_78_24 or var_78_24 * (utf8.len(var_78_27) / 52)) > 0 and var_78_24 < var_78_29 then
					arg_75_1.talkMaxDuration = var_78_29
					var_78_23 = var_78_23 + 0.3

					if var_78_29 + var_78_23 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_29 + var_78_23
					end
				end

				arg_75_1.text_.text = var_78_27
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401018", "story_v_out_321401.awb") ~= 0 then
					local var_78_30 = manager.audio:GetVoiceLength("story_v_out_321401", "321401018", "story_v_out_321401.awb") / 1000

					if var_78_30 + var_78_23 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_30 + var_78_23
					end

					if var_78_26.prefab_name ~= "" and arg_75_1.actors_[var_78_26.prefab_name] ~= nil then
						local var_78_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_26.prefab_name].transform, "story_v_out_321401", "321401018", "story_v_out_321401.awb")

						arg_75_1:RecordAudio("321401018", var_78_31)
						arg_75_1:RecordAudio("321401018", var_78_31)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_321401", "321401018", "story_v_out_321401.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_321401", "321401018", "story_v_out_321401.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_32 = var_78_23 + 0.3
			local var_78_33 = math.max(var_78_24, arg_75_1.talkMaxDuration)

			if var_78_23 + 0.3 <= arg_75_1.time_ and arg_75_1.time_ < var_78_32 + var_78_33 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_32) / var_78_33

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_32 + var_78_33 and arg_75_1.time_ < var_78_32 + var_78_33 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play321401019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 321401019
		arg_81_1.duration_ = 9.2

		local var_81_0 = {
			zh = 7.5,
			ja = 9.2
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
				arg_81_0:Play321401020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_84_0 = 0
			local var_84_1 = 0.95

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_2 = arg_81_1:GetWordFromCfg(321401019)
				local var_84_3 = arg_81_1:FormatText(var_84_2.content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 38 <= 0 and var_84_1 or var_84_1 * (utf8.len(var_84_3) / 38)

				if (38 <= 0 and var_84_1 or var_84_1 * (utf8.len(var_84_3) / 38)) > 0 and var_84_1 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401019", "story_v_out_321401.awb") ~= 0 then
					local var_84_6 = manager.audio:GetVoiceLength("story_v_out_321401", "321401019", "story_v_out_321401.awb") / 1000

					if var_84_6 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_6 + var_84_0
					end

					if var_84_2.prefab_name ~= "" and arg_81_1.actors_[var_84_2.prefab_name] ~= nil then
						local var_84_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_2.prefab_name].transform, "story_v_out_321401", "321401019", "story_v_out_321401.awb")

						arg_81_1:RecordAudio("321401019", var_84_7)
						arg_81_1:RecordAudio("321401019", var_84_7)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_321401", "321401019", "story_v_out_321401.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_321401", "321401019", "story_v_out_321401.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_8 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_8 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_8

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_8 and arg_81_1.time_ < var_84_0 + var_84_8 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play321401020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 321401020
		arg_85_1.duration_ = 3.3

		local var_85_0 = {
			zh = 2.733,
			ja = 3.3
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
				arg_85_0:Play321401021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1211ui_story = arg_85_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1211ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1211ui_story"].transform.position).z)
				arg_85_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1211ui_story"].transform.localEulerAngles = arg_85_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0.7, -0.67, -6.07)
				arg_85_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1211ui_story"].transform.position).z)
				arg_85_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1211ui_story"].transform.localEulerAngles = arg_85_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1211ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1211ui_story == nil then
				arg_85_1.var_.characterEffect1211ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1211ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1211ui_story then
				arg_85_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_88_4 = arg_85_1.actors_["1061ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.characterEffect1061ui_story == nil then
				arg_85_1.var_.characterEffect1061ui_story = var_88_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_5 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_5 and not isNil(var_88_4) then
				if arg_85_1.var_.characterEffect1061ui_story and not isNil(var_88_4) then
					arg_85_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_5)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_5 and arg_85_1.time_ < 0 + var_88_5 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.characterEffect1061ui_story then
				arg_85_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_88_6 = arg_85_1.actors_["1061ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1061ui_story = var_88_6.localPosition
			end

			local var_88_7 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				var_88_6.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_85_1.time_ - 0) / var_88_7)
				var_88_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_6.position).x, (manager.ui.mainCamera.transform.position - var_88_6.position).y, (manager.ui.mainCamera.transform.position - var_88_6.position).z)
				var_88_6.localEulerAngles.z = 0
				var_88_6.localEulerAngles.x = 0
				var_88_6.localEulerAngles = var_88_6.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				var_88_6.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				var_88_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_6.position).x, (manager.ui.mainCamera.transform.position - var_88_6.position).y, (manager.ui.mainCamera.transform.position - var_88_6.position).z)
				var_88_6.localEulerAngles.z = 0
				var_88_6.localEulerAngles.x = 0
				var_88_6.localEulerAngles = var_88_6.localEulerAngles
			end

			local var_88_8 = 0
			local var_88_9 = 0.225

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
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

				local var_88_10 = arg_85_1:GetWordFromCfg(321401020)
				local var_88_11 = arg_85_1:FormatText(var_88_10.content)

				arg_85_1.text_.text = var_88_11

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 9 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 9)

				if (9 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 9)) > 0 and var_88_9 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_11
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401020", "story_v_out_321401.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_321401", "321401020", "story_v_out_321401.awb") / 1000

					if var_88_14 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_8
					end

					if var_88_10.prefab_name ~= "" and arg_85_1.actors_[var_88_10.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_10.prefab_name].transform, "story_v_out_321401", "321401020", "story_v_out_321401.awb")

						arg_85_1:RecordAudio("321401020", var_88_15)
						arg_85_1:RecordAudio("321401020", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_321401", "321401020", "story_v_out_321401.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_321401", "321401020", "story_v_out_321401.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_16 and arg_85_1.time_ < var_88_8 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
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
				actorName = "1061ui_story",
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
	Play321401021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 321401021
		arg_89_1.duration_ = 12.73

		local var_89_0 = {
			zh = 9.666,
			ja = 12.733
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
				arg_89_0:Play321401022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1061ui_story"]) and arg_89_1.var_.characterEffect1061ui_story == nil then
				arg_89_1.var_.characterEffect1061ui_story = arg_89_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1061ui_story"]) then
				if arg_89_1.var_.characterEffect1061ui_story and not isNil(arg_89_1.actors_["1061ui_story"]) then
					arg_89_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1061ui_story"]) and arg_89_1.var_.characterEffect1061ui_story then
				arg_89_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_92_2 = arg_89_1.actors_["1211ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect1211ui_story == nil then
				arg_89_1.var_.characterEffect1211ui_story = var_92_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_3 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.characterEffect1211ui_story and not isNil(var_92_2) then
					arg_89_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_3)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect1211ui_story then
				arg_89_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_92_4 = 0
			local var_92_5 = 1

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(321401021)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 40 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 40)

				if (40 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 40)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401021", "story_v_out_321401.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_321401", "321401021", "story_v_out_321401.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_321401", "321401021", "story_v_out_321401.awb")

						arg_89_1:RecordAudio("321401021", var_92_11)
						arg_89_1:RecordAudio("321401021", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_321401", "321401021", "story_v_out_321401.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_321401", "321401021", "story_v_out_321401.awb")
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

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play321401022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 321401022
		arg_93_1.duration_ = 16.07

		local var_93_0 = {
			zh = 15.166,
			ja = 16.066
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
				arg_93_0:Play321401023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 1.999999999999 < arg_93_1.time_ and arg_93_1.time_ <= 1.999999999999 + arg_96_0 then
				local var_96_0 = arg_93_1.bgs_.L11f

				arg_93_1.bgs_.L11f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_96_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_96_1 = var_96_0:GetComponent("SpriteRenderer")

				if var_96_1 and var_96_1.sprite then
					local var_96_2 = 2 * (var_96_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_96_0.transform.localScale = Vector3.New(var_96_2 / var_96_1.sprite.bounds.size.y < var_96_2 * manager.ui.mainCameraCom_.aspect / var_96_1.sprite.bounds.size.x and var_96_2 * manager.ui.mainCameraCom_.aspect / var_96_1.sprite.bounds.size.x or var_96_2 / var_96_1.sprite.bounds.size.y, var_96_2 / var_96_1.sprite.bounds.size.y < var_96_2 * manager.ui.mainCameraCom_.aspect / var_96_1.sprite.bounds.size.x and var_96_2 * manager.ui.mainCameraCom_.aspect / var_96_1.sprite.bounds.size.x or var_96_2 / var_96_1.sprite.bounds.size.y, 0)
				end

				for iter_96_0, iter_96_1 in pairs(arg_93_1.bgs_) do
					if iter_96_0 ~= "L11f" then
						iter_96_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_96_3 = 3.999999999999

			if 3.999999999999 < arg_93_1.time_ and arg_93_1.time_ <= var_96_3 + arg_96_0 then
				arg_93_1.allBtn_.enabled = false
			end

			if arg_93_1.time_ >= var_96_3 + 0.3 and arg_93_1.time_ < var_96_3 + 0.3 + arg_96_0 then
				arg_93_1.allBtn_.enabled = true
			end

			local var_96_4 = 0

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_5 = 2

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_5 then
				local var_96_6 = Color.New(0, 0, 0)

				var_96_6.a = Mathf.Lerp(0, 1, (arg_93_1.time_ - var_96_4) / var_96_5)
				arg_93_1.mask_.color = var_96_6
			end

			if arg_93_1.time_ >= var_96_4 + var_96_5 and arg_93_1.time_ < var_96_4 + var_96_5 + arg_96_0 then
				local var_96_7 = Color.New(0, 0, 0)

				var_96_7.a = 1
				arg_93_1.mask_.color = var_96_7
			end

			local var_96_8 = 2

			if 2 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_9 = 2

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_9 then
				local var_96_10 = Color.New(0, 0, 0)

				var_96_10.a = Mathf.Lerp(1, 0, (arg_93_1.time_ - var_96_8) / var_96_9)
				arg_93_1.mask_.color = var_96_10
			end

			if arg_93_1.time_ >= var_96_8 + var_96_9 and arg_93_1.time_ < var_96_8 + var_96_9 + arg_96_0 then
				local var_96_11 = Color.New(0, 0, 0)

				arg_93_1.mask_.enabled = false
				var_96_11.a = 0
				arg_93_1.mask_.color = var_96_11
			end

			local var_96_12 = 2

			arg_93_1.isInRecall_ = false

			if var_96_12 < arg_93_1.time_ and arg_93_1.time_ <= var_96_12 + arg_96_0 then
				arg_93_1.screenFilterGo_:SetActive(false)

				for iter_96_2, iter_96_3 in pairs(arg_93_1.actors_) do
					for iter_96_4, iter_96_5 in ipairs((iter_96_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_96_5.color = iter_96_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_96_13 = 0.034000001847744

			if var_96_12 <= arg_93_1.time_ and arg_93_1.time_ < var_96_12 + var_96_13 then
				arg_93_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_93_1.time_ - var_96_12) / var_96_13)
			end

			if arg_93_1.time_ >= var_96_12 + var_96_13 and arg_93_1.time_ < var_96_12 + var_96_13 + arg_96_0 then
				arg_93_1.screenFilterEffect_.weight = 0
			end

			local var_96_14 = arg_93_1.actors_["1061ui_story"].transform

			if 3.8 < arg_93_1.time_ and arg_93_1.time_ <= 3.8 + arg_96_0 then
				arg_93_1.var_.moveOldPos1061ui_story = var_96_14.localPosition
			end

			local var_96_15 = 0.001

			if 3.8 <= arg_93_1.time_ and arg_93_1.time_ < 3.8 + var_96_15 then
				var_96_14.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_93_1.time_ - 3.8) / var_96_15)
				var_96_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_14.position).x, (manager.ui.mainCamera.transform.position - var_96_14.position).y, (manager.ui.mainCamera.transform.position - var_96_14.position).z)
				var_96_14.localEulerAngles.z = 0
				var_96_14.localEulerAngles.x = 0
				var_96_14.localEulerAngles = var_96_14.localEulerAngles
			end

			if arg_93_1.time_ >= 3.8 + var_96_15 and arg_93_1.time_ < 3.8 + var_96_15 + arg_96_0 then
				var_96_14.localPosition = Vector3.New(0, -1.18, -6.15)
				var_96_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_14.position).x, (manager.ui.mainCamera.transform.position - var_96_14.position).y, (manager.ui.mainCamera.transform.position - var_96_14.position).z)
				var_96_14.localEulerAngles.z = 0
				var_96_14.localEulerAngles.x = 0
				var_96_14.localEulerAngles = var_96_14.localEulerAngles
			end

			if 3.8 < arg_93_1.time_ and arg_93_1.time_ <= 3.8 + arg_96_0 then
				arg_93_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 3.8 < arg_93_1.time_ and arg_93_1.time_ <= 3.8 + arg_96_0 then
				arg_93_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_96_16 = arg_93_1.actors_["1061ui_story"]

			if 3.8 < arg_93_1.time_ and arg_93_1.time_ <= 3.8 + arg_96_0 and not isNil(var_96_16) and arg_93_1.var_.characterEffect1061ui_story == nil then
				arg_93_1.var_.characterEffect1061ui_story = var_96_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_17 = 0.200000002980232

			if 3.8 <= arg_93_1.time_ and arg_93_1.time_ < 3.8 + var_96_17 and not isNil(var_96_16) then
				if arg_93_1.var_.characterEffect1061ui_story and not isNil(var_96_16) then
					arg_93_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 3.8 + var_96_17 and arg_93_1.time_ < 3.8 + var_96_17 + arg_96_0 and not isNil(var_96_16) and arg_93_1.var_.characterEffect1061ui_story then
				arg_93_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_96_19 = arg_93_1.actors_["1211ui_story"].transform

			if 2 < arg_93_1.time_ and arg_93_1.time_ <= 2 + arg_96_0 then
				arg_93_1.var_.moveOldPos1211ui_story = var_96_19.localPosition
			end

			local var_96_20 = 0.001

			if 2 <= arg_93_1.time_ and arg_93_1.time_ < 2 + var_96_20 then
				var_96_19.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 2) / var_96_20)
				var_96_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_19.position).x, (manager.ui.mainCamera.transform.position - var_96_19.position).y, (manager.ui.mainCamera.transform.position - var_96_19.position).z)
				var_96_19.localEulerAngles.z = 0
				var_96_19.localEulerAngles.x = 0
				var_96_19.localEulerAngles = var_96_19.localEulerAngles
			end

			if arg_93_1.time_ >= 2 + var_96_20 and arg_93_1.time_ < 2 + var_96_20 + arg_96_0 then
				var_96_19.localPosition = Vector3.New(0, 100, 0)
				var_96_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_19.position).x, (manager.ui.mainCamera.transform.position - var_96_19.position).y, (manager.ui.mainCamera.transform.position - var_96_19.position).z)
				var_96_19.localEulerAngles.z = 0
				var_96_19.localEulerAngles.x = 0
				var_96_19.localEulerAngles = var_96_19.localEulerAngles
			end

			local var_96_21 = arg_93_1.actors_["1061ui_story"].transform

			if 1.999999999999 < arg_93_1.time_ and arg_93_1.time_ <= 1.999999999999 + arg_96_0 then
				arg_93_1.var_.moveOldPos1061ui_story = var_96_21.localPosition
			end

			local var_96_22 = 0.001

			if 1.999999999999 <= arg_93_1.time_ and arg_93_1.time_ < 1.999999999999 + var_96_22 then
				var_96_21.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 1.999999999999) / var_96_22)
				var_96_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_21.position).x, (manager.ui.mainCamera.transform.position - var_96_21.position).y, (manager.ui.mainCamera.transform.position - var_96_21.position).z)
				var_96_21.localEulerAngles.z = 0
				var_96_21.localEulerAngles.x = 0
				var_96_21.localEulerAngles = var_96_21.localEulerAngles
			end

			if arg_93_1.time_ >= 1.999999999999 + var_96_22 and arg_93_1.time_ < 1.999999999999 + var_96_22 + arg_96_0 then
				var_96_21.localPosition = Vector3.New(0, 100, 0)
				var_96_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_21.position).x, (manager.ui.mainCamera.transform.position - var_96_21.position).y, (manager.ui.mainCamera.transform.position - var_96_21.position).z)
				var_96_21.localEulerAngles.z = 0
				var_96_21.localEulerAngles.x = 0
				var_96_21.localEulerAngles = var_96_21.localEulerAngles
			end

			if 1.999999999999 < arg_93_1.time_ and arg_93_1.time_ <= 1.999999999999 + arg_96_0 then
				if arg_93_1.var_.characterEffect1061ui_story == nil then
					arg_93_1.var_.characterEffect1061ui_story = arg_93_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_96_23 = arg_93_1.var_.characterEffect1061ui_story

				arg_93_1.var_.characterEffect1061ui_story.imageEffect:turnOff()

				var_96_23.interferenceEffect.enabled = false
				var_96_23.interferenceEffect.noise = 0.001
				var_96_23.interferenceEffect.simTimeScale = 1
				var_96_23.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 1.999999999999 < arg_93_1.time_ and arg_93_1.time_ <= 1.999999999999 + arg_96_0 then
				if arg_93_1.var_.characterEffect1061ui_story == nil then
					arg_93_1.var_.characterEffect1061ui_story = arg_93_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_93_1.var_.characterEffect1061ui_story.imageEffect:turnOff()
			end

			if arg_93_1.frameCnt_ <= 1 then
				arg_93_1.dialog_:SetActive(false)
			end

			local var_96_25 = 4
			local var_96_26 = 1.4

			if 4 < arg_93_1.time_ and arg_93_1.time_ <= var_96_25 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				arg_93_1.dialog_:SetActive(true)

				arg_93_1.dialogCg_.alpha = 0

				local var_96_27 = LeanTween.value(arg_93_1.dialog_, 0, 1, 0.3)

				var_96_27:setOnUpdate(LuaHelper.FloatAction(function(arg_97_0)
					arg_93_1.dialogCg_.alpha = arg_97_0
				end))
				var_96_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_93_1.dialog_)
					var_96_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_93_1.duration_ = arg_93_1.duration_ + 0.3

				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_28 = arg_93_1:GetWordFromCfg(321401022)
				local var_96_29 = arg_93_1:FormatText(var_96_28.content)

				arg_93_1.text_.text = var_96_29

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_31 = 57 <= 0 and var_96_26 or var_96_26 * (utf8.len(var_96_29) / 57)

				if (57 <= 0 and var_96_26 or var_96_26 * (utf8.len(var_96_29) / 57)) > 0 and var_96_26 < var_96_31 then
					arg_93_1.talkMaxDuration = var_96_31
					var_96_25 = var_96_25 + 0.3

					if var_96_31 + var_96_25 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_31 + var_96_25
					end
				end

				arg_93_1.text_.text = var_96_29
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401022", "story_v_out_321401.awb") ~= 0 then
					local var_96_32 = manager.audio:GetVoiceLength("story_v_out_321401", "321401022", "story_v_out_321401.awb") / 1000

					if var_96_32 + var_96_25 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_32 + var_96_25
					end

					if var_96_28.prefab_name ~= "" and arg_93_1.actors_[var_96_28.prefab_name] ~= nil then
						local var_96_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_28.prefab_name].transform, "story_v_out_321401", "321401022", "story_v_out_321401.awb")

						arg_93_1:RecordAudio("321401022", var_96_33)
						arg_93_1:RecordAudio("321401022", var_96_33)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_321401", "321401022", "story_v_out_321401.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_321401", "321401022", "story_v_out_321401.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_34 = var_96_25 + 0.3
			local var_96_35 = math.max(var_96_26, arg_93_1.talkMaxDuration)

			if var_96_25 + 0.3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_34 + var_96_35 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_34) / var_96_35

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_34 + var_96_35 and arg_93_1.time_ < var_96_34 + var_96_35 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play321401023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 321401023
		arg_99_1.duration_ = 16.77

		local var_99_0 = {
			zh = 12.2,
			ja = 16.766
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
				arg_99_0:Play321401024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1061ui_story = arg_99_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1061ui_story"].transform.position).z)
				arg_99_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1061ui_story"].transform.localEulerAngles = arg_99_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_99_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1061ui_story"].transform.position).z)
				arg_99_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1061ui_story"].transform.localEulerAngles = arg_99_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_1")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_102_1 = 0
			local var_102_2 = 1.4

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:GetWordFromCfg(321401023)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_6 = 56 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_4) / 56)

				if (56 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_4) / 56)) > 0 and var_102_2 < var_102_6 then
					arg_99_1.talkMaxDuration = var_102_6

					if var_102_6 + var_102_1 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_6 + var_102_1
					end
				end

				arg_99_1.text_.text = var_102_4
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401023", "story_v_out_321401.awb") ~= 0 then
					local var_102_7 = manager.audio:GetVoiceLength("story_v_out_321401", "321401023", "story_v_out_321401.awb") / 1000

					if var_102_7 + var_102_1 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_1
					end

					if var_102_3.prefab_name ~= "" and arg_99_1.actors_[var_102_3.prefab_name] ~= nil then
						local var_102_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_3.prefab_name].transform, "story_v_out_321401", "321401023", "story_v_out_321401.awb")

						arg_99_1:RecordAudio("321401023", var_102_8)
						arg_99_1:RecordAudio("321401023", var_102_8)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_321401", "321401023", "story_v_out_321401.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_321401", "321401023", "story_v_out_321401.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_9 = math.max(var_102_2, arg_99_1.talkMaxDuration)

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_9 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_1) / var_102_9

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_1 + var_102_9 and arg_99_1.time_ < var_102_1 + var_102_9 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
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

		arg_99_1:InitPlayNodeList()
	end,
	Play321401024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 321401024
		arg_103_1.duration_ = 12.17

		local var_103_0 = {
			zh = 8.033,
			ja = 12.166
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
				arg_103_0:Play321401025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.85

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_1 = arg_103_1:GetWordFromCfg(321401024)
				local var_106_2 = arg_103_1:FormatText(var_106_1.content)

				arg_103_1.text_.text = var_106_2

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 34 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 34)

				if (34 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 34)) > 0 and var_106_0 < var_106_4 then
					arg_103_1.talkMaxDuration = var_106_4

					if var_106_4 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_4 + 0
					end
				end

				arg_103_1.text_.text = var_106_2
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401024", "story_v_out_321401.awb") ~= 0 then
					local var_106_5 = manager.audio:GetVoiceLength("story_v_out_321401", "321401024", "story_v_out_321401.awb") / 1000

					if var_106_5 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + 0
					end

					if var_106_1.prefab_name ~= "" and arg_103_1.actors_[var_106_1.prefab_name] ~= nil then
						local var_106_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_1.prefab_name].transform, "story_v_out_321401", "321401024", "story_v_out_321401.awb")

						arg_103_1:RecordAudio("321401024", var_106_6)
						arg_103_1:RecordAudio("321401024", var_106_6)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_321401", "321401024", "story_v_out_321401.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_321401", "321401024", "story_v_out_321401.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_7 and arg_103_1.time_ < 0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play321401025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 321401025
		arg_107_1.duration_ = 4.23

		local var_107_0 = {
			zh = 2.933,
			ja = 4.233
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
				arg_107_0:Play321401026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if arg_107_1.actors_["1156ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1156ui_story"))) then
				local var_110_0 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_107_1.stage_.transform)

				var_110_0.name = "1156ui_story"
				var_110_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_107_1.actors_["1156ui_story"] = var_110_0

				local var_110_1 = var_110_0:GetComponentInChildren(typeof(CharacterEffect))

				var_110_1.enabled = true

				local var_110_2 = GameObjectTools.GetOrAddComponent(var_110_0, typeof(DynamicBoneHelper))

				if var_110_2 then
					var_110_2:EnableDynamicBone(false)
				end

				arg_107_1:ShowWeapon(var_110_1.transform, false)

				arg_107_1.var_["1156ui_story" .. "Animator"] = var_110_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_107_1.var_["1156ui_story" .. "Animator"].applyRootMotion = true
				arg_107_1.var_["1156ui_story" .. "LipSync"] = var_110_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_110_3 = arg_107_1.actors_["1156ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1156ui_story = var_110_3.localPosition
			end

			local var_110_4 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				var_110_3.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_107_1.time_ - 0) / var_110_4)
				var_110_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_3.position).x, (manager.ui.mainCamera.transform.position - var_110_3.position).y, (manager.ui.mainCamera.transform.position - var_110_3.position).z)
				var_110_3.localEulerAngles.z = 0
				var_110_3.localEulerAngles.x = 0
				var_110_3.localEulerAngles = var_110_3.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				var_110_3.localPosition = Vector3.New(0, -1.1, -6.18)
				var_110_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_3.position).x, (manager.ui.mainCamera.transform.position - var_110_3.position).y, (manager.ui.mainCamera.transform.position - var_110_3.position).z)
				var_110_3.localEulerAngles.z = 0
				var_110_3.localEulerAngles.x = 0
				var_110_3.localEulerAngles = var_110_3.localEulerAngles
			end

			local var_110_5 = arg_107_1.actors_["1061ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1061ui_story = var_110_5.localPosition
			end

			local var_110_6 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_6 then
				var_110_5.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_107_1.time_ - 0) / var_110_6)
				var_110_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_5.position).x, (manager.ui.mainCamera.transform.position - var_110_5.position).y, (manager.ui.mainCamera.transform.position - var_110_5.position).z)
				var_110_5.localEulerAngles.z = 0
				var_110_5.localEulerAngles.x = 0
				var_110_5.localEulerAngles = var_110_5.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_6 and arg_107_1.time_ < 0 + var_110_6 + arg_110_0 then
				var_110_5.localPosition = Vector3.New(0, 100, 0)
				var_110_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_5.position).x, (manager.ui.mainCamera.transform.position - var_110_5.position).y, (manager.ui.mainCamera.transform.position - var_110_5.position).z)
				var_110_5.localEulerAngles.z = 0
				var_110_5.localEulerAngles.x = 0
				var_110_5.localEulerAngles = var_110_5.localEulerAngles
			end

			local var_110_7 = arg_107_1.actors_["1211ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1211ui_story = var_110_7.localPosition
			end

			local var_110_8 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_8 then
				var_110_7.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_107_1.time_ - 0) / var_110_8)
				var_110_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_7.position).x, (manager.ui.mainCamera.transform.position - var_110_7.position).y, (manager.ui.mainCamera.transform.position - var_110_7.position).z)
				var_110_7.localEulerAngles.z = 0
				var_110_7.localEulerAngles.x = 0
				var_110_7.localEulerAngles = var_110_7.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_8 and arg_107_1.time_ < 0 + var_110_8 + arg_110_0 then
				var_110_7.localPosition = Vector3.New(0, 100, 0)
				var_110_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_7.position).x, (manager.ui.mainCamera.transform.position - var_110_7.position).y, (manager.ui.mainCamera.transform.position - var_110_7.position).z)
				var_110_7.localEulerAngles.z = 0
				var_110_7.localEulerAngles.x = 0
				var_110_7.localEulerAngles = var_110_7.localEulerAngles
			end

			local var_110_9 = arg_107_1.actors_["1156ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_9) and arg_107_1.var_.characterEffect1156ui_story == nil then
				arg_107_1.var_.characterEffect1156ui_story = var_110_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_10 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_10 and not isNil(var_110_9) then
				if arg_107_1.var_.characterEffect1156ui_story and not isNil(var_110_9) then
					arg_107_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_10 and arg_107_1.time_ < 0 + var_110_10 + arg_110_0 and not isNil(var_110_9) and arg_107_1.var_.characterEffect1156ui_story then
				arg_107_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_110_12 = arg_107_1.actors_["1061ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_12) and arg_107_1.var_.characterEffect1061ui_story == nil then
				arg_107_1.var_.characterEffect1061ui_story = var_110_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_13 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_13 and not isNil(var_110_12) then
				if arg_107_1.var_.characterEffect1061ui_story and not isNil(var_110_12) then
					arg_107_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_13)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_13 and arg_107_1.time_ < 0 + var_110_13 + arg_110_0 and not isNil(var_110_12) and arg_107_1.var_.characterEffect1061ui_story then
				arg_107_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_110_14 = 0
			local var_110_15 = 0.4

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_14 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_16 = arg_107_1:GetWordFromCfg(321401025)
				local var_110_17 = arg_107_1:FormatText(var_110_16.content)

				arg_107_1.text_.text = var_110_17

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_19 = 16 <= 0 and var_110_15 or var_110_15 * (utf8.len(var_110_17) / 16)

				if (16 <= 0 and var_110_15 or var_110_15 * (utf8.len(var_110_17) / 16)) > 0 and var_110_15 < var_110_19 then
					arg_107_1.talkMaxDuration = var_110_19

					if var_110_19 + var_110_14 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_19 + var_110_14
					end
				end

				arg_107_1.text_.text = var_110_17
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401025", "story_v_out_321401.awb") ~= 0 then
					local var_110_20 = manager.audio:GetVoiceLength("story_v_out_321401", "321401025", "story_v_out_321401.awb") / 1000

					if var_110_20 + var_110_14 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_20 + var_110_14
					end

					if var_110_16.prefab_name ~= "" and arg_107_1.actors_[var_110_16.prefab_name] ~= nil then
						local var_110_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_16.prefab_name].transform, "story_v_out_321401", "321401025", "story_v_out_321401.awb")

						arg_107_1:RecordAudio("321401025", var_110_21)
						arg_107_1:RecordAudio("321401025", var_110_21)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_321401", "321401025", "story_v_out_321401.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_321401", "321401025", "story_v_out_321401.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_22 = math.max(var_110_15, arg_107_1.talkMaxDuration)

			if var_110_14 <= arg_107_1.time_ and arg_107_1.time_ < var_110_14 + var_110_22 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_14) / var_110_22

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_14 + var_110_22 and arg_107_1.time_ < var_110_14 + var_110_22 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play321401026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 321401026
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play321401027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1156ui_story = arg_111_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_114_0 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 then
				arg_111_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_0)
				arg_111_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1156ui_story"].transform.position).z)
				arg_111_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1156ui_story"].transform.localEulerAngles = arg_111_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 then
				arg_111_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1156ui_story"].transform.position).z)
				arg_111_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1156ui_story"].transform.localEulerAngles = arg_111_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_114_1 = arg_111_1.actors_["1156ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect1156ui_story == nil then
				arg_111_1.var_.characterEffect1156ui_story = var_114_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_2 and not isNil(var_114_1) then
				if arg_111_1.var_.characterEffect1156ui_story and not isNil(var_114_1) then
					arg_111_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_2)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_2 and arg_111_1.time_ < 0 + var_114_2 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect1156ui_story then
				arg_111_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0.05 < arg_111_1.time_ and arg_111_1.time_ <= 0.05 + arg_114_0 then
				arg_111_1:AudioAction("play", "effect", "se_story_side_1094", "se_story_1094_run", "")
			end

			local var_114_4 = 0
			local var_114_5 = 1.35

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_6 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(321401026).content)

				arg_111_1.text_.text = var_114_6

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_8 = 54 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_6) / 54)

				if (54 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_6) / 54)) > 0 and var_114_5 < var_114_8 then
					arg_111_1.talkMaxDuration = var_114_8

					if var_114_8 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_4
					end
				end

				arg_111_1.text_.text = var_114_6
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_9 = math.max(var_114_5, arg_111_1.talkMaxDuration)

			if var_114_4 <= arg_111_1.time_ and arg_111_1.time_ < var_114_4 + var_114_9 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_4) / var_114_9

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_4 + var_114_9 and arg_111_1.time_ < var_114_4 + var_114_9 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
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

		arg_111_1:InitPlayNodeList()
	end,
	Play321401027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 321401027
		arg_115_1.duration_ = 3.6

		local var_115_0 = {
			zh = 2.666,
			ja = 3.6
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
				arg_115_0:Play321401028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if arg_115_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_118_0 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_115_1.stage_.transform)

				var_118_0.name = "404001ui_story"
				var_118_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.actors_["404001ui_story"] = var_118_0

				local var_118_1 = var_118_0:GetComponentInChildren(typeof(CharacterEffect))

				var_118_1.enabled = true

				local var_118_2 = GameObjectTools.GetOrAddComponent(var_118_0, typeof(DynamicBoneHelper))

				if var_118_2 then
					var_118_2:EnableDynamicBone(false)
				end

				arg_115_1:ShowWeapon(var_118_1.transform, false)

				arg_115_1.var_["404001ui_story" .. "Animator"] = var_118_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_115_1.var_["404001ui_story" .. "Animator"].applyRootMotion = true
				arg_115_1.var_["404001ui_story" .. "LipSync"] = var_118_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_118_3 = arg_115_1.actors_["404001ui_story"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos404001ui_story = var_118_3.localPosition
			end

			local var_118_4 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				var_118_3.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_115_1.time_ - 0) / var_118_4)
				var_118_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_3.position).x, (manager.ui.mainCamera.transform.position - var_118_3.position).y, (manager.ui.mainCamera.transform.position - var_118_3.position).z)
				var_118_3.localEulerAngles.z = 0
				var_118_3.localEulerAngles.x = 0
				var_118_3.localEulerAngles = var_118_3.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				var_118_3.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				var_118_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_3.position).x, (manager.ui.mainCamera.transform.position - var_118_3.position).y, (manager.ui.mainCamera.transform.position - var_118_3.position).z)
				var_118_3.localEulerAngles.z = 0
				var_118_3.localEulerAngles.x = 0
				var_118_3.localEulerAngles = var_118_3.localEulerAngles
			end

			local var_118_5 = "4040ui_story"

			if arg_115_1.actors_["4040ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4040ui_story"))) then
				local var_118_6 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_115_1.stage_.transform)

				var_118_6.name = var_118_5
				var_118_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.actors_[var_118_5] = var_118_6

				local var_118_7 = var_118_6:GetComponentInChildren(typeof(CharacterEffect))

				var_118_7.enabled = true

				local var_118_8 = GameObjectTools.GetOrAddComponent(var_118_6, typeof(DynamicBoneHelper))

				if var_118_8 then
					var_118_8:EnableDynamicBone(false)
				end

				arg_115_1:ShowWeapon(var_118_7.transform, false)

				arg_115_1.var_[var_118_5 .. "Animator"] = var_118_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_115_1.var_[var_118_5 .. "Animator"].applyRootMotion = true
				arg_115_1.var_[var_118_5 .. "LipSync"] = var_118_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_118_9 = arg_115_1.actors_["4040ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect4040ui_story == nil then
				arg_115_1.var_.characterEffect4040ui_story = var_118_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_10 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_10 and not isNil(var_118_9) then
				if arg_115_1.var_.characterEffect4040ui_story and not isNil(var_118_9) then
					arg_115_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_10 and arg_115_1.time_ < 0 + var_118_10 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect4040ui_story then
				arg_115_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_118_12 = 0
			local var_118_13 = 0.275

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
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

				local var_118_14 = arg_115_1:GetWordFromCfg(321401027)
				local var_118_15 = arg_115_1:FormatText(var_118_14.content)

				arg_115_1.text_.text = var_118_15

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_17 = 11 <= 0 and var_118_13 or var_118_13 * (utf8.len(var_118_15) / 11)

				if (11 <= 0 and var_118_13 or var_118_13 * (utf8.len(var_118_15) / 11)) > 0 and var_118_13 < var_118_17 then
					arg_115_1.talkMaxDuration = var_118_17

					if var_118_17 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_17 + var_118_12
					end
				end

				arg_115_1.text_.text = var_118_15
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401027", "story_v_out_321401.awb") ~= 0 then
					local var_118_18 = manager.audio:GetVoiceLength("story_v_out_321401", "321401027", "story_v_out_321401.awb") / 1000

					if var_118_18 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_18 + var_118_12
					end

					if var_118_14.prefab_name ~= "" and arg_115_1.actors_[var_118_14.prefab_name] ~= nil then
						local var_118_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_14.prefab_name].transform, "story_v_out_321401", "321401027", "story_v_out_321401.awb")

						arg_115_1:RecordAudio("321401027", var_118_19)
						arg_115_1:RecordAudio("321401027", var_118_19)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_321401", "321401027", "story_v_out_321401.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_321401", "321401027", "story_v_out_321401.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_20 = math.max(var_118_13, arg_115_1.talkMaxDuration)

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_20 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_12) / var_118_20

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_12 + var_118_20 and arg_115_1.time_ < var_118_12 + var_118_20 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
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

		arg_115_1:InitPlayNodeList()
	end,
	Play321401028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 321401028
		arg_119_1.duration_ = 4.77

		local var_119_0 = {
			zh = 3.2,
			ja = 4.766
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
				arg_119_0:Play321401029(arg_119_1)
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

			local var_122_1 = arg_119_1.actors_["1156ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1156ui_story == nil then
				arg_119_1.var_.characterEffect1156ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect1156ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1156ui_story then
				arg_119_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_122_4 = arg_119_1.actors_["4040ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_4) and arg_119_1.var_.characterEffect4040ui_story == nil then
				arg_119_1.var_.characterEffect4040ui_story = var_122_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_5 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_5 and not isNil(var_122_4) then
				if arg_119_1.var_.characterEffect4040ui_story and not isNil(var_122_4) then
					arg_119_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_119_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_5)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_5 and arg_119_1.time_ < 0 + var_122_5 + arg_122_0 and not isNil(var_122_4) and arg_119_1.var_.characterEffect4040ui_story then
				arg_119_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_119_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_122_6 = 0
			local var_122_7 = 0.3

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
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

				local var_122_8 = arg_119_1:GetWordFromCfg(321401028)
				local var_122_9 = arg_119_1:FormatText(var_122_8.content)

				arg_119_1.text_.text = var_122_9

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_11 = 12 <= 0 and var_122_7 or var_122_7 * (utf8.len(var_122_9) / 12)

				if (12 <= 0 and var_122_7 or var_122_7 * (utf8.len(var_122_9) / 12)) > 0 and var_122_7 < var_122_11 then
					arg_119_1.talkMaxDuration = var_122_11

					if var_122_11 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_6
					end
				end

				arg_119_1.text_.text = var_122_9
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401028", "story_v_out_321401.awb") ~= 0 then
					local var_122_12 = manager.audio:GetVoiceLength("story_v_out_321401", "321401028", "story_v_out_321401.awb") / 1000

					if var_122_12 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_12 + var_122_6
					end

					if var_122_8.prefab_name ~= "" and arg_119_1.actors_[var_122_8.prefab_name] ~= nil then
						local var_122_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_8.prefab_name].transform, "story_v_out_321401", "321401028", "story_v_out_321401.awb")

						arg_119_1:RecordAudio("321401028", var_122_13)
						arg_119_1:RecordAudio("321401028", var_122_13)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_321401", "321401028", "story_v_out_321401.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_321401", "321401028", "story_v_out_321401.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_14 = math.max(var_122_7, arg_119_1.talkMaxDuration)

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_14 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_6) / var_122_14

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_6 + var_122_14 and arg_119_1.time_ < var_122_6 + var_122_14 + arg_122_0 then
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
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play321401029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 321401029
		arg_123_1.duration_ = 13.7

		local var_123_0 = {
			zh = 12.532999999999,
			ja = 13.699999999999
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
				arg_123_0:Play321401030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 2 < arg_123_1.time_ and arg_123_1.time_ <= 2 + arg_126_0 then
				local var_126_0 = arg_123_1.bgs_.L09g

				arg_123_1.bgs_.L09g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_126_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_126_1 = var_126_0:GetComponent("SpriteRenderer")

				if var_126_1 and var_126_1.sprite then
					local var_126_2 = 2 * (var_126_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_126_0.transform.localScale = Vector3.New(var_126_2 / var_126_1.sprite.bounds.size.y < var_126_2 * manager.ui.mainCameraCom_.aspect / var_126_1.sprite.bounds.size.x and var_126_2 * manager.ui.mainCameraCom_.aspect / var_126_1.sprite.bounds.size.x or var_126_2 / var_126_1.sprite.bounds.size.y, var_126_2 / var_126_1.sprite.bounds.size.y < var_126_2 * manager.ui.mainCameraCom_.aspect / var_126_1.sprite.bounds.size.x and var_126_2 * manager.ui.mainCameraCom_.aspect / var_126_1.sprite.bounds.size.x or var_126_2 / var_126_1.sprite.bounds.size.y, 0)
				end

				for iter_126_0, iter_126_1 in pairs(arg_123_1.bgs_) do
					if iter_126_0 ~= "L09g" then
						iter_126_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_126_3 = 3.999999999999

			if 3.999999999999 < arg_123_1.time_ and arg_123_1.time_ <= var_126_3 + arg_126_0 then
				arg_123_1.allBtn_.enabled = false
			end

			if arg_123_1.time_ >= var_126_3 + 0.3 and arg_123_1.time_ < var_126_3 + 0.3 + arg_126_0 then
				arg_123_1.allBtn_.enabled = true
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

			local var_126_12 = arg_123_1.actors_["1156ui_story"].transform

			if 1.96599999815226 < arg_123_1.time_ and arg_123_1.time_ <= 1.96599999815226 + arg_126_0 then
				arg_123_1.var_.moveOldPos1156ui_story = var_126_12.localPosition
			end

			local var_126_13 = 0.001

			if 1.96599999815226 <= arg_123_1.time_ and arg_123_1.time_ < 1.96599999815226 + var_126_13 then
				var_126_12.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_123_1.time_ - 1.96599999815226) / var_126_13)
				var_126_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_12.position).x, (manager.ui.mainCamera.transform.position - var_126_12.position).y, (manager.ui.mainCamera.transform.position - var_126_12.position).z)
				var_126_12.localEulerAngles.z = 0
				var_126_12.localEulerAngles.x = 0
				var_126_12.localEulerAngles = var_126_12.localEulerAngles
			end

			if arg_123_1.time_ >= 1.96599999815226 + var_126_13 and arg_123_1.time_ < 1.96599999815226 + var_126_13 + arg_126_0 then
				var_126_12.localPosition = Vector3.New(0, 100, 0)
				var_126_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_12.position).x, (manager.ui.mainCamera.transform.position - var_126_12.position).y, (manager.ui.mainCamera.transform.position - var_126_12.position).z)
				var_126_12.localEulerAngles.z = 0
				var_126_12.localEulerAngles.x = 0
				var_126_12.localEulerAngles = var_126_12.localEulerAngles
			end

			local var_126_14 = arg_123_1.actors_["404001ui_story"].transform

			if 1.96599999815226 < arg_123_1.time_ and arg_123_1.time_ <= 1.96599999815226 + arg_126_0 then
				arg_123_1.var_.moveOldPos404001ui_story = var_126_14.localPosition
			end

			local var_126_15 = 0.001

			if 1.96599999815226 <= arg_123_1.time_ and arg_123_1.time_ < 1.96599999815226 + var_126_15 then
				var_126_14.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_123_1.time_ - 1.96599999815226) / var_126_15)
				var_126_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_14.position).x, (manager.ui.mainCamera.transform.position - var_126_14.position).y, (manager.ui.mainCamera.transform.position - var_126_14.position).z)
				var_126_14.localEulerAngles.z = 0
				var_126_14.localEulerAngles.x = 0
				var_126_14.localEulerAngles = var_126_14.localEulerAngles
			end

			if arg_123_1.time_ >= 1.96599999815226 + var_126_15 and arg_123_1.time_ < 1.96599999815226 + var_126_15 + arg_126_0 then
				var_126_14.localPosition = Vector3.New(0, 100, 0)
				var_126_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_14.position).x, (manager.ui.mainCamera.transform.position - var_126_14.position).y, (manager.ui.mainCamera.transform.position - var_126_14.position).z)
				var_126_14.localEulerAngles.z = 0
				var_126_14.localEulerAngles.x = 0
				var_126_14.localEulerAngles = var_126_14.localEulerAngles
			end

			if arg_123_1.frameCnt_ <= 1 then
				arg_123_1.dialog_:SetActive(false)
			end

			local var_126_16 = 3.999999999999
			local var_126_17 = 0.9

			if 3.999999999999 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 then
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

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10131")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_19 = arg_123_1:GetWordFromCfg(321401029)
				local var_126_20 = arg_123_1:FormatText(var_126_19.content)

				arg_123_1.text_.text = var_126_20

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_22 = 36 <= 0 and var_126_17 or var_126_17 * (utf8.len(var_126_20) / 36)

				if (36 <= 0 and var_126_17 or var_126_17 * (utf8.len(var_126_20) / 36)) > 0 and var_126_17 < var_126_22 then
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

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401029", "story_v_out_321401.awb") ~= 0 then
					local var_126_23 = manager.audio:GetVoiceLength("story_v_out_321401", "321401029", "story_v_out_321401.awb") / 1000

					if var_126_23 + var_126_16 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_23 + var_126_16
					end

					if var_126_19.prefab_name ~= "" and arg_123_1.actors_[var_126_19.prefab_name] ~= nil then
						local var_126_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_19.prefab_name].transform, "story_v_out_321401", "321401029", "story_v_out_321401.awb")

						arg_123_1:RecordAudio("321401029", var_126_24)
						arg_123_1:RecordAudio("321401029", var_126_24)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_321401", "321401029", "story_v_out_321401.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_321401", "321401029", "story_v_out_321401.awb")
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

		arg_123_1.nodeConfigList_ = {
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
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play321401030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 321401030
		arg_129_1.duration_ = 9.97

		local var_129_0 = {
			zh = 8.333,
			ja = 9.966
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
				arg_129_0:Play321401031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.875

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10131")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:GetWordFromCfg(321401030)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 35 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 35)

				if (35 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 35)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401030", "story_v_out_321401.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_321401", "321401030", "story_v_out_321401.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_321401", "321401030", "story_v_out_321401.awb")

						arg_129_1:RecordAudio("321401030", var_132_6)
						arg_129_1:RecordAudio("321401030", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_321401", "321401030", "story_v_out_321401.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_321401", "321401030", "story_v_out_321401.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play321401031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 321401031
		arg_133_1.duration_ = 5.63

		local var_133_0 = {
			zh = 5.5,
			ja = 5.633
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
				arg_133_0:Play321401032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.475

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10131")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_1 = arg_133_1:GetWordFromCfg(321401031)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 19 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 19)

				if (19 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 19)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401031", "story_v_out_321401.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_321401", "321401031", "story_v_out_321401.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_321401", "321401031", "story_v_out_321401.awb")

						arg_133_1:RecordAudio("321401031", var_136_6)
						arg_133_1:RecordAudio("321401031", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_321401", "321401031", "story_v_out_321401.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_321401", "321401031", "story_v_out_321401.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play321401032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 321401032
		arg_137_1.duration_ = 3.73

		local var_137_0 = {
			zh = 3.733,
			ja = 2.966
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
				arg_137_0:Play321401033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1111ui_story = arg_137_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1111ui_story"].transform.position).z)
				arg_137_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1111ui_story"].transform.localEulerAngles = arg_137_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_137_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1111ui_story"].transform.position).z)
				arg_137_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1111ui_story"].transform.localEulerAngles = arg_137_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["10131ui_story"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10131ui_story = var_140_1.localPosition
			end

			local var_140_2 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 then
				var_140_1.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 0) / var_140_2)
				var_140_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_1.position).x, (manager.ui.mainCamera.transform.position - var_140_1.position).y, (manager.ui.mainCamera.transform.position - var_140_1.position).z)
				var_140_1.localEulerAngles.z = 0
				var_140_1.localEulerAngles.x = 0
				var_140_1.localEulerAngles = var_140_1.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 then
				var_140_1.localPosition = Vector3.New(0, 100, 0)
				var_140_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_1.position).x, (manager.ui.mainCamera.transform.position - var_140_1.position).y, (manager.ui.mainCamera.transform.position - var_140_1.position).z)
				var_140_1.localEulerAngles.z = 0
				var_140_1.localEulerAngles.x = 0
				var_140_1.localEulerAngles = var_140_1.localEulerAngles
			end

			local var_140_3 = arg_137_1.actors_["1111ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_3) and arg_137_1.var_.characterEffect1111ui_story == nil then
				arg_137_1.var_.characterEffect1111ui_story = var_140_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_4 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 and not isNil(var_140_3) then
				if arg_137_1.var_.characterEffect1111ui_story and not isNil(var_140_3) then
					arg_137_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 and not isNil(var_140_3) and arg_137_1.var_.characterEffect1111ui_story then
				arg_137_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_140_6 = arg_137_1.actors_["10131ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_6) and arg_137_1.var_.characterEffect10131ui_story == nil then
				arg_137_1.var_.characterEffect10131ui_story = var_140_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_7 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 and not isNil(var_140_6) then
				if arg_137_1.var_.characterEffect10131ui_story and not isNil(var_140_6) then
					arg_137_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_7)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 and not isNil(var_140_6) and arg_137_1.var_.characterEffect10131ui_story then
				arg_137_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_140_8 = 0
			local var_140_9 = 0.375

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_10 = arg_137_1:GetWordFromCfg(321401032)
				local var_140_11 = arg_137_1:FormatText(var_140_10.content)

				arg_137_1.text_.text = var_140_11

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_13 = 16 <= 0 and var_140_9 or var_140_9 * (utf8.len(var_140_11) / 16)

				if (16 <= 0 and var_140_9 or var_140_9 * (utf8.len(var_140_11) / 16)) > 0 and var_140_9 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_8
					end
				end

				arg_137_1.text_.text = var_140_11
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401032", "story_v_out_321401.awb") ~= 0 then
					local var_140_14 = manager.audio:GetVoiceLength("story_v_out_321401", "321401032", "story_v_out_321401.awb") / 1000

					if var_140_14 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_14 + var_140_8
					end

					if var_140_10.prefab_name ~= "" and arg_137_1.actors_[var_140_10.prefab_name] ~= nil then
						local var_140_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_10.prefab_name].transform, "story_v_out_321401", "321401032", "story_v_out_321401.awb")

						arg_137_1:RecordAudio("321401032", var_140_15)
						arg_137_1:RecordAudio("321401032", var_140_15)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_321401", "321401032", "story_v_out_321401.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_321401", "321401032", "story_v_out_321401.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_16 = math.max(var_140_9, arg_137_1.talkMaxDuration)

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_16 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_8) / var_140_16

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_8 + var_140_16 and arg_137_1.time_ < var_140_8 + var_140_16 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play321401033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 321401033
		arg_141_1.duration_ = 12.37

		local var_141_0 = {
			zh = 9.8,
			ja = 12.366
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
				arg_141_0:Play321401034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10131ui_story = arg_141_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10131ui_story, Vector3.New(-0.78, -0.96, -5.8), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10131ui_story"].transform.position).z)
				arg_141_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10131ui_story"].transform.localEulerAngles = arg_141_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(-0.78, -0.96, -5.8)
				arg_141_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10131ui_story"].transform.position).z)
				arg_141_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10131ui_story"].transform.localEulerAngles = arg_141_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["10131ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect10131ui_story == nil then
				arg_141_1.var_.characterEffect10131ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect10131ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect10131ui_story then
				arg_141_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_144_4 = arg_141_1.actors_["1111ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect1111ui_story == nil then
				arg_141_1.var_.characterEffect1111ui_story = var_144_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_5 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_5 and not isNil(var_144_4) then
				if arg_141_1.var_.characterEffect1111ui_story and not isNil(var_144_4) then
					arg_141_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_5)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_5 and arg_141_1.time_ < 0 + var_144_5 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect1111ui_story then
				arg_141_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_144_6 = arg_141_1.actors_["1111ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1111ui_story = var_144_6.localPosition
			end

			local var_144_7 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				var_144_6.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_141_1.time_ - 0) / var_144_7)
				var_144_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_6.position).x, (manager.ui.mainCamera.transform.position - var_144_6.position).y, (manager.ui.mainCamera.transform.position - var_144_6.position).z)
				var_144_6.localEulerAngles.z = 0
				var_144_6.localEulerAngles.x = 0
				var_144_6.localEulerAngles = var_144_6.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				var_144_6.localPosition = Vector3.New(0.7, -0.87, -5.7)
				var_144_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_6.position).x, (manager.ui.mainCamera.transform.position - var_144_6.position).y, (manager.ui.mainCamera.transform.position - var_144_6.position).z)
				var_144_6.localEulerAngles.z = 0
				var_144_6.localEulerAngles.x = 0
				var_144_6.localEulerAngles = var_144_6.localEulerAngles
			end

			local var_144_8 = 0
			local var_144_9 = 1

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_10 = arg_141_1:GetWordFromCfg(321401033)
				local var_144_11 = arg_141_1:FormatText(var_144_10.content)

				arg_141_1.text_.text = var_144_11

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_13 = 40 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_11) / 40)

				if (40 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_11) / 40)) > 0 and var_144_9 < var_144_13 then
					arg_141_1.talkMaxDuration = var_144_13

					if var_144_13 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_8
					end
				end

				arg_141_1.text_.text = var_144_11
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401033", "story_v_out_321401.awb") ~= 0 then
					local var_144_14 = manager.audio:GetVoiceLength("story_v_out_321401", "321401033", "story_v_out_321401.awb") / 1000

					if var_144_14 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_8
					end

					if var_144_10.prefab_name ~= "" and arg_141_1.actors_[var_144_10.prefab_name] ~= nil then
						local var_144_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_10.prefab_name].transform, "story_v_out_321401", "321401033", "story_v_out_321401.awb")

						arg_141_1:RecordAudio("321401033", var_144_15)
						arg_141_1:RecordAudio("321401033", var_144_15)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_321401", "321401033", "story_v_out_321401.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_321401", "321401033", "story_v_out_321401.awb")
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

		arg_141_1:InitPlayNodeList()
	end,
	Play321401034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 321401034
		arg_145_1.duration_ = 5.3

		local var_145_0 = {
			zh = 4.4,
			ja = 5.3
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
				arg_145_0:Play321401035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_148_0 = 0
			local var_148_1 = 0.45

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_2 = arg_145_1:GetWordFromCfg(321401034)
				local var_148_3 = arg_145_1:FormatText(var_148_2.content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 18 <= 0 and var_148_1 or var_148_1 * (utf8.len(var_148_3) / 18)

				if (18 <= 0 and var_148_1 or var_148_1 * (utf8.len(var_148_3) / 18)) > 0 and var_148_1 < var_148_5 then
					arg_145_1.talkMaxDuration = var_148_5

					if var_148_5 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401034", "story_v_out_321401.awb") ~= 0 then
					local var_148_6 = manager.audio:GetVoiceLength("story_v_out_321401", "321401034", "story_v_out_321401.awb") / 1000

					if var_148_6 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_0
					end

					if var_148_2.prefab_name ~= "" and arg_145_1.actors_[var_148_2.prefab_name] ~= nil then
						local var_148_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_2.prefab_name].transform, "story_v_out_321401", "321401034", "story_v_out_321401.awb")

						arg_145_1:RecordAudio("321401034", var_148_7)
						arg_145_1:RecordAudio("321401034", var_148_7)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_321401", "321401034", "story_v_out_321401.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_321401", "321401034", "story_v_out_321401.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_8 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_8 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_8

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_8 and arg_145_1.time_ < var_148_0 + var_148_8 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play321401035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 321401035
		arg_149_1.duration_ = 2.9

		local var_149_0 = {
			zh = 2.9,
			ja = 2.333
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
				arg_149_0:Play321401036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1111ui_story = arg_149_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1111ui_story"].transform.position).z)
				arg_149_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1111ui_story"].transform.localEulerAngles = arg_149_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_149_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1111ui_story"].transform.position).z)
				arg_149_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1111ui_story"].transform.localEulerAngles = arg_149_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["1111ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1111ui_story == nil then
				arg_149_1.var_.characterEffect1111ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1111ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1111ui_story then
				arg_149_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_152_4 = arg_149_1.actors_["10131ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect10131ui_story == nil then
				arg_149_1.var_.characterEffect10131ui_story = var_152_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_5 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_5 and not isNil(var_152_4) then
				if arg_149_1.var_.characterEffect10131ui_story and not isNil(var_152_4) then
					arg_149_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_5)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_5 and arg_149_1.time_ < 0 + var_152_5 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect10131ui_story then
				arg_149_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_152_6 = 0
			local var_152_7 = 0.25

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_8 = arg_149_1:GetWordFromCfg(321401035)
				local var_152_9 = arg_149_1:FormatText(var_152_8.content)

				arg_149_1.text_.text = var_152_9

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 10 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 10)

				if (10 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 10)) > 0 and var_152_7 < var_152_11 then
					arg_149_1.talkMaxDuration = var_152_11

					if var_152_11 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_9
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401035", "story_v_out_321401.awb") ~= 0 then
					local var_152_12 = manager.audio:GetVoiceLength("story_v_out_321401", "321401035", "story_v_out_321401.awb") / 1000

					if var_152_12 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_12 + var_152_6
					end

					if var_152_8.prefab_name ~= "" and arg_149_1.actors_[var_152_8.prefab_name] ~= nil then
						local var_152_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_8.prefab_name].transform, "story_v_out_321401", "321401035", "story_v_out_321401.awb")

						arg_149_1:RecordAudio("321401035", var_152_13)
						arg_149_1:RecordAudio("321401035", var_152_13)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_321401", "321401035", "story_v_out_321401.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_321401", "321401035", "story_v_out_321401.awb")
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
				actorName = "1111ui_story",
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
	Play321401036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 321401036
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play321401037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1111ui_story = arg_153_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1111ui_story"].transform.position).z)
				arg_153_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1111ui_story"].transform.localEulerAngles = arg_153_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_153_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1111ui_story"].transform.position).z)
				arg_153_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1111ui_story"].transform.localEulerAngles = arg_153_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["10131ui_story"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10131ui_story = var_156_1.localPosition
			end

			local var_156_2 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 then
				var_156_1.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_153_1.time_ - 0) / var_156_2)
				var_156_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_1.position).x, (manager.ui.mainCamera.transform.position - var_156_1.position).y, (manager.ui.mainCamera.transform.position - var_156_1.position).z)
				var_156_1.localEulerAngles.z = 0
				var_156_1.localEulerAngles.x = 0
				var_156_1.localEulerAngles = var_156_1.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 then
				var_156_1.localPosition = Vector3.New(0, 100, 0)
				var_156_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_1.position).x, (manager.ui.mainCamera.transform.position - var_156_1.position).y, (manager.ui.mainCamera.transform.position - var_156_1.position).z)
				var_156_1.localEulerAngles.z = 0
				var_156_1.localEulerAngles.x = 0
				var_156_1.localEulerAngles = var_156_1.localEulerAngles
			end

			local var_156_3 = arg_153_1.actors_["1111ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_3) and arg_153_1.var_.characterEffect1111ui_story == nil then
				arg_153_1.var_.characterEffect1111ui_story = var_156_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_4 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 and not isNil(var_156_3) then
				if arg_153_1.var_.characterEffect1111ui_story and not isNil(var_156_3) then
					arg_153_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_4)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 and not isNil(var_156_3) and arg_153_1.var_.characterEffect1111ui_story then
				arg_153_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0.675 < arg_153_1.time_ and arg_153_1.time_ <= 0.675 + arg_156_0 then
				arg_153_1:AudioAction("play", "effect", "se_story_1210", "se_story_1210_loading", "")
			end

			local var_156_6 = 0
			local var_156_7 = 0.675

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_8 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(321401036).content)

				arg_153_1.text_.text = var_156_8

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_10 = 27 <= 0 and var_156_7 or var_156_7 * (utf8.len(var_156_8) / 27)

				if (27 <= 0 and var_156_7 or var_156_7 * (utf8.len(var_156_8) / 27)) > 0 and var_156_7 < var_156_10 then
					arg_153_1.talkMaxDuration = var_156_10

					if var_156_10 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_6
					end
				end

				arg_153_1.text_.text = var_156_8
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_11 = math.max(var_156_7, arg_153_1.talkMaxDuration)

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_11 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_6) / var_156_11

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_6 + var_156_11 and arg_153_1.time_ < var_156_6 + var_156_11 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play321401037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 321401037
		arg_157_1.duration_ = 10.57

		local var_157_0 = {
			zh = 6.8,
			ja = 10.566
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
				arg_157_0:Play321401038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1111ui_story = arg_157_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1111ui_story"].transform.position).z)
				arg_157_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1111ui_story"].transform.localEulerAngles = arg_157_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_157_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1111ui_story"].transform.position).z)
				arg_157_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1111ui_story"].transform.localEulerAngles = arg_157_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["1111ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1111ui_story == nil then
				arg_157_1.var_.characterEffect1111ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect1111ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1111ui_story then
				arg_157_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_2")
			end

			local var_160_4 = 0
			local var_160_5 = 0.875

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(321401037)
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

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401037", "story_v_out_321401.awb") ~= 0 then
					local var_160_10 = manager.audio:GetVoiceLength("story_v_out_321401", "321401037", "story_v_out_321401.awb") / 1000

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end

					if var_160_6.prefab_name ~= "" and arg_157_1.actors_[var_160_6.prefab_name] ~= nil then
						local var_160_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_6.prefab_name].transform, "story_v_out_321401", "321401037", "story_v_out_321401.awb")

						arg_157_1:RecordAudio("321401037", var_160_11)
						arg_157_1:RecordAudio("321401037", var_160_11)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_321401", "321401037", "story_v_out_321401.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_321401", "321401037", "story_v_out_321401.awb")
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

		arg_157_1.nodeConfigList_ = {
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

		arg_157_1:InitPlayNodeList()
	end,
	Play321401038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 321401038
		arg_161_1.duration_ = 4.9

		local var_161_0 = {
			zh = 4.2,
			ja = 4.9
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
				arg_161_0:Play321401039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.525

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(321401038)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 21 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 21)

				if (21 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 21)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401038", "story_v_out_321401.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_321401", "321401038", "story_v_out_321401.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_321401", "321401038", "story_v_out_321401.awb")

						arg_161_1:RecordAudio("321401038", var_164_6)
						arg_161_1:RecordAudio("321401038", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_321401", "321401038", "story_v_out_321401.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_321401", "321401038", "story_v_out_321401.awb")
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
	Play321401039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 321401039
		arg_165_1.duration_ = 11.5

		local var_165_0 = {
			zh = 8.466,
			ja = 11.5
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
				arg_165_0:Play321401040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1111ui_story = arg_165_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1111ui_story"].transform.position).z)
				arg_165_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1111ui_story"].transform.localEulerAngles = arg_165_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_165_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1111ui_story"].transform.position).z)
				arg_165_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1111ui_story"].transform.localEulerAngles = arg_165_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_168_1 = 0
			local var_168_2 = 1.075

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:GetWordFromCfg(321401039)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_6 = 43 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_4) / 43)

				if (43 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_4) / 43)) > 0 and var_168_2 < var_168_6 then
					arg_165_1.talkMaxDuration = var_168_6

					if var_168_6 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_6 + var_168_1
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401039", "story_v_out_321401.awb") ~= 0 then
					local var_168_7 = manager.audio:GetVoiceLength("story_v_out_321401", "321401039", "story_v_out_321401.awb") / 1000

					if var_168_7 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_1
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_321401", "321401039", "story_v_out_321401.awb")

						arg_165_1:RecordAudio("321401039", var_168_8)
						arg_165_1:RecordAudio("321401039", var_168_8)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_321401", "321401039", "story_v_out_321401.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_321401", "321401039", "story_v_out_321401.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_9 = math.max(var_168_2, arg_165_1.talkMaxDuration)

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_9 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_1) / var_168_9

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_1 + var_168_9 and arg_165_1.time_ < var_168_1 + var_168_9 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
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

		arg_165_1:InitPlayNodeList()
	end,
	Play321401040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 321401040
		arg_169_1.duration_ = 6.53

		local var_169_0 = {
			zh = 3.9,
			ja = 6.533
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
				arg_169_0:Play321401041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10131ui_story = arg_169_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10131ui_story"].transform.position).z)
				arg_169_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10131ui_story"].transform.localEulerAngles = arg_169_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_169_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10131ui_story"].transform.position).z)
				arg_169_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10131ui_story"].transform.localEulerAngles = arg_169_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["1111ui_story"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1111ui_story = var_172_1.localPosition
			end

			local var_172_2 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 then
				var_172_1.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_169_1.time_ - 0) / var_172_2)
				var_172_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_1.position).x, (manager.ui.mainCamera.transform.position - var_172_1.position).y, (manager.ui.mainCamera.transform.position - var_172_1.position).z)
				var_172_1.localEulerAngles.z = 0
				var_172_1.localEulerAngles.x = 0
				var_172_1.localEulerAngles = var_172_1.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 then
				var_172_1.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				var_172_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_1.position).x, (manager.ui.mainCamera.transform.position - var_172_1.position).y, (manager.ui.mainCamera.transform.position - var_172_1.position).z)
				var_172_1.localEulerAngles.z = 0
				var_172_1.localEulerAngles.x = 0
				var_172_1.localEulerAngles = var_172_1.localEulerAngles
			end

			local var_172_3 = arg_169_1.actors_["10131ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_3) and arg_169_1.var_.characterEffect10131ui_story == nil then
				arg_169_1.var_.characterEffect10131ui_story = var_172_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_4 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 and not isNil(var_172_3) then
				if arg_169_1.var_.characterEffect10131ui_story and not isNil(var_172_3) then
					arg_169_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 and not isNil(var_172_3) and arg_169_1.var_.characterEffect10131ui_story then
				arg_169_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_172_6 = arg_169_1.actors_["1111ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_6) and arg_169_1.var_.characterEffect1111ui_story == nil then
				arg_169_1.var_.characterEffect1111ui_story = var_172_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_7 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 and not isNil(var_172_6) then
				if arg_169_1.var_.characterEffect1111ui_story and not isNil(var_172_6) then
					arg_169_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_7)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 and not isNil(var_172_6) and arg_169_1.var_.characterEffect1111ui_story then
				arg_169_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_172_8 = 0
			local var_172_9 = 0.35

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_10 = arg_169_1:GetWordFromCfg(321401040)
				local var_172_11 = arg_169_1:FormatText(var_172_10.content)

				arg_169_1.text_.text = var_172_11

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_13 = 14 <= 0 and var_172_9 or var_172_9 * (utf8.len(var_172_11) / 14)

				if (14 <= 0 and var_172_9 or var_172_9 * (utf8.len(var_172_11) / 14)) > 0 and var_172_9 < var_172_13 then
					arg_169_1.talkMaxDuration = var_172_13

					if var_172_13 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_13 + var_172_8
					end
				end

				arg_169_1.text_.text = var_172_11
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401040", "story_v_out_321401.awb") ~= 0 then
					local var_172_14 = manager.audio:GetVoiceLength("story_v_out_321401", "321401040", "story_v_out_321401.awb") / 1000

					if var_172_14 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_14 + var_172_8
					end

					if var_172_10.prefab_name ~= "" and arg_169_1.actors_[var_172_10.prefab_name] ~= nil then
						local var_172_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_10.prefab_name].transform, "story_v_out_321401", "321401040", "story_v_out_321401.awb")

						arg_169_1:RecordAudio("321401040", var_172_15)
						arg_169_1:RecordAudio("321401040", var_172_15)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_321401", "321401040", "story_v_out_321401.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_321401", "321401040", "story_v_out_321401.awb")
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

		arg_169_1:InitPlayNodeList()
	end,
	Play321401041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 321401041
		arg_173_1.duration_ = 4.07

		local var_173_0 = {
			zh = 4.066,
			ja = 3.7
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
				arg_173_0:Play321401042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1111ui_story"]) and arg_173_1.var_.characterEffect1111ui_story == nil then
				arg_173_1.var_.characterEffect1111ui_story = arg_173_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1111ui_story"]) then
				if arg_173_1.var_.characterEffect1111ui_story and not isNil(arg_173_1.actors_["1111ui_story"]) then
					arg_173_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1111ui_story"]) and arg_173_1.var_.characterEffect1111ui_story then
				arg_173_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_176_2 = arg_173_1.actors_["10131ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.characterEffect10131ui_story == nil then
				arg_173_1.var_.characterEffect10131ui_story = var_176_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_3 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 and not isNil(var_176_2) then
				if arg_173_1.var_.characterEffect10131ui_story and not isNil(var_176_2) then
					arg_173_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_3)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.characterEffect10131ui_story then
				arg_173_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action442")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_176_4 = 0
			local var_176_5 = 0.475

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(321401041)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 19 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 19)

				if (19 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 19)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401041", "story_v_out_321401.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_321401", "321401041", "story_v_out_321401.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_321401", "321401041", "story_v_out_321401.awb")

						arg_173_1:RecordAudio("321401041", var_176_11)
						arg_173_1:RecordAudio("321401041", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_321401", "321401041", "story_v_out_321401.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_321401", "321401041", "story_v_out_321401.awb")
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
	Play321401042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 321401042
		arg_177_1.duration_ = 7.37

		local var_177_0 = {
			zh = 5.733,
			ja = 7.366
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
				arg_177_0:Play321401043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["10131ui_story"]) and arg_177_1.var_.characterEffect10131ui_story == nil then
				arg_177_1.var_.characterEffect10131ui_story = arg_177_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["10131ui_story"]) then
				if arg_177_1.var_.characterEffect10131ui_story and not isNil(arg_177_1.actors_["10131ui_story"]) then
					arg_177_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["10131ui_story"]) and arg_177_1.var_.characterEffect10131ui_story then
				arg_177_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_180_2 = arg_177_1.actors_["1111ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect1111ui_story == nil then
				arg_177_1.var_.characterEffect1111ui_story = var_180_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_3 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.characterEffect1111ui_story and not isNil(var_180_2) then
					arg_177_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_3)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect1111ui_story then
				arg_177_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_180_4 = 0
			local var_180_5 = 0.55

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(321401042)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 22 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 22)

				if (22 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 22)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401042", "story_v_out_321401.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_321401", "321401042", "story_v_out_321401.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_out_321401", "321401042", "story_v_out_321401.awb")

						arg_177_1:RecordAudio("321401042", var_180_11)
						arg_177_1:RecordAudio("321401042", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_321401", "321401042", "story_v_out_321401.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_321401", "321401042", "story_v_out_321401.awb")
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
	Play321401043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 321401043
		arg_181_1.duration_ = 12.8

		local var_181_0 = {
			zh = 10.066,
			ja = 12.8
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
				arg_181_0:Play321401044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.9

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:GetWordFromCfg(321401043)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 36 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 36)

				if (36 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 36)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401043", "story_v_out_321401.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_321401", "321401043", "story_v_out_321401.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_321401", "321401043", "story_v_out_321401.awb")

						arg_181_1:RecordAudio("321401043", var_184_6)
						arg_181_1:RecordAudio("321401043", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_321401", "321401043", "story_v_out_321401.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_321401", "321401043", "story_v_out_321401.awb")
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
	Play321401044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 321401044
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play321401045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1111ui_story = arg_185_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1111ui_story"].transform.position).z)
				arg_185_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1111ui_story"].transform.localEulerAngles = arg_185_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_185_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1111ui_story"].transform.position).z)
				arg_185_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1111ui_story"].transform.localEulerAngles = arg_185_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["10131ui_story"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10131ui_story = var_188_1.localPosition
			end

			local var_188_2 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 then
				var_188_1.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 0) / var_188_2)
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

			local var_188_3 = arg_185_1.actors_["10131ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_3) and arg_185_1.var_.characterEffect10131ui_story == nil then
				arg_185_1.var_.characterEffect10131ui_story = var_188_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_4 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 and not isNil(var_188_3) then
				if arg_185_1.var_.characterEffect10131ui_story and not isNil(var_188_3) then
					arg_185_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_185_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_4)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 and not isNil(var_188_3) and arg_185_1.var_.characterEffect10131ui_story then
				arg_185_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_185_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_188_5 = 0
			local var_188_6 = 0.95

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

				local var_188_7 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(321401044).content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 38 <= 0 and var_188_6 or var_188_6 * (utf8.len(var_188_7) / 38)

				if (38 <= 0 and var_188_6 or var_188_6 * (utf8.len(var_188_7) / 38)) > 0 and var_188_6 < var_188_9 then
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
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play321401045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 321401045
		arg_189_1.duration_ = 5.3

		local var_189_0 = {
			zh = 5.3,
			ja = 5.2
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
				arg_189_0:Play321401046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1111ui_story = arg_189_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1111ui_story"].transform.position).z)
				arg_189_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1111ui_story"].transform.localEulerAngles = arg_189_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_189_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1111ui_story"].transform.position).z)
				arg_189_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1111ui_story"].transform.localEulerAngles = arg_189_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_192_1 = arg_189_1.actors_["1111ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1111ui_story == nil then
				arg_189_1.var_.characterEffect1111ui_story = var_192_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 and not isNil(var_192_1) then
				if arg_189_1.var_.characterEffect1111ui_story and not isNil(var_192_1) then
					arg_189_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1111ui_story then
				arg_189_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_192_4 = 0
			local var_192_5 = 0.4

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_6 = arg_189_1:GetWordFromCfg(321401045)
				local var_192_7 = arg_189_1:FormatText(var_192_6.content)

				arg_189_1.text_.text = var_192_7

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_9 = 16 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 16)

				if (16 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 16)) > 0 and var_192_5 < var_192_9 then
					arg_189_1.talkMaxDuration = var_192_9

					if var_192_9 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_9 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_7
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401045", "story_v_out_321401.awb") ~= 0 then
					local var_192_10 = manager.audio:GetVoiceLength("story_v_out_321401", "321401045", "story_v_out_321401.awb") / 1000

					if var_192_10 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_4
					end

					if var_192_6.prefab_name ~= "" and arg_189_1.actors_[var_192_6.prefab_name] ~= nil then
						local var_192_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_6.prefab_name].transform, "story_v_out_321401", "321401045", "story_v_out_321401.awb")

						arg_189_1:RecordAudio("321401045", var_192_11)
						arg_189_1:RecordAudio("321401045", var_192_11)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_321401", "321401045", "story_v_out_321401.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_321401", "321401045", "story_v_out_321401.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_12 = math.max(var_192_5, arg_189_1.talkMaxDuration)

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_12 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_4) / var_192_12

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_4 + var_192_12 and arg_189_1.time_ < var_192_4 + var_192_12 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
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

		arg_189_1:InitPlayNodeList()
	end,
	Play321401046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 321401046
		arg_193_1.duration_ = 3.77

		local var_193_0 = {
			zh = 3.766,
			ja = 3.066
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
				arg_193_0:Play321401047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10131ui_story = arg_193_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10131ui_story"].transform.position).z)
				arg_193_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["10131ui_story"].transform.localEulerAngles = arg_193_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_193_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10131ui_story"].transform.position).z)
				arg_193_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["10131ui_story"].transform.localEulerAngles = arg_193_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["10131ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect10131ui_story == nil then
				arg_193_1.var_.characterEffect10131ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect10131ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect10131ui_story then
				arg_193_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_196_4 = arg_193_1.actors_["1111ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_4) and arg_193_1.var_.characterEffect1111ui_story == nil then
				arg_193_1.var_.characterEffect1111ui_story = var_196_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_5 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_5 and not isNil(var_196_4) then
				if arg_193_1.var_.characterEffect1111ui_story and not isNil(var_196_4) then
					arg_193_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_5)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_5 and arg_193_1.time_ < 0 + var_196_5 + arg_196_0 and not isNil(var_196_4) and arg_193_1.var_.characterEffect1111ui_story then
				arg_193_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			local var_196_6 = 0
			local var_196_7 = 0.45

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_8 = arg_193_1:GetWordFromCfg(321401046)
				local var_196_9 = arg_193_1:FormatText(var_196_8.content)

				arg_193_1.text_.text = var_196_9

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_11 = 18 <= 0 and var_196_7 or var_196_7 * (utf8.len(var_196_9) / 18)

				if (18 <= 0 and var_196_7 or var_196_7 * (utf8.len(var_196_9) / 18)) > 0 and var_196_7 < var_196_11 then
					arg_193_1.talkMaxDuration = var_196_11

					if var_196_11 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_11 + var_196_6
					end
				end

				arg_193_1.text_.text = var_196_9
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401046", "story_v_out_321401.awb") ~= 0 then
					local var_196_12 = manager.audio:GetVoiceLength("story_v_out_321401", "321401046", "story_v_out_321401.awb") / 1000

					if var_196_12 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_12 + var_196_6
					end

					if var_196_8.prefab_name ~= "" and arg_193_1.actors_[var_196_8.prefab_name] ~= nil then
						local var_196_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_8.prefab_name].transform, "story_v_out_321401", "321401046", "story_v_out_321401.awb")

						arg_193_1:RecordAudio("321401046", var_196_13)
						arg_193_1:RecordAudio("321401046", var_196_13)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_321401", "321401046", "story_v_out_321401.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_321401", "321401046", "story_v_out_321401.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_14 = math.max(var_196_7, arg_193_1.talkMaxDuration)

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_14 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_6) / var_196_14

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_6 + var_196_14 and arg_193_1.time_ < var_196_6 + var_196_14 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play321401047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 321401047
		arg_197_1.duration_ = 14.27

		local var_197_0 = {
			zh = 13.2,
			ja = 14.266
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
				arg_197_0:Play321401048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 1.25

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:GetWordFromCfg(321401047)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 50 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 50)

				if (50 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 50)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401047", "story_v_out_321401.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_321401", "321401047", "story_v_out_321401.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_321401", "321401047", "story_v_out_321401.awb")

						arg_197_1:RecordAudio("321401047", var_200_6)
						arg_197_1:RecordAudio("321401047", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_321401", "321401047", "story_v_out_321401.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_321401", "321401047", "story_v_out_321401.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play321401048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 321401048
		arg_201_1.duration_ = 10.13

		local var_201_0 = {
			zh = 8.533,
			ja = 10.133
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
				arg_201_0:Play321401049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			local var_204_0 = 0
			local var_204_1 = 0.9

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_2 = arg_201_1:GetWordFromCfg(321401048)
				local var_204_3 = arg_201_1:FormatText(var_204_2.content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 36 <= 0 and var_204_1 or var_204_1 * (utf8.len(var_204_3) / 36)

				if (36 <= 0 and var_204_1 or var_204_1 * (utf8.len(var_204_3) / 36)) > 0 and var_204_1 < var_204_5 then
					arg_201_1.talkMaxDuration = var_204_5

					if var_204_5 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401048", "story_v_out_321401.awb") ~= 0 then
					local var_204_6 = manager.audio:GetVoiceLength("story_v_out_321401", "321401048", "story_v_out_321401.awb") / 1000

					if var_204_6 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_6 + var_204_0
					end

					if var_204_2.prefab_name ~= "" and arg_201_1.actors_[var_204_2.prefab_name] ~= nil then
						local var_204_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_2.prefab_name].transform, "story_v_out_321401", "321401048", "story_v_out_321401.awb")

						arg_201_1:RecordAudio("321401048", var_204_7)
						arg_201_1:RecordAudio("321401048", var_204_7)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_321401", "321401048", "story_v_out_321401.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_321401", "321401048", "story_v_out_321401.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_8 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_8 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_8

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_8 and arg_201_1.time_ < var_204_0 + var_204_8 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play321401049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 321401049
		arg_205_1.duration_ = 7.1

		local var_205_0 = {
			zh = 4.966,
			ja = 7.1
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
				arg_205_0:Play321401050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1111ui_story = arg_205_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1111ui_story"].transform.position).z)
				arg_205_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1111ui_story"].transform.localEulerAngles = arg_205_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_205_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1111ui_story"].transform.position).z)
				arg_205_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1111ui_story"].transform.localEulerAngles = arg_205_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_208_1 = arg_205_1.actors_["1111ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1111ui_story == nil then
				arg_205_1.var_.characterEffect1111ui_story = var_208_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_2 and not isNil(var_208_1) then
				if arg_205_1.var_.characterEffect1111ui_story and not isNil(var_208_1) then
					arg_205_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_2 and arg_205_1.time_ < 0 + var_208_2 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1111ui_story then
				arg_205_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_208_4 = arg_205_1.actors_["10131ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_4) and arg_205_1.var_.characterEffect10131ui_story == nil then
				arg_205_1.var_.characterEffect10131ui_story = var_208_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_5 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_5 and not isNil(var_208_4) then
				if arg_205_1.var_.characterEffect10131ui_story and not isNil(var_208_4) then
					arg_205_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_205_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_5)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_5 and arg_205_1.time_ < 0 + var_208_5 + arg_208_0 and not isNil(var_208_4) and arg_205_1.var_.characterEffect10131ui_story then
				arg_205_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_205_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_208_6 = 0
			local var_208_7 = 0.55

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_6 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_8 = arg_205_1:GetWordFromCfg(321401049)
				local var_208_9 = arg_205_1:FormatText(var_208_8.content)

				arg_205_1.text_.text = var_208_9

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_11 = 22 <= 0 and var_208_7 or var_208_7 * (utf8.len(var_208_9) / 22)

				if (22 <= 0 and var_208_7 or var_208_7 * (utf8.len(var_208_9) / 22)) > 0 and var_208_7 < var_208_11 then
					arg_205_1.talkMaxDuration = var_208_11

					if var_208_11 + var_208_6 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_11 + var_208_6
					end
				end

				arg_205_1.text_.text = var_208_9
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401049", "story_v_out_321401.awb") ~= 0 then
					local var_208_12 = manager.audio:GetVoiceLength("story_v_out_321401", "321401049", "story_v_out_321401.awb") / 1000

					if var_208_12 + var_208_6 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_12 + var_208_6
					end

					if var_208_8.prefab_name ~= "" and arg_205_1.actors_[var_208_8.prefab_name] ~= nil then
						local var_208_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_8.prefab_name].transform, "story_v_out_321401", "321401049", "story_v_out_321401.awb")

						arg_205_1:RecordAudio("321401049", var_208_13)
						arg_205_1:RecordAudio("321401049", var_208_13)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_321401", "321401049", "story_v_out_321401.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_321401", "321401049", "story_v_out_321401.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_14 = math.max(var_208_7, arg_205_1.talkMaxDuration)

			if var_208_6 <= arg_205_1.time_ and arg_205_1.time_ < var_208_6 + var_208_14 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_6) / var_208_14

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_6 + var_208_14 and arg_205_1.time_ < var_208_6 + var_208_14 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
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

		arg_205_1:InitPlayNodeList()
	end,
	Play321401050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 321401050
		arg_209_1.duration_ = 11.43

		local var_209_0 = {
			zh = 9.133,
			ja = 11.433
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
				arg_209_0:Play321401051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos10131ui_story = arg_209_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["10131ui_story"].transform.position).z)
				arg_209_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["10131ui_story"].transform.localEulerAngles = arg_209_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_209_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["10131ui_story"].transform.position).z)
				arg_209_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["10131ui_story"].transform.localEulerAngles = arg_209_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["10131ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect10131ui_story == nil then
				arg_209_1.var_.characterEffect10131ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect10131ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect10131ui_story then
				arg_209_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_212_4 = arg_209_1.actors_["1111ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_4) and arg_209_1.var_.characterEffect1111ui_story == nil then
				arg_209_1.var_.characterEffect1111ui_story = var_212_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_5 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_5 and not isNil(var_212_4) then
				if arg_209_1.var_.characterEffect1111ui_story and not isNil(var_212_4) then
					arg_209_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_5)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_5 and arg_209_1.time_ < 0 + var_212_5 + arg_212_0 and not isNil(var_212_4) and arg_209_1.var_.characterEffect1111ui_story then
				arg_209_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_212_6 = 0
			local var_212_7 = 0.85

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_8 = arg_209_1:GetWordFromCfg(321401050)
				local var_212_9 = arg_209_1:FormatText(var_212_8.content)

				arg_209_1.text_.text = var_212_9

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_11 = 34 <= 0 and var_212_7 or var_212_7 * (utf8.len(var_212_9) / 34)

				if (34 <= 0 and var_212_7 or var_212_7 * (utf8.len(var_212_9) / 34)) > 0 and var_212_7 < var_212_11 then
					arg_209_1.talkMaxDuration = var_212_11

					if var_212_11 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_11 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_9
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401050", "story_v_out_321401.awb") ~= 0 then
					local var_212_12 = manager.audio:GetVoiceLength("story_v_out_321401", "321401050", "story_v_out_321401.awb") / 1000

					if var_212_12 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_12 + var_212_6
					end

					if var_212_8.prefab_name ~= "" and arg_209_1.actors_[var_212_8.prefab_name] ~= nil then
						local var_212_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_8.prefab_name].transform, "story_v_out_321401", "321401050", "story_v_out_321401.awb")

						arg_209_1:RecordAudio("321401050", var_212_13)
						arg_209_1:RecordAudio("321401050", var_212_13)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_321401", "321401050", "story_v_out_321401.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_321401", "321401050", "story_v_out_321401.awb")
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
				actorName = "10131ui_story",
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
	Play321401051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 321401051
		arg_213_1.duration_ = 13.6

		local var_213_0 = {
			zh = 11.066,
			ja = 13.6
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
				arg_213_0:Play321401052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 1.225

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:GetWordFromCfg(321401051)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 49 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 49)

				if (49 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 49)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401051", "story_v_out_321401.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_out_321401", "321401051", "story_v_out_321401.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_out_321401", "321401051", "story_v_out_321401.awb")

						arg_213_1:RecordAudio("321401051", var_216_6)
						arg_213_1:RecordAudio("321401051", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_321401", "321401051", "story_v_out_321401.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_321401", "321401051", "story_v_out_321401.awb")
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
	Play321401052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 321401052
		arg_217_1.duration_ = 9.13

		local var_217_0 = {
			zh = 6.3,
			ja = 9.133
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
				arg_217_0:Play321401053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos10131ui_story = arg_217_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["10131ui_story"].transform.position).z)
				arg_217_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["10131ui_story"].transform.localEulerAngles = arg_217_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_217_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["10131ui_story"].transform.position).z)
				arg_217_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["10131ui_story"].transform.localEulerAngles = arg_217_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_220_1 = 0
			local var_220_2 = 0.75

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_3 = arg_217_1:GetWordFromCfg(321401052)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_6 = 30 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_4) / 30)

				if (30 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_4) / 30)) > 0 and var_220_2 < var_220_6 then
					arg_217_1.talkMaxDuration = var_220_6

					if var_220_6 + var_220_1 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_6 + var_220_1
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401052", "story_v_out_321401.awb") ~= 0 then
					local var_220_7 = manager.audio:GetVoiceLength("story_v_out_321401", "321401052", "story_v_out_321401.awb") / 1000

					if var_220_7 + var_220_1 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_1
					end

					if var_220_3.prefab_name ~= "" and arg_217_1.actors_[var_220_3.prefab_name] ~= nil then
						local var_220_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_3.prefab_name].transform, "story_v_out_321401", "321401052", "story_v_out_321401.awb")

						arg_217_1:RecordAudio("321401052", var_220_8)
						arg_217_1:RecordAudio("321401052", var_220_8)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_321401", "321401052", "story_v_out_321401.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_321401", "321401052", "story_v_out_321401.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_9 = math.max(var_220_2, arg_217_1.talkMaxDuration)

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_9 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_1) / var_220_9

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_1 + var_220_9 and arg_217_1.time_ < var_220_1 + var_220_9 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play321401053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 321401053
		arg_221_1.duration_ = 3.4

		local var_221_0 = {
			zh = 2.433,
			ja = 3.4
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
				arg_221_0:Play321401054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1111ui_story = arg_221_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1111ui_story"].transform.position).z)
				arg_221_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1111ui_story"].transform.localEulerAngles = arg_221_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_221_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1111ui_story"].transform.position).z)
				arg_221_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1111ui_story"].transform.localEulerAngles = arg_221_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["1111ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1111ui_story == nil then
				arg_221_1.var_.characterEffect1111ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect1111ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1111ui_story then
				arg_221_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_224_4 = arg_221_1.actors_["10131ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_4) and arg_221_1.var_.characterEffect10131ui_story == nil then
				arg_221_1.var_.characterEffect10131ui_story = var_224_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_5 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_5 and not isNil(var_224_4) then
				if arg_221_1.var_.characterEffect10131ui_story and not isNil(var_224_4) then
					arg_221_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_221_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_5)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_5 and arg_221_1.time_ < 0 + var_224_5 + arg_224_0 and not isNil(var_224_4) and arg_221_1.var_.characterEffect10131ui_story then
				arg_221_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_221_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_224_6 = 0
			local var_224_7 = 0.15

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_6 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_8 = arg_221_1:GetWordFromCfg(321401053)
				local var_224_9 = arg_221_1:FormatText(var_224_8.content)

				arg_221_1.text_.text = var_224_9

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_11 = 6 <= 0 and var_224_7 or var_224_7 * (utf8.len(var_224_9) / 6)

				if (6 <= 0 and var_224_7 or var_224_7 * (utf8.len(var_224_9) / 6)) > 0 and var_224_7 < var_224_11 then
					arg_221_1.talkMaxDuration = var_224_11

					if var_224_11 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_11 + var_224_6
					end
				end

				arg_221_1.text_.text = var_224_9
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401053", "story_v_out_321401.awb") ~= 0 then
					local var_224_12 = manager.audio:GetVoiceLength("story_v_out_321401", "321401053", "story_v_out_321401.awb") / 1000

					if var_224_12 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_12 + var_224_6
					end

					if var_224_8.prefab_name ~= "" and arg_221_1.actors_[var_224_8.prefab_name] ~= nil then
						local var_224_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_8.prefab_name].transform, "story_v_out_321401", "321401053", "story_v_out_321401.awb")

						arg_221_1:RecordAudio("321401053", var_224_13)
						arg_221_1:RecordAudio("321401053", var_224_13)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_321401", "321401053", "story_v_out_321401.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_321401", "321401053", "story_v_out_321401.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_14 = math.max(var_224_7, arg_221_1.talkMaxDuration)

			if var_224_6 <= arg_221_1.time_ and arg_221_1.time_ < var_224_6 + var_224_14 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_6) / var_224_14

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_6 + var_224_14 and arg_221_1.time_ < var_224_6 + var_224_14 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
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

		arg_221_1:InitPlayNodeList()
	end,
	Play321401054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 321401054
		arg_225_1.duration_ = 13.73

		local var_225_0 = {
			zh = 10.4,
			ja = 13.733
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
				arg_225_0:Play321401055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10131ui_story = arg_225_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_228_0 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 then
				arg_225_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_225_1.time_ - 0) / var_228_0)
				arg_225_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["10131ui_story"].transform.position).z)
				arg_225_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["10131ui_story"].transform.localEulerAngles = arg_225_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 then
				arg_225_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_225_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["10131ui_story"].transform.position).z)
				arg_225_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["10131ui_story"].transform.localEulerAngles = arg_225_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_228_1 = arg_225_1.actors_["10131ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect10131ui_story == nil then
				arg_225_1.var_.characterEffect10131ui_story = var_228_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 and not isNil(var_228_1) then
				if arg_225_1.var_.characterEffect10131ui_story and not isNil(var_228_1) then
					arg_225_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect10131ui_story then
				arg_225_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_228_4 = arg_225_1.actors_["1111ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_4) and arg_225_1.var_.characterEffect1111ui_story == nil then
				arg_225_1.var_.characterEffect1111ui_story = var_228_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_5 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_5 and not isNil(var_228_4) then
				if arg_225_1.var_.characterEffect1111ui_story and not isNil(var_228_4) then
					arg_225_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_5)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_5 and arg_225_1.time_ < 0 + var_228_5 + arg_228_0 and not isNil(var_228_4) and arg_225_1.var_.characterEffect1111ui_story then
				arg_225_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_1")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_228_6 = 0
			local var_228_7 = 1.125

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_8 = arg_225_1:GetWordFromCfg(321401054)
				local var_228_9 = arg_225_1:FormatText(var_228_8.content)

				arg_225_1.text_.text = var_228_9

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_11 = 45 <= 0 and var_228_7 or var_228_7 * (utf8.len(var_228_9) / 45)

				if (45 <= 0 and var_228_7 or var_228_7 * (utf8.len(var_228_9) / 45)) > 0 and var_228_7 < var_228_11 then
					arg_225_1.talkMaxDuration = var_228_11

					if var_228_11 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_11 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_9
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401054", "story_v_out_321401.awb") ~= 0 then
					local var_228_12 = manager.audio:GetVoiceLength("story_v_out_321401", "321401054", "story_v_out_321401.awb") / 1000

					if var_228_12 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_12 + var_228_6
					end

					if var_228_8.prefab_name ~= "" and arg_225_1.actors_[var_228_8.prefab_name] ~= nil then
						local var_228_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_8.prefab_name].transform, "story_v_out_321401", "321401054", "story_v_out_321401.awb")

						arg_225_1:RecordAudio("321401054", var_228_13)
						arg_225_1:RecordAudio("321401054", var_228_13)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_321401", "321401054", "story_v_out_321401.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_321401", "321401054", "story_v_out_321401.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_14 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_14 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_14

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_14 and arg_225_1.time_ < var_228_6 + var_228_14 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play321401055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 321401055
		arg_229_1.duration_ = 9.63

		local var_229_0 = {
			zh = 7.6,
			ja = 9.633
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
				arg_229_0:Play321401056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.85

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:GetWordFromCfg(321401055)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 34 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 34)

				if (34 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 34)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401055", "story_v_out_321401.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_321401", "321401055", "story_v_out_321401.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_321401", "321401055", "story_v_out_321401.awb")

						arg_229_1:RecordAudio("321401055", var_232_6)
						arg_229_1:RecordAudio("321401055", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_321401", "321401055", "story_v_out_321401.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_321401", "321401055", "story_v_out_321401.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play321401056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 321401056
		arg_233_1.duration_ = 7.03

		local var_233_0 = {
			zh = 7.033,
			ja = 6.633
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
				arg_233_0:Play321401057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131actionlink/10131action456")
			end

			local var_236_0 = 0
			local var_236_1 = 0.625

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_2 = arg_233_1:GetWordFromCfg(321401056)
				local var_236_3 = arg_233_1:FormatText(var_236_2.content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 25 <= 0 and var_236_1 or var_236_1 * (utf8.len(var_236_3) / 25)

				if (25 <= 0 and var_236_1 or var_236_1 * (utf8.len(var_236_3) / 25)) > 0 and var_236_1 < var_236_5 then
					arg_233_1.talkMaxDuration = var_236_5

					if var_236_5 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401056", "story_v_out_321401.awb") ~= 0 then
					local var_236_6 = manager.audio:GetVoiceLength("story_v_out_321401", "321401056", "story_v_out_321401.awb") / 1000

					if var_236_6 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_6 + var_236_0
					end

					if var_236_2.prefab_name ~= "" and arg_233_1.actors_[var_236_2.prefab_name] ~= nil then
						local var_236_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_2.prefab_name].transform, "story_v_out_321401", "321401056", "story_v_out_321401.awb")

						arg_233_1:RecordAudio("321401056", var_236_7)
						arg_233_1:RecordAudio("321401056", var_236_7)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_321401", "321401056", "story_v_out_321401.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_321401", "321401056", "story_v_out_321401.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_8 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_8 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_8

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_8 and arg_233_1.time_ < var_236_0 + var_236_8 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play321401057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 321401057
		arg_237_1.duration_ = 5.17

		local var_237_0 = {
			zh = 5.166,
			ja = 3.966
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
			arg_237_1.auto_ = false
		end

		function arg_237_1.playNext_(arg_239_0)
			arg_237_1.onStoryFinished_()
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.4

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:GetWordFromCfg(321401057)
				local var_240_2 = arg_237_1:FormatText(var_240_1.content)

				arg_237_1.text_.text = var_240_2

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 16 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 16)

				if (16 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 16)) > 0 and var_240_0 < var_240_4 then
					arg_237_1.talkMaxDuration = var_240_4

					if var_240_4 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_4 + 0
					end
				end

				arg_237_1.text_.text = var_240_2
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321401", "321401057", "story_v_out_321401.awb") ~= 0 then
					local var_240_5 = manager.audio:GetVoiceLength("story_v_out_321401", "321401057", "story_v_out_321401.awb") / 1000

					if var_240_5 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + 0
					end

					if var_240_1.prefab_name ~= "" and arg_237_1.actors_[var_240_1.prefab_name] ~= nil then
						local var_240_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_1.prefab_name].transform, "story_v_out_321401", "321401057", "story_v_out_321401.awb")

						arg_237_1:RecordAudio("321401057", var_240_6)
						arg_237_1:RecordAudio("321401057", var_240_6)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_321401", "321401057", "story_v_out_321401.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_321401", "321401057", "story_v_out_321401.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_7 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_7 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_7

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_7 and arg_237_1.time_ < 0 + var_240_7 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L09g",
		"TextureConfig/Background/L11f",
		"TextureConfig/Background/L10g"
	},
	voices = {
		"story_v_out_321401.awb"
	}
}
